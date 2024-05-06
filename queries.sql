-- Refer to 'Documentation' for more information about the following queries 

-- This query selects project details from the project table where the start date is after January 1, 2023.
SELECT project_id, project_name, start_date, end_date, DATEDIFF(end_date, start_date) AS project_duration_days
FROM project 
WHERE start_date > '2023-01-01';


-- This query performs an INNER JOIN between the project and companies tables using the company_id as the common attribute.
-- It retrieves project details along with the associated company details.
SELECT p.project_id, p.project_name, p.start_date, p.end_date, p.budget_usd, c.company_name, c.sectors
FROM project p
INNER JOIN companies c ON p.company_id = c.company_id;


-- This query calculates the total budget for each company by summing up the budget_usd column from the project table.
-- It groups the results by the company_id and retrieves the company name along with the total budget.
SELECT c.company_name, SUM(p.budget_usd) AS total_budget
FROM project p
JOIN companies c ON p.company_id = c.company_id
GROUP BY c.company_id, c.company_name;


-- The average budget is calculated within subquery in FROM clause
-- Compliance records for companies with projects having a budget greater than this average budget is found using outer query
SELECT cr.compliance_id, cr.regulation_name, cr.certification_type, cr.certification_number, cr.expiry_date, cr.description, cr.company_id, p.budget_usd
FROM (
    SELECT AVG(p.budget_usd) AS avg_budget
    FROM project p
) AS avg_proj
JOIN project p ON p.budget_usd > avg_proj.avg_budget
JOIN compliance_records cr ON p.company_id = cr.company_id;


-- View modifies project budget for a specific project and indicates difference before and after change 
CREATE VIEW project_compliance AS
SELECT p.project_id, p.project_name, p.start_date, p.end_date, p.budget_usd, 
       DATEDIFF(p.end_date, p.start_date) AS project_duration_days,
       cr.regulation_name, cr.certification_type, cr.certification_number, 
       cr.expiry_date
FROM project p
JOIN compliance_records cr ON p.company_id = cr.company_id;

-- SELECT query on VIEW project_compliance
SELECT * FROM project_compliance;

-- Modify underlying table project - budget value 
UPDATE project
SET budget_usd = budget_usd + 10000
WHERE project_id = 49;

-- Re-run select query to view modification 
SELECT * FROM project_compliance;
