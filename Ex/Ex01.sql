/*

select 문
 select 절
 from 절;
*/

--직원테이블 전체 조회
select * 
from employees;

--부서테이블 전체 조회
select * 
from departments;

--원하는 컬럼만 조회
select employee_id, 
       first_name, 
       last_name
from employees;

select first_name, phone_number, hire_date, salary
from empoyees;

select first_name, 
       salary, 
       phone_number, 
       email, 
       hire_date
from employees;

--출력할 컬럼명 별명적용하기

select employee_id as empNo, --as empNo 대소문자써도 밑에 대문자로만 나옴 특수한의도를 갖고 이글자꼭표시하고싶으면 쌍따옴표
       first_name as "f-name", --as f-name, 하면 오류남 -라는 특수기호때문에그럼 그래서 쌍따옴표붙여주면해결됨
       salary as "연 봉"
from employees;

--예제
select first_name as "이름",
       phone_number as 전화번호,
       hire_date as 입사일,
       salary as 급여
from employees;

select employee_id as 사원번호,
       first_name as 이름,
       last_name as 성,
       salary as 급여,
       phone_number as 전화번호,
       email as 이메일,
       hire_date as 입사일
from employees;

--연결 연산자(Concatenation)로 컬럼들 붙이기
select first_name || ' ' || last_name --더하기개념. 근데 EllenAbel이렇게 딱붙어서 나와서 한칸띄우고싶음 - ' ' 써주기
from employees;

select first_name || ' 입사일은 ' || hire_date
from employees;

select first_name || ' ' || last_name as name
from employees;


--산술 연산자 사용하기
select first_name,
       salary as 월급,
       salary*12 as 연봉,
       (salary+300)*12
from employees;

select first_name || '-' || last_name as 성명,
       salary as 급여,
       salary*12 as 연봉,
       (salary*12)+5000 as 연봉2,
       phone_number as 전화번호
from employees;


/*where 절*/------------------------------------------------------------------
--비교 연산자
--부서번호가 10인 사원의 이름을 구하시오
select *
from employees --여기 마침표있으면 여기서 끝나는거라 마침표쓰면안됨
where department_id = 10;

select first_name,
       last_name,
       salary,
       department_id --depatement id 제대로 들어갔는지 확인을 위해 넣어보고 잘 들어갔으면 지우기
from employees
where department_id = 10;

--예제
--연봉이 15000이상인 사원들의 이름과 월급을 출력하세요
select first_name,
       salary
from employees
where salary*12 >= 15000;

--07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select first_name,
       hire_date
from employees
where hire_date >'07/01/01'; --글자아니고 날짜로 알아들을 수 있도록 ' '안에 날짜를 넣어줌

--이름이 Lex인 직원의 연봉을 출력하세요
select salary*12
from employees
where first_name = 'Lex';

--where절 -조건...
--조건이 2개이상 일때 한꺼번에 조회하기
--월급이 14000 이상 17000이하인 사원의 이름과 월급을 구하시오
select first_name,
       salary
from employees
where salary >= 14000
and salary <=17000; --두개 동시에 만족이니깐 and쓴거

--예제 연봉이 14000이하이거나 17000이상인 사원의 이름과 연봉을 출력하세요
select first_name,
       salary
from employees
where salary <= 14000
or salary >=17000;

--예제 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select first_name,
       hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';


--BETWEEN 연산자로 특정구간 값 출력하기-----------------------------------
select first_name,  
       salary
from employees
where salary >= 14000
and salary <= 17000; --아까푼 문젠데 이걸 between사용해서 풀수도있다

select first_name,
       salary
from employees
where salary between 14000 and 17000; --작은값을 앞에, 큰 값을 뒤에 14000이상 17000이하



--Like 연산자로 비슷한것들 모두 찾기--------------------------------------------
select first_name, last_name, salary
from employees
where first_name like 'L%';  --이름이 L로 시작하는.  L% %->L로 시작하고 나머지는 몇글자든 상관이없다 

--이름에 am을 포함한 사원의 이름과 연봉을 출력하세요
select first_name, salary
from employees
where first_name like '%am%'; --앞뒤에 뭐가오든 am이 포함되도록. am이 맨앞에 있는경우도 여기 해당됨

--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select first_name, salary
from employees
where first_name like '_a%'; -- _이게 한글자라는 뜻 ->맨앞에 어떤글자가 들어갈것.

--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '___a%'; --네번째글자만 a면 되니까 4글자가 넘더라도 a뒤에 암거나 와도 상관없으니 %까지써줘야함

--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '__a_';


--IN 연산자로 여러 조건을 검사하기---------------------------------------------
select *
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John' --성이 니나거나 렉스거나 존인애들 다 나오게끔 -덜깐깐한 or썼는데 너무 길어져서 In을사용하기로함
;

--first name이 neena인애도 구하고싶고 lex,john인 애도 구할겨 
select first_name,
       last_name,
       salary
from employees
where first_name in ('Neena', 'Lex', 'John'); 

--예제 연봉이 2100,3100,4100,5100인 사원의 이름과 연봉을 구하시오
select first_name,
       salary
from employees
where salary in (2100, 3100, 4100, 5100);


--Null------------------------------------------ null은 칸을만들고 아예사용안한, 어떤값도들어오지않은
--아무런 값도 정해지지 않았음을 의미(0이 아님)
--숫자뿐 아니라 글자넣는 자리에도 사용가능 - 모든 데이터타입에 사용가능
--not null이나 primary key 속성에는 사용할 수 없음
select first_name, 
       salary,
       commission_pct,
       salary*commission_pct --계산식으로만들어낸 컬럼 실제오라클엔없는데이터
from employees
where salary between 13000 and 15000;


--is null / is not null -------------------------------------------
select *
from employees
--where commission_pct = null;  commission_pct null인애 나오게하고싶었는데 안나옴
where commission_pct is null; --이렇게 써야 나옴

--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select first_name,
       salary,
       commssion_pct
from employees
where commssion_pct is not null;

--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select first_name
from employees
where manager_id is null 
and commssion_pct is null;


--서버가 정렬해서 데이터 줬으면 좋겠다 - 명령어에 정렬해서 데이터 달라고 써야함 이 순서대로 줘~~
--한글 정렬하기도 됨 '가' 가 작은값  영어도 a가 작은값 날짜도 예전날짜가 작은값//정렬 안해도 될땐 굳이 안해도됨 오래걸림
/*ORDER BY 절*/ 
select *
from employees
order by salary desc--많은 컬럼중 salary를 기준으로. 큰것부터 작은것 순으로(내림차순)
;

--order by 절에서 정렬조건이 복수일때  " , " 로 구분하여 나열한다
select first_name, salary
from employees
order by first_name asc, salary desc;

select first_name,
       salary
from employees
where salary >=9000
order by salary asc;

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select department_id,
       salary,
       first_name
from employees
order by department_id asc;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name,
       salary
from employees
where salary >= 10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
select department_id, --부서번호 , 급여 , 이름을 출력하세요->이것들 골라야함1
       salary,
       first_name
from employees --저것들은 employees에 있음2
--where department_id = department_id --조건. 부서번호가 같으면3 어차피 부서번호 정렬을했기때문에 같다 라는조건 안써도 되는듯
order by department_id asc, salary desc; -- 부서번호 오름차순 정렬, 급여가 큰 직원부터 출력4
--1234순으로 생각하고 짜는게 잘 맞는듯