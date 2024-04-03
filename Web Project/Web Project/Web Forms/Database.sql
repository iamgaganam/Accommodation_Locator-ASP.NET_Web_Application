/* Database Name: Web */

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Admin (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Landlords (
    LandlordID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Warden (
    WardenID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Articles (
    ArticleID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255),
    Content NVARCHAR(MAX),
    RegistrationDateTime DATETIME DEFAULT GETDATE(),
    UserID INT,
    CONSTRAINT FK_Articles_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Properties (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    description NVARCHAR(MAX),
    price DECIMAL(18, 2),
    location NVARCHAR(100),
    imageUrl NVARCHAR(200),
    registration_date DATETIME DEFAULT GETDATE(),
    LandlordID INT,
    latitude NVARCHAR(MAX),
    longitude NVARCHAR(MAX),
    status BIT,
    CONSTRAINT FK_Properties_Landlords FOREIGN KEY (LandlordID) REFERENCES Landlords(LandlordID)
);

CREATE TABLE Reservations (
    ReservationID INT IDENTITY(1,1) PRIMARY KEY,
    PropertyID INT NOT NULL,
    StudentID INT NOT NULL,
    ReservationDateTime DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL, -- Status of the reservation (e.g., Pending, Accepted, Rejected)
    CONSTRAINT FK_Reservations_Properties FOREIGN KEY (PropertyID) REFERENCES Properties(id),
    CONSTRAINT FK_Reservations_Students FOREIGN KEY (StudentID) REFERENCES Users(UserID)
);

/* 

Dataset

-- Inserting sample data into Users table
INSERT INTO Users (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('landlord1', 'password1', 'landlord1@example.com', 'John', 'Doe', '123-456-7890'),
('landlord2', 'password2', 'landlord2@example.com', 'Jane', 'Smith', '987-654-3210'),
('student1', 'password1', 'student1@example.com', 'Alice', 'Johnson', '456-789-0123'),
('student2', 'password2', 'student2@example.com', 'Bob', 'Brown', '789-012-3456'),
('warden1', 'password1', 'warden1@example.com', 'Chris', 'Lee', '321-654-9870'),
('admin1', 'adminpassword', 'admin1@example.com', 'Admin', 'Adminson', '999-999-9999'),
('landlord3', 'password3', 'landlord3@example.com', 'Michael', 'Johnson', '111-222-3333'),
('landlord4', 'password4', 'landlord4@example.com', 'Emily', 'Wilson', '444-555-6666'),
('landlord5', 'password5', 'landlord5@example.com', 'David', 'Martinez', '777-888-9999'),
('landlord6', 'password6', 'landlord6@example.com', 'Jessica', 'Brown', '666-777-8888');

-- Inserting sample data into Articles table
INSERT INTO Articles (Title, Content, UserID)
VALUES
('Tips for Finding the Perfect Accommodation', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('How to Choose the Right Roommate', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('Budgeting Tips for Students', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('Living Off-Campus: Pros and Cons', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('Essential Items for Your First Apartment', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('How to Negotiate Rent with Your Landlord', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('Safety Tips for Renting a Property', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('Decorating Your Rental Without Losing Your Deposit', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('Finding Roommates: Dos and Don’ts', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6),
('Creating a Budget for Your Rent and Utilities', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 6);

-- Inserting sample data into Landlords table
INSERT INTO Landlords (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('landlord7', 'password7', 'landlord7@example.com', 'Alex', 'Davis', '135-246-7890'),
('landlord8', 'password8', 'landlord8@example.com', 'Emma', 'Thomas', '258-369-1470'),
('landlord9', 'password9', 'landlord9@example.com', 'Olivia', 'Wilson', '147-258-3690'),
('landlord10', 'password10', 'landlord10@example.com', 'James', 'Johnson', '369-147-2580'),
('landlord11', 'password11', 'landlord11@example.com', 'Sophia', 'Brown', '258-147-3690'),
('landlord12', 'password12', 'landlord12@example.com', 'Mia', 'Martinez', '369-258-1470'),
('landlord13', 'password13', 'landlord13@example.com', 'Daniel', 'Taylor', '147-369-2580'),
('landlord14', 'password14', 'landlord14@example.com', 'Charlotte', 'White', '258-369-1470'),
('landlord15', 'password15', 'landlord15@example.com', 'Lucas', 'Lee', '369-258-1470'),
('landlord16', 'password16', 'landlord16@example.com', 'Liam', 'Garcia', '147-258-3690');

-- Inserting sample data into Students table
INSERT INTO Students (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('student3', 'password3', 'student3@example.com', 'Sarah', 'Taylor', '012-345-6789'),
('student4', 'password4', 'student4@example.com', 'Alex', 'Davis', '135-246-7890'),
('student5', 'password5', 'student5@example.com', 'Emma', 'Thomas', '258-369-1470'),
('student6', 'password6', 'student6@example.com', 'Noah', 'White', '369-147-2580'),
('student7', 'password7', 'student7@example.com', 'Olivia', 'Garcia', '147-258-3690'),
('student8', 'password8', 'student8@example.com', 'William', 'Martinez', '258-147-3690'),
('student9', 'password9', 'student9@example.com', 'James', 'Brown', '369-258-1470'),
('student10', 'password10', 'student10@example.com', 'Sophia', 'Johnson', '147-369-2580'),
('student11', 'password11', 'student11@example.com', 'Michael', 'Lee', '258-369-1470'),
('student12', 'password12', 'student12@example.com', 'Liam', 'Smith', '369-258-1470');

-- Inserting sample data into Warden table
INSERT INTO Warden (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('warden2', 'password2', 'warden2@example.com', 'Jessica', 'Wilson', '987-654-3210'),
('warden3', 'password3', 'warden3@example.com', 'Michael', 'Smith', '123-456-7890'),
('warden4', 'password4', 'warden4@example.com', 'Emily', 'Johnson', '987-654-1230'),
('warden5', 'password5', 'warden5@example.com', 'David', 'Brown', '789-456-1230'),
('warden6', 'password6', 'warden6@example.com', 'Olivia', 'Martinez', '147-258-3690'),
('warden7', 'password7', 'warden7@example.com', 'Noah', 'Taylor', '369-147-2580'),
('warden8', 'password8', 'warden8@example.com', 'Sophia', 'Jones', '258-369-1470'),
('warden9', 'password9', 'warden9@example.com', 'Ethan', 'Garcia', '369-258-1470'),
('warden10', 'password10', 'warden10@example.com', 'Ava', 'Anderson', '258-147-3690'),
('warden11', 'password11', 'warden11@example.com', 'James', 'Wilson', '369-258-1470');

-- Inserting sample data into Properties table
INSERT INTO Properties (name, description, price, location, imageUrl, LandlordID, latitude, longitude, status)
VALUES
('Cozy Apartment Near Campus', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 700, '123 Main St', 'https://example.com/apartment1.jpg', 1, '40.7128', '-74.0060', 1),
('Spacious House with Garden', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 1200, '456 Elm St', 'https://example.com/house1.jpg', 2, '34.0522', '-118.2437', 1),
('Studio Apartment with Modern Amenities', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 900, '789 Oak St', 'https://example.com/apartment2.jpg', 3, '51.5074', '-0.1278', 1),
('Apartment with City View', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 1000, '101 Broadway', 'https://example.com/apartment3.jpg', 4, '40.7128', '-74.0060', 1),
('Modern Loft in Downtown', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 850, '202 Pine St', 'https://example.com/loft1.jpg', 5, '34.0522', '-118.2437', 1),
('Charming Townhouse Near Park', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 1100, '303 Oak St', 'https://example.com/townhouse1.jpg', 6, '51.5074', '-0.1278', 1),
('Studio Apartment with River View', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 750, '404 River St', 'https://example.com/apartment4.jpg', 7, '40.7128', '-74.0060', 1),
('Cozy Cottage in Suburbs', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 950, '505 Maple St', 'https://example.com/cottage1.jpg', 8, '34.0522', '-118.2437', 1),
('Luxury Condo with Amenities', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 1500, '606 High St', 'https://example.com/condo1.jpg', 9, '51.5074', '-0.1278', 1),
('Rustic Cabin Retreat', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisi eu massa eleifend interdum.', 800, '707 Forest St', 'https://example.com/cabin1.jpg', 10, '40.7128', '-74.0060', 1);

-- Inserting sample data into Reservations table
INSERT INTO Reservations (PropertyID, StudentID, Status)
VALUES
(1, 3, 'Pending'),
(2, 4, 'Accepted'),
(3, 5, 'Pending'),
(4, 6, 'Pending'),
(5, 7, 'Pending'),
(6, 8, 'Pending'),
(7, 9, 'Pending'),
(8, 10, 'Pending'),
(9, 11, 'Pending'),
(10, 12, 'Pending');

*/
