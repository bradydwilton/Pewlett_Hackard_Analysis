-- 1. Create a table of all retirement-eligible employees and their titles & departments
select a.emp_no,
	a.first_name,
	a.last_name,
	b.title,
	b.from_date,
	b.to_date,
	c.dept_name
into retirement_depts
from employees as a
inner join titles as b on a.emp_no = b.emp_no
left join dept_info as c on a.emp_no = c.emp_no
-- and b.to_date = ('9999-01-01')
where a.birth_date between '1952-01-01' and '1955-12-31'
order by a.emp_no;

commit;

select count(*) from retirement_titles

-- 2. Filter retirement_titles down to only each employee's most recent position
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title,
dept_name
INTO unique_dept
FROM retirement_depts
ORDER BY emp_no, to_date DESC;

commit;

-- 3. Create a table with the count of retirees by each position
select count(*), title, dept_name 
into retiring_depts
from unique_dept
group by dept_name, title
order by dept_name, title;

commit;

select * from retiring_depts

-- 3. Create a table with the count of retirees by each position
select count(*), dept_name 
into retiring_dept_count
from unique_dept
group by dept_name
order by count desc;

select * from retiring_dept_count