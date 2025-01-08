INSERT INTO target_table (id, name, value)
SELECT id, name, value
FROM source_table
WHERE last_modified > (SELECT MAX(last_modified) FROM target_table);
