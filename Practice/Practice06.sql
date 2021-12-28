--테이블 / 시퀀스 삭제
drop table book;
drop table author;

drop sequence seq_book_id;
drop sequence seq_author_id;

--시퀀스 만들기 1부터 시작해서  1씩 증가하는 seq_book_id 라는 이름의 시퀀스 book_id/author_id에 사용할 시퀀스
create sequence seq_book_id
increment by 1
start with 1
nocache;

create sequence seq_author_id
increment by 1
start with 1
nocache;

--시퀀스 확인용
select * from user_sequences;
select seq_book_id.currval from dual;


--필요한 테이블 book / author
create table author(
     author_id number(5), --데이터가 들어갈 형식들 써줘야함. 
     author_name varchar2(10) not null,
     author_desc varchar2(50),
     primary key(author_id) --author id로 primary key 만들어주기
);

create table book(
     book_id number(5),
     book_title varchar2(50) not null,
     book_pubs varchar2(20),
     book_pub_date date,
      author_id number(5), 
     primary key(book_id),
     constraint book_fk foreign key(author_id) --author의 author_id - pk와 book의 author_id -fk 연결해주기
     references author(author_id)
);

--데이터 넣기 시퀀스 사용

/********************************
211227 author insert문 테스트 
********************************/
select *
from author;

select *
from book;

select *
from user_sequences;

rollback;

---------------------book/author테이블조인-------------------------------
select au.author_name,
       au.author_desc,
       bo.book_id,
       bo.book_title,
       bo.book_pubs,
       to_char(bo.book_pub_date, 'yyyy-mm-dd') bookPdate,
       bo.author_id
from author au, book bo
where au.author_id = bo.author_id;

--------------------------------------------
--select author
select author_id,
       author_name,
       author_desc
from author;

--select book
select book_id,
       book_title,
       book_pubs,
       to_char(book_pub_date, 'yyyy-mm-dd'),
       author_id
from book;
--------------------------------------------

--delete author
delete from author
where author_id = 1;

--delete book
delete from book
where author_id = 3;
---------------------------------------------

--author update
update author
set author_name = '김문열',
    author_desc = '삼국지 작가'--여기까지만 쓰면 모든 데이터가 김문열/삼국지 작가 로 바뀌게됨 의도한게 아니라면 이렇게쓰지말기
where author_id =1; 

--book update 
/*
update book
set book_pubs = '삼국국'
where book_id = 2;
*/

--book update author_id바꾸기
update book
set author_id = 2
where book_title = '토지';

-----------------------------------------------

--author 테이블 데이터 넣기
insert into author
values(seq_author_id.nextval,'이문열','경북 영양');

insert into author
values(seq_author_id.nextval,'박경리','경상남도 통영');

insert into author
values(seq_author_id.nextval,'유시민','17대 국회의원');

insert into author
values(seq_author_id.nextval,'기안84','기안동에서 산 84년생');

insert into author
values(seq_author_id.nextval,'강풀','온라인 만화가 1세대');

insert into author
values(seq_author_id.nextval,'김영하','알쓸신잡');


--book 테이블 데이터 넣기
insert into book
values(seq_book_id.nextval,'우리들의 일그러진 영웅','다림','1998-02-22',1);

insert into book
values(seq_book_id.nextval,'삼국지','민음사','2002-03-01',1);

insert into book
values(seq_book_id.nextval,'토지','마로니에북스','2012-08-15',2);

insert into book
values(seq_book_id.nextval,'유시민의 글쓰기 특강','생각의길','2015-04-01',3);

insert into book
values(seq_book_id.nextval,'패션왕','중앙북스(books)','2012-02-22',4);

insert into book
values(seq_book_id.nextval,'순정만화','재미주의','2011-08-03',5);

insert into book
values(seq_book_id.nextval,'오직두사람','문학동네','2017-05-04',6);

insert into book
values(seq_book_id.nextval,'26년','재미주의','2012-02-04',5);

select * from book;


commit;