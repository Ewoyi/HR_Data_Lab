-- Data analysis of the HR dataset
CREATE TABLE hr_data_lab (
    id INT NOT NULL PRIMARY KEY,
    satisfaction_level FLOAT NULL,
    last_evaluation FLOAT NULL,
    number_project INT NULL,
    average_monthly_hours INT NULL,
    time_spend_company INT NULL,
    Work_accident INT NULL,
    `left` INT NULL,
    promotion_last_5years INT NULL,
    sales TEXT NULL,
    salary TEXT NULL
);
-- inputing the dataset into the table
LOAD DATA INFILE 'hr_data.csv' INTO TABLE hr_data_lab;

-- What drives high performers to leave the company
-- Who is a high performer or regular employee
SELECT 
	hr_data_lab.`MyUnknownColumn` AS id,
    hr_data_lab.`satisfaction_level`,
    hr_data_lab.`last_evaluation`,
    hr_data_lab.`number_project`,
    hr_data_lab.`average_montly_hours`,
    hr_data_lab.`time_spend_company`,
    hr_data_lab.`Work_accident`,
    hr_data_lab.`left`,
    hr_data_lab.`promotion_last_5years`,
    hr_data_lab.`sales`,
    hr_data_lab.`salary`,
    CASE WHEN last_evaluation > 0.716
		AND number_project > 4
        AND time_spend_company >= 4
        THEN 'high_perf' 
        ELSE 'regular' 
    END AS employee
FROM `hr_database`.hr_data_lab;

-- From the temporary table
with Temp as
(SELECT 
	hr_data_lab.`MyUnknownColumn` AS id,
    hr_data_lab.`satisfaction_level`,
    hr_data_lab.`last_evaluation`,
    hr_data_lab.`number_project`,
    hr_data_lab.`average_montly_hours`,
    hr_data_lab.`time_spend_company`,
    hr_data_lab.`Work_accident`,
    hr_data_lab.`left`,
    hr_data_lab.`promotion_last_5years`,
    hr_data_lab.`sales`,
    hr_data_lab.`salary`,
    CASE WHEN last_evaluation > 0.716
		AND number_project > 4
        AND time_spend_company >= 4
        THEN 'high_perf' 
        ELSE 'regular' 
        END AS employee
FROM `hr_database`.hr_data_lab
	)
-- Count of high perfromers that left the company based on their promotion status
SELECT 
    promotion_last_5years,
    COUNT(*) AS employee_count
FROM temp
    WHERE employee = 'high_perf'
    AND `left` = 1
        GROUP BY promotion_last_5years
;
-- Count of high performers that left the company with high salary
SELECT
	sales AS department,
    COUNT(*) AS employee_count
FROM temp
	WHERE employee = 'high_perf'
    AND `left` = 1
    AND salary = 'high'
		GROUP BY sales
;

-- Count of high performers that left the company with medium salary
SELECT
	sales AS department,
    COUNT(*) AS employee_count
FROM temp
	WHERE employee = 'high_perf'
    AND `left` = 1
    AND salary = 'medium'
		GROUP BY sales
;

-- Count of high performers that left the company with low salary
SELECT
	sales AS department,
    COUNT(*) AS employee_count
FROM temp
	WHERE employee = 'high_perf'
    AND `left` = 1
    AND salary = 'low'
		GROUP BY sales
;

-- Count of high performers that either left of stayed at the company 
SELECT
	`left`,
    COUNT(*) AS employee_count
FROM temp
	WHERE employee = 'high_perf'
        GROUP BY `left`
;

-- Count of high performers that left the company based on salary level
SELECT
	salary,
    COUNT(*) AS employee_count
FROM temp
	WHERE employee = 'high_perf'
    AND `left` = 1
        GROUP BY salary
        ORDER BY employee_count DESC
;

-- Count of high performers that left the company with high salary
SELECT
    sales AS department,
    AVG(satisfaction_level) AS AVG_satisfaction,
    COUNT(*) AS employee_count
FROM temp
	WHERE employee = 'high_perf'
    AND `left` = 1
        GROUP BY 1
        ORDER BY employee_count DESC
;


SELECT
	employee,
    salary,
    sales AS department,
    AVG(satisfaction_level) AS satisfaction_level,
    AVG(average_montly_hours) AS monthly_hrs,
    SUM(Work_accident) AS Work_accident,
    SUM(`left`) AS left_company,
    COUNT(*) AS total_employees
FROM temp
	GROUP BY 
		employee,
		salary,
        sales
;


SELECT
	employee,
    salary,
    sales AS department,
    Work_accident,
    `left`,
    AVG(satisfaction_level) AS satisfaction_level,
    AVG(average_montly_hours) AS monthly_hrs,
    COUNT(*) AS employees
FROM temp
	GROUP BY 
		employee,
		salary,
        sales,
        Work_accident,
        `left`
;

-- Count of both regular and high performing employees at the company
SELECT
	employee,
    COUNT(*)
FROM Temp
	GROUP BY employee
;