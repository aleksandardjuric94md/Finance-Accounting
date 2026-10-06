CREATE TABLE Payments
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CustomerId INT NOT NULL,             
    ExecutedAt DATE NOT NULL,           
    Amount DECIMAL(10,2) NOT NULL,       
    PaymentMethod NVARCHAR(50) NOT NULL, 
    ReferenceNumber NVARCHAR(100) NULL,  
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    CONSTRAINT CK_Payments_AmountGreaterThanZero CHECK (Amount > 0) 
);

CREATE NONCLUSTERED INDEX IX_Payments_CustomerId_ExecutedAt
ON Payments
(
    CustomerId ASC,
    ExecutedAt ASC
);

--#region Insert 21 records
INSERT INTO Payments 
(
    CustomerId, 
    ExecutedAt, 
    Amount, 
    PaymentMethod, 
    ReferenceNumber, 
    CreatedAt, 
    UpdatedAt
)
VALUES
-- John Smith (CustomerId = 1) – paid all the invoices
(1, '2026-01-15', 1500.00, 'Bank Transfer', 'TXN-1001', GETDATE(), GETDATE()),
(1, '2026-02-10', 3000.00, 'Credit Card', 'TXN-1002', GETDATE(), GETDATE()),
(1, '2026-03-20', 500.00, 'Bank Transfer', 'TXN-1003', GETDATE(), GETDATE()),

-- Emily Johnson (CustomerId = 2) – paid only half of an invoice
(2, '2026-01-25', 1400.00, 'Cash', 'TXN-2001', GETDATE(), GETDATE()),

-- Michael Brown (CustomerId = 3) – has two payments for one invoice record
(3, '2026-02-15', 1000.00, 'Bank Transfer', 'TXN-3001', GETDATE(), GETDATE()),
(3, '2026-02-20', 1000.00, 'Bank Transfer', 'TXN-3002', GETDATE(), GETDATE()),

-- Sarah Davis (CustomerId = 4) – paid nothing (no records)

-- David Wilson (CustomerId = 5) – paid only one invoice 
(5, '2026-01-25', 1100.00, 'Credit Card', 'TXN-5001', GETDATE(), GETDATE()),

-- Laura Taylor (CustomerId = 6) – paid everything
(6, '2026-01-28', 2100.00, 'Bank Transfer', 'TXN-6001', GETDATE(), GETDATE()),
(6, '2026-02-20', 700.00, 'Cash', 'TXN-6002', GETDATE(), GETDATE()),
(6, '2026-03-25', 2800.00, 'Bank Transfer', 'TXN-6003', GETDATE(), GETDATE()),

-- James Anderson (CustomerId = 7) – paid half of an invoice (still owes all invoices)
(7, '2026-02-25', 425.00, 'Credit Card', 'TXN-7001', GETDATE(), GETDATE()),

-- Olivia Thomas (CustomerId = 8) – paid everything
(8, '2026-02-05', 3100.00, 'Bank Transfer', 'TXN-8001', GETDATE(), GETDATE()),
(8, '2026-03-10', 1800.00, 'Credit Card', 'TXN-8002', GETDATE(), GETDATE()),
(8, '2026-04-05', 650.00, 'Bank Transfer', 'TXN-8003', GETDATE(), GETDATE()),

-- Robert Martinez (CustomerId = 9) – paid nothing

-- Sophia Garcia (CustomerId = 10) – paid everything
(10, '2026-02-01', 920.00, 'Cash', 'TXN-10001', GETDATE(), GETDATE()),
(10, '2026-03-05', 2700.00, 'Bank Transfer', 'TXN-10002', GETDATE(), GETDATE()),
(10, '2026-04-10', 1950.00, 'Credit Card', 'TXN-10003', GETDATE(), GETDATE()),

-- William Harris (CustomerId = 11) – paid only one invoice 
(11, '2026-02-10', 1600.00, 'Bank Transfer', 'TXN-11001', GETDATE(), GETDATE()),

-- Isabella Clark (CustomerId = 12) – paid all invoices
(12, '2026-02-05', 2250.00, 'Credit Card', 'TXN-12001', GETDATE(), GETDATE()),
(12, '2026-03-01', 880.00, 'Bank Transfer', 'TXN-12002', GETDATE(), GETDATE()),
(12, '2026-04-05', 2950.00, 'Bank Transfer', 'TXN-12003', GETDATE(), GETDATE());
--#endregion
