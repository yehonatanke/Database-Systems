-- This code creates a trigger function and a trigger to check if a new project assignment
-- is made at least 30 days before the project's due date

-- Create or replace the trigger function
CREATE OR REPLACE FUNCTION trigf1() 
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the new assignment date plus 30 days is before the project's due date
    IF ((NEW.fdate + 30) < (SELECT duedate FROM project WHERE pid = NEW.pid)) THEN
        -- If true, allow the insertion
        RETURN NEW;
    END IF;

    -- If false, raise a notice and prevent the insertion
    RAISE NOTICE 'There is less than a month left until the end of the project';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER t1
BEFORE INSERT ON onproject
FOR EACH ROW
EXECUTE PROCEDURE trigf1();
