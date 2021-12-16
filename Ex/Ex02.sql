/*단일행 함수*/

--문자함수 - INITCAP(컬럼명)
select email,
       initcap(email) as email2, --첫글자만 대문자로 하고 나머지는 소문자로 하고싶을때 함수+(문자열)
       departrment_id
from employees
where depatment_id = 100;


--문자함수 - Lower(s) / upper(s)   입력되는 값을 전부 소문자/대문자로 변경하는 함수
select first_name,
       lower(first_name),
       upper(first_name)
from employees
where department_id = 100;


--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수) 
select first_name,
       substr(first_name,1,3), --양수인 경우 왼->오 검색,글자수 만큼 추출 첫번째 글자부터 3개글자 추출 Nancy -> Nan
       substr(first_name,-3,2) --음수인 경우 오->왼 검색후 왼->오 쪽으로 글자수 만큼 추출 오른쪽에서3번째까지 읽고 왼쪽부터2글자만 추출
from employees
where department_id = 100;


--문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’)LPAD() :왼쪽 공백에 특별한 문자로 채우기 / RPAD(컬럼명, 자리수, ‘채울문자’) RPAD() :오른쪽 공백에 특별한 문자로 채우기
select first_name,
       lpad(first_name, 10, '*'), --다 10글자로 만들고 10글자 채울 자리만큼 왼쪽부터*을 넣음
       rpad(first_name, 10, '*') --위랑같은데 *를 오른쪽부터 채움
from employees;


--문자함수 – REPLACE (컬럼명, 문자1, 문자2)- 컬럼명에서 문자1을 문자2로 바꾸는 함수
select first_name,
       replace(first_name, 'a', '*' ),
       replace(first_name, 'a', '****'), --문자1(a) 자체를 문자2로 바꿔주는것
       replace(first_name, substr(first_name, 2, 3), '***'), --replace와 substr 조합으로 first_name의 2,3,4번째 글자를 ***로 바꾸기      
       substr(first_name, 2, 3) --두번째 글자부터 세글자 가져오기 Nancy -> anc
from employees
where department_id = 100;


--숫자함수 – ROUND(숫자, 출력을 원하는 자리수) -주어진 숫자의 반올림을 하는 함수
select 123 as num --데이터 값 다 123이라고 해준것 // sysdate ->현재 날짜 추출함
from dual; --**가상의 테이블. select절 문장의 구조 완성하려면 from절이 필요해서 테이블은 필요없지만 테이블 이름이 필요할때 쓰는 가상의 테이블

 --" "안에 넣지 않고 as를 하면 무조건 대문자로 나오니까 소문자로 나오게끔 하고싶어서 "r2"해준것
select round(123.346, 2) "r2", --소수점 2번째자리까지 반올림 -> 두번째자리가 4니까 셋째자리인6에서 반올림해줘야함 -> 123.35
       round(123.456, 0) "r0", --소수점 0번째자리까지 반올림 ->일의자리 수 까지 반올림 -> 123.4 니까 ->123  123.8이었다면 124 나왔을것
       round(123.456, -1) "r-1" -- 0번째가 일의자리수 였으니까 -1은 십의 자리수까지 반올림하는것 123을 10의자리수까지 반올림하면 120
from dual;


--숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) -주어진 숫자의 버림을 하는 함수
select trunc(123.346, 2) "r2", --123.34
       trunc(123.456, 0) "r0", --123
       trunc(123.456, -1) "r-1" --120
from dual;


--날짜함수 – SYSDATE() MONTH_BETWEEN(d1, d2) d1날짜와 d2날짜의 개월수를 출력하는 함수
select sysdate --현재 시간을 알아낼 수 있다
from dual;

select sysdate,
       hire_date,
       trunc( months_between(sysdate, hire_date) , 0),
       months_between(sysdate, hire_date)
from employees
where department_id = 100;


--변환함수 숫자->문자열  문자열->date 02/11/21 이런식으로 양식 맞추면 날짜로 바꿀수있을것 그냥123 을 date로 바꾸고 그런건안됨

--TO_CHAR(숫자, ‘출력모양’) 숫자형문자형으로 변환하기
select first_name,
       salary,
       salary*12,
       to_char(salary*12,'$9999999'), --내가 출력되었으면 하는 형식을 써주기// 999이거는 자릿수고 $표시+급여*12 형식으로 나오길 바래서 $9999999이렇게쓴것//숫자를 문자형으로
       to_char(salary*12,'9999999'), --salary*12 숫자가 그대로 보이는 형식
       to_char(salary*12,'0009999999'), --salary*12앞에 000이붙는형식
       to_char(salary*12,'9999999.99'), --소수점 둘째자리까지 보이는 형식
       to_char(salary*12*12,'999,999,999') --숫자를 ,로 끊어 표현되도록/ 숫자가 전부 표현될수 있도록 자리수에 해당하는9를 넉넉히 적어줄것
from employees
where department_id = 100;


--변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로 변환하기
select sysdate,
       to_char(sysdate, 'YYYY'), --연도 4자리 표현  'MM' -월을 2자리로 표현
       to_char(sysdate, 'month'),
       to_char(sysdate, 'dd'),
       to_char(sysdate, 'hh24'),
       to_char(sysdate, 'yyyy-mm-dd hh24:mi') --yyyy/mm/dd  hh24 24시기준 시 / mi-분 'yyyy"년"mm"월"dd"일" hh24:mi:ss' "년" "월" "일" 에 쌍따옴표붙인것  
from dual;

select sysdate,
       to_char(sysdate, 'DD'),
       hire_date,
       to_char(hire_date, 'yyyy')
from employees;     


--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
select first_name,
       commission_pct,
       nvl(commission_pct, 0), --원본인 null을 0으로바꾸면 문제생기니까(다른쿼리에서 이 null정보를 쓰고있을경우) 이 쿼리문쓸때만 null을 0으로바꾸는것 원본인null은 그대로있고. - nvl
       nvl2(commission_pct, 100, 0) --null이 아닌 값 0.25,0.1 등 갖고있었던것들은 100으로 null인 값들은 0 으로 추출 / 이것도 원본을 바꾸는것은 아님
from employees;       


select * from regions;
select * from countries;
select * from locations;