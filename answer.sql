-- 1. Create the database
CREATE DATABASE ClinicBookingSystem;

-- 2. Use the database
USE ClinicBookingSystem;

-- 3. Create the Patients table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Address TEXT
);

-- 4. Create the Doctors table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Create the Appointments table
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- 6. Create the Treatments table
CREATE TABLE Treatments (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    TreatmentName VARCHAR(255) NOT NULL,
    Description TEXT
);

-- 7. Create the Appointment_Treatments table (junction table for Many-to-Many relationship)
CREATE TABLE Appointment_Treatments (
    AppointmentID INT NOT NULL,
    TreatmentID INT NOT NULL,
    PRIMARY KEY (AppointmentID, TreatmentID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
);

-- 8. Create the Visits table to track patient's history of visits
CREATE TABLE Visits (
    VisitID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    VisitDate DATETIME NOT NULL,
    TreatmentDetails TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- 9. Add a few sample entries into the Patients table
INSERT INTO Patients (FirstName, LastName, DOB, Gender, Phone, Email, Address) VALUES
('John', 'Doe', '1985-02-15', 'Male', '123-456-7890', 'john.doe@example.com', '123 Main St'),
('Jane', 'Smith', '1992-07-24', 'Female', '987-654-3210', 'jane.smith@example.com', '456 Oak St');

-- 10. Add sample entries into the Doctors table
INSERT INTO Doctors (FirstName, LastName, Specialty, Phone, Email) VALUES
('Dr. Alice', 'Johnson', 'Cardiology', '123-987-6543', 'alice.johnson@example.com'),
('Dr. Bob', 'Williams', 'Neurology', '987-123-4567', 'bob.williams@example.com');

-- 11. Add sample entries into the Treatments table
INSERT INTO Treatments (TreatmentName, Description) VALUES
('ECG', 'Electrocardiogram for heart monitoring'),
('MRI', 'Magnetic resonance imaging for brain scan');

-- 12. Add sample appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status) VALUES
(1, 1, '2025-05-12 10:00:00', 'Scheduled'),
(2, 2, '2025-05-13 11:00:00', 'Scheduled');

-- 13. Add sample treatments for appointments
INSERT INTO Appointment_Treatments (AppointmentID, TreatmentID) VALUES
(1, 1),  -- Patient 1, Doctor 1, ECG
(2, 2);  -- Patient 2, Doctor 2, MRI

-- 14. Add a sample visit record
INSERT INTO Visits (PatientID, DoctorID, VisitDate, TreatmentDetails) VALUES
(1, 1, '2025-04-20 09:00:00', 'ECG performed, no abnormalities found.');
