# 🎓 University Survey & Form Builder System

A dynamic web application similar to Google Forms, built using **Java Servlets, JSP, and MySQL**.

---

## 🚀 Features

* User Registration & Login
* Create Forms
* Add Questions (Text / MCQ)
* Share Form via Link
* Submit Responses
* View Responses (with user details & timestamp)
* Delete Forms

---

## 🛠️ Tech Stack

* Java (Servlets + JSP)
* MySQL
* Apache Tomcat 10+
* JDBC

---

## ⚙️ Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/kishore-sv/FormBuilderApp.git
cd FormBuilderApp
```

---

## 🗄️ Database Setup (UPDATED)

Open MySQL and run:

```sql
CREATE DATABASE form_builder;
USE form_builder;

-- USERS
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    role VARCHAR(20) DEFAULT 'user'
);

-- FORMS
CREATE TABLE forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

-- QUESTIONS
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    form_id INT,
    question_text TEXT,
    type ENUM('text','mcq'),
    required BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (form_id) REFERENCES forms(id) ON DELETE CASCADE
);

-- OPTIONS (for MCQ)
CREATE TABLE options (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    option_text VARCHAR(255),
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

-- RESPONSES
CREATE TABLE responses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    form_id INT,
    user_id INT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (form_id) REFERENCES forms(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ANSWERS
CREATE TABLE answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    response_id INT,
    question_id INT,
    answer_text TEXT,
    FOREIGN KEY (response_id) REFERENCES responses(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);
```

---

## 🔁 Reset Database (Optional)

```sql
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS responses;
DROP TABLE IF EXISTS options;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS forms;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;
```

---

## 📦 Add MySQL Connector

Download:

* mysql-connector-j-8.x.x.jar

Place inside:

```
WebContent/WEB-INF/lib/
```

---

## ⚙️ Configure Database Connection

Update:

```
src/db/DBConnection.java
```

```java
String url = "jdbc:mysql://127.0.0.1:3306/form_builder";
String user = "root";
String password = "your_password";
```

---

## 🚀 Run the Project

* Use **Apache Tomcat 10+**
* Deploy project via Eclipse
* Open:

```
http://localhost:8080/FormBuilderApp
```

---

## 🔄 Application Flow

1. Register
2. Login
3. Create Form
4. Add Questions
5. Share Link
6. Submit Responses
7. View Responses

---

## 📂 Project Structure

```
src/
 ├── controller/
 ├── dao/
 ├── model/
 ├── db/

WebContent/
 ├── WEB-INF/
 │    └── lib/
 ├── *.jsp
```

---

## ⚠️ Known Issues / Improvements

* Passwords are stored in plain text ❌ (should use hashing)
* No pagination for responses
* No analytics or charts

---

## 💡 Future Improvements

* Charts & Analytics
* Export to Excel
* Form Editing
* UI Enhancements
* Role-based access control

---
