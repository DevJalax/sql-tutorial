-- 1. Check Database Sizes
SELECT tablespace_name,
       ROUND(SUM(bytes) / 1024 / 1024, 2) AS size_in_mb
FROM dba_data_files
GROUP BY tablespace_name
ORDER BY size_in_mb DESC;

-- 2. List Slow Queries (Requires `v$sqlarea`)
SELECT sql_text,
       elapsed_time / executions AS avg_exec_time,
       executions,
       elapsed_time
FROM v$sqlarea
WHERE elapsed_time / executions > 1000000 -- 1 second
ORDER BY avg_exec_time DESC;

-- 3. Rebuild Fragmented Indexes
BEGIN
   FOR idx IN (SELECT owner, index_name FROM dba_indexes WHERE status = 'UNUSABLE') LOOP
      EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.owner || '.' || idx.index_name || ' REBUILD';
   END LOOP;
END;
/

-- 4. Check Table Sizes
SELECT table_name,
       ROUND(SUM(bytes) / 1024 / 1024, 2) AS size_in_mb
FROM user_segments
WHERE segment_type = 'TABLE'
GROUP BY table_name
ORDER BY size_in_mb DESC;

-- 5. Archive Old Data (Adjust Table Names and Date Columns)
INSERT INTO archive_table
SELECT * FROM main_table
WHERE created_at < SYSDATE - 365;

DELETE FROM main_table
WHERE created_at < SYSDATE - 365;

-- 6. Backup Database Command (Shell Script Suggestion)
-- Use RMAN for backups:
-- rman target / <<EOF
-- BACKUP DATABASE FORMAT '/path/to/backup/db_%U.bkp';
-- EOF
