-- ---------------------------------------------------------------------------------------
-- PGSQL
-- ---------------------------------------------------------------------------------------

-- NEW
-- - - -- - - - -- -- -- -- - --

-- ---------------------------------------------------------------------------------------
-- PGSQL
-- ---------------------------------------------------------------------------------------




-- ---------------------------------------------------------------------------------------
-- AWS Function Calls
-- ---------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------
-- 1. DB Link
-- ---------------------------------------------------------------------------------------
-- DB Link Test
-- --------------------------

-- STEP 1: Build Oracle SQL Cache
--
select sbp_app_obj.set_aws_ops_cache( p_aws_ops_context=>'ORA'
                                     ,p_aws_ops_key=>'SQL'
                                     ,p_aws_ops_value=> 'SELECT 1 id_1,2 val_1,''933AM'' data_1 from dual
union all
SELECT 11 id_1,22 val_1,''933AM'' data_1 from dual
union all
SELECT 111 id_1,222 val_1,''933AM'' data_1 from dual
');


drop table sbp_app_obj.vb_dblink_test;
create table sbp_app_obj.vb_dblink_test (
id_1    int,
val_1   int,
data_1  text
)


-- ONE Time register AWS Lambda in PG
-- SELECT aws_commons.create_lambda_function_arn( 'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-ora-dblink-data-load-to-s3','us-east-1') AS ora_dblink2s3
-- Check the cache
SELECT sbp_app_obj.get_aws_ops_cache(p_aws_ops_cache_id =>172)

-- Cal the Lambda
select  a.aws_function_name,
        a.status_code,
        a.status_message,
        -- data1,
        data1->>'bucket_name' bucket_name,
        data1->>'folder_name' folder_name,
        data1->>'file_name' file_name,
        data1->>'aws_ops_cache_id' aws_ops_cache_id,
        data1->>'row_count' row_count
from    (SELECT
        payload->'aws_function_name' aws_function_name,
        payload->'status_code' status_code,
        payload->'status_message' status_message,
        payload->'data' data_json
        from   aws_lambda.invoke(aws_commons.create_lambda_function_arn(
               'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-ora-dblink-data-load-to-s3'
               ,'us-east-1')
               ,'{ "bucket_name":"sbp-app-object"
                  ,"folder_name":"csv"
                  ,"dblink":"oats_tax"
                  ,"aws_ops_cache_id":172
                 }'::json)
                       ) a
      ,JSONB_ARRAY_ELEMENTS(a.data_json::jsonb) data1


-- Import to PG
--
SELECT aws_s3.table_import_from_s3('vb_dblink_test', '', '(format csv,HEADER true)', aws_commons.create_s3_uri('sbp-app-object','csv/dual_1684416881.csv','us-east-1'))

-- Check data in Table
--
select * from vb_dblink_test;


SELECT *
FROM aws_s3.query_export_to_s3
       ( 'select * from sbp_app_obj.vb_dblink_test'
        ,aws_commons.create_s3_uri('sbp-app-object','csv'||'/'||'demo_test.csv','us-east-1'));

-- ---------------------------------------------------------------------------------------
-- 2. ZIP File
-- ---------------------------------------------------------------------------------------
select  a.aws_function_name,
        a.status_code,
        a.status_message,
        data1->>'bucket_name' bucket_name,
        data1->>'folder_name' folder_name,
        data1->>'file_name' file_name,
        data1->>'zip_file_name' zip_file_name
from    (SELECT
        payload->'aws_function_name' aws_function_name,
        payload->'status_code' status_code,
        payload->'status_message' status_message,
        payload->'data' data_json
        from   aws_lambda.invoke(aws_commons.create_lambda_function_arn(
               'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-zip'
               ,'us-east-1')
               ,'{"bucket_name": "sbp-app-object","folder_name":"csv","file_name":"demo_test.csv"}'::json)
       ) a
      ,JSONB_ARRAY_ELEMENTS(data_json::jsonb) data1

-- ---------------------------------------------------------------------------------------
-- 3. MAIL
-- ---------------------------------------------------------------------------------------
select * from pg_proc where proname like 'pkg%mail%';

-- Register Function
-- ------------------
SELECT aws_commons.create_lambda_function_arn( 'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-sendmail','us-east-1') AS sbp_aws_sendmail

SELECT
        payload->'aws_function_name' aws_function_name,
        payload->'status_code' status_code,
        payload->'status_message' status_message,
        payload->'data' data_json
FROM   aws_lambda.invoke('arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-sendmail',
'{ "sender_address":"vbhattaram@navisite.com"
 ,"receiver_address":"vbhattaram@navisite.com"
 ,"cc_receiver_address":""
 ,"subject":"Apr 25 1028 AM PG CALL Test"
 ,"aws_ops_cache_id":"4"
 ,"footer":""
 ,"signature":""
 ,"comments":""
 ,"s3_bucket_name":"sbp-app-object"
 ,"folder_name":"csv"
 ,"file_names":["demo_test.zip"]
}'::jsonb)





-- OLD
-- -- - - - --  -- -- - -- -
-- ---------------------------------------------------------------------------------------
-- AWS Function Calls
-- ---------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------
-- 1. DB Link
-- ---------------------------------------------------------------------------------------
-- DB Link Test
-- --------------------------

-- STEP 1: Build Oracle SQL Cache
--
select sbp_app_obj.set_aws_ops_cache( p_aws_ops_context=>'ORA'
                                     ,p_aws_ops_key=>'SQL'
                                     ,p_aws_ops_value=> 'SELECT 1 id_1,2 val_1,''933AM'' data_1 from dual
union all
SELECT 11 id_1,22 val_1,''933AM'' data_1 from dual
union all
SELECT 111 id_1,222 val_1,''933AM'' data_1 from dual
');


drop table sbp_app_obj.vb_dblink_test;
create table sbp_app_obj.vb_dblink_test (
id_1    int,
val_1   int,
data_1  text
)


-- ONE Time register AWS Lambda in PG
-- SELECT aws_commons.create_lambda_function_arn( 'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-ora-dblink-data-load-to-s3','us-east-1') AS ora_dblink2s3
-- Check the cache
SELECT sbp_app_obj.get_aws_ops_cache(p_aws_ops_cache_id =>172)

-- Cal the Lambda
select  a.aws_function_name,
        a.status_code,
        a.status_message,
        -- data1,
        data1->>'bucket_name' bucket_name,
        data1->>'folder_name' folder_name,
        data1->>'file_name' file_name,
        data1->>'aws_ops_cache_id' aws_ops_cache_id,
        data1->>'row_count' row_count
from    (SELECT
        payload->'aws_function_name' aws_function_name,
        payload->'status_code' status_code,
        payload->'status_message' status_message,
        payload->'data' data_json
        from   aws_lambda.invoke(aws_commons.create_lambda_function_arn(
               'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-ora-dblink-data-load-to-s3'
               ,'us-east-1')
               ,'{ "bucket_name":"sbp-app-object"
                  ,"folder_name":"csv"
                  ,"dblink":"oats_tax"
                  ,"aws_ops_cache_id":172
                 }'::json)
                       ) a
      ,JSONB_ARRAY_ELEMENTS(a.data_json::jsonb) data1


-- Import to PG
--
SELECT aws_s3.table_import_from_s3('vb_dblink_test', '', '(format csv,HEADER true)', aws_commons.create_s3_uri('sbp-app-object','csv/dual_1684416881.csv','us-east-1'))

-- Check data in Table
--
select * from vb_dblink_test;


SELECT *
FROM   aws_s3.query_export_to_s3
       ( 'select * from sbp_app_obj.vb_dblink_test'
        ,aws_commons.create_s3_uri('sbp-app-object','csv'||'/'||'demo_test.csv','us-east-1'));

-- ---------------------------------------------------------------------------------------
-- 2. ZIP File
-- ---------------------------------------------------------------------------------------
select  a.aws_function_name,
        a.status_code,
        a.status_message,
        data1->>'bucket_name' bucket_name,
        data1->>'folder_name' folder_name,
        data1->>'file_name' file_name,
        data1->>'zip_file_name' zip_file_name
from    (SELECT
        payload->'aws_function_name' aws_function_name,
        payload->'status_code' status_code,
        payload->'status_message' status_message,
        payload->'data' data_json
        from   aws_lambda.invoke(aws_commons.create_lambda_function_arn(
               'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-zip'
               ,'us-east-1')
               ,'{"bucket_name": "sbp-app-object","folder_name":"csv","file_name":"demo_test.csv"}'::json)
       ) a
      ,JSONB_ARRAY_ELEMENTS(data_json::jsonb) data1

-- ---------------------------------------------------------------------------------------
-- 3. MAIL
-- ---------------------------------------------------------------------------------------
select * from pg_proc where proname like 'pkg%mail%';

-- Register Function
-- ------------------
SELECT aws_commons.create_lambda_function_arn( 'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-sendmail','us-east-1') AS sbp_aws_sendmail

SELECT
        payload->'aws_function_name' aws_function_name,
        payload->'status_code' status_code,
        payload->'status_message' status_message,
        payload->'data' data_json
FROM   aws_lambda.invoke('arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-sendmail',
'{ "sender_address":"vbhattaram@navisite.com"
 ,"receiver_address":"vbhattaram@navisite.com"
 ,"cc_receiver_address":""
 ,"subject":"Apr 25 1028 AM PG CALL Test"
 ,"aws_ops_cache_id":"4"
 ,"footer":""
 ,"signature":""
 ,"comments":""
 ,"s3_bucket_name":"sbp-app-object"
 ,"folder_name":"csv"
 ,"file_names":["demo_test.zip"]
}'::jsonb)


--- PROCS DB LINK
-- ONE Time register AWS Lambda in PG
-- SELECT aws_commons.create_lambda_function_arn( 'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-ora-dblink-data-load-to-s3','us-east-1') AS ora_dblink2s3
-- Check the cache
SELECT sbp_app_obj.get_aws_ops_cache(p_aws_ops_cache_id =>10)

l_aws_cache_id:=sbp_app_obj.set_aws_ops_cache( p_aws_ops_context=>'ORA'
                                  ,p_aws_ops_key=>'PROC'
                                  ,p_aws_ops_value=> l_proc_call_with_params

-- Cal the Lambda
select  a.aws_function_name,
		a.status_code,
		a.status_message
from    (SELECT
		payload->'aws_function_name' aws_function_name,
		payload->'status_code' status_code,
		payload->'status_message' status_message
		from   aws_lambda.invoke(aws_commons.create_lambda_function_arn(
		       'arn:aws:lambda:us-east-1:131110090272:function:sbp-aws-ora-dblink-proc-exec'
		       ,'us-east-1')
		       ,'{ "dblink":"oats_tax"
				  ,"aws_ops_cache_id":l_aws_cache_id
				 }'::json)
				       ) a
	  ,JSONB_ARRAY_ELEMENTS(a.data_json::jsonb) data1;
      