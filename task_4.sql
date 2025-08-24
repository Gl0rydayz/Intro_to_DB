-- Task 4: Show Full Description of Books Table
-- This script shows the complete table structure of the books table
-- Database name will be passed as argument of mysql command

SELECT COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_KEY, COLUMN_DEFAULT, EXTRA
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'alx_book_store' AND TABLE_NAME = 'Books'
ORDER BY ORDINAL_POSITION;
