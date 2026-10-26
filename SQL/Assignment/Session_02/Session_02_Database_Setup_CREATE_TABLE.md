# Session 2: Database Setup + CREATE TABLE

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Database**: `foodie_app`  
**SQL Script File**: [`session_02_database_setup.sql`](session_02_database_setup.sql)

---

## Task 1: Environment Installation & Verification

### System Environment Verification
* **RDBMS Engine**: MySQL Community Server 8.0 (Version: 8.0.46 for Win64)
* **Windows Service**: `MySQL80` (Status: **Running**)
* **GUI Management Tool**: MySQL Workbench 8.0 (`C:\Program Files\MySQL\MySQL Workbench 8.0`)
* **CLI Client**: `mysql.exe` (`C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe`)

### Connection Verification
```sql
mysql> STATUS;
--------------
mysql  Ver 8.0.46 for Win64 on x86_64 (MySQL Community Server - GPL)
Connection id:          12
Current database:       
Current user:           root@localhost
Server version:         8.0.46 MySQL Community Server - GPL
Uptime:                 1 hour 45 min
Threads: 2  Questions: 24  Slow queries: 0  Opens: 120  Flush tables: 3
--------------
```

---

## Task 2: Create Database `foodie_app`

### Objective
Create a new database named `foodie_app` to simulate a Zomato-style backend.

### SQL Implementation
```sql
-- Create database if it does not already exist
CREATE DATABASE IF NOT EXISTS foodie_app;

-- Select foodie_app as active database
USE foodie_app;
```

### Execution Output (MySQL Workbench / CLI)
```sql
mysql> CREATE DATABASE IF NOT EXISTS foodie_app;
Query OK, 1 row affected (0.01 sec)

mysql> USE foodie_app;
Database changed
```

---

## Task 3: Create Table `restaurants` (Zomato-Style)

### Objective
Write a `CREATE TABLE` statement to define a `restaurants` table in `foodie_app` with:
* `id` (integer, primary key)
* `name` (varchar/character, max 100)
* `cuisine` (varchar/character, max 50)
* `rating` (decimal, e.g., 4.5)
* `location` (varchar/character, max 100)

### SQL DDL Statement
```sql
CREATE TABLE IF NOT EXISTS restaurants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    location VARCHAR(100) NOT NULL
);
```

### Data Types & Column Architecture
| Column Name | Data Type | Constraint | Design Rationale |
| :--- | :--- | :--- | :--- |
| `id` | `INT` | `PRIMARY KEY AUTO_INCREMENT` | Unique integer identifier; automatically increments with every new restaurant. |
| `name` | `VARCHAR(100)` | `NOT NULL` | Restaurant trade name (variable length up to 100 characters). |
| `cuisine` | `VARCHAR(50)` | `NOT NULL` | Food genre (e.g., 'North Indian', 'Italian', 'Desserts'). |
| `rating` | `DECIMAL(2, 1)` | `NOT NULL` | Precise fixed-point decimal. Total 2 digits with 1 decimal place (e.g., `4.5`), avoiding floating-point rounding errors of `FLOAT`. |
| `location` | `VARCHAR(100)` | `NOT NULL` | Neighborhood and city name (e.g., 'Bandra West, Mumbai'). |

### Verification & Sample Records
```sql
-- Insert sample restaurants
INSERT INTO restaurants (name, cuisine, rating, location) VALUES
('The Belgian Waffle Co.', 'Desserts', 4.5, 'Bandra West, Mumbai'),
('Punjab Grill', 'North Indian', 4.7, 'Connaught Place, Delhi'),
('Toscano', 'Italian', 4.6, 'Indiranagar, Bangalore'),
('Chai Point', 'Beverages', 4.2, 'Cyber Hub, Gurugram');

-- Query all records
SELECT * FROM restaurants;
```

#### Output:
```text
+----+------------------------+--------------+--------+------------------------+
| id | name                   | cuisine      | rating | location               |
+----+------------------------+--------------+--------+------------------------+
|  1 | The Belgian Waffle Co. | Desserts     |    4.5 | Bandra West, Mumbai    |
|  2 | Punjab Grill           | North Indian |    4.7 | Connaught Place, Delhi |
|  3 | Toscano                | Italian      |    4.6 | Indiranagar, Bangalore |
|  4 | Chai Point             | Beverages    |    4.2 | Cyber Hub, Gurugram    |
+----+------------------------+--------------+--------+------------------------+
4 rows in set (0.00 sec)
```

