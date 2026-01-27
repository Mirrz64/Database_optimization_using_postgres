-- INVENTORY CONSTRAINTS
ALTER TABLE inventory.drugs
add constraint check_positive_price CHECK (price > 0);
-- check the price of each drugs recorded into database'

ALTER TABLE inventory.stock
ADD CONSTRAINT check_nonnegative_quantity CHECK (quantity >= 0)

-- orders constraints
ALTER TABLE operations.orders
ADD CONSTRAINT check_total_amount CHECK (total_amount >= 0)

-- Set a constraint on the trial_participant table where the age must be between 8 to 85
ALTER TABLE research.trial_participants
ADD CONSTRAINT check_age CHECK (age BETWEEN 8 AND 85);