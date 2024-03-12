/* Database Name: Web */

CREATE TABLE Users (
    UserID INT IDENTITY PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Landlords (
    LandlordID INT IDENTITY PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Articles (
    ArticleID INT IDENTITY PRIMARY KEY,
    Title NVARCHAR(255),
    Content TEXT,
    RegistrationDateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Properties (
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100),
    description TEXT,
    price DECIMAL(18, 2),
    location NVARCHAR(100),
    imageUrl NVARCHAR(200),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    LandlordID INT,
    FOREIGN KEY (LandlordID) REFERENCES Landlords(LandlordID)
);

CREATE TABLE Students (
    StudentID INT IDENTITY PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Warden (
    WardenID INT IDENTITY PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Admin (
    AdminID INT IDENTITY PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);


/* 

Sample Data

INSERT INTO Users (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES 
('john_doe', 'password123', 'john.doe@example.com', 'John', 'Doe', '1234567890'),
('jane_smith', 'letmein', 'jane.smith@example.com', 'Jane', 'Smith', '9876543210'),
('bob_jackson', 'bobpass', 'bob.jackson@example.com', 'Bob', 'Jackson', '5551234567'),
('alice_williams', 'alicepass', 'alice.williams@example.com', 'Alice', 'Williams', '5559876543'),
('david_miller', 'davidpass', 'david.miller@example.com', 'David', 'Miller', '5555555555'),
('sophia_brown', 'sophiapass', 'sophia.brown@example.com', 'Sophia', 'Brown', '5554444444'),
('michael_jones', 'michaelpass', 'michael.jones@example.com', 'Michael', 'Jones', '5553333333'),
('emma_davis', 'emmapass', 'emma.davis@example.com', 'Emma', 'Davis', '5552222222'),
('olivia_martin', 'oliviapass', 'olivia.martin@example.com', 'Olivia', 'Martin', '5551111111'),
('william_taylor', 'williampass', 'william.taylor@example.com', 'William', 'Taylor', '5550000000');

INSERT INTO Landlords (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES 
('landlord1', 'landlordpass', 'landlord1@example.com', 'Bob', 'Landlord', '5551234567'),
('landlord2', 'password', 'landlord2@example.com', 'Alice', 'Landlord', '5559876543'),
('landlord3', 'landlord3pass', 'landlord3@example.com', 'Chris', 'Landlord', '5551112222'),
('landlord4', 'landlord4pass', 'landlord4@example.com', 'Diana', 'Landlord', '5553334444'),
('landlord5', 'landlord5pass', 'landlord5@example.com', 'Eva', 'Landlord', '5555556666'),
('landlord6', 'landlord6pass', 'landlord6@example.com', 'Frank', 'Landlord', '5557778888'),
('landlord7', 'landlord7pass', 'landlord7@example.com', 'Grace', 'Landlord', '5559990000'),
('landlord8', 'landlord8pass', 'landlord8@example.com', 'Henry', 'Landlord', '5552223333'),
('landlord9', 'landlord9pass', 'landlord9@example.com', 'Isabel', 'Landlord', '5554445555'),
('landlord10', 'landlord10pass', 'landlord10@example.com', 'Jack', 'Landlord', '5556667777');

INSERT INTO Articles (Title, Content, UserID)
VALUES 
('Top 10 Tips for Renters', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 1),
('How to Find the Perfect Rental Property', 'Nulla ac bibendum arcu. Nam pretium purus vitae risus blandit, vitae venenatis sapien sodales.', 2),
('The Benefits of Renting vs. Buying', 'Pellentesque ac neque eu quam rutrum congue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi sit amet dolor libero.', 3),
('Essential Questions to Ask Before Renting', 'Vestibulum auctor nisl nec risus fermentum, vitae efficitur velit convallis. Fusce laoreet convallis sapien, ac varius felis laoreet nec.', 4),
('How to Deal with Difficult Landlords', 'Quisque ultricies, libero non fermentum pellentesque, libero ex pellentesque purus, nec lobortis libero tortor et nulla.', 5),
('10 Must-Have Amenities for Renters', 'Maecenas non libero a magna tempus luctus vel eu libero. Morbi convallis orci ut mi consectetur, et maximus justo tempor.', 6),
('The Importance of Rental Insurance', 'Aliquam erat volutpat. Fusce eget sapien pharetra, mattis ligula sed, ullamcorper leo.', 7),
('How to Budget for Rent and Utilities', 'Sed nec tellus quis purus bibendum ultrices. Integer vehicula neque ac risus convallis efficitur.', 8),
('Tips for Finding a Roommate', 'Fusce tincidunt, ex ac consectetur ullamcorper, risus neque ullamcorper ligula, eget fermentum nibh justo a elit.', 9),
('The Rental Application Process Explained', 'Mauris at augue sed magna posuere consequat. In in odio et est suscipit fermentum.', 10);

INSERT INTO Properties (name, description, price, location, imageUrl, LandlordID)
VALUES 
('Cozy Apartment Near Park', 'A beautiful apartment located close to the city park.', 1200.00, '123 Main St, Cityville', 'https://example.com/apartment1.jpg', 1),
('Spacious House with Garden', 'A spacious house with a large garden, perfect for families.', 2500.00, '456 Oak St, Townsville', 'https://example.com/house1.jpg', 2),
('Modern Condo in Downtown', 'Stunning views from this modern condo in the heart of downtown.', 1800.00, '789 Elm St, Metropolis', 'https://example.com/condo1.jpg', 3),
('Charming Townhouse Near Beach', 'Enjoy seaside living in this charming townhouse just steps from the beach.', 2200.00, '321 Beach Blvd, Seaside', 'https://example.com/townhouse1.jpg', 4),
('Luxury Penthouse with City Views', 'Experience luxury living in this penthouse with panoramic city views.', 3500.00, '555 Skyline Ave, Urbania', 'https://example.com/penthouse1.jpg', 5),
('Cozy Studio Apartment', 'Compact yet comfortable studio apartment with modern amenities.', 1000.00, '987 Pine St, Cosyville', 'https://example.com/studio1.jpg', 6),
('Family-Friendly Suburban Home', 'Spacious home in a family-friendly neighborhood with easy access to schools and parks.', 2800.00, '654 Maple St, Suburbia', 'https://example.com/home1.jpg', 7),
('Rustic Cabin Retreat', 'Escape to nature in this cozy rustic cabin nestled in the woods.', 1500.00, '101 Forest Ln, Serenity Valley', 'https://example.com/cabin1.jpg', 8),
('Urban Loft with Industrial Charm', 'Industrial chic meets urban living in this stylish loft apartment.', 2000.00, '246 Warehouse St, Loftville', 'https://example.com/loft1.jpg', 9),
('Historic Mansion with Vintage Elegance', 'Step back in time in this beautifully preserved historic mansion.', 5000.00, '888 Heritage Rd, Vintage City', 'https://example.com/mansion1.jpg', 10);

INSERT INTO Students (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES 
('student1', 'studentpass', 'student1@example.com', 'Emma', 'Student', '5551112233'),
('student2', 'letmein', 'student2@example.com', 'Michael', 'Student', '5553332211'),
('student3', 'student3pass', 'student3@example.com', 'Sophie', 'Student', '5555554433'),
('student4', 'student4pass', 'student4@example.com', 'Oliver', 'Student', '5552225544'),
('student5', 'student5pass', 'student5@example.com', 'Emily', 'Student', '5558887766'),
('student6', 'student6pass', 'student6@example.com', 'Jacob', 'Student', '5554446677'),
('student7', 'student7pass', 'student7@example.com', 'Ava', 'Student', '5557778899'),
('student8', 'student8pass', 'student8@example.com', 'William', 'Student', '5559990011'),
('student9', 'student9pass', 'student9@example.com', 'Sophia', 'Student', '5553331122'),
('student10', 'student10pass', 'student10@example.com', 'James', 'Student', '5556662233');

INSERT INTO Warden (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES 
('warden1', 'wardenpass', 'warden1@example.com', 'Sarah', 'Warden', '5554445566'),
('warden2', 'adminpass', 'warden2@example.com', 'David', 'Warden', '5557778899'),
('warden3', 'warden3pass', 'warden3@example.com', 'Jennifer', 'Warden', '5553332211'),
('warden4', 'warden4pass', 'warden4@example.com', 'Michael', 'Warden', '5552223344'),
('warden5', 'warden5pass', 'warden5@example.com', 'Jessica', 'Warden', '5558887766'),
('warden6', 'warden6pass', 'warden6@example.com', 'Kevin', 'Warden', '5554446677'),
('warden7', 'warden7pass', 'warden7@example.com', 'Hannah', 'Warden', '5557778899'),
('warden8', 'warden8pass', 'warden8@example.com', 'Andrew', 'Warden', '5559990011'),
('warden9', 'warden9pass', 'warden9@example.com', 'Rachel', 'Warden', '5553331122'),
('warden10', 'warden10pass', 'warden10@example.com', 'Daniel', 'Warden', '5556662233');

INSERT INTO Admin (Username, Password, Email, FirstName, LastName, PhoneNumber)
VALUES 
('admin1', 'adminpass', 'admin1@example.com', 'Admin', 'One', '5550001111'),
('admin2', 'admin123', 'admin2@example.com', 'Admin', 'Two', '5552223333'),
('admin3', 'admin3pass', 'admin3@example.com', 'Admin', 'Three', '5554445555'),
('admin4', 'admin4pass', 'admin4@example.com', 'Admin', 'Four', '5556667777'),
('admin5', 'admin5pass', 'admin5@example.com', 'Admin', 'Five', '5558889999'),
('admin6', 'admin6pass', 'admin6@example.com', 'Admin', 'Six', '5551112222'),
('admin7', 'admin7pass', 'admin7@example.com', 'Admin', 'Seven', '5553334444'),
('admin8', 'admin8pass', 'admin8@example.com', 'Admin', 'Eight', '5555556666'),
('admin9', 'admin9pass', 'admin9@example.com', 'Admin', 'Nine', '5557778888'),
('admin10', 'admin10pass', 'admin10@example.com', 'Admin', 'Ten', '5559990000');

*/