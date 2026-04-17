# 🎓 Online Examination System

A comprehensive web-based platform for conducting and managing online examinations, built using **Java Servlets, JSP, and MySQL**.

---

## 🚀 Features

### 👨‍💼 Admin Panel
* **Secure Login**: Access the administrative dashboard.
* **Exam Management**: Create, view, and delete online exams.
* **Question Builder**: Add multiple-choice questions with 4 options and mark the correct answer.
* **Dashboard Overview**: Track total exams and system activity.

### 👨‍🎓 Student Portal
* **Registration & Login**: Secure user accounts with role-based access.
* **Exam Listing**: View available exams to participate in.
* **Real-time Examination**: Take exams with integrated timers and smooth navigation.
* **Instant Results**: Get immediate feedback and scores upon submission.
* **Result History**: View previous exam attempts and scores.

---

## 🛠️ Tech Stack

* **Backend**: Java (Servlets + JSP)
* **Database**: MySQL 8.0+
* **Server**: Apache Tomcat 10+
* **Frontend**: HTML5, CSS3, JavaScript (Modern Responsive Design)
* **Connectivity**: JDBC (MySQL Connector/J)

---

## ⚙️ Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/kishore-sv/OnlineExaminationSystem.git
cd OnlineExaminationSystem
```

---

## 🗄️ Database Setup

Open MySQL and run the following commands (or import the `db_schema.sql` file):

```sql
CREATE DATABASE IF NOT EXISTS exam_system;
USE exam_system;

-- USERS
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin', 'student') NOT NULL
);

-- EXAMS
CREATE TABLE exams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INT NOT NULL, -- minutes
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- QUESTIONS
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    question_text TEXT NOT NULL,
    option1 VARCHAR(255) NOT NULL,
    option2 VARCHAR(255) NOT NULL,
    option3 VARCHAR(255) NOT NULL,
    option4 VARCHAR(255) NOT NULL,
    correct_answer INT NOT NULL, -- 1, 2, 3, or 4
    FOREIGN KEY (exam_id) REFERENCES exams(id) ON DELETE CASCADE
);

-- RESULTS
CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    user_id INT NOT NULL,
    score INT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (exam_id) REFERENCES exams(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

---

## 📦 Add MySQL Connector

Download `mysql-connector-j-8.x.x.jar` and place it inside:
```
src/main/webapp/WEB-INF/lib/
```

---

## ⚙️ Configure Database Connection

Update `src/main/java/db/DBConnection.java` with your MySQL credentials:

```java
private static final String URL = "jdbc:mysql://localhost:3306/exam_system";
private static final String USER = "root";
private static final String PASSWORD = "your_password";
```

---

## 🚀 Run the Project

* Use **Apache Tomcat 10+** (Jakarta EE compatible).
* Import the project into **Eclipse IDE** as a Dynamic Web Project.
* Add the Tomcat Server and deploy the project.
* Open: `http://localhost:8080/OnlineExaminationSystem`

---

## 📂 Project Structure

```
OnlineExaminationSystem/
 ├── src/
 │    ├── model/       (POJO Classes)
 │    └── main/java/
 │         ├── controller/  (Servlets handling requests)
 │         ├── dao/         (Data Access Objects)
 │         └── db/          (Database Connection)
 ├── src/main/webapp/
 │    ├── css/         (Stylesheets)
 │    ├── js/          (Client-side logic)
 │    ├── WEB-INF/     (Configuration & Libraries)
 │    └── *.jsp        (Presentation Layer)
 └── db_schema.sql     (SQL Script)
```

---

## 🔄 Application Flow

1. **Registration**: Users sign up as either Admin or Student.
2. **Admin Entry**: Admin creates an Exam and adds Questions.
3. **Student Entry**: Student logs in, selects an Exam, and starts the test.
4. **Grading**: System automatically calculates score upon submission.
5. **Tracking**: Both Students and Admins can view exam results.

---

## 💡 Future Improvements

* **Password Hashing**: Secure passwords using BCrypt.
* **Certificate Generation**: PDF certificates for students who pass.
* **Proctoring**: Basic tab-switch detection or webcam monitoring.
* **Question Bank**: Randomize questions from a larger pool.
* **Analytics**: Graphical representation of class performance.
