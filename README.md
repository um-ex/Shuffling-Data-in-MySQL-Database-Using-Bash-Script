## Shuffling Data in MySQL Database Using Bash Script
## Overview
This Bash script is designed to shuffle data in a specified MySQL table. It takes columns from a table and randomly shuffles their values, then updates the original table with the shuffled values. The script makes use of a temporary table to store shuffled data and performs the necessary updates through SQL queries.
The script is executed in a Linux environment and uses MySQL as the database management system. The database credentials are retrieved from a .env file.

---
## 📌 Overview

- ✅ Uses **MySQL** as the database.
- ✅ Written in **Bash** for Linux/Unix systems (or WSL on Windows).
- ✅ Reads database credentials securely from a `.env` file.
- ✅ Creates a **temporary table** to store shuffled data.
- ✅ Runs SQL queries to update the original table with shuffled values.

---

## 🧾 Example `.env` File (not committed to Git)

```env
DB_HOST=localhost
DB_USER=root
DB_PASS=your_password
DB_NAME=your_database
TABLE_NAME=your_table
COLUMNS_TO_SHUFFLE=column1,column2

