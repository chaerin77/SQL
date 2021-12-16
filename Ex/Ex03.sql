/*************************
*그룹함수
*************************/

--오류 발생 이유 확인할 것 -->first_name은 1개의 row에 표현할 수 없다.
select first_name, avg(salary)
from employees;

--그룹함수 avg()
select round(avg(salary),2) --아까 아침에 배운 메소드 조합 소수점자리표현
from employees;

--그룹함수 count()
select count(*),
       count(commission_pct),
       count(department_id)
from employees;

select count(*)
from employees
where salary > 16000;

select count(*) --부서번호가 100번인 사람들의 수
from employees
where department_id =100;

--그룹함수 sum()
select sum(department_id) --숫자를 쓰고있긴하지만 문자열로 관리되고있었어야 하는건데 그렇게 안했나봄 sum(department_id)계산이 되어버림
from employees;

select sum(salary) , count(*), avg(salary) --둘다 한칸에 표현되는 데이터라서  sum(salary),count(*)이렇게 쓸수있는것 // 합계,수를 센 대상이 똑같으니까 이렇게 쓰기 가능함 평균도
from employees;

select sum(salary) , count(*), avg(salary) --조건절이 붙었기때문에 salary가 16000이넘는 세명의 평균을 구한것
from employees
where salary > 16000;

--그룹함수 avg()
select count(*),
       sum(salary),
       avg (salary)
from employees;

select count(*),
       sum(salary),
       avg(   nvl (salary, 0)   ) --***null값은 0으로 바꿔주고 평균구하기
from employees;

--그룹함수 - max() / min()
select count(*),
       max(salary),
       min(salary)
from employees;

/*****************************************
*group by 절
*****************************************/
select avg(salary)
from employees
group by department_id;