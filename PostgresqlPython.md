psql -f "file.sql" "host=my_host port=5432 dbname=dbname user=username password=pass"

import psycopg2

conn = psycopg2.connect(database = "mydb", user = "mysuer", password = 'mypasswd", host = "my_host_ip", port = "5432")
cur = conn.cursor()

in_param1=123
in_param2="abc"
out_param= None
    
cur.execute("call MyProc(%s,%s,%s)",(in_param1,in_param2 ,out_param))
result = cur.fetchone()

conn.close()


import cx_Oracle

dsn_tns = cx_Oracle.makedsn('my_host_ip', '1521', service_name='myDB')
conn = cx_Oracle.connect("username", "passwd", dsn_tns, cx_Oracle.SYSDBA) # if sys user
cur = conn.cursor()

i_input = "ABC"

sql_proc = """
DECLARE
  v_result  NUMBER;
BEGIN
  v_result:= MyProc('"""+i_input+"""',10);
  :o_result:=v_result;
END;
"""
o_result = cur.var(cx_Oracle.NUMBER)
cur.execute(sql_proc, o_result=o_result)
res = o_result.getvalue()

conn.close()