/********************************
*Sub Query
********************************/
---순서 적어본것---
--1)
select first_name,
       salary
from employees
where salary > 'Den의 급여';

--2) Den의 급여
select salary --부가정보 넣으면 식 달라지니까 주의
from employees
where first_name = 'Den';

--3)Query문 완성 --들여쓰기 잘할것
select first_name,
       salary
from employees
where salary >= (select salary
                 from employees
                 where first_name = 'Den');   
                 
                 
/*
[예제]
급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는? */   

--1.급여를 가장 적게 받는 사람의 급여 구하기
select min(salary)
from employees;

--2. 2100받는 사람의 이름, 급여, 사원번호 구하기
select first_name,
       salary,
       employee_id
from employees
where salary = 2100; --1.의 값 where절에 넣어서 구했지만 하나의 식에 구해보기

--3.식 조합
select first_name,
       salary,
       employee_id
from employees
where salary = (select min(salary)
                from employees);       



--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요       
--1.평균 급여 구하기
select avg(salary)
from employees;

--2. 평균 급여인 6461.83 보다 적게 받은 사람의 이름, 급여
select first_name,
       salary
from employees
where salary < 6461.83;

--3. 식 조합
select first_name,
       salary
from employees
where salary < (select avg(salary)
                from employees);