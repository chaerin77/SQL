--테이블 / 시퀀스 삭제
drop table book;
drop table author;

drop sequence seq_book_id;

--시퀀스 만들기 1부터 시작해서  1씩 증가하는 seq_book_id 라는 이름의 시퀀스 book_id/author_id에 사용할 시퀀스
create sequence seq_book_id
increment by 1
start with 1
nocache;

create sequence seq_aut_id
increment by 1
start with 1
nocache;

--시퀀스 확인용
select * from user_sequences;
select seq_book_id.currval from dual;


--필요한 테이블 book / author
create table author(
     author_id number(5), 
     author_name varchar2(10) not null,
     author_desc varchar2(50),
     primary key(author_id) --author id로 primary key 만들어주기
);

create table book(
     book_id number(5),
     title varchar2(50) not null,
     pubs varchar2(20),
     pub_date date,
      author_id number(5), 
     primary key(book_id),
     constraint book_fk foreign key(author_id) --author의 author_id - pk와 book의 author_id -fk 연결해주기
     references author(author_id)
);

--데이터 넣기 시퀀스 사용

--author 테이블 데이터 넣기
insert into author
values(seq_aut_id.nextval,'이문열','경북 영양');

insert into author
values(seq_aut_id.nextval,'박경리','경상남도 통영');

insert into author
values(seq_aut_id.nextval,'유시민','17대 국회의원');

insert into author
values(seq_aut_id.nextval,'기안84','기안동에서 산 84년생');

insert into author
values(seq_aut_id.nextval,'강풀','온라인 만화가 1세대');

insert into author
values(seq_aut_id.nextval,'김영하','알쓸신잡');


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