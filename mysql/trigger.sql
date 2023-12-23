-- @block
CREATE TABLE trigger_test (
    message VARCHAR(200)
);

-- @block
DESCRIBE trigger_test;

-- @block
-- this will only run in the terminal
DELIMITER $$
CREATE
	TRIGGER my_trigger BEFORE INSERT
	ON employee
	FOR EACH ROW BEGIN
		IF NEW.sex = 'M' THEN
			INSERT INTO trigger_test VALUES('added male employee');
		ELSEIF NEW.sex = 'F' THEN
			INSERT INTO trigger_test VALUES('added female');
		ELSE
			INSERT INTO trigger_test VALUES('added another employee');
		END IF;
	END $$
DELIMITER;