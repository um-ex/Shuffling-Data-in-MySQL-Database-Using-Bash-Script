# Shuffling Data in MySQL Database Using Bash Script
## Overview
This Bash script is designed to shuffle data in a specified MySQL table. It takes columns from a table and randomly shuffles their values, then updates the original table with the shuffled values. The script makes use of a temporary table to store shuffled data and performs the necessary updates through SQL queries.
The script is executed in a Linux environment and uses MySQL as the database management system. The database credentials are retrieved from a .env file.

---

### Requirements
Before running the script, ensure the following requirements are met:
1.MySQL Database Access: Ensure that MySQL is installed and running on your system.
2.MySQL Credentials: The .env file should contain the database username, password, and database name.
3.Bash Environment: The script should be executed in a Linux or Unix-based environment with Bash installed.
4.Required Variables:
- $DB_USER: MySQL database user.
- $DB_PASSWORD: MySQL database password.
- $DB_NAME: The database name containing the table to shuffle.
- $TABLE_NAME: The table in which the data needs to be shuffled.
- $ID_COLUMN: The primary key column in the table.
- $SHUFFLE_COLUMNS: Array of columns to shuffle.

---


