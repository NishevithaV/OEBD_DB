-- Refer to 'Documentation' for detailed information about the functionality of the following stored procedures 

-- Stored Procedure 1 : 
DELIMITER $$
CREATE PROCEDURE UpdateAndInsertCompliance (
    IN p_company_id INT, -- Input parameter: Company ID
    IN p_new_budget DECIMAL(10, 2), -- Input parameter: New budget for the company
    IN p_regulation_name VARCHAR(100), -- Input parameter: Name of the regulation for compliance record
    IN p_certification_type VARCHAR(100), -- Input parameter: Type of certification for compliance record
    IN p_certification_number VARCHAR(10), -- Input parameter: Certification number for compliance record
    IN p_expiry_date DATE -- Input parameter: Expiry date for compliance record
)
-- Start transaction 
BEGIN
	-- Variable to store old budget 
    DECLARE v_old_budget DECIMAL(10, 2);
    
    -- Start transaction
    START TRANSACTION;
    
    -- Retrieve the old budget of the company
    SELECT budget_usd INTO v_old_budget FROM project WHERE company_id = p_company_id LIMIT 1;
    
    -- Update the budget of the company
    UPDATE project SET budget_usd = p_new_budget WHERE company_id = p_company_id;
    
    -- Insert a new compliance record
    INSERT INTO compliance_records (regulation_name, certification_type, certification_number, expiry_date, company_id)
    VALUES (p_regulation_name, p_certification_type, p_certification_number, p_expiry_date, p_company_id);
    
    -- Commit transaction
    COMMIT;
    
END $$
DELIMITER ;

-- Sample CALL statement to invoke procedure UpdateAndInsertCompliance
CALL UpdateAndInsertCompliance(56, 150300, 'Clean Air Act', 'Green Seal Certification', 'G77KTY', '2024-11-07');


-- Stored Procedure 2:
DELIMITER $$
CREATE PROCEDURE UpdateCompanyNameAndLocation(
    IN p_company_id INT, -- Input parameter: Company ID
    IN p_new_company_name VARCHAR(100),  -- Input parameter: New company name
    IN p_new_location_name VARCHAR(100),  -- Input parameter: New location name
    IN p_new_postal_code VARCHAR(100) -- Input parameter: New postal code
)
-- Start transaction
BEGIN
    DECLARE v_old_company_name VARCHAR(100); -- Variable to store old company's name
    DECLARE v_old_location_name VARCHAR(100); -- Variable to store old company's location
    DECLARE v_old_postal_code VARCHAR(100); -- Variable to store old company's postal code 

    -- Start transaction
    START TRANSACTION;

    -- Retrieve the old company name, location name, and postal code
    SELECT company_name INTO v_old_company_name FROM companies WHERE company_id = p_company_id;
    SELECT location_name INTO v_old_location_name FROM location WHERE company_id = p_company_id;
    SELECT postal_code INTO v_old_postal_code FROM location WHERE company_id = p_company_id;

    -- Update the company name
    UPDATE companies SET company_name = p_new_company_name WHERE company_id = p_company_id;

    -- Update the location name and postal code
    UPDATE location 
    SET location_name = p_new_location_name, postal_code = p_new_postal_code 
    WHERE company_id = p_company_id;

	-- Commit transaction
	COMMIT;

END $$
DELIMITER ;

-- Sample CALL statement to invoke procedure UpdateCompanyNameAndLocation 
CALL UpdateCompanyNameAndLocation(240, 'EcoSolutions Canada', 'EcoPark Ontario', 'M4B 1B3');


