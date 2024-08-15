CREATE TABLE PROG_TEST_BLNC(   
  BLNC_ACCNT_CODE bigint primary key,
  BLNC_OSTATOK numeric not null default 0
);

CREATE TABLE PROG_TEST_ACCNT(  
  ACCNT_CODE numeric not null default 10,
  ACCNT_ACNT varchar not null,
  ACCNT_PPL_CODE bigint primary key,
  ACCNT_CRNC varchar not null,
  ACCNT_NAME varchar not null,
  constraint uk_PROG_TEST_ACCNT unique (BLNC_ACCNT_CODE, BLNC_OSTATOK),
  constraint fk_PROG_TEST_ACCNT_BLNC_ACCNT_CODE foreign key (ACCNT_CODE) references PROG_TEST_BLNC(BLNC_ACCNT_CODE),
);

create table PROG_TEST_DOCS(
  DOC_PPL_CODE bigint primary key,
  DOC_NUM varchar not null,
  DOC_SERIES varchar not null,
  DOC_TYPE varchar not null,
  DOC_DATE date not null default current_date
);

create table PROG_TEST_ADDRESS(
  ADDR_PPL_CODE bigint primary key,
  ADDR_CITY varchar not null,
  ADDR_STREET varchar not null,
  ADDR_HOUSE varchar not null,
  ADDR_FLAT varchar not null
);

create table PROG_TEST.PEOPLE( 
  PPL_CODE numeric not null,
  PPL_NAME varchar not null,
  PPL_PPL_CODE bigint primary key
  constraint uk_PROG_TEST.PEOPLE unique (PPL_CODE, PPL_NAME, PPL_PPL_CODE),
  constraint fk_PROG_TEST.PEOPLE foreign key  (PPL_CODE) references PROG_TEST.DOCS(DOC_PPL_CODE),
  constraint fk_PROG_TEST.PEOPLE foreign key  (PPL_CODE) references PROG_TEST_ADDRESS(ADDR_PPL_CODE)
);

insert into PROG_TEST.PEOPLE values (1, 'Anna', 166);
insert into PROG_TEST.PEOPLE values (2, 'Andrey', 211);
insert into PROG_TEST.PEOPLE values (3, 'Kate', 333);
insert into PROG_TEST.PEOPLE values (4, 'Denis', 131);
