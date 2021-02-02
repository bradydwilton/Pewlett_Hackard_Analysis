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

select count(*) from retirement_info
