-- Create Retirement Titles table of all current employees
-- that were born between 1/1//1952 and 12/31/1955.
-- Use Distinct On statement to filter titles to most recent
-- title, as there are be duplicates for some employees

-- 1. Create a table of all retirement-eligible employees and their titles
select a.emp_no,
	a.first_name,
	a.last_name,
	b.title,
	b.from_date,
	b.to_date
into retirement_titles
from employees as a
inner join titles as b on a.emp_no = b.emp_no
-- and b.to_date = ('9999-01-01')
where a.birth_date between '1952-01-01' and '1955-12-31'
order by a.emp_no

-- 2. Filter retirement_titles down to only each employee's most recent position
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;


-- 3. Create a table with the count of retirees by each position
select count(*), title 
into retiring_titles
from unique_titles
group by title
order by count desc;

commit

-- Deliverable 2
-- Create a table of mentorship-eligible employees who were born
-- between 01/01/1965 and 12/31/1965
select distinct on (emp_no) a.emp_no,
	a.first_name,
	a.last_name,
	a.birth_date,
	b.from_date,
	b.to_date,
	c.title
into mentorship_eligibility
from employees as a,
	dept_employees as b,
	titles as c
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and a.birth_date between '1965-01-01' and '1965-12-31'
and c.to_date = '9999-01-01'
order by emp_no, to_date desc;

commit;