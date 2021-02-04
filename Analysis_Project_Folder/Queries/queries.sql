-- List of employees born from 1952-1955
select first_name, last_name
from "public".employees
where birth_date between '1952-01-01' and '1955-12-31';

-- List of employees born in 1952
select first_name, last_name
from "public".employees
where birth_date between '1952-01-01' and '1952-12-31';

-- List of employees born in 1953
select first_name, last_name
from "public".employees
where birth_date between '1953-01-01' and '1953-12-31';

-- List of employees born in 1954
select first_name, last_name
from "public".employees
where birth_date between '1954-01-01' and '1954-12-31';

-- List of employees born in 1955
select first_name, last_name
from "public".employees
where birth_date between '1955-01-01' and '1955-12-31';

-- Retirement Eligibility
select first_name, last_name
from "public".employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Retirement Count
select count(first_name)
from "public".employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Retirement_info table
select first_name,last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

commit;

rollback;

select count(*) from retirement_info

-- join statement
select first_name, last_name, title
from employees as e
left join titles as t on e.emp_no = t.emp_no

drop table retirement_info;

select emp_no, first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');
select * from retirement_info

-- inner join on departments and dept_managers
select departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
from departments
inner join dept_manager
on departments.dept_no = dept_manager.dept_no;

-- left join retirement_info and dept_employees
select retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_employees.to_date
from retirement_info
left join dept_employees on retirement_info.emp_no = de.emp_no;

-- left join retirement_info and dept_employees (ALIASED)
select r.emp_no,
	r.first_name,
	r.last_name,
	de.to_date
from retirement_info as r
left join dept_employees as de on r.emp_no = de.emp_no;

-- inner join on departments and dept_managers (ALIASED)
select d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
from departments as d
inner join dept_manager as dm
on d.dept_no = dm.dept_no;

-- left join retirement_info and dept_employees into new table
select r.emp_no,
	r.first_name,
	r.last_name,
	de.to_date
into current_emp
from retirement_info as r
left join dept_employees as de on r.emp_no = de.emp_no
where de.to_date = ('9999-01-01');

select * from current_emp

-- Employee count by department number
select count(ce.emp_no), de.dept_no
into dept_retirees
from current_emp as ce
left join dept_employees as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

-- 7.3.5 Employee Info list
-- list of employees w/emp_no, first name, last name, gender, & salary
select e.emp_no,
	e.last_name,
	e.first_name,
	e.gender,
	de.to_date,
	s.salary
into emp_info
from employees as e
inner join dept_employees as de on e.emp_no = de.emp_no
inner join salaries as s on e.emp_no = s.emp_no
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31')
and (de.to_date = '9999-01-01');

-- retiring managers solo attempt
select de.dept_no,
	d.dept_name,
	de.emp_no,
	e.last_name,
	e.first_name,
	man.from_date,
	man.to_date
into ret_managers_bdw
from dept_employees as de
inner join departments as d on de.dept_no = d.dept_no
inner join employees as e on de.emp_no = e.emp_no
inner join dept_manager as man on de.emp_no = man.emp_no
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31')
and (man.to_date = '9999-01-01');

-- retiring managers from da module
select dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
-- into ret_managers
from dept_manager as dm
inner join departments as d on dm.dept_no = d.dept_no
inner join current_emp as ce on dm.emp_no = ce.emp_no;

-- solo attempt at dept_info (department retirees)
select ce.emp_no,
	ce.last_name,
	ce.first_name,
	d.dept_name
into dept_info
from current_emp as ce
left join dept_employees as de on ce.emp_no = de.emp_no
left join departments as d on de.dept_no = d.dept_no
order by dept_name;

drop table dept_info;

select count(*) from current_emp
select count(*) from dept_info
select count(*) from emp_info

-- create list of employees retiring from sales team
select * 
into sales_ret
from dept_info as di
where di.dept_name = 'Sales'

-- create list of employees retiring from sales & development teams
select * 
into salesAndDev_ret
from dept_info as di
-- where di.dept_name = 'Sales'
-- or di.dept_name='Development';
where di.dept_name in ('Sales','Development')

select * from salesAndDev_ret

commit;

rollback;

