delimiter // 
create function salary_cal2(salary float , bonus int)
returns float 
deterministic
begin
	declare bonus1 int ;
	select ifnull(bonus , 0) into bonus1;
	return ((bonus1/100)*salary) + salary;
end
//

select emp_no , first_name , salary , bonus ,  salary_cal2(salary , bonus) "month_salary" from employees;
DELIMITER //
create procedure getEmployee(in emp_id int)
begin
	select * from employees where emp_no = emp_id ;
end
//

call getEmployee(10002);
call getEmployee(10001)
drop procedure getEmployee;
DELIMITER //
CREATE PROCEDURE p1()
BEGIN
   /* declare local variables */
   DECLARE x INT DEFAULT 0;
   DECLARE y, z INT;
 
   /* using the local variables */
   SET x := x + 100;
   SET y := 2;
   SET z := x + y;
 
   BEGIN
      /* local variable in nested block */
      DECLARE z INT;
       
      SET z := 5;
 
      /* local variable z takes precedence over the one of the 
         same name declared in the enclosing block. */ 
      SELECT x, y, z;
   END;
 
   SELECT x, y, z;
END;
//
call p1();  -- this will give 2 result one for outer block and one for inner 

-- use of session variable :
DELIMITER //
CREATE PROCEDURE p2()
BEGIN
   SET @a = 5; 
      SET @b = 5; 
      SELECT @a, @b;
   END;
 // 
 
 DELIMITER //
CREATE PROCEDURE p3()
BEGIN
   SET @a = @a + 10; 
      SET @b = @b - 5; 
      SELECT @a, @b;
   END;
   //
   call p2();
   call p3();  -- @ is global variable will access outside the stored procedure also 
   
   
  DELIMITER //
  create procedure emp_dept( in dept_id varchar(50) , out tot_c int , out min_sal float)
  begin
	select count(*) , min(salary)  into tot_c , min_sal from employees where did = dept_id ;
  end 
  //
  
  call emp_dept('d001' ,@tot_c , @min_sal);
  select @tot_c , @min_sal;
  DELIMITER //
create PROCEDURE adjust_emp_salary (IN employee_id int) 
BEGIN 
  DECLARE job_designation varchar(50);
  DECLARE bonus_raise int;
  SELECT designation , ifnull(bonus,0) INTO job_designation , bonus_raise  FROM employees where emp_no=employee_id ; 
  CASE 
    WHEN job_designation like 'Jr.%' THEN 
      SET bonus_raise := bonus_raise +5;
    WHEN job_designation like 'Sr.%' THEN 
      SET bonus_raise := bonus_raise+10;
    WHEN job_designation like '%manager%' THEN 
      SET bonus_raise := bonus_raise+10;
  END CASE;
  update employees set bonus = bonus_raise  where emp_no=employee_id;
END;
call adjust_emp_salary (10002) ;
drop procedure adjust_emp_salary;
-- Trigger 
use employees;
create table emp_sal_dummy (emp_no int , salary_date date , salary_rec date );
alter table emp_sal_dummy modify salary_rec float;

delimiter // 
create trigger emp_sal_update
before update on emp_salary
for each row 
begin
insert into emp_sal_dummy values(old.emp_no , old.salary_date , old.salary_rec);
end;
//
select * from emp_salary;
set sql_safe_updates=0;

update employees.emp_salary set emp_salary.salary_rec = 60000 where emp_salary.emp_no = 10001;
select * from emp_sal_dummy;


delimiter // 
create trigger up_emp
before insert on employees
for each row
set new.first_name = UPPER(new.first_name);
// 

INSERT INTO `employees` VALUES (10028,'1953-09-02','Ria','Pandya','M','1986-06-26','Jr. Developer', 56789 , 'd005' , 10);
select * from employees;

DELIMITER //
 create procedure student_pr( in id int , out sid_o int)
begin 


select sid into sid_o from student where sid = id ;
END;
 //
 call student_pr(6,@sid_o);
 select @sid_o;

-- cursor 
DELIMITER $$
CREATE PROCEDURE getFullName (  INOUT fullNameList varchar(4000))
BEGIN
  DECLARE finished INTEGER DEFAULT 0;
  DECLARE fullName varchar(100) DEFAULT "";
   #Cursor declaration
      DEClARE curName
        CURSOR FOR
             SELECT concat(first_name ,' , ' , last_name) FROM employees LIMIT 10;
               #declare NOT FOUND handler
               DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    #Open cursor
               OPEN curName;
    #fetch records
               getName: LOOP
                              FETCH curName INTO fullName;
                              IF finished = 1 THEN LEAVE getName;
                              END IF;
                              SET fullNameList = CONCAT(fullName,";",fullNameList);
               END LOOP getName;
               CLOSE curName;
END$$

DELIMITER ;
SET @fullNameList = "";

CALL getFullName(@fullNameList);

SELECT @fullNameList;
DELIMITER $$
CREATE PROCEDURE emp_poc ()
BEGIN
  DECLARE done INTEGER DEFAULT 0;
  declare emp_id int;
declare bonus_raise int;
declare job_designation varchar(50);
   #Cursor declaration
      DEClARE curName
        CURSOR FOR
             SELECT emp_no, designation , bonus FROM employees;
               #declare NOT FOUND handler
               DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    #Open cursor
               OPEN curName;
    #fetch records
               getName: LOOP
                              FETCH curName INTO emp_id  ,job_designation , bonus_raise ;
                              IF done = 1 THEN LEAVE getName;
                              END IF;
                              -- SET fullNameList = CONCAT(fullName,";",fullNameList);
                              CASE 
    WHEN job_designation like 'Jr.%' THEN 
      SET bonus_raise := bonus_raise +5;
    WHEN job_designation like 'Sr.%' THEN 
      SET bonus_raise := bonus_raise+10;
    WHEN job_designation like '%manager%' THEN 
      SET bonus_raise := bonus_raise+10;
	else set bonus_raise := bonus_raise;
  END CASE;
  update employees set bonus = bonus_raise  where emp_no=emp_id;
               END LOOP getName;
               CLOSE curName;
END$$

call emp_poc();