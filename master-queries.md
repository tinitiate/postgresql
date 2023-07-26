# PostgreSQL Master Queries
> (c) Venkata Bhattaram

## PG Master Queries
* Read SP code line by line
```sql
-- DBA Source
-- ---------------------------------------------------------------------------------------
with d as(
SELECT unnest(regexp_split_to_array(pg_get_functiondef(p.oid), E'\\n'))  code_line
FROM   pg_proc p
JOIN   pg_namespace n ON p.pronamespace = n.oid
WHERE  n.nspname = 'sbp_app_obj'
and    p.proname = 'pkg_mailing$sp_trigger_mail'
)
select 'sbp_app_obj' nspname,row_number() over () line_number,(d.code_line)
from   d;

-- DBA Source
-- ---------------------------------------------------------------------------------------
with d as(
SELECT unnest(regexp_split_to_array(pg_get_functiondef(p.oid), E'\\n'))  code_line
FROM   pg_proc p
JOIN   pg_namespace n ON p.pronamespace = n.oid
WHERE  n.nspname = 'sbp_app_obj'
and    p.proname = 'pkg_mailing$sp_trigger_mail'
)
select 'sbp_app_obj' nspname,row_number() over () line_number,(d.code_line)
from   d;
```


