-- 1. Check Database Sizes
SELECT pg_database.datname AS database_name,
       pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database
ORDER BY pg_database_size(pg_database.datname) DESC;

-- 2. List Slow Queries (Requires `pg_stat_statements` Extension)
SELECT query, total_exec_time, calls, total_exec_time / calls AS avg_time
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;

-- 3. Reindex All Tables
DO $$ DECLARE
    tbl RECORD;
BEGIN
    FOR tbl IN
        SELECT schemaname, tablename
        FROM pg_tables
        WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
    LOOP
        EXECUTE 'REINDEX TABLE ' || tbl.schemaname || '.' || tbl.tablename;
    END LOOP;
END $$;

-- 4. Check Table Sizes
SELECT relname AS table_name,
       pg_size_pretty(pg_total_relation_size(relid)) AS size,
       n_live_tup AS rows
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;

-- 5. Archive Old Data (Adjust Table Names and Date Columns)
INSERT INTO archive_table
SELECT * FROM main_table
WHERE created_at < NOW() - INTERVAL '1 year';

DELETE FROM main_table
WHERE created_at < NOW() - INTERVAL '1 year';

-- 6. Backup Database Command (Shell Script Suggestion)
-- Use `pg_dumpall` as a shell script for full database backups:
-- pg_dumpall -U postgres > /path/to/backup/pg_backup.sql;
