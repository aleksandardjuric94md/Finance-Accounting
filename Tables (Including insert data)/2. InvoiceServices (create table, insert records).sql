CREATE TABLE InvoiceServices
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NULL
);

INSERT INTO InvoiceServices (Name, Description)
VALUES
('Consulting', 'Hourly consulting services for business clients'),
('Software License', 'Annual license fee for enterprise software'),
('Maintenance', 'Monthly maintenance and support contract'),
('Training', 'On-site or online training sessions'),
('Hosting', 'Cloud hosting and infrastructure services'),
('Audit', 'Financial or technical audit services');
