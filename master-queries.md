# PostgreSQL Master Queries
> (c) Venkata Bhattaram

## PG Master Queries
* Read SP code line by line
```sql
-- DBA Source
-- ---------------------------------------------------------------------------------------
with d as(
select nspname,proname,code_line,row_number() over (partition by nspname,proname,seq_num) line_number
from (
SELECT unnest(regexp_split_to_array(pg_get_functiondef(p.oid), E'\\n'))  code_line
, p.proname,n.nspname,row_number() over (partition by nspname,proname) seq_num
FROM   pg_proc p
JOIN   pg_namespace n ON p.pronamespace = n.oid
WHERE  n.nspname = 'sbp_app_obj'
    ) a
)
select 'sbp_app_obj' nspname,proname, line_number,(d.code_line)
--select count(*)
from   d
where lower((d.code_line)) like '%mail%'
```


