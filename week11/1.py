from datetime import date, datetime
 
from pymongo import MongoClient
 
client = MongoClient("mongodb://localhost")
db = client['test']
 
def query_all_Indian_Cuisines():
    cursor = db.restaurants.find({"cuisine": "Indian"})
    print(list(cursor))
 
def query_all_Indian_and_Thai_Cuisines():
    cursor = db.restaurants.find({ '$or': [ { 'cuisine': 'Thai' }, { 'cuisine': 'Indian' } ] })
    print(list(cursor))
 
def find_restaurant_with_address():
    cursor = db.restaurants.find({ 'address': {'building': '1115','street':'Rogers Avenue','zipcode':'11226'} })
    print(list(cursor))
 
def insert():
    result = db.collection_name.insert_one({
        'address':
            {'building': '1480',
             'street':'2 Avenue',
             'zipcode':'10075',
             'coord':[-73.9557413, 40.7720266]
             },
        'borough': 'Manhattan',
        'cuisine' : 'Italian',
        'name': 'Vella',
        'restaurant_id': '41704620',
        'grades':[{'grade': 'A','score' : 11,'date': datetime(2014,10,1)}]
    })
    print(result)
 
def delete_single_Manhattan_located_restaurant():
	db.code.deleteOne({'borough': 'Manhattan'})
	pass
 
def delete_all_Thai_cuisines():
	db.code.find()
	db.code.deleteMany({'cuisine': 'Thai'})
	pass
 
def query_all_restaurants_on_the_Rogers_Avenue_street():
    pass
 