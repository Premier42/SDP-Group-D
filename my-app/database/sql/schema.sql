CREATE DATABASE IF NOT EXISTS hospital_management_db;
USE hospital_management_db;

-- 1. Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('doctor', 'nurse', 'receptionist', 'admin', 'ward_manager', 'ambulance_team') NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. User Details
CREATE TABLE user_details (
    user_id INT PRIMARY KEY,
    job_title VARCHAR(100) DEFAULT NULL,
    department VARCHAR(100) DEFAULT NULL,
    qualification VARCHAR(255) DEFAULT NULL,
    phone_number VARCHAR(20) DEFAULT NULL,
    address VARCHAR(255) DEFAULT NULL,
    joining_date DATE DEFAULT NULL,
    emergency_contact VARCHAR(20) DEFAULT NULL,
    license_number VARCHAR(50) DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Patients
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('male', 'female', 'other') NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    is_emergency BOOLEAN NOT NULL DEFAULT FALSE, -- ✅ Emergency flag
    reg_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 4. Appointments
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT,
    appointment_time DATETIME NOT NULL,
    status ENUM('booked', 'completed', 'cancelled', 'no_show') NOT NULL DEFAULT 'booked',
    notes TEXT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE SET NULL
);

-- 5. Wards
CREATE TABLE wards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type ENUM('ICU', 'General', 'Private', 'Semi-Private') NOT NULL,
    manager_id INT DEFAULT NULL,
    FOREIGN KEY (manager_id) REFERENCES users(id) ON DELETE SET NULL
);

-- 6. Beds
CREATE TABLE beds (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ward_id INT NOT NULL,
    bed_number VARCHAR(20) NOT NULL,
    status ENUM('available', 'occupied', 'cleaning') NOT NULL DEFAULT 'available',
    patient_id INT DEFAULT NULL,
    FOREIGN KEY (ward_id) REFERENCES wards(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE SET NULL,
    UNIQUE KEY unique_bed_in_ward (ward_id, bed_number)
);

-- 7. Admissions
CREATE TABLE admissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    ward_id INT,
    bed_id INT,
    admit_time DATETIME NOT NULL,
    discharge_time DATETIME DEFAULT NULL,
    status ENUM('admitted', 'discharged', 'transferred') NOT NULL DEFAULT 'admitted',
    admitted_by INT,
    discharged_by INT,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (ward_id) REFERENCES wards(id) ON DELETE SET NULL,
    FOREIGN KEY (bed_id) REFERENCES beds(id) ON DELETE SET NULL,
    FOREIGN KEY (admitted_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (discharged_by) REFERENCES users(id) ON DELETE SET NULL
);

-- 8. Ambulances
CREATE TABLE ambulances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    number VARCHAR(50) NOT NULL UNIQUE,
    status ENUM('available', 'busy', 'maintenance') NOT NULL DEFAULT 'available',
    driver VARCHAR(100) DEFAULT NULL,
    last_known_location VARCHAR(255) DEFAULT NULL
);

-- 9. Ambulance Requests
CREATE TABLE ambulance_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    requested_by INT,
    request_time DATETIME NOT NULL,
    status ENUM('pending', 'approved', 'rejected', 'completed') NOT NULL DEFAULT 'pending',
    pickup_location VARCHAR(255) NOT NULL,
    dropoff_location VARCHAR(255) NOT NULL,
    ambulance_id INT DEFAULT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (requested_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (ambulance_id) REFERENCES ambulances(id) ON DELETE SET NULL
);

-- 10. Invoices
CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    created_by INT,
    date DATE NOT NULL DEFAULT CURRENT_DATE,
    total DECIMAL(10,2) NOT NULL,
    paid BOOLEAN NOT NULL DEFAULT FALSE,
    status ENUM('pending', 'paid', 'cancelled') NOT NULL DEFAULT 'pending',
    details TEXT DEFAULT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- 11. Inventory
CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ward_id INT NOT NULL,
    item VARCHAR(255) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ward_id) REFERENCES wards(id) ON DELETE CASCADE
);

-- 12. Notifications
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 13. Audit Logs
CREATE TABLE audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    performed_by INT NOT NULL,
    action VARCHAR(100) NOT NULL,
    target_table VARCHAR(50) DEFAULT NULL,
    target_id INT DEFAULT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (performed_by) REFERENCES users(id) ON DELETE RESTRICT
    
);

-- Indexes
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_user_details_department ON user_details(department);
CREATE INDEX idx_beds_status ON beds(status);
CREATE INDEX idx_appointments_doctor_id ON appointments(doctor_id);
CREATE INDEX idx_ambulance_requests_request_time ON ambulance_requests(request_time);