---

## Task 4: Design & Create `users` Table (Flipkart-Style)

### Objective
Design and create a `users` table for an e-commerce (Flipkart-style) application with columns:
* `user_id` (primary key)
* `username`
* `email`
* `phone_number`
* `created_at` (date/time)

### Design Considerations & Constraints
1. **`phone_number` Data Type**:
   - Must be **`VARCHAR(15)`**, **never `INT` or `BIGINT`**.
   - *Reason*: Phone numbers often include leading zeroes (e.g., `098...`) and international dialing prefixes (e.g., `+91`). Storing phone numbers as integers strips leading zeroes, fails on `+` symbols, and phone numbers are identifiers rather than quantities used in mathematical operations.
2. **Uniqueness (`UNIQUE`)**:
   - `username`, `email`, and `phone_number` must have `UNIQUE` constraints to prevent duplicate user registrations, identity theft, and authentication collisions.
3. **`created_at`**:
   - `TIMESTAMP DEFAULT CURRENT_TIMESTAMP` automatically captures the exact registration instant without requiring manual client input.

### SQL DDL Statement
```sql
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Table Structure Inspection (`DESCRIBE users;`)
```text
+--------------+--------------+------+-----+-------------------+-------------------+
| Field        | Type         | Null | Key | Default           | Extra             |
+--------------+--------------+------+-----+-------------------+-------------------+
| user_id      | int          | NO   | PRI | NULL              | auto_increment    |
| username     | varchar(50)  | NO   | UNI | NULL              |                   |
| email        | varchar(100) | NO   | UNI | NULL              |                   |
| phone_number | varchar(15)  | NO   | UNI | NULL              |                   |
| created_at   | timestamp    | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+--------------+--------------+------+-----+-------------------+-------------------+
5 rows in set (0.00 sec)
```

### Sample Record Insertion & Verification
```sql
INSERT INTO users (username, email, phone_number) VALUES
('kathan_gadhiya', 'kathan@example.com', '+919876543210'),
('priya_sharma', 'priya.s@example.com', '+919812345678'),
('rahul_verma', 'rahul.v@example.com', '+919890123456');

SELECT user_id, username, email, phone_number, created_at FROM users;
```

#### Output:
```text
+---------+----------------+---------------------+---------------+---------------------+
| user_id | username       | email               | phone_number  | created_at          |
+---------+----------------+---------------------+---------------+---------------------+
|       1 | kathan_gadhiya | kathan@example.com  | +919876543210 | 2026-10-26 13:48:30 |
|       2 | priya_sharma   | priya.s@example.com | +919812345678 | 2026-10-26 13:48:30 |
|       3 | rahul_verma    | rahul.v@example.com | +919890123456 | 2026-10-26 13:48:30 |
+---------+----------------+---------------------+---------------+---------------------+
3 rows in set (0.00 sec)
```

---

## Task 5: Intentional Error & Resolution Experiment

### 1. Intentional Mistake: Missing Comma
In SQL, column definitions must be separated by commas. We intentionally omit the comma after line 2:

```sql
CREATE TABLE orders_error_test (
    order_id INT PRIMARY KEY,
    name VARCHAR(100)          -- <-- MISSING COMMA HERE!
    amount DECIMAL(10, 2)
);
```

### 2. Error Message Received
```text
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds 
to your MySQL server version for the right syntax to use near 'amount DECIMAL(10, 2)
)' at line 4
```

### 3. Diagnosis & Fix
* **Diagnosis**: MySQL's parser expects either a comma `,` to denote the next column or a closing parenthesis `)` to finish the table definition. When it encounters `amount` on line 4 without a preceding comma, it flags a syntax error at that token.
* **Correction**: Add the missing comma `,` immediately following `VARCHAR(100)`:

```sql
CREATE TABLE IF NOT EXISTS orders_error_test (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);
```

### 4. Successful Execution After Fix
```text
mysql> CREATE TABLE IF NOT EXISTS orders_error_test (
    ->     order_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(100) NOT NULL,
    ->     amount DECIMAL(10, 2) NOT NULL
    -> );
Query OK, 0 rows affected (0.02 sec)
```
