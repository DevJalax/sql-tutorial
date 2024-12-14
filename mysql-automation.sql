-- 1. Check Database Sizes
SELECT table_schema AS database_name,
       ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS size_in_mb
FROM information_schema.tables
GROUP BY table_schema
ORDER BY size_in_mb DESC;

-- 2. List Slow Queries (Requires Performance Schema)
SELECT start_time, user_host, query_time, sql_text
FROM performance_schema.events_statements_history_long
WHERE query_time > '00:00:01'
ORDER BY query_time DESC;

-- 3. Optimize All Tables
SELECT CONCAT('OPTIMIZE TABLE ', table_schema, '.', table_name, ';') AS optimization_query
FROM information_schema.tables
WHERE table_schema NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys');

-- 4. Check Table Sizes
SELECT TABLE_NAME,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS size_in_mb,
       TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'your_database'
ORDER BY size_in_mb DESC;

-- 5. Identify and Delete Unused Users
DELETE FROM mysql.user
WHERE user NOT IN ('root', 'admin', 'monitoring');
FLUSH PRIVILEGES;

-- 6. Archive Old Data (Adjust Table Names and Date Columns)
INSERT INTO archive_table
SELECT * FROM main_table
WHERE created_at < NOW() - INTERVAL 1 YEAR;

DELETE FROM main_table
WHERE created_at < NOW() - INTERVAL 1 YEAR;

-- 7. Backup Database Command (Shell Script Suggestion)
-- Use `mysqldump` as a shell script for full database backups:
-- mysqldump -u root -p --all-databases > /path/to/backup/db_backup.sql;
