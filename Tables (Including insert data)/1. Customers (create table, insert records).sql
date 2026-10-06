CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	FirstName NVARCHAR(200) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	City NVARCHAR(100) NULL,
	Country NVARCHAR(100) NULL,
	Email NVARCHAR(200) NULL,
	Phone NVARCHAR(30) NULL,
	IsActive BIT NOT NULL,
	CreatedAt DATETIME NOT NULL,
	UpdatedAt DATETIME NOT NULL,
);


INSERT INTO Customers (FirstName, LastName, City, Country, Email, Phone, IsActive, CreatedAt, UpdatedAt)
VALUES
('John', 'Smith', 'New York', 'USA', 'john.smith@example.com', '+1-212-555-0101', 1, GETDATE(), GETDATE()),
('Emily', 'Johnson', 'Los Angeles', 'USA', 'emily.johnson@example.com', '+1-310-555-0202', 1, GETDATE(), GETDATE()),
('Michael', 'Brown', 'Chicago', 'USA', 'michael.brown@example.com', '+1-773-555-0303', 1, GETDATE(), GETDATE()),
('Sarah', 'Davis', 'Houston', 'USA', 'sarah.davis@example.com', '+1-713-555-0404', 0, GETDATE(), GETDATE()),
('David', 'Wilson', 'Seattle', 'USA', 'david.wilson@example.com', '+1-206-555-0505', 1, GETDATE(), GETDATE()),
('Laura', 'Taylor', 'Boston', 'USA', 'laura.taylor@example.com', '+1-617-555-0606', 1, GETDATE(), GETDATE()),
('James', 'Anderson', 'San Francisco', 'USA', 'james.anderson@example.com', '+1-415-555-0707', 1, GETDATE(), GETDATE()),
('Olivia', 'Thomas', 'Miami', 'USA', 'olivia.thomas@example.com', '+1-305-555-0808', 1, GETDATE(), GETDATE()),
('Robert', 'Martinez', 'Dallas', 'USA', 'robert.martinez@example.com', '+1-214-555-0909', 0, GETDATE(), GETDATE()),
('Sophia', 'Garcia', 'Denver', 'USA', 'sophia.garcia@example.com', '+1-303-555-1010', 1, GETDATE(), GETDATE()),
('William', 'Harris', 'Atlanta', 'USA', 'william.harris@example.com', '+1-404-555-1111', 1, GETDATE(), GETDATE()),
('Isabella', 'Clark', 'Phoenix', 'USA', 'isabella.clark@example.com', '+1-602-555-1212', 1, GETDATE(), GETDATE());



