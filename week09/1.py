import psycopg2
 
con = psycopg2.connect(database="hellokitty", user="postgres", host="127.0.0.1", port="5432")
 
print("Database opened successfully")
  
cur = con.cursor()
  
cur.execute("select * from retrieveAddresses()")
 
res = cur.fetchall()

print(res)
 