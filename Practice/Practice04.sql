--서브쿼리(SUBQUERY) SQL 문제입니다.
/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)*/

select count(employee_id)
from employees
where salary < (select avg(salary)
                from employees);
                
                
/*
문제2.
평균급여 이상, 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차
순으로 정렬하여 출력하세요
(51건)*/
                
select employee_id,
       first_name,
       salary,
       avg(salary),
       max(salary)
from employees
where salary between (select avg(salary)
                      from employees) 
             and (select max(salary)
                  from employees)
group by employee_id, first_name, salary;

                   
/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요
(1건)*/

select l.location_id,
       l.street_address,
       l.postal_code,
       l.city,
       l.state_province,
       l.country_id
from locations l
where l.location_id = (select de.location_id
                      from employees em, locations lo, departments de      
                      where first_name = 'Steven'
                      and last_name = 'King'
                      and em.department_id = de.department_id
                      and de.location_id = lo.location_id);


/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로
출력하세요 -ANY연산자 사용
(74건)*/
                      
select salary
from employees
where job_id = 'ST_MAN';

select employee_id,
       first_name,
       salary
from employees
where salary < any (select salary 
                    from employees
                    where job_id = 'ST_MAN')
order by salary desc;                      


/*
문제5.
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여
(salary) 부서번호(department_id)를 조회하세요
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)*/
--조건절비교
select employee_id,
       first_name,
       salary,
       department_id
from employees
where (department_id,salary) in (select department_id,max(salary)
                                 from employees
                                 group by department_id);

--테이블 조인
select em.employee_id,
       em.first_name,
       em.salary,
       s.department_id
from employees em, (select department_id,max(salary)salary
                                 from employees
                                 group by department_id)s
where em.department_id = s.department_id
and em.salary = s.salary;                                 

/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오
(19건)*/
select job_title,
       sum(salary)
from jobs, employees
where jobs.job_id = employees.job_id
group by job_title
order by sum(salary) desc;


/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름
(first_name)과 급여(salary)을 조회하세요
(38건)*/
--테이블 조인 , 그룹함수 alias사용
select em.employee_id,
       em.first_name,
       em.salary
       --em.department_id,
       --s.average
from employees em, (select avg(salary)as average,emp.department_id
                    from employees emp
                    group by emp.department_id)s
where em.department_id = s.department_id
and em.salary > s.average;

/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력
하세요*/
--1.입사일 순서로 정렬하기
select employee_id,
       first_name,
       salary,
       hire_date
from employees
order by hire_date asc;

--2. 1을 테이블 o라고 이름붙이고 그 테이블에 일련번호(rownum)붙이기
select rownum,
       o.employee_id,
       o.first_name,
       o.salary,
       o.hire_date
from (select employee_id,
      first_name,
      salary,
      hire_date
      from employees
      order by hire_date asc)o;        

--3. 2를 테이블 r이라고 이름 붙이고, r은 일련번호가 매겨진 테이블이니까 그 위에서 일련번호가 11~15인 조건을 넣어주기 
--+ r에서 rownum은 번호를 매기기위해 쓴거지만 3.에서도 select rownum해버리면 또 번호매기는걸로 알아들을수있으니 r테이블의 rownum에 별명을지어주고 그 별명을 select절에 쓰기

select r.rno,
       r.employee_id,
       r.first_name,
       r.salary,
       r.hire_date
from (select rownum rno,
             o.employee_id,
             o.first_name,
             o.salary,
             o.hire_date
      from (select employee_id,
                   first_name,
                   salary,
                   hire_date
            from employees
            order by hire_date asc)o
      )r
where r.rno >=11
and r.rno <=15;