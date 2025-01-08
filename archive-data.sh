#!/bin/bash

# Define paths and filenames
DB_NAME="your_database"
TABLE_NAME="orders"
ARCHIVE_DIR="/path/to/archive"
DATE=$(date +%Y-%m-%d)

# Export data to CSV for weekly, monthly, and yearly partition ranges
# For Weekly Archive (data from the last week)
psql -d $DB_NAME -c "\COPY (SELECT * FROM orders WHERE created_at >= now() - interval '1 week') TO '$ARCHIVE_DIR/weekly_orders_$DATE.csv' WITH CSV HEADER;"

# Compress the weekly CSV to .gz
gzip $ARCHIVE_DIR/weekly_orders_$DATE.csv

# For Monthly Archive (data from the last month)
psql -d $DB_NAME -c "\COPY (SELECT * FROM orders WHERE created_at >= now() - interval '1 month') TO '$ARCHIVE_DIR/monthly_orders_$DATE.csv' WITH CSV HEADER;"

# Compress the monthly CSV to .gz
gzip $ARCHIVE_DIR/monthly_orders_$DATE.csv

# For Yearly Archive (data from the last year)
psql -d $DB_NAME -c "\COPY (SELECT * FROM orders WHERE created_at >= now() - interval '1 year') TO '$ARCHIVE_DIR/yearly_orders_$DATE.csv' WITH CSV HEADER;"

# Compress the yearly CSV to .gz
gzip $ARCHIVE_DIR/yearly_orders_$DATE.csv

# Optional: Delete data older than one year from the table
psql -d $DB_NAME -c "DELETE FROM orders WHERE created_at < now() - interval '1 year';"
