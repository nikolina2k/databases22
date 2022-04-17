from geopy.geocoders import Nominatim
import psycopg2
 
con = psycopg2.connect(database="hellokitty", user="postgres", host="127.0.0.1", port="5432")
 
print("Database opened successfully")
  
cur = con.cursor()
  
cur.execute("select * from retrieveAddresses()")
 
res = cur.fetchall()


geolocator = Nominatim(user_agent="peepoo")
for adr in res:
    s = str(adr)
    s = s.removeprefix('(\'')
    s = s.removesuffix('\',)')
    print(s)

    try: 
        location = geolocator.geocode(adr)
        cur.execute(f"update address set longitude={location.longitude}, latitude={location.latitude} where address.address='{s}';")
    
    except: 
        cur.execute(f"update address set longitude={0}, latitude={0} where address.address='{s}';")

con.commit()