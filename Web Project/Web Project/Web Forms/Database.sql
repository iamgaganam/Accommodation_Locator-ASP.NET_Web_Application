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

/* 

Dataset

INSERT INTO Users (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('user1', 'password1', 'user1@example.com', 'John', 'Doe', '1234567890'),
('user2', 'password2', 'user2@example.com', 'Jane', 'Smith', '9876543210'),
('user3', 'password3', 'user3@example.com', 'Michael', 'Johnson', '5551234567'),
('user4', 'password4', 'user4@example.com', 'Emily', 'Brown', '5559876543'),
('user5', 'password5', 'user5@example.com', 'David', 'Lee', '1112223333'),
('user6', 'password6', 'user6@example.com', 'Sarah', 'Wilson', '4445556666'),
('user7', 'password7', 'user7@example.com', 'Daniel', 'Martinez', '7778889999'),
('user8', 'password8', 'user8@example.com', 'Olivia', 'Taylor', '2223334444'),
('user9', 'password9', 'user9@example.com', 'William', 'Anderson', '6667778888'),
('user10', 'password10', 'user10@example.com', 'Sophia', 'Hernandez', '9990001111');

INSERT INTO Admin (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('admin1', 'adminpass1', 'admin1@example.com', 'Admin', 'One', '1234567890'),
('admin2', 'adminpass2', 'admin2@example.com', 'Admin', 'Two', '9876543210'),
('admin3', 'adminpass3', 'admin3@example.com', 'Admin', 'Three', '5551234567'),
('admin4', 'adminpass4', 'admin4@example.com', 'Admin', 'Four', '5559876543'),
('admin5', 'adminpass5', 'admin5@example.com', 'Admin', 'Five', '1112223333'),
('admin6', 'adminpass6', 'admin6@example.com', 'Admin', 'Six', '4445556666'),
('admin7', 'adminpass7', 'admin7@example.com', 'Admin', 'Seven', '7778889999'),
('admin8', 'adminpass8', 'admin8@example.com', 'Admin', 'Eight', '2223334444'),
('admin9', 'adminpass9', 'admin9@example.com', 'Admin', 'Nine', '6667778888'),
('admin10', 'adminpass10', 'admin10@example.com', 'Admin', 'Ten', '9990001111');

INSERT INTO Landlords (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('landlord1', 'landlordpass1', 'landlord1@example.com', 'Mark', 'Williams', '1234567890'),
('landlord2', 'landlordpass2', 'landlord2@example.com', 'Emma', 'Jones', '9876543210'),
('landlord3', 'landlordpass3', 'landlord3@example.com', 'James', 'Brown', '5551234567'),
('landlord4', 'landlordpass4', 'landlord4@example.com', 'Sophie', 'Davis', '5559876543'),
('landlord5', 'landlordpass5', 'landlord5@example.com', 'Chris', 'Wilson', '1112223333'),
('landlord6', 'landlordpass6', 'landlord6@example.com', 'Lucy', 'Taylor', '4445556666'),
('landlord7', 'landlordpass7', 'landlord7@example.com', 'Tom', 'Martinez', '7778889999'),
('landlord8', 'landlordpass8', 'landlord8@example.com', 'Rachel', 'Johnson', '2223334444'),
('landlord9', 'landlordpass9', 'landlord9@example.com', 'Adam', 'Anderson', '6667778888'),
('landlord10', 'landlordpass10', 'landlord10@example.com', 'Maria', 'Hernandez', '9990001111');

INSERT INTO Students (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('student1', 'studentpass1', 'student1@example.com', 'Alex', 'Smith', '1234567890'),
('student2', 'studentpass2', 'student2@example.com', 'Megan', 'Johnson', '9876543210'),
('student3', 'studentpass3', 'student3@example.com', 'Ryan', 'Williams', '5551234567'),
('student4', 'studentpass4', 'student4@example.com', 'Sophia', 'Brown', '5559876543'),
('student5', 'studentpass5', 'student5@example.com', 'Ethan', 'Taylor', '1112223333'),
('student6', 'studentpass6', 'student6@example.com', 'Lily', 'Davis', '4445556666'),
('student7', 'studentpass7', 'student7@example.com', 'Noah', 'Martinez', '7778889999'),
('student8', 'studentpass8', 'student8@example.com', 'Ava', 'Wilson', '2223334444'),
('student9', 'studentpass9', 'student9@example.com', 'Logan', 'Jones', '6667778888'),
('student10', 'studentpass10', 'student10@example.com', 'Isabella', 'Anderson', '9990001111');

INSERT INTO Warden (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES
('warden1', 'wardenpass1', 'warden1@example.com', 'Warden', 'One', '1234567890'),
('warden2', 'wardenpass2', 'warden2@example.com', 'Warden', 'Two', '9876543210'),
('warden3', 'wardenpass3', 'warden3@example.com', 'Warden', 'Three', '5551234567'),
('warden4', 'wardenpass4', 'warden4@example.com', 'Warden', 'Four', '5559876543'),
('warden5', 'wardenpass5', 'warden5@example.com', 'Warden', 'Five', '1112223333'),
('warden6', 'wardenpass6', 'warden6@example.com', 'Warden', 'Six', '4445556666'),
('warden7', 'wardenpass7', 'warden7@example.com', 'Warden', 'Seven', '7778889999'),
('warden8', 'wardenpass8', 'warden8@example.com', 'Warden', 'Eight', '2223334444'),
('warden9', 'wardenpass9', 'warden9@example.com', 'Warden', 'Nine', '6667778888'),
('warden10', 'wardenpass10', 'warden10@example.com', 'Warden', 'Ten', '9990001111');

INSERT INTO Articles (Title, Content, UserID)
VALUES
('Top 10 Tips for Finding Off-Campus Housing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 1),
('Navigating the Rental Market: A Student’s Guide', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 2),
('The Ultimate Checklist for Renting Your First Apartment', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 3),
('Budgeting for Rent: How to Manage Your Finances Wisely', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
('Roommate Etiquette: Living in Harmony with Others', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 5),
('Decorating Your Dorm Room on a Budget', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 6),
('Tips for Negotiating Your Lease Agreement', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 7),
('Finding the Perfect Neighborhood: What to Look For', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 8),
('Managing Utilities: Tips for Splitting Bills with Roommates', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 9),
('Moving Out: A Step-by-Step Guide to a Smooth Transition', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 10);

INSERT INTO Properties (name, description, price, location, imageUrl, LandlordID, latitude, longitude, status)
VALUES
('Cozy Apartment near Campus', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 1200.00, '123 University Ave', 'https://example.com/apartment1.jpg', 1, '40.7128', '-74.0060', 1),
('Spacious Studio in Downtown', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 1500.00, '456 Main St', 'https://example.com/apartment2.jpg', 2, '34.0522', '-118.2437', 1),
('Charming Townhouse with Garden', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 1800.00, '789 Elm St', 'https://example.com/house1.jpg', 3, '51.5074', '-0.1278', 1),
('Modern Loft with City Views', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 2000.00, '101 Oak St', 'https://example.com/apartment3.jpg', 4, '51.5074', '-0.1278', 1),
('Coastal Condo with Ocean View', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 2500.00, '555 Beach Blvd', 'https://example.com/apartment4.jpg', 5, '34.0522', '-118.2437', 1),
('Luxury Penthouse in Skyline Tower', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 5000.00, '1 Skyline Dr', 'https://example.com/penthouse.jpg', 6, '40.7128', '-74.0060', 1),
('Quaint Cottage in Suburbia', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 1600.00, '222 Pine St', 'https://example.com/house2.jpg', 7, '40.7128', '-74.0060', 1),
('Rustic Cabin Retreat in the Woods', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 1000.00, '333 Forest Rd', 'https://example.com/cabin.jpg', 8, '34.0522', '-118.2437', 1),
('Urban Apartment with Rooftop Pool', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 2200.00, '777 High St', 'https://example.com/apartment5.jpg', 9, '51.5074', '-0.1278', 1),
('Family Home with Large Backyard', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 2800.00, '999 Maple Ave', 'https://example.com/house3.jpg', 10, '51.5074', '-0.1278', 1); 

*/
