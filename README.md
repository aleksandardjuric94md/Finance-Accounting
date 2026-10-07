

---

## 1. What's the business problem?
- A company stores invoices and customer payments in separate tables.
- However,there is no reliable report showing whether an invoice **has been paid**

<br>

The client requested a solution (stored procedure) that would help answer the following questions:
- Has the customer paid the invoice?
- Has the customer paid only part of the invoice?
- How much does the customer still owe?
- How does the customer's balance change over time?

### 1.1. What's the challenge?
- The main challenge is that payments are not always directly linked to a specific invoice.
- Therefore, payment status cannot always be determined by simply joining an invoice to a payment record.

---

## 2. Data Model
### 2.1. Entity relationship model
The project contains the following tables:

- `Customers` – customer master data;
- `InvoiceServices` – services that can appear on an invoice;
- `Invoices` – customer invoices and their amounts;
- `Payments` – customer payment transactions.

<br>

Picture bellow:
<img width="1020" height="812" alt="image" src="https://github.com/user-attachments/assets/fc475c04-3302-4629-b4a3-ba1c59d8eba9" />


<br>

### 2.2. What is stored in the database?
<img width="1071" height="893" alt="image" src="https://github.com/user-attachments/assets/b8a74241-d987-4566-b17d-a34d706ff57b" />


<br>

---

## 3. How to solve the problem?
### 3.1. Stored procedure
The goal is to develop a reporting procedure (**spGetInvoicePayingDetails**) that:

- combines invoice and payment transactions
- orders transactions chronologically for each customer
- calculates a cumulative customer balance
- estimates whether an invoice has been paid by its due date
- supports filtering by a specific customer or returning results for all customers.

### 3.2. Example
- Example 1: Fetch records for all customers
<img width="952" height="887" alt="image" src="https://github.com/user-attachments/assets/98c38f43-7058-4a1a-96d4-ccd65c70ae9e" />

<br>

- Example 2: Report for a specific customer
<img width="968" height="551" alt="image" src="https://github.com/user-attachments/assets/c53d44d4-be11-4b42-bc83-027fbab59ee8" />

### 3.3. Procedure report analysis
- The procedure takes an optional parameter CustomerId (filter)
- When executing this SQL procedure, we get two result-sets:
    - 1st result-set contains a list of all the payments and invoices sorted by date column - ExecutedAt. This result-set is a confirmation that an invoice is paid or not, which can be determined by analysing the OwingAmount column
    - 2nd result-set contains more useful information (there is a column - IsPaid, which can tell us if an Invoice is paid or not)
<br>
---

## 3. Conclusion
- This project demonstrates a problem-solving approach to invoice payment tracking.
- Instead of relying on a simple invoice-to-payment join, the solution combines chronological invoice and payment transactions, calculates a running
customer balance and estimates whether each invoice is unpaid, partially paid or fully paid.
- Although the current solution works at customer level and does not provide complete invoice-level payment allocation, this limitation is explicitly
documented.
- A future `InvoicePayments` table could support precise allocation of payments to individual invoices.
- The main outcome is a practical SQL Server reporting solution that connects business requirements, relational data modelling, financial logic and testable reporting results.



