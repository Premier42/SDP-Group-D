
# SDP-Group-D

A Fullstack Laravel-based Hospital Management System developed as part of the Software Development Project (SDP) course at [Your College Name].

---

## 📖 Table of Contents

- [SDP-Group-D](#sdp-group-d)
  - [📖 Table of Contents](#-table-of-contents)
  - [📌 About the Project](#-about-the-project)
  - [🎯 Project Objectives](#-project-objectives)
  - [✨ Features](#-features)
  - [🛠️ Tech Stack](#️-tech-stack)
  - [🖥️ Installation](#️-installation)
  - [🗄️ Database Configuration](#️-database-configuration)
  - [⚙️ Environment Configuration](#️-environment-configuration)
  - [👥 Team Members](#-team-members)
  - [📃 License](#-license)
  - [📎 Additional Information](#-additional-information)

---

## 📌 About the Project

This is a comprehensive Hospital Management System (HMS) designed to streamline and automate various administrative, clinical, and operational workflows of a hospital. It covers modules for patient registration, doctor scheduling, appointments, billing, and more.

---

## 🎯 Project Objectives

1. Design and implement a scalable and secure hospital management system using Laravel.
2. Provide user-friendly interfaces for admins, doctors, and patients.
3. Support full CRUD functionality for all modules including patients, doctors, appointments, and billing.
4. Integrate session, queue, and cache handling via the database.
5. Enable PDF-based report generation and data export for administrative use.

---

## ✨ Features

- User Authentication & Role-based Authorization
- Patient Registration & Profile Management
- Doctor & Staff Management
- Appointment Scheduling System
- Billing and Payment Tracking
- Prescription & Medical History Module
- Admin Dashboard with Analytics
- API Support for external integrations
- Session, Cache, and Queue via Database
- Mail Notifications using Log Driver
- Responsive Frontend using Blade/Vue/React
- LaTeX-based final report generation
- Presentation slide preparation

---

## 🛠️ Tech Stack

| Component             | Version       |
|:---------------------|:--------------|
| **Laravel Framework** | 11.45.1       |
| **PHP**               | 8.4.10        |
| **Composer**          | 2.8.9         |
| **MySQL**             | 8.0.42        |
| **Node.js**           | 18.19.1       |
| **NPM**               | 9.2.0         |
| **Redis Server**      | 7.0.15        |

---

## 🖥️ Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/SDP-Group-D.git
   cd SDP-Group-D
   ```

2. Install backend dependencies:
   ```bash
   composer install
   ```

3. Install frontend dependencies:
   ```bash
   npm install
   npm run dev
   ```

4. Copy the environment file and configure:
   ```bash
   cp .env.example .env
   ```

5. Generate a new application encryption key:
   ```bash
   php artisan key:generate
   ```

6. Set up the database and run migrations:
   ```bash
   php artisan migrate --seed
   ```

7. Serve the application:
   ```bash
   php artisan serve
   ```

---

## 🗄️ Database Configuration

The project uses **MySQL 8.0.42**.

Default `.env` config:
```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=hospital_system
DB_USERNAME=root
DB_PASSWORD=
```

Adjust these values according to your local setup.

---

## ⚙️ Environment Configuration

Key `.env` highlights:
- **APP_ENV=local**
- **APP_DEBUG=true**
- **APP_TIMEZONE=Asia/Dhaka**
- **SESSION_DRIVER=database**
- **CACHE_STORE=database**
- **QUEUE_CONNECTION=database**
- **MAIL_MAILER=log**
- **REDIS_CLIENT=phpredis**
- **PHP_CLI_SERVER_WORKERS=4**
- **BCRYPT_ROUNDS=12**

Each developer must run:
```bash
php artisan key:generate
```
after configuring their `.env` file.

---

## 👥 Team Members

- **[Your Name]** — Backend Developer
- **[Member 2]** — Frontend Developer
- **[Member 3]** — Database & Documentation
- **[Member 4]** — Testing & Deployment

---

## 📃 License

This project is licensed for academic purposes only.

---

## 📎 Additional Information

- Proposal Document: [link]
- Final Report (LaTeX): [link]
- Presentation Slides: [link]