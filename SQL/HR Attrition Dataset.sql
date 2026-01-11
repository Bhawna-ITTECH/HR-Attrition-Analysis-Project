use Interview_Dataset;
select * from [dbo].[HR-Employee-Attrition];
--Level 1 — Easy (Basic SELECT, WHERE, COUNT, GROUP BY)
--Count total number of employees in the dataset.
select COUNT(*) as total_emp
from [HR-Employee-Attrition];
--Find how many employees have left the company (Attrition = 'Yes').
select count(*) from [HR-Employee-Attrition]
where Attrition='yes';
--Show all employees who travel rarely for business.
select * from [HR-Employee-Attrition]
where BusinessTravel='travel_rarely';
--Display employees whose MonthlyIncome is above 50,000.
select * from [HR-Employee-Attrition]
where MonthlyIncome>50000;
--List the distinct JobRoles available in the dataset.
select distinct JobRole 
from [HR-Employee-Attrition];
--Count employees by Gender.
select Gender,
count(employeenumber) as total_emp  
from [HR-Employee-Attrition]
group by Gender;
--Show average DailyRate of all employees.
select avg(DailyRate) as avg_dailyrate 
from [HR-Employee-Attrition];
--Find employees who work overtime.
select * from [HR-Employee-Attrition]
where OverTime='yes';
--List employees from the Sales department.
select * from [HR-Employee-Attrition]
where Department='sales';
--Show the minimum and maximum DistanceFromHome.
select max(DistanceFromHome) as high_distance,
min(DistanceFromHome) as low_distance
from [HR-Employee-Attrition];
--?? Level 2 — Medium (Multi-column filters, Aggregations, Joins, Grouping)
--Count employees by Department who have left (Attrition = 'Yes')
select count(*) as total_emp, 
Department 
from [HR-Employee-Attrition]
where Attrition='yes'
group by Department;
--Find the average MonthlyIncome by JobRole.
select JobRole,avg(MonthlyIncome) as avg_monthlyIncome
from [HR-Employee-Attrition]
group by JobRole;
--Show the number of employees by MaritalStatus and Gender.
select count(*) as total_emp,
MaritalStatus,
Gender
from [HR-Employee-Attrition]
group by MaritalStatus,Gender;
--Find employees with WorkLifeBalance less than 3.
select * from [HR-Employee-Attrition]
where WorkLifeBalance<3;
--Find employees who have more than 5 years at the company AND overtime = ‘Yes’.
select count(*) as total_emp
from [HR-Employee-Attrition]
where OverTime='yes'
and YearsAtCompany >5;
--Show total working years grouped by EducationField.
select EducationField,
sum(cast(TotalWorkingYears as float)) as total_working_years
from [HR-Employee-Attrition]
group by EducationField;
--Display JobSatisfaction average by Department.
select Department,
avg(cast(JobSatisfaction as float)) as avg_jobsatisfaction
from [HR-Employee-Attrition]
group by Department;
--Find employees who had more than 3 companies before working here (NumCompaniesWorked > 3).
select * from [HR-Employee-Attrition]
where NumCompaniesWorked>3;
--Count total employees grouped by Attrition and OverTime.
select count(*) as total_emp,
Attrition,
OverTime
from [HR-Employee-Attrition]
group by Attrition,OverTime;
--Find employees with highest EnvironmentSatisfaction.
select * from [HR-Employee-Attrition]
where EnvironmentSatisfaction=4;
--?? Level 3 — Hard (Subqueries, Window Functions, Advanced Aggregations)
--Find the top 5 highest MonthlyIncome earners.
Select Top 5 EmployeeNumber,
MonthlyIncome
from [HR-Employee-Attrition]
order by MonthlyIncome desc;
--Find employees whose MonthlyIncome is above the company average income.
select EmployeeNumber,
MonthlyIncome 
from [HR-Employee-Attrition]
where MonthlyIncome>(
select avg(monthlyincome) 
from [HR-Employee-Attrition]);
--Rank employees in each department based on MonthlyIncome.
select EmployeeNumber,
Department,
MonthlyIncome,
rank() over(partition by department order by monthlyincome desc) as income_rank
from [HR-Employee-Attrition];
--Find employees who got a PercentSalaryHike higher than the department average.
select EmployeeNumber,
PercentSalaryHike,
Department
from [HR-Employee-Attrition]
where PercentSalaryHike>(
select avg(PercentSalaryHike)
from [HR-Employee-Attrition] e
where Department=e.Department);
--Find which JobRole has the highest attrition rate (Attrition %).
select  top 1 JobRole,
(sum(case when Attrition= 'yes' then 1 else 0 end)*100.0/ count(*)) as attritionrate
from [HR-Employee-Attrition]
group by jobrole
order by attritionrate desc;
--Find employees whose YearsSinceLastPromotion is above the overall average promotion gap.
select * from [HR-Employee-Attrition]
where YearsSinceLastPromotion>(
select avg(cast(YearsSinceLastPromotion as float))
from [HR-Employee-Attrition]);
--Show the correlation-style query by comparing YearsAtCompany vs TotalWorkingYears.
select YearsAtCompany,
TotalWorkingYears
from [HR-Employee-Attrition]
order by YearsAtCompany;
--Find the most common EducationField among employees who left the company.
select top 1 EducationField ,
count(*) as total_left
from [HR-Employee-Attrition]
where Attrition='yes'
group by EducationField
order by total_left desc;
--Identify employees who have the highest WorkLifeBalance per job role.
select JobRole,
max(WorkLifeBalance) as high_balance
from [HR-Employee-Attrition]
group by JobRole;
--Return employees whose YearsInCurrentRole is higher than their YearsAtCompany / 2.
select *from [HR-Employee-Attrition]
where YearsInCurrentRole>YearsAtCompany/2;