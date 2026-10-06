/*
Stored Procedure: spGetInvoicePayingDetails
Author: Aleksandar Djuric
Date: 21/01/2026

Task Description:
-----------------
This procedure retrieves invoice and payment transactions for customers.
It builds a temporary table (#Transactions) combining invoices and payments,
calculates running balances (OwingAmount), and determines whether each invoice
has been fully paid by its due date.

Parameters:
-----------
@CustomerId INT = NULL
    - If provided, filters results to a specific customer.
    - If NULL, returns results for all customers.

Output:
-------
- Detailed list of transactions (invoices and payments).
- Summary showing each invoice with its due date, amount,
    and a flag indicating whether it is paid (IsPaid).
*/


CREATE OR ALTER PROC spGetInvoicePayingDetails
	@CustomerId INT = NULL -- this is an optional filter
AS
BEGIN
IF OBJECT_ID('tempdb..#Transactions') IS NOT NULL
BEGIN
	DROP TABLE #Transactions;
END

CREATE TABLE #Transactions 
(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	RowNumber INT, 
	InvoiceId INT NULL, 
	PaymentId INT NULL, 
	TransactionType NVARCHAR(20), 
	TransactionName NVARCHAR(100), 
	CustomerId INT, 
	ExecutedAt DATE, 
	DueDate DATE NULL, 
	Amount DECIMAL(10,2), 
	OwingAmount DECIMAL(10,2) 
);

CREATE NONCLUSTERED INDEX 
	IX_InvoiceId_PaymentId_CustomerId
ON 
	#Transactions
	(
		InvoiceId ASC,
		PaymentId ASC,
		CustomerId ASC,
		Amount DESC
	);

DECLARE @invoiceWhere NVARCHAR(MAX) = ' 1 = 1 ';
DECLARE @paymentWhere NVARCHAR(MAX) = ' 1 = 1 ';

IF @CustomerId IS NOT NULL
	SELECT 
		@invoiceWhere = @invoiceWhere + ' AND Invoices.CustomerId = @CustomerId',
		@paymentWhere = @paymentWhere + ' AND CustomerId = @CustomerId';
		


DECLARE @cmd NVARCHAR(MAX) = N'
WITH Transactions_CTE AS (
SELECT
	 Invoices.Id
	,''Invoice''
		AS TransactionType
	,InvoiceServices.Name 
		AS TransactionName
	,Invoices.CustomerId
	,Invoices.ExecutedAt
	,Invoices.DueDate
	,Invoices.Amount

FROM
	Invoices
INNER JOIN
	InvoiceServices
ON
	Invoices.ServiceId = InvoiceServices.Id
WHERE
	' + @invoiceWhere + '

UNION ALL

SELECT
	 Id
	,''Payment''
		AS TransactionType
	,PaymentMethod 
		AS TransactionName
	,CustomerId
	,ExecutedAt
	,NULL 
		AS DueDate
	,Amount

FROM 
	Payments
WHERE
	' + @paymentWhere + '
)

INSERT INTO #Transactions
(
	RowNumber,
	InvoiceId,
	PaymentId,
	TransactionType,
	TransactionName,
	CustomerId,
	ExecutedAt,
	DueDate,
	Amount,
	OwingAmount
)
SELECT
	 ROW_NUMBER() OVER 
	 (
		PARTITION BY
			CustomerId
		ORDER BY
			ExecutedAt ASC
	 ) AS RowNumber
	,IIF(
		TransactionType = ''Invoice'',
		Id,
		NULL
	) AS InvoiceId
	,IIF(
		TransactionType = ''Payment'',
		Id,
		NULL
	) AS PaymentId
	,TransactionType
	,TransactionName
	,CustomerId
	,ExecutedAt
	,DueDate
	,Detail.Amount
	,SUM(Detail.Amount) OVER 
	(
		PARTITION BY
			CustomerId
		ORDER BY
			ExecutedAt ASC
		ROWS BETWEEN 
			UNBOUNDED PRECEDING AND CURRENT ROW
	) AS OwingAmount

FROM
	Transactions_CTE
CROSS APPLY
(
	SELECT
		CASE
			WHEN TransactionType = ''Payment''
				THEN -Amount
			WHEN TransactionType = ''Invoice''
				THEN Amount
		ELSE 0
	END AS Amount
) AS Detail
';


EXEC SP_EXECUTESQL 
	@cmd,
	N'
		@CustomerId INT
	',
	@CustomerId = @CustomerId;


SELECT 
     InvoiceTransactions.InvoiceId
    ,InvoiceTransactions.DueDate
    ,InvoiceTransactions.Amount 
		AS InvoiceAmount
	,CASE 
		WHEN ISNULL(PaymentDetail.TotalAmount, 0) = InvoiceTransactions.Amount 
			THEN 1 
		ELSE 0 
	END AS IsPaid

FROM 
	#Transactions AS InvoiceTransactions
OUTER APPLY 
( 
	SELECT 
		SUM(-p.Amount) 
			AS TotalAmount 
	FROM 
		#Transactions p
	WHERE 
		p.CustomerId = InvoiceTransactions.CustomerId 
		AND p.PaymentId IS NOT NULL
		AND p.ExecutedAt >= InvoiceTransactions.ExecutedAt
		AND p.ExecutedAt <= InvoiceTransactions.DueDate
) AS PaymentDetail
WHERE 
	InvoiceTransactions.InvoiceId IS NOT NULL;


DROP TABLE #Transactions;
END
