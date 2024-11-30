-- Create the database
CREATE DATABASE BloodDonationCenter;

-- Use the database
USE BloodDonationCenter;

-- Create table for users
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    BloodGroup ENUM('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-') NOT NULL,
    Address TEXT,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for blood banks
CREATE TABLE BloodBanks (
    BloodBankID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    EstablishedYear YEAR,
    Capacity INT DEFAULT 0
);

-- Create table for donations
CREATE TABLE Donations (
    DonationID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    BloodBankID INT NOT NULL,
    DonationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Quantity DECIMAL(5, 2) NOT NULL COMMENT 'Quantity in liters',
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (BloodBankID) REFERENCES BloodBanks(BloodBankID) ON DELETE CASCADE
);

-- Insert sample data into Users table
INSERT INTO Users (FullName, Email, PhoneNumber, BloodGroup, Address, DateOfBirth, Gender)
VALUES
('John Doe', 'john.doe@example.com', '+91-9876543210', 'O+', '123 Main Street, Delhi', '1990-01-15', 'Male'),
('Jane Smith', 'jane.smith@example.com', '+91-8765432109', 'A+', '456 Elm Street, Mumbai', '1985-06-23', 'Female'),
('Raj Patel', 'raj.patel@example.com', '+91-7654321098', 'B-', '789 Maple Avenue, Bangalore', '1992-11-10', 'Male');

-- Insert sample data into BloodBanks table
INSERT INTO BloodBanks (Name, Location, ContactNumber, Email, EstablishedYear, Capacity)
VALUES
('City Hospital Blood Bank', 'Delhi', '+91-12345-67890', 'cityhospital@example.com', 2000, 500),
('Red Cross Blood Bank', 'Mumbai', '+91-23456-78901', 'redcross@example.com', 1995, 700),
('Life Care Blood Donation Center', 'Bangalore', '+91-34567-89012', 'lifecare@example.com', 2010, 600),
('Chhattisgarh Blood Bank', 'Raipur, Chhattisgarh', '+91-56789-01234', 'chhattisgarhbb@example.com', 2005, 400),
('Bhilai Blood Donation Center', 'Bhilai, Chhattisgarh', '+91-67890-12345', 'bhilaibb@example.com', 2012, 450);

-- Insert sample data into Donations table
INSERT INTO Donations (UserID, BloodBankID, Quantity)
VALUES
(1, 1, 0.5),
(2, 2, 0.45),
(3, 3, 0.6),
(1, 4, 0.7),
(2, 5, 0.55);

-- Query to display all donation records
SELECT
    d.DonationID,
    u.FullName AS DonorName,
    u.BloodGroup,
    b.Name AS BloodBankName,
    d.Quantity AS QuantityInLiters,
    d.DonationDate
FROM
    Donations d
JOIN
    Users u ON d.UserID = u.UserID
JOIN
    BloodBanks b ON d.BloodBankID = b.BloodBankID
ORDER BY
    d.DonationDate DESC;
