-- 2 --

CREATE OR REPLACE FUNCTION trigf1()
RETURNS TRIGGER AS $$
DECLARE
    lawyer_billing_rate INT;
BEGIN
    -- Get the lawyer's billing rate
    SELECT hbilling INTO lawyer_billing_rate
    FROM lawyer
    WHERE lname = NEW.lname;

    -- Calculate the amount
    NEW.amount := NEW.hours * lawyer_billing_rate;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER T1
BEFORE INSERT OR UPDATE OF hours ON billing
FOR EACH ROW
EXECUTE FUNCTION trigf1();
