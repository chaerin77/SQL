/***********************************
group by 절  group by에 참여한 컬럼이나 그룹함수만 올 수 있다
***********************************/

select department_id, avg(salary) 
from employees
group by department_id;

/*
select department_id, salary 
from employees
--group by department_id;*/

select department_id, job_id, count(*), avg(salary) 
from employees
group by department_id, job_id
order by department_id desc, job_id asc; --안써주면 asc 

--where 절에는 그룹 함수를 쓸 수 없다
select department_id, count(*), sum(salary)
from employees
where sum(salary) >= 20000 --에러
group by department_id;

--Having절 그룹함수 전용 where절
select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) >=20000;

select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) >=20000
and department_id = 100; --급여합계가 20000이상인 부서중 부서id가 100인


--CASE ~ END 문  문법
select employee_id,
       first_name,
       salary,
       job_id,
       case when job_id = 'AC_ACCOUNT' then salary + salary*0.1
            When job_id = 'SA_REP' then salary + salary * 0.2
            When job_id = 'ST_CLERK' then salary + salary * 0.3
            else salary
       end realSalary  --end as realSalary   
from employees;       

--DECODE()
select employee_id,
       first_name,
       salary,
       job_id,
       decode( job_id, 'AC_ACCOUNT', salary + salary*0.1,
                       'SA_REP', salary + salary*0.2,
                       'ST_CLERK', salary + salary*0.3,
               salary) as realSalary
from employees;

/*[예제]
직원의 이름, 부서, 팀을 출력하세요
팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
60~100이면 ‘B-TEAM’ 110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요*/

select first_name,
       department_id,
       case when department_id between 10 and 50 then 'A-TEAM'
            when department_id >=60 and department_id <= 100 then 'B-TEAM'
            when department_id >=110 and department_id <= 150 then 'C-TEAM'
            else '팀없음'
       end as team
from employees;       

