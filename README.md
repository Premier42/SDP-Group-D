# SDP-Group-D

A Fullstack Laravel-based project developed as part of the Software Development Project (SDP) course at [Your College Name].

---

## 📖 Table of Contents

- [About the Project](#about-the-project)
- [Project Objectives](#project-objectives)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Database Configuration](#database-configuration)
- [Environment Configuration](#environment-configuration)
- [Team Members](#team-members)
- [License](#license)

---

## 📌 About the Project

This project is developed as part of the final year Software Development Project course. It aims to [describe your project purpose briefly].

---

## 🎯 Project Objectives

- [Objective 1]
- [Objective 2]
- [Objective 3]

---

## ✨ Features

- User Authentication & Authorization
- CRUD Operations for core modules
- API Support (if applicable)
- Session Management via Database
- Cache and Queue support via Database
- Responsive Frontend using Blade/Vue/React
- Mail system using Log driver
- Redis cache client setup available
- LaTeX-based final report generation
- Presentation slide preparation

---

## 🛠️ Tech Stack

| Component             | Version       |
|:---------------------|:--------------|
| **Laravel Framework** | 11.45.1        |
| **PHP**               | 8.4.10         |
| **Composer**          | 2.8.9          |
| **MySQL**             | 8.0.42         |
| **Node.js**           | 18.19.1        |
| **NPM**               | 9.2.0          |
| **Redis Server**      | 7.0.15         |

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
DB_DATABASE=laravel_app
DB_USERNAME=root
DB_PASSWORD=
```

Adjust these values based on your local development environment.

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

For security, **`APP_KEY` is excluded** from the repository. Each developer must run:
```bash
php artisan key:generate
```
after setting up their `.env` file.

---

## 👥 Team Members

- **[Your Name]** — Backend Developer
- **[Member 2]** — Frontend Developer
- **[Member 3]** — Documentation Lead
- **[Member 4]** — Testing & Deployment

---

## 📃 License

This project is licensed for academic purposes only.

---

## 📎 Additional Information

- Proposal Document: [link]
- Final Report (LaTeX): [link]
- Presentation Slides: [link]