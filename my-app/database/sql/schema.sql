
CREATE DATABASE IF NOT EXISTS hospital_management_db;
USE hospital_management_db;

-- 1. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'doctor', 'nurse', 'pharmacist', 'lab_tech', 'receptionist') NOT NULL,
    email VARCHAR(100) UNIQUE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME DEFAULT NULL
);

-- 2. Departments Table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    location VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE
);

-- 3. Staff Table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    phone VARCHAR(20),
    hire_date DATE,
    deleted_at DATETIME DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 4. Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    created_by_staff_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    phone VARCHAR(20),
    emergency_contact VARCHAR(100),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_emergency BOOLEAN DEFAULT FALSE,
    status ENUM('active', 'discharged', 'deceased') DEFAULT 'active',
    FOREIGN KEY (created_by_staff_id) REFERENCES Staff(staff_id)
);

-- 5. Wards Table
CREATE TABLE Wards (
    ward_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    type ENUM('general', 'icu', 'maternity', 'pediatric', 'other') NOT NULL,
    in_charge_id INT,
    FOREIGN KEY (in_charge_id) REFERENCES Staff(staff_id)
);

-- 6. Beds Table
CREATE TABLE Beds (
    bed_id INT PRIMARY KEY AUTO_INCREMENT,
    ward_id INT NOT NULL,
    status ENUM('available', 'booked', 'maintenance') DEFAULT 'available',
    FOREIGN KEY (ward_id) REFERENCES Wards(ward_id)
);

-- 7. Services Table
CREATE TABLE Services (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    ward_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    type ENUM('bed', 'icu', 'ccu', 'pcu', 'other'),
    cost DECIMAL(10,2),
    FOREIGN KEY (ward_id) REFERENCES Wards(ward_id)
);

-- 8. Admissions Table
CREATE TABLE PatientAdmissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    ward_id INT NOT NULL,
    bed_id INT,
    admission_date DATETIME NOT NULL,
    discharge_date DATETIME,
    status ENUM('admitted', 'discharged') DEFAULT 'admitted',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (ward_id) REFERENCES Wards(ward_id),
    FOREIGN KEY (bed_id) REFERENCES Beds(bed_id)
);

-- 9. Doctor Availability Table
CREATE TABLE DoctorAvailability (
    availability_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    available_day ENUM('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'),
    available_time_from TIME,
    available_time_to TIME,
    FOREIGN KEY (doctor_id) REFERENCES Staff(staff_id)
);

-- 10. Medical Tests Table
CREATE TABLE MedicalTests (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type ENUM('blood', 'urine', 'xray', 'ultrasound', 'other'),
    department_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 11. Test Orders Table
CREATE TABLE TestOrders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    test_id INT NOT NULL,
    doctor_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ordered', 'completed', 'cancelled') DEFAULT 'ordered',
    results TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (test_id) REFERENCES MedicalTests(test_id),
    FOREIGN KEY (doctor_id) REFERENCES Staff(staff_id)
);

-- 12. Medications Table
CREATE TABLE Medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    form ENUM('tablet', 'capsule', 'syrup', 'injection', 'other'),
    strength VARCHAR(50)
);

-- 13. Pharmacy Inventory Table
CREATE TABLE PharmacyInventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    medication_id INT NOT NULL,
    quantity INT DEFAULT 0,
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);

-- 14. Prescriptions Table
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    prescribed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);

-- 15. Ambulance Services Table
CREATE TABLE AmbulanceServices (
    ambulance_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_number VARCHAR(20) UNIQUE NOT NULL,
    driver_name VARCHAR(100),
    status ENUM('available', 'dispatched', 'maintenance') DEFAULT 'available'
);

-- 16. Emergency Cases Table
CREATE TABLE EmergencyCases (
    case_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    ambulance_id INT,
    case_type ENUM('accident', 'heart_attack', 'stroke', 'trauma', 'other'),
    severity ENUM('critical', 'serious', 'stable'),
    pickup_location TEXT,
    arrival_time DATETIME NOT NULL,
    status ENUM('active', 'admitted', 'discharged') DEFAULT 'active',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (ambulance_id) REFERENCES AmbulanceServices(ambulance_id)
);

-- 17. Invoices Table
CREATE TABLE Invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    admission_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    paid_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('pending', 'paid') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (admission_id) REFERENCES PatientAdmissions(admission_id)
);

-- 18. Invoice Details Table
CREATE TABLE InvoiceDetails (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_id INT,
    item_type ENUM('service', 'test', 'medication', 'ambulance'),
    item_description VARCHAR(255),
    cost DECIMAL(10,2),
    FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id)
);
