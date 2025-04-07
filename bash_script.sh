#!/usr/bin/bash                                                                                              
# Load environment variables from .env file
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "ERROR: .env file not found!"
    exit 1
fi


# Check if at least 4 arguments are provided
if [ "$#" -lt 4 ]; then
    echo "Usage: $0 <database_name> <table_name> <id_column> <column1> [<column2> ... <columnN>]"
    exit 1
fi

# Get arguments
DB_NAME="$1"
TABLE_NAME="$2"
ID_COLUMN="$3"
shift 3
SHUFFLE_COLUMNS=("$@")

# Construct SQL Query
SQL_QUERY="CREATE TEMPORARY TABLE shuffled AS SELECT $ID_COLUMN"

for COL in "${SHUFFLE_COLUMNS[@]}"; do
    SQL_QUERY+=", (SELECT $COL FROM $TABLE_NAME ORDER BY RAND() LIMIT 1) AS shuffled_$COL"
done

SQL_QUERY+=" FROM $TABLE_NAME; UPDATE $TABLE_NAME AS c JOIN shuffled AS s ON c.$ID_COLUMN = s.$ID_COLUMN SET"

for COL in "${SHUFFLE_COLUMNS[@]}"; do
    SQL_QUERY+=" c.$COL = s.shuffled_$COL,"
done

SQL_QUERY=${SQL_QUERY%,}";"  # Remove last comma

# Print the query for debugging
echo "Executing SQL Query:"
echo "$SQL_QUERY"

# Execute SQL query using credentials from .env file
sudo mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$SQL_QUERY"

# Check if MySQL command was successful
if [ $? -eq 0 ]; then
    echo "Data in '$DB_NAME', table '$TABLE_NAME' shuffled successfully for columns: ${SHUFFLE_COLUMNS[@]}"
else
    echo "ERROR: MySQL query execution failed."
    exit 1
fi

