create database project;
use project;

select * from HR_1;
select * from HR_2;

alter table HR_1
add constraint pk_hr1 primary key (EmployeeNumber);

alter table HR_2
add constraint fk_hr2 foreign key (EmployeeID)
references HR_1 (EmployeeNumber);

/*1. Average Attrition rate for all Departments */
select Department, 
    count(*) as TotalEmp, 
    sum(case when Attrition = 'Yes' then 1 else 0 end) as AttritionCount, 
	round((sum(case when Attrition = 'Yes' then 1 else 0 end) /count(*))*100,2) as AttritionRate
from HR_1
group by Department;


/*2. Average Hourly rate of Male Research Scientist */
select avg(hourlyRate) as "Average Hourly rate"
from HR_1
where gender='Male' and JobRole = "Research Scientist";

/* 3. Attrition rate Vs Monthly income stats */
SELECT 
    h1.Department, 
    ROUND(AVG(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2) AS AttritionRate,
    AVG(h2.MonthlyIncome) AS AvgMonthlyIncome
FROM HR_1 h1 
INNER JOIN HR_2 h2 
ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY h1.Department;


/* 4. Average working years for each Department */
select h1.Department, round(avg(h2.TotalWorkingYears),2) as Avg_Working_Hours
from HR_1 h1 
inner join HR_2 h2
on h1.EmployeeNumber = h2.EmployeeId
group by h1.department;

/* 5. Job Role Vs Work life balance */
select h1.jobRole, round(avg(h2.WorkLifeBalance),2) as Avg_WorkLifeBalance
from HR_1 h1 
join HR_2 h2
on h1.EmployeeNumber = h2.EmployeeId
group by JobRole;


/* 6. Attrition rate Vs Year since last promotion relation */
select h2.YearsSinceLastPromotion,
	count(*) as TotalEmp, 
    sum(case when Attrition = 'Yes' then 1 else 0 end) as AttritionCount,
	round((sum(case when Attrition = 'Yes' then 1 else 0 end) /count(*))*100,2) as AttritionRate
from HR_1 h1 inner join HR_2 h2
on h1.EmployeeNumber = h2.EmployeeID
group by h2.YearsSinceLastPromotion
order by h2.YearsSinceLastPromotion;


