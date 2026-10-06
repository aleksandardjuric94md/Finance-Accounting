CREATE TABLE Invoices
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CustomerId INT NOT NULL,
    ServiceId INT NOT NULL,
    ExecutedAt DATE NOT NULL,
    DueDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    FOREIGN KEY (CustomerId) 
        REFERENCES Customers(Id),
    FOREIGN KEY (ServiceId) 
        REFERENCES InvoiceServices(Id),
    CONSTRAINT CK_Invoices_DueDate 
        CHECK (DueDate >= ExecutedAt)
);


CREATE NONCLUSTERED INDEX IX_CustomerId_ExecutedAt
ON Invoices
(
    CustomerId ASC,
    ExecutedAt ASC
);


--#region Insert 36 records
INSERT INTO Invoices 
(
    CustomerId, 
    ServiceId, 
    ExecutedAt, 
    DueDate, 
    Amount, 
    CreatedAt, 
    UpdatedAt
)
VALUES
-- John Smith (CustomerId = 1)
(1, 1, '2026-01-05', '2026-01-20', 1500.00, GETDATE(), GETDATE()),
(1, 2, '2026-02-01', '2026-03-01', 3000.00, GETDATE(), GETDATE()),
(1, 3, '2026-03-10', '2026-03-25', 500.00, GETDATE(), GETDATE()),

-- Emily Johnson (CustomerId = 2)
(2, 2, '2026-01-07', '2026-02-07', 2800.00, GETDATE(), GETDATE()),
(2, 4, '2026-02-15', '2026-03-01', 900.00, GETDATE(), GETDATE()),
(2, 5, '2026-03-05', '2026-03-20', 1200.00, GETDATE(), GETDATE()),

-- Michael Brown (CustomerId = 3)
(3, 3, '2026-01-10', '2026-01-25', 600.00, GETDATE(), GETDATE()),
(3, 6, '2026-02-12', '2026-02-28', 2000.00, GETDATE(), GETDATE()),
(3, 1, '2026-03-18', '2026-04-02', 1000.00, GETDATE(), GETDATE()),

-- Sarah Davis (CustomerId = 4)
(4, 4, '2026-01-12', '2026-01-22', 800.00, GETDATE(), GETDATE()),
(4, 2, '2026-02-20', '2026-03-20', 3200.00, GETDATE(), GETDATE()),
(4, 5, '2026-03-25', '2026-04-10', 1500.00, GETDATE(), GETDATE()),

-- David Wilson (CustomerId = 5)
(5, 5, '2026-01-15', '2026-02-01', 1100.00, GETDATE(), GETDATE()),
(5, 1, '2026-02-25', '2026-03-12', 1400.00, GETDATE(), GETDATE()),
(5, 6, '2026-03-28', '2026-04-15', 2200.00, GETDATE(), GETDATE()),

-- Laura Taylor (CustomerId = 6)
(6, 6, '2026-01-18', '2026-02-02', 2100.00, GETDATE(), GETDATE()),
(6, 3, '2026-02-10', '2026-02-25', 700.00, GETDATE(), GETDATE()),
(6, 2, '2026-03-15', '2026-04-01', 2800.00, GETDATE(), GETDATE()),

-- James Anderson (CustomerId = 7)
(7, 1, '2026-01-20', '2026-02-05', 950.00, GETDATE(), GETDATE()),
(7, 4, '2026-02-18', '2026-03-05', 850.00, GETDATE(), GETDATE()),
(7, 5, '2026-03-22', '2026-04-07', 1300.00, GETDATE(), GETDATE()),

-- Olivia Thomas (CustomerId = 8)
(8, 2, '2026-01-22', '2026-02-22', 3100.00, GETDATE(), GETDATE()),
(8, 6, '2026-02-28', '2026-03-15', 1800.00, GETDATE(), GETDATE()),
(8, 3, '2026-03-30', '2026-04-15', 650.00, GETDATE(), GETDATE()),

-- Robert Martinez (CustomerId = 9)
(9, 3, '2026-01-25', '2026-02-10', 550.00, GETDATE(), GETDATE()),
(9, 1, '2026-02-14', '2026-03-01', 1250.00, GETDATE(), GETDATE()),
(9, 5, '2026-03-26', '2026-04-12', 1450.00, GETDATE(), GETDATE()),

-- Sophia Garcia (CustomerId = 10)
(10, 4, '2026-01-27', '2026-02-12', 920.00, GETDATE(), GETDATE()),
(10, 2, '2026-02-22', '2026-03-22', 2700.00, GETDATE(), GETDATE()),
(10, 6, '2026-03-29', '2026-04-14', 1950.00, GETDATE(), GETDATE()),

-- William Harris (CustomerId = 11)
(11, 5, '2026-01-29', '2026-02-14', 1600.00, GETDATE(), GETDATE()),
(11, 3, '2026-02-27', '2026-03-13', 720.00, GETDATE(), GETDATE()),
(11, 1, '2026-03-31', '2026-04-16', 1350.00, GETDATE(), GETDATE()),

-- Isabella Clark (CustomerId = 12)
(12, 6, '2026-01-30', '2026-02-15', 2250.00, GETDATE(), GETDATE()),
(12, 4, '2026-02-24', '2026-03-10', 880.00, GETDATE(), GETDATE()),
(12, 2, '2026-03-27', '2026-04-12', 2950.00, GETDATE(), GETDATE());
--#ednregion
