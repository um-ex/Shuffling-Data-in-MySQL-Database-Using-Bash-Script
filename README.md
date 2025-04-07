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

### 1. Loading Credentials from .env File
The script starts by loading the database credentials like DB_USER, DB_PASSWORD from a .env file. This file must be in the same directory as the script. The .env file is read using the export command, making the variables available for use throughout the script.
```bash
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "ERROR: .env file not found!"
    exit 1
fi

```
### 2. Argument Validation
The script ensures that at least 4 arguments are provided, including the database name, table name, ID column, and one or more columns to shuffle. If the required arguments are not provided, it displays a usage message and exits.
```bash
# Check if at least 4 arguments are provided
if [ "$#" -lt 4 ]; then
    echo "Usage: $0 <database_name> <table_name> <id_column> <column1> [<column2> ... <columnN>]"
    exit 1
fi
```
### 3. Extracting Arguments 
The script extracts the database name, table name, ID column, and columns to shuffle from the command-line arguments:
```bash
# Get arguments
DB_NAME="$1"
TABLE_NAME="$2"
ID_COLUMN="$3"
shift 3
SHUFFLE_COLUMNS=("$@")
```
	- $1, $2, $3: Database name, table name, and ID column.
	- shift 3: Shifts the first three arguments so that $@ contains the list of columns to shuffle.

### 4. Constructing the SQL Query
The script dynamically constructs an SQL query to create a temporary table (shuffled) that contains the shuffled values of the specified columns. Here’s a breakdown of the query construction:
**Step 1: Create Temporary Table for Shuffling Data**  
The first part of the query creates a temporary table shuffled containing the ID_COLUMN and the randomly selected values for each of the shuffle columns.
```bash
# Construct SQL Query
SQL_QUERY="CREATE TEMPORARY TABLE shuffled AS SELECT $ID_COLUMN"

for COL in "${SHUFFLE_COLUMNS[@]}"; do
    SQL_QUERY+=", (SELECT $COL FROM $TABLE_NAME ORDER BY RAND() LIMIT 1) AS shuffled_$COL"
done
```
**Step 2: Update Original Table with Shuffled Values**  
The second part of the query updates the original table, setting each column's value to the shuffled value from the temporary table.
```bash
SQL_QUERY+=" FROM $TABLE_NAME; UPDATE $TABLE_NAME AS c JOIN shuffled AS s ON c.$ID_COLUMN = s.$ID_COLUMN SET"

for COL in "${SHUFFLE_COLUMNS[@]}"; do
    SQL_QUERY+=" c.$COL = s.shuffled_$COL,"
done

SQL_QUERY=${SQL_QUERY%,}";"  # Remove last comma
```
### 5. Printing and Executing the SQL Query
Before executing the SQL query, the script prints it for debugging purposes:
```bash
# Print the query for debugging
echo "Executing SQL Query:"
echo "$SQL_QUERY"
```
The script then uses the mysql command to execute the query. The command connects to MySQL using the credentials provided in the .env file:
```bash
# Execute SQL query using credentials from .env file
sudo mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$SQL_QUERY"
```
### 6. Error Handling 
After executing the query, the script checks if the command was successful. If the query is executed without errors, a success message is displayed. Otherwise, an error message is shown, and the script exits with a non-zero status.
```bash
# Check if MySQL command was successful
if [ $? -eq 0 ]; then
    echo "Data in '$DB_NAME', table '$TABLE_NAME' shuffled successfully for columns: ${SHUFFLE_COLUMNS[@]}"
else
    echo "ERROR: MySQL query execution failed."
    exit 1
fi 
```
---
## Run the Script:
Run the script by passing the required arguments:
	- chmod +x scriptName.sh
	- bash shuffle_data.sh your_database_name your_table_name your_id_column col1 col2…..col n.
```bash
bash shuffle_data.sh your_database_name your_table_name your_id_column col1 col2.... coln
```
or

```bash
./shuffle_data.sh your_database_name your_table_name your_id_column col1 col2....coln
```
## Conclusion
This script provides an automated and efficient way to shuffle data in MySQL tables. By leveraging Bash and MySQL, it can randomize values in specified columns, which can be useful for data analysis, anonymization, or testing purposes. With proper setup and precautions, it can be safely used to modify backed-up production data for different purposes. However, it is important to consider the impact of shuffling data on referential integrity in databases. Randomizing values in tables that have foreign key constraints could lead to broken relationships between tables, resulting in inconsistencies or data corruption. Ensuring referential integrity during the shuffling process is crucial to maintain the accuracy and reliability of the database.

## What next : 
While there is always room for improvement, here are a few areas that need attention:
Modify the script to allow data shuffling across multiple tables.
Resolve the problem of duplicate data generation during the shuffling process, ensuring that unique values stay unique even after randomization.



