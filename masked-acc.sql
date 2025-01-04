DECLARE @sql NVARCHAR(MAX) = '';

-- Generate SQL for each table and each column that could potentially contain masked values
SELECT @sql = STRING_AGG('
SELECT COUNT(*) AS masked_rows_count, ''' + TABLE_NAME + ''' AS table_name, ''' + COLUMN_NAME + ''' AS column_name
FROM ' + TABLE_NAME + '
WHERE ' + COLUMN_NAME + ' LIKE ''%****%''', '; ')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE');

-- Execute the generated SQL
EXEC sp_executesql @sql;
