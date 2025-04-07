
# 🔀 Shuffling Data in MySQL Table Using a Bash Script

This Bash script is designed to **shuffle data** in a specified MySQL table. It randomly rearranges values in selected columns and updates the original table with these shuffled values—useful for data anonymization or test data generation.

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

