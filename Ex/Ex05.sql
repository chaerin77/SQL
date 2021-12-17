/*******************************
*join
*******************************/

--r2889 c15  row-세로 c-가로    --row- 107개 calumn-11개   --r27 c04
/*select *                       select *                  select *
  from employees, departments;   from employees;           from employees, departments;*/
--카티션 프로덕트(Cartesian Product)
select *
from employees, departments;

--조인
select emp.employee_id, --소속을 좀더 정확히 쓰면 이것, 별명 지은걸로 표기
       emp.first_name,
       enp.salary,
       dep.department_name,
       emp.department_id, --department_id는 employees,departments 테이블에 공통으로 존재해서 소속 명확하게 써줘야 오류가 안남
       dep.department_id
from employees emp, departments dep --from절에 별명 붙일땐 as쓰면 안됨
where emp.department_id = dep.department_id;
--결과가 107이 아니라 106인 이유 --department_id가 null값인걸 부서테이블에서 찾을수 없어서 제외됨


/*[예제]
모든 직원이름, 부서이름, 업무명 을 출력하세요*/
select first_name,
       department_name,
       job_title
from employees,departments,jobs;       

---왜 이렇게 되는지 모르겠으면 외우기
select em.first_name,
       de.department_name,--공통된거 아니라서 앞에 departmetns.안써도 값 나오긴함
       jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and   em.job_id = jo.job_id
order by first_name asc;
      

select count(*)      
from employees em, departments de, jobs jo
where em.department_id = de.department_id
      and em.job_id = jo.job_id;  