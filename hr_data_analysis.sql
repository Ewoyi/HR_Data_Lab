-- What drives high performers to leave the company
SELECT 
	`hr data lab`.`MyUnknownColumn` as id,
    `hr data lab`.`satisfaction_level`,
    `hr data lab`.`last_evaluation`,
    `hr data lab`.`number_project`,
    `hr data lab`.`average_montly_hours`,
    `hr data lab`.`time_spend_company`,
    `hr data lab`.`Work_accident`,
    `hr data lab`.`left`,
    `hr data lab`.`promotion_last_5years`,
    `hr data lab`.`sales`,
    `hr data lab`.`salary`,
    case when last_evaluation > 0.716
		and number_project > 4
        and time_spend_company >= 4
        then 'high_perf' else 'regular' end as employee
FROM `hr_database`.`hr data lab`;


with Temp as
(SELECT 
	`hr data lab`.`MyUnknownColumn` as id,
    `hr data lab`.`satisfaction_level`,
    `hr data lab`.`last_evaluation`,
    `hr data lab`.`number_project`,
    `hr data lab`.`average_montly_hours`,
    `hr data lab`.`time_spend_company`,
    `hr data lab`.`Work_accident`,
    `hr data lab`.`left`,
    `hr data lab`.`promotion_last_5years`,
    `hr data lab`.`sales`,
    `hr data lab`.`salary`,
    case when last_evaluation > 0.716
		and number_project > 4
        and time_spend_company >= 4
        then 'high_perf' else 'regular' end as employee
FROM `hr_database`.`hr data lab`
	)
/*
select
	sales as department,
    count(*) as employee_count
from temp
	where employee = 'high_perf'
    and `left` = 1
    and salary = 'high'
		group by sales
;
*/
/*
select
	sales as department,
    count(*) as employee_count
from temp
	where employee = 'high_perf'
    and `left` = 1
    and salary = 'medium'
		group by sales
;
*/
/*
select
	sales as department,
    count(*) as employee_count
from temp
	where employee = 'high_perf'
    and `left` = 1
    and salary = 'low'
		group by sales
;
*/
/*
select
	`left`,
    count(*) as employee_count
from temp
	where employee = 'high_perf'
group by `left`
;
*/
/*
select
	salary,
    count(*) as employee_count
from temp
	where employee = 'high_perf'
    and `left` = 1
group by salary
order by employee_count
;
*/
/*
select
    sales as department,
    avg(satisfaction_level) as avg_satisfaction,
    count(*) as employee_count
from temp
	where employee = 'high_perf'
    and `left` = 1
group by 1
order by employee_count desc
;
*/
/*
select
	employee,
    salary,
    sales as department,
    avg(satisfaction_level) as satisfaction_level,
    avg(average_montly_hours) as monthly_hrs,
    sum(Work_accident) as Work_accident,
    sum(`left`) as left_company,
    count(*) as total_employees
from temp
	group by 
		employee,
		salary,
        sales
;
*/
/*
select
	employee,
    salary,
    sales as department,
    Work_accident,
    `left`,
    avg(satisfaction_level) as satisfaction_level,
    avg(average_montly_hours) as monthly_hrs,
    count(*) as employees
from temp
	group by 
		employee,
		salary,
        sales,
        Work_accident,
        `left`
;
*/
/*
select
	employee,
    count(*)
from Temp
	group by employee
;
*/