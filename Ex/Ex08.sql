/****************************************
 * rownum
 ****************************************/

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.

--rownum을 붙인후 정렬시 rownum의 순서가 섞이게 된다 -> 정렬을 하고 rownum을 붙여야함
select rownum,
       first_name,
       salary
from employees
order by salary desc;

---->정렬을 하고 rownum을 붙인다.
select rownum
       frist_name,
       salary
from (select first_name,
             salary
      from employees
      order by salary desc) ot  --ot : 정렬되어 있는 테이블
      

 ---->정렬을 하고 rownum을 붙인 후 rownum조건을 설정시 rownum >=2 -->데이터 출력이 안됨     
select rownum
       frist_name,
       salary
from (select first_name,
             salary
      from employees
      order by salary desc) ot
where rownum >=1 --rownum >=2  -->데이터가 없
and rownum <= 5;


--->해결방법 (1)정렬을 하고   (2)rownum을 붙이고  (3)where절 사용

select ort.rn,
       ort.first_name,
       ort.salary
from(select rownum rn,
            ot.first_name,
            ot.salary
     from(select first_name,
                 salary
          from employees
          order by salary desc)ot ----(1)       
     )ort ----(2)
where rn >= 2
and rn <= 5;


/*************************************************/
--예제) 07년에 입사한 직원 중 급여가 많은 직원중
-- 3에서 7등의 이름/급여/입사일은?
---> (1)정렬을 하고 (2)rownum을 붙이고 (3)where절 사용

select ort.rn,
       ort.first_name,
       ort.salary,
       ort.hire_date
from(select rownum rn,
            ot.first_name,
            ot.salary,
            ot.hire_date
     from(select first_name,
                 salary,
                 hire_date
          from employees
          where hire_date >= '07/01/01'
          and hire_date < '08/01/01'
          order by salary desc) ot  -------(1)
     ) ort ---------(2)
where rn >=6
and rn <=7 ; ------(3)


--07년에 입사한 직원중 급여가 많은 직원중 
--3에서 7등의 이름 급여 입사일 + 부서명은? 
--->  (1)정렬을 하고  (2)rowmum 붙이고  (3)where절 사용

select ort.rn,
       ort.first_name,
       ort.salary,
       ort.hire_date,
       ort.department_name
from (select rownum rn,
             ot.first_name,
             ot.salary,
             ot.hire_date,
             ot.department_name
	  from (select em.first_name,
       			   em.salary,
       			   em.hire_date,
       			   de.department_name
			from employees em, departments de  ---(0)부서명 때문에 조인
			where em.department_id = de.department_id
			and hire_date >= '07/01/01'
			and hire_date < '08/01/01'
			order by salary desc) ot --------(1)
      ) ort -----(2)
where ort.rn >= 3 ------(3)
and ort.rn <= 7 ;      
      