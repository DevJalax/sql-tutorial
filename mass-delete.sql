BEGIN
    FOR table_name IN (
        SELECT table_name
        FROM all_tables
        WHERE owner = 'UPI_CL'        -- Your schema name in uppercase
          AND table_name LIKE 'UPI_CC_%' -- Table name prefix
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE UPI_CL.' || table_name.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/
