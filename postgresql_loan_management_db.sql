-- ----------------------------------------------------------------------------------
-- SyntaxBoard Professional IT Training
-- (c) Venkata Bhattaram
-- File Name: postgresql_lms_db.sql
-- Notes:  * Script to create LOANS Database, Tables DDL 
--         * Inserts for Initial Data load for all tables
--
-- ----------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------
-- 1. Create Schema and assign syntaxboard user to that schema 
-- ----------------------------------------------------------------------------------
CREATE SCHEMA loans;
ALTER SCHEMA loans OWNER TO syntaxboard;


-- ----------------------------------------------------------------------------------
-- 2. Create tables loan management
-- ----------------------------------------------------------------------------------
-- table loans.loan_master
--
create table loans.loan_master
(
    loan_id    int
   ,loan_type  varchar(200)
   ,loan_desc  varchar(2000)
);

alter table loans.loan_master add constraint loan_master_pk primary key (loan_id);


-- table loans.loan_rules
--
create table loans.loan_rules
(
    loan_rule_id       int 
   ,loan_id            int 
   ,creditscore_limit  decimal 
   ,creditscore_offset decimal
   ,amount_limit       decimal  
   ,amount_offset      decimal
   ,interest           decimal
   ,duration_months    int 
);

alter table loans.loan_rules add constraint loan_rules_pk primary key (loan_rule_id);
alter table loans.loan_rules add constraint loan_rules_loan_id_fk foreign key(loan_id) references loans.loan_master(loan_id);


-- table loans.customer
-- 
create table loans.customer
(
    customer_id              int
   ,customer_name            varchar(200)
   ,application_date         date
   ,customer_creditscore     int
   ,customer_req_loanamount  decimal
);

alter table loans.customer add constraint customer_pk primary key (customer_id);


-- table loans.customer_loans
--
create table loans.customer_loans_status
( 
    customer_loan_id  int
   ,customer_id       int
   ,loan_id           int
   ,loan_status       varchar(200)  -- (approved / rejected)
   ,approved_interest decimal
   ,approved_duration_months int
   ,application_date  date
   ,notes             varchar(2000)
);

alter table loans.customer_loans add constraint customer_loans_pk primary key (customer_loan_id);
alter table loans.customer_loans add constraint customer_loans_loanid_fk foreign key(loan_id) references loans.loan_master(loan_id);
alter table loans.customer_loans add constraint customer_loans_custid_fk foreign key(customer_id) references loans.customer(customer_id);


-- ----------------------------------------------------------------------------------
-- 3. Load Data for Loan Management
-- ----------------------------------------------------------------------------------

-- 
-- loans.loan_master
insert into loans.loan_master (1,'Personal Loan','Personal Loans Short Term');
insert into loans.loan_master (2,'Home Loan','Home Loans Long Term');
insert into loans.loan_master (3,'Auto Loan','Auto Loans Medium Term');



COPY persons(loan_rule_id, loan_id, creditscore_limit, creditscore_offset, amount_limit, amount_offset, interest, duration_months)
FROM 'E:\code\PYTHON_TRAINING\Python_SQL\loan_rules.csv'
DELIMITER ','
CSV HEADER;





