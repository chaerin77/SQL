/********************************
join
********************************/

select first_name,
       salary,
       de.department_name,
       de.department_id
from employees em, departments de
where em.department_id = de.department_id; --중요조건

select count(*) --null값을 가진 경우는 제외됨
from employees em, departments de
where em.department_id = de.department_id;


--예제)모든 직원이름/부서이름/업무명을 출력하세요
select em.first_name || ' ' || em.last_name name,
        de.department_name,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and jo.job_id = em.job_id;



--OUTER Join 
--left outer join    on
select em.first_name,
       em.salary,
       em.department_id,
       de.department_id,
       de.department_name
from employees em left outer join departments de --왼쪽(employees)을 기준으로 join하는것 null값을 가진 데이터도 출력됨
on em.department_id = de.department_id; --on

select em.department_id  
from employees em, departments de
where em.department_id = de.department_id(+); --위의 것과 같은것

select em.department_id  
from employees em, departments de
where em.department_id = de.department_id(+)
and em.employee_id =178;

select em.department_id
from employees em,departments de
where em.department_id = de.department_id(+); --연습



--right outer join
select em.first_name,
       em.salary,   
       em.department_id,
       de.department_id,
       de.department_name       
from employees em right outer join departments de
on em.department_id = de.department_id;

select em.first_name,
       em.salary,   
       em.department_id,
       de.department_id,
       de.department_name       
from employees em, departments de
where em.department_id(+) = de.department_id; --null로 표현하는곳에 (+)



--right outer join --> left outer join
select em.first_name,
       em.salary,
       em.department_id
from departments de left outer join employees em
on de.department_id = em.department_id; 

select em.first_name,
       em.salary,
       em.department_id
from departments de,employees em
where de.department_id = em.department_id(+); 



--full outer join
select em.first_name,
       em.salary,
       em.department_id,
       de.department_id,
       de.department_name
from employees em full outer join departments de
on em.department_id = de.department_id;

/*full outer join 은 이렇게 못 씀 에러남
select em.first_name,
       em.salary,
       em.department_id,
       de.department_id,
       de.department_name
from employees em full outer join departments de
on em.department_id(+) = de.department_id(+);*/



--self join
select em.employee_id 직원번호,
       em.first_name,
       em.salary,
       em.phone_number,
       em.manager_id, --여기까지 직원정보  --e
       ma.employee_id,--m    e줄과 m줄이 같은걸 출력하는것
       ma.first_name,
       ma.phone_number,
       ma.email
    
from employees em, employees ma
where em.manager_id = ma.employee_id;



--잘못된 조인
select em.employee_id,--급여랑 지역아이디 아무 상관없는데 어쩌다 값이 맞아서 연결되어서 오류없이 나와버림
       em.first_name,
       em.salary,
       lo.location_id,
       lo.city
from employees em, locations lo
where em.salary = lo.location_id;
