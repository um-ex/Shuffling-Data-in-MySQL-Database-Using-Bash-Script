# Shuffling Data in MySQL Database Using Bash Script
## Overview
This Bash script is designed to shuffle data in a specified MySQL table. It takes columns from a table and randomly shuffles their values, then updates the original table with the shuffled values. The script makes use of a temporary table to store shuffled data and performs the necessary updates through SQL queries.
The script is executed in a Linux environment and uses MySQL as the database management system. The database credentials are retrieved from a .env file.

---

## Requirements
Before running the script, ensure the following requirements are met:
1. MySQL Database Access: Ensure that MySQL is installed and running on your system.
2. MySQL Credentials: The .env file should contain the database username, password, and database name.
3. Bash Environment: The script should be executed in a Linux or Unix-based environment with Bash installed.
4. Required Variables:
	- $DB_USER: MySQL database user.
	- $DB_PASSWORD: MySQL database password.
	- $DB_NAME: The database name containing the table to shuffle.
	- $TABLE_NAME: The table in which the data needs to be shuffled.
	- $ID_COLUMN: The primary key column in the table.
	- $SHUFFLE_COLUMNS: Array of columns to shuffle.

---

## Script Breakdown

1. Loading Credentials from .env File
The script starts by loading the database credentials like DB_USER, DB_PASSWORD from a .env file. This file must be in the same directory as the script. The .env file is read using the export command, making the variables available for use throughout the script.
```bash
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "ERROR: .env file not found!"
    exit 1
fi

```
2. Argument Validation
The script ensures that at least 4 arguments are provided, including the database name, table name, ID column, and one or more columns to shuffle. If the required arguments are not provided, it displays a usage message and exits.













