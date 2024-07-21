-- Function to check for scheduling conflicts and event existence
CREATE OR REPLACE FUNCTION trigf1() 
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the event exists in either revent or sevent tables
    IF (NOT EXISTS (SELECT * FROM revent WHERE reid = NEW.eid) AND 
        NOT EXISTS (SELECT * FROM sevent WHERE seid = NEW.eid)) THEN 
        BEGIN 
            RAISE NOTICE 'event % not an event in DB.', NEW.eid;
            RETURN NULL; -- Prevent the insertion/update
        END;
    END IF;

    -- Check for scheduling conflicts
    IF EXISTS (
        SELECT * FROM schedule 
        WHERE sdate = NEW.sdate 
          AND rno = NEW.rno 
          AND bno = NEW.bno 
          AND (
              (NEW.stime >= stime AND NEW.stime < stime + duration) 
              OR 
              (stime >= NEW.stime AND stime < NEW.stime + NEW.duration)
          )
    ) THEN
        BEGIN
            RAISE NOTICE 'room % in building % is already taken at this time', NEW.rno, NEW.bno;
            RETURN NULL; -- Prevent the insertion/update
        END;
    END IF;

    -- If all checks pass, allow the insertion/update
    RETURN NEW;
END; 
$$ LANGUAGE plpgsql;

-- Create trigger to execute the function before INSERT or UPDATE on schedule table
CREATE TRIGGER check_schedule_conflict
BEFORE INSERT OR UPDATE ON schedule 
FOR EACH ROW 
EXECUTE FUNCTION trigf1();
