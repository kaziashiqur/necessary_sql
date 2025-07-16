
-- For checking two different dabatase same table column mismatch

-- Change these variables
SET @db1 = 'old_database'; -- old database
SET @db2 = 'new_database'; -- new database
SET @table = 'table_name'; -- table name

-- Compare columns in db1 vs db2
(
    SELECT 
        a.COLUMN_NAME,
        a.COLUMN_TYPE AS db1_column_type,
        b.COLUMN_TYPE AS db2_column_type,
        CASE
            WHEN b.COLUMN_NAME IS NULL THEN 'Only in DB1'
            WHEN a.COLUMN_TYPE != b.COLUMN_TYPE THEN 'Type Mismatch'
            ELSE 'Same'
        END AS status
    FROM 
        information_schema.COLUMNS a
    LEFT JOIN 
        information_schema.COLUMNS b
        ON a.COLUMN_NAME = b.COLUMN_NAME 
        AND b.TABLE_SCHEMA = @db2 AND b.TABLE_NAME = @table
    WHERE 
        a.TABLE_SCHEMA = @db1 AND a.TABLE_NAME = @table
)

UNION

(
    SELECT 
        b.COLUMN_NAME,
        a.COLUMN_TYPE AS db1_column_type,
        b.COLUMN_TYPE AS db2_column_type,
        'Only in DB2' AS status
    FROM 
        information_schema.COLUMNS b
    LEFT JOIN 
        information_schema.COLUMNS a
        ON a.COLUMN_NAME = b.COLUMN_NAME 
        AND a.TABLE_SCHEMA = @db1 AND a.TABLE_NAME = @table
    WHERE 
        b.TABLE_SCHEMA = @db2 AND b.TABLE_NAME = @table
        AND a.COLUMN_NAME IS NULL
)
ORDER BY column_name;

-- For checking two different dabatase same table column mismatch end

-- show all table name of a database
USE dbname; 
SHOW TABLES; 
SELECT FOUND_ROWS();

-- count table of a database
SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'ashiqur_viserhotel' and TABLE_TYPE='BASE TABLE';


-- reset primary keys
SET  @num := 0;

UPDATE your_table SET id = @num := (@num+1);

ALTER TABLE your_table AUTO_INCREMENT =1;
