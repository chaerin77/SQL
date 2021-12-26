--혼합 SQL 문제입니다.
/*문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)*/
select first_name,
       manager_id,
       commission_pct,
       salary
from employees
where commission_pct is null
and manager_id is not null
and salary > 3000;

/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하
세요
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)*/

/*
문제3
매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매
니저별최대급여 입니다.
(9건)*/

/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)*/
select em.employee_id,
       em.first_name,
       de.department_name,
       ma.first_name
from employees em, departments de, employees ma
where em.department_id = de.department_id(+)
and em.manager_id = ma.employee_id;

/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요*/
select r.rno,
       r.employee_id,
       r.first_name,
       r.department_name,
       r.salary,
       r.hire_date
from (select rownum rno,
             o.employee_id,
             o.first_name,
             o.department_name,
             o.salary,
             o.hire_date
      from (select em.employee_id,
                   em.first_name,
                   de.department_name,
                   em.salary,
                   em.hire_date
            from employees em, departments de
            where em.department_id = de.department_id 
            and hire_date > '2004/12/31'
            order by hire_date asc)o
     )r       
where r.rno >= 11
and r.rno <= 20;

/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름
(department_name)은?*/
select em.first_name || ' ' || em.last_name,
       em.salary,
       de.department_name
from employees em, departments de
where em.department_id = de.department_id
and hire_date = (select max(hire_date)
                 from employees);

/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 연봉(salary)을 조회하시오.*/
select em.employee_id,
       em.first_name,
       em.last_name,
       jo.job_title,
       em.salary
from employees em, jobs jo       
where em.job_id = jo.job_id
and em.department_id = (select department_id --평균연봉이 부서별로 가장높은 부서의아이디
                        from employees 
                        having avg(salary) = (select max(avg(salary)) --부서별로 가장높은 평균연봉의 값
                                              from employees
                                              group by department_id)
                        group by department_id);
                 
/*
문제8.
평균 급여(salary)가 가장 높은 부서는?*/
select de.department_name
from departments de 
where de.department_id = (select em.department_id
                          from employees em
                          having avg(em.salary)= (select max(avg(emp.salary))
                                                  from employees emp
                                                  group by emp.department_id)
                          group by em.department_id); 
                        
/*
문제9.
평균 급여(salary)가 가장 높은 지역은?*/

/*
문제10.
평균 급여(salary)가 가장 높은 업무는?*/