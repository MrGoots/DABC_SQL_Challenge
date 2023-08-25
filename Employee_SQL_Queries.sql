-- Data Analysis

-- List the employee number, last name, first name, sex, and salary of each employee.
select 
	emp.emp_no
	, emp.first_name
	, emp.last_name
	, emp.sex
	, (select sal.salary 
	   from salaries 
	   as sal 
	   where emp.emp_no = sal.emp_no) 
	   as salary
from employees as emp;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select
	emp.first_name
	, emp.last_name
	, emp.hire_date
from employees as emp
where date_part('year', emp.hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
select
	dept.dept_no
	, dept.dept_name
	, emp.emp_title_id
	, emp.first_name
	, emp.last_name
from dept_emp as de
	left join employees as emp on emp.emp_no = de.emp_no
	left join departments as dept on dept.dept_no = de.dept_no		
where emp.emp_title_id like 'm%';

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
create view all_dept_emp as
	(select emp.emp_no
			, emp.emp_title_id
			, emp.birth_date
			, emp.first_name
			, emp.last_name
			, emp.sex
			, emp.hire_date
			, dept.dept_name
			, dept.dept_no
	from dept_emp as de
		left join employees as emp on emp.emp_no = de.emp_no
		left join departments as dept on dept. dept_no = de.dept_no);

select
	emp_no
	, first_name
	, last_name
	, dept_name
from all_dept_emp;
	
-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select
	emp.first_name
	, emp.last_name
	, emp.sex
from employees as emp
where emp.first_name = 'Hercules' and emp.last_name like 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
create view all_dept_emp2 as
	(select
		emp_no
		, first_name
		, last_name
		, dept_name
	from all_dept_emp);
	
select * from all_dept_emp2 where dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select * from all_dept_emp2 where dept_name in ('Sales', 'Development');

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select
	emp.last_name
	, count(emp.last_name) as frequency
	from employees as emp
	group by emp.last_name
	order by frequency desc;


