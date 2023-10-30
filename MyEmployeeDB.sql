show databases;
show tables;
use employees;
show tables;
select * from employees;
INSERT INTO `departments` VALUES 
('d001','Marketing'),
('d002','Finance'),
('d003','Human Resources'),
('d004','Production'),
('d005','Development'),
('d006','Quality Management'),
('d007','Sales'),
('d008','Research'),
('d009','Customer Service');
select * from departments;
select * from employees;
alter table employees add (designation varchar(50) , salary float , did varchar(20) REFERENCES departments(dept_no));
INSERT INTO `employees` VALUES (10001,'1953-09-02','Georgi','Facello','M','1986-06-26','Jr. Developer', 56789 , 'd005'),
(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21','Manager' , 6789.23,'d005'),
(10003,'1959-12-03','Parto','Bamford','M','1986-08-28' , 'Team Lead' , 45673 ,'d005'),
(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01', 'Asst. Manager' ,56789, 'd001'),
(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12','Dy. Manager' ,89000, 'd001'),
(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02' , 'Manager' , 67890,'d001'),
(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10' , 'Manager' ,56789, 'd007'),
(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15' , 'Jr. Developer' , 40890,'d005'),
(10009,'1952-04-19','Sumant','Peac','F','1985-02-18','Jr. Developer' , 40899 , 'd005'),
(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24' ,' Jr. Developer' , 47890,'d005'),
(10011,'1953-11-07','Mary','Sluis','F','1990-01-22' , 'Sr. developer', 78900, 'd005'),
(10012,'1960-10-04','Patricio','Bridgland','M','1992-12-18' , 'Sales Ex.' , 43789 , 'd007'),
(10013,'1963-06-07','Eberhardt','Terkki','M','1985-10-20', 'Sales Ex.' , 34564.23 , 'd007'),
(10014,'1956-02-12','Berni','Genin','M','1987-03-11' , 'Sales Ex.' , 33564.23 , 'd007'),
(10015,'1959-08-19','Guoxiang','Nooteboom','M','1987-07-02', 'Sales Ex.' , 44564.23 , 'd007'),
(10016,'1961-05-02','Kazuhito','Cappelletti','M','1995-01-27' , 'Jr. Tester' , 65656 , 'd004'),
(10017,'1958-07-06','Cristinel','Bouloucos','F','1993-08-03','Jr. Tester' , 65656 , 'd004'),
(10018,'1954-06-19','Kazuhide','Peha','F','1987-04-03','Jr. Tester' , 65656 , 'd004'),
(10019,'1953-01-23','Lillian','Haddadi','M','1999-04-30' , 'Clerk' ,19000  , 'd003'),
(10020,'1952-12-24','Mayuko','Warwick','M','1991-01-26','Sr. Clerk' ,30000  , 'd003'),
(10021,'1960-02-20','Ramzi','Erde','M','1988-02-10','HR' ,70000  , 'd003'),
(10022,'1952-07-08','Shahaf','Famili','M','1995-08-22' , 'Jr. Accountant' , 35000 , 'd002'),
(10023,'1953-09-29','Bojan','Montemayor','F','1989-12-17', 'Jr. Accountant' , 35000 , 'd002'),
(10024,'1958-09-05','Suzette','Pettey','F','1997-05-19', 'Sr. Accountant' , 65000 , 'd002'),
(10025,'1958-10-31','Prasadram','Heyers','M','1987-08-17' , 'Sr. Accountant' , 75000 , 'd002'),
(10026,'1953-04-03','Yongqiao','Berztiss','M','1995-03-20','Cashier' , 55000 , 'd002'),
(10027,'1962-07-10','Divier','Reistad','F','1989-07-07', 'Accountant' , 95000 , 'd002');

alter table employees add bonus int;

UPDATE `employees`.`employees` SET `bonus` = '10' WHERE (`emp_no` = '10001');
UPDATE `employees`.`employees` SET `bonus` = '20' WHERE (`emp_no` = '10002');
UPDATE `employees`.`employees` SET `bonus` = '10' WHERE (`emp_no` = '10003');
UPDATE `employees`.`employees` SET `bonus` = '10' WHERE (`emp_no` = '10006');
UPDATE `employees`.`employees` SET `bonus` = '10' WHERE (`emp_no` = '10009');
UPDATE `employees`.`employees` SET `bonus` = '10' WHERE (`emp_no` = '10010');
UPDATE `employees`.`employees` SET `bonus` = '20' WHERE (`emp_no` = '10012');
UPDATE `employees`.`employees` SET `bonus` = '20' WHERE (`emp_no` = '10013');
UPDATE `employees`.`employees` SET `bonus` = '10' WHERE (`emp_no` = '10017');
UPDATE `employees`.`employees` SET `bonus` = '10' WHERE (`emp_no` = '10018');
UPDATE `employees`.`employees` SET `bonus` = '20' WHERE (`emp_no` = '10020');
UPDATE `employees`.`employees` SET `bonus` = '15' WHERE (`emp_no` = '10021');
UPDATE `employees`.`employees` SET `bonus` = '15' WHERE (`emp_no` = '10022');
UPDATE `employees`.`employees` SET `bonus` = '10' WHERE (`emp_no` = '10025');
UPDATE `employees`.`employees` SET `bonus` = '15' WHERE (`emp_no` = '10026');
select emp_no , salary , (salary *12) "Annual Package" from employees;
select emp_no , salary , (salary+((salary*bonus)/100)) "Monthly Salry " ,(salary *12) "Annual Package" from employees where bonus is not null;
select concat(first_name ," ", last_name) from employees;
select * from departments;
select emp_no ,ucase(concat(first_name ," ", last_name)) "name" , salary , designation  from employees
where salary between 50000 and 70000
and designation LIKE '%developer%';
select * from employees order by hire_date;
select first_name , birth_date ,round( (datediff(current_date(),birth_date)/365))  "age" from employees;
select e.did, d.dept_name , avg (e.salary) from employees e
inner join departments d on e.did = d.dept_no
group by e.did;
create table emp_history (eid int references employees.employees(emp_no) , end_date date );
insert into emp_history values (10009 , '2020-01-30'),(10002,'2019-03-30'),(10001, '2000-12-30');
select e.emp_no , datediff(d.end_date,e.hire_date)/365 "tenure" from employees e 
inner join emp_history d on e.emp_no = d.eid ;
select e.emp_no , datediff(d.end_date,e.hire_date)/365 "tenure_end" , datediff(current_date(),e.hire_date)/365 "tenure" 
from employees e 
left outer join emp_history d on e.emp_no = d.eid;

select * from emp_history inner join employees on emp_history.eid = employees.emp_no;

select e.emp_no , datediff(d.end_date,e.hire_date)/365 "tenure" from employees e 
inner join emp_history d on e.emp_no = d.eid 
union all 
select e.emp_no , datediff(current_date(),e.hire_date)/365 "tenure"  from employees e limit 2,4;

select designation , replace(replace(designation , 'Jr.' ,'Junior'),'Sr.' , 'Senior') from employees;

create table emp_salary (emp_no int references employees(emp_no) , salary_date date , salary_rec float);
insert into emp_salary values(10001 , '2023-01-30' , 56700),(10002 , '2023-01-30' , 67800) , (10001 , '2023-02-28' , 56780) ,(10001 , '2023-03-30' , 56700),(10002 , '2023-02-28' , 6789) , (10002 , '2023-03-30' , 6789);

select * from emp_salary;
select emp_no , last_value(salary_date) over(order by salary_date desc) , date_add(salary_date , interval 1 month ) next_sal from emp_salary limit 2;

select emp_no ,salary_date , date_add(salary_date , interval 1 month ) next_sal from emp_salary order by salary_date desc limit 2 ;
select d.dept_name , max(e.salary) , min(e.salary) from employees e  
inner join departments d on e.did = d.dept_no group by e.did;

(select first_name , floor(datediff(current_date(),hire_date)/365) "tenure" from employees 
order by tenure limit 2)
union all 
(select first_name , floor(datediff(current_date(),hire_date)/365) "tenure" from employees 
order by tenure desc limit 2);

select first_name , max(salary)  from employees group by did , emp_no;

select first_name,did, max(salary) over() from employees  ;

select first_name , salary,
case 
when salary <= 15000 then "Grade 4"
when salary>15000 and salary <= 50000 then "Grade 3"
when salary>50000 and salary <= 100000 then "Grade 2"
when salary >100000 then "Grade 1"
end salary_tag
from employees;

select did  , max(salary),
case 
when max(salary) >80000 then "Higher"
when max(salary)<80000 then "LOwer"
end salary_tag
from employees
group by did ; 

 
 select designation  , avg(salary) avg_salary,
if (max(salary) >80000 , "Higher" , "Lower")
 salary_tag
from employees
group by designation; 
 
select * from employees where salary = ( select min(salary) from employees);
select * from employees where salary IN (select min(salary) from employees group by did );

select d.dept_name , avg(e.salary) from employees e inner join departments d on e.did = d.dept_no  group by e.did 
having e.did in (select did from employees group by did having avg(salary) >60000);

select e.first_name , e.did , d.dept_name from employees e inner join departments d on e.did = d.dept_no ;
select * from employees e inner join departments d on e.did = d.dept_no ;
select * from employees e left outer join departments d on e.did = d.dept_no ;
select * from employees e right outer join departments d on e.did = d.dept_no ;

select * from employees where emp_no in (select emp_no from emp_salary );
select * from employees left outer join emp_salary using(emp_no);

-- all employees where bonus is less tha 15 % 
select * from employees where bonus <  15 or bonus is null;
select dept_name from departments where dept_no >
ALL (select did from employees where emp_no in (select emp_no from employees.emp_salary));

-- degination wise average salary and display in higher to lower order 
select designation , avg(salary) avg_sal from employees group by designation order by avg_sal desc;
-- max no of employees in which department 
select max(dept_cnt) from
(select count(*) dept_cnt from employees group by did ) t1;
-- all thoses employees who are not in department sales
select * from employees where did not in
(select dept_no from departments where dept_name like'Sales');

-- highest salary department wise 
select did ,first_name , salary  from employees where salary in
(select max(salary) from employees group by did );

-- select the employees whose tenure is greter than 30
select first_name , t1.tenure from
(select first_name , (datediff(current_date(),hire_date)/365) as tenure from employees)t1 
where t1.tenure >30;

-- or 
select first_name , (datediff(current_date(),hire_date)/365) as tenure from employees having tenure >30;

-- all those employees who join in month of Dec

select first_name ,month(hire_date) as mon from employees having  mon =12;
select if(bonus  is null ,0,bonus) from employees;

select first_name , salary , bonus , salary+bonus from employees;

-- select first_name , salary , bonus , ((bonus/100)*salary) +salary net_sal from employees;
select first_name , t2.net_sal from 
(select first_name , salary , ((t1.b/100)*salary) +salary net_sal from
(select first_name , salary , bonus , ifnull(bonus ,0) b from employees)t1)t2
where t2.net_sal > t2.salary;

select first_name ,salary , t2.netpay from 
(select first_name ,salary , (((t1.b/100)*salary)+salary) as netpay from
(select first_name , salary  , ifnull(bonus,0) b from employees)t1)t2 
where t2.netpay>t2.salary;

-- find all those join efore 15th 
select first_name , hire_date from employees where dayofmonth(hire_date)<15;

-- find the details of the emloyees who hired first in the company 
select * from employees order by hire_date limit 1;

select * , min(hire_date) over(partition by did order by hire_date ) from employees;
select * ,  max(hire_date)over(order by hire_date)  from employees limit 1 ;

-- rank of employees on baisis of salary 
select first_name , salary , dense_rank() over (order by salary ) sal_rank from employees ;
-- select rank of each department on the basis of there total salary 
select * , dense_rank() over(order by total_amount desc) ranks from
(select did , sum(salary) total_amount from employees  group by 1)t1;

-- select the departments where total salary is less thank 2 l 
select d.dept_name , t1.sum_a from departments d , 
(select did , sum(salary) sum_a from employees group by did)t1
where t1.did = d.dept_no and t1.sum_a <2000000;

select * from 
(select * , dense_rank() over(order by total_amount desc) ranks from
(select did , sum(salary) total_amount from employees  group by 1)t1)t2
where total_amount<=200000;

-- -- select the departments name where total salary is less thank 2 l  
select t3.did ,d.dept_name  from departments d  , 
(select * from 
(select * , dense_rank() over(order by total_amount desc) ranks from
(select did , sum(salary) total_amount from employees  group by 1)t1)t2
where total_amount<=200000) t3
where d.dept_no = t3.did;

-- rank of employees according to salary and tag them high and low 
select concat(t1.first_name , " " , t1.last_name) ename, t1.salary, t1.ranks,
case when t1.ranks <=5 then 'Top Salaries' else 'Bottom Salaries' end rank_tag from
(select * , dense_rank() over(order by salary desc) ranks from employees)t1 ; 

select concat(t2.first_name , " " , t2.last_name) ename, t2.salary, t2.ranks,
case when t2.ranks <=5 then 'Top Salaries' else 'Bottom Salaries' end rank_tag from
(select * from
(select * , dense_rank() over(order by salary desc) ranks , count(*) over() counts from employees)t1)t2
where t2.ranks <=5  or t2.ranks > counts-5; 

-- find out department wise total solary nad comapre with total salry in company
select  did , salary ,sum(salary)  over() as "total_salary" ,
sum(salary) over(partition by did order by did ) "dept_salary"  
from employees;

-- find out details of employee who get hire first 
select d.dept_name , e.first_name , e.hire_date , first_value(e.hire_date) over (partition by e.did order by e.hire_date) first_hire
from employees e inner join departments d on e.did = d.dept_no;
-- or (check) 
select * from employees where did in (select distinct did from
(select did  , max(hire_date) over(partition by did) from employees )t1);

select t1.first_hire , t1.dept_name from 
(select d.dept_name , e.first_name , e.hire_date , first_value(e.hire_date) over (partition by e.did order by e.hire_date) first_hire
from employees e inner join departments d on e.did = d.dept_no)t1 
group by t1.dept_name , t1.first_hire ;

-- last_value 
select d.dept_name , e.first_name , e.hire_date , last_value(e.hire_date) over 
(partition by e.did order by e.hire_date asc 
range between unbounded preceding  and unbounded following) last_hire
from employees e inner join departments d on e.did = d.dept_no;
-- or 
select d.dept_name , e.first_name , e.hire_date , last_value(e.hire_date) over 
(partition by e.did order by e.hire_date asc ) last_hire
from employees e inner join departments d on e.did = d.dept_no;
-- difference in salary of person in each month 
select emp_no , salary_date, salary_rec , lead(salary_rec ,1) over (partition by emp_no order by salary_rec ) "lead_sal", 
lead(salary_rec ,1) over (partition by emp_no order by salary_rec  )-salary_rec from emp_salary;

select emp_no , salary_date, salary_rec , lag(salary_rec ,1) over (partition by emp_no order by salary_rec ) "lead_sal", 
lag(salary_rec ,1) over (partition by emp_no order by salary_rec  )-salary_rec from emp_salary;


-- find out hiring frequncy in each department 

select dept_name , t2.did , avg(t2.hiring_frequency) from 
(select * , datediff(t1.next_Hiring , t1.hire_date )/365 "hiring_frequency" from
(select e.first_name , e.did , d.dept_name , e.hire_date  , lead(e.hire_date) 
over (partition by e.did order by e.hire_date) "next_Hiring"
from employees e join departments d on e.did = d.dept_no)t1)t2 
group by t2.did;
-- join departments d on t2.did =d.dept_no group by t2.did ;

-- example common 
select * , row_number() over(partition by did order by salary) "row_number" , 
rank() over(partition by did order by salary)  "rank",
dense_rank() over(partition by did order by salary) "dense_rank",
ntile(3) over(partition by did order by salary ) "ntile"
from employees; 


