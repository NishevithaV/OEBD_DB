DROP TABLE IF EXISTS compliance_records; -- Drop table 'compliance_records' if it exists in the database 
DROP TABLE IF EXISTS location; -- Drop table 'location' if it exists in the database 
DROP TABLE IF EXISTS project; -- Drop table 'project' if it exists in the database 
DROP TABLE IF EXISTS companies; -- Drop table 'companies' if it exists in the database 

-- Create companies table with company details
CREATE TABLE IF NOT EXISTS companies (
	company_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each company
    company_name VARCHAR(100) NOT NULL, -- Name of the company 
    sectors VARCHAR(100), -- Sectors in which the company operates
    website VARCHAR(100), -- Company website URL
    location VARCHAR(100), -- Location of the company
    description TEXT -- Description of the company
);

-- Create project table to store project details
CREATE TABLE IF NOT EXISTS project (
	project_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each project
    project_name VARCHAR(100) NOT NULL, -- Name of the project 
    project_description TEXT, -- Description of the project
    start_date DATE NOT NULL, -- Start date of the project
    end_date DATE NOT NULL, -- End date of the project 
    budget_usd DECIMAL(10, 2) NOT NULL, -- Budget of the project in USD
    company_id INT NOT NULL, -- Foreign key referencing company_id in companies table
    FOREIGN KEY (company_id) REFERENCES companies(company_id) -- Establishing foreign key constraint
);

-- Create location table to store company locations
CREATE TABLE IF NOT EXISTS location (
    location_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each location
    location_name VARCHAR(100) NOT NULL, -- Name of the location 
    area_sq_ft DECIMAL(10, 2), -- Area in square feet
    postal_code VARCHAR(100) NOT NULL, -- Postal code of the location
    company_id INT NOT NULL, -- Foreign key referencing company_id in companies table
    FOREIGN KEY (company_id) REFERENCES companies(company_id) -- Establishing foreign key constraint
);

-- Create compliance_records table to store compliance records
CREATE TABLE IF NOT EXISTS compliance_records (
    compliance_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each compliance record
    regulation_name VARCHAR(100) NOT NULL, -- Name of the regulation 
    certification_type VARCHAR(100) NOT NULL, -- Type of certification 
    certification_number VARCHAR(10) NOT NULL, -- Certification number 
    expiry_date DATE NOT NULL, -- Expiry date of the certification 
    description TEXT, -- Description of the compliance record
    company_id INT NOT NULL, -- Foreign key referencing company_id in companies table
    FOREIGN KEY (company_id) REFERENCES companies(company_id) -- Establishing foreign key constraint
);

-- Table data will be imported using MySQL WorkBench's Import Wizard 
-- NOTE : .csv files contain column headings
-- Column headings can be used to map data in .csv files to created tables using DDL 
-- Detailed instructions in 'Documentation'


-- sample INSERT INTO statements 

-- Inserting a new company record with company name, sectors, website, and description.
-- INSERT INTO companies(company_name, sectors, website, description)
-- VALUES('Zorbit Technologies Inc.','Waste Management','www.peatsorb.ca ', 'Offers solutions for spill control problems (e.g. Zorbit markets Peat Sorbâ„¢, a 100% natural oil absorbent manufactured from Canadian sphagnum peat moss).');

-- Inserting a new compliance record with regulation name, certification type, certification number, expiry date, description, and company ID.
-- INSERT INTO compliance_records(regulation_name, certification_type, certification_number, expiry_date, description, company_id)
-- VALUES('Resource Conservation and Recovery Act','ENERGY STAR Certification','J26OS75E','9/8/2025','Implementing waste management practices and recycling initiatives',118);

-- Inserting a new location record with location name, postal code, company ID, and area in square feet.
-- INSERT INTO location(location_name, postal_code, company_id, area_sq_ft)
-- VALUES('Riverside Plaza','S0 F8A',22,'3016.00');

-- Inserting a new project record with project name, project description, start date, end date, budget in USD, and company ID.
-- INSERT INTO project(project_name, project_description, start_date, end_date, budget_usd, company_id)
-- VALUES('Water Resource Management','Monitoring air quality and implementing strategies to reduce pollution levels','15/12/2023','29/11/2024',147412,184);

