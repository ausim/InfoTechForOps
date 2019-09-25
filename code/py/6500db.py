# initial setup
import mysql.connector

# connect to the database
cnx = mysql.connector.connect(
    user="insy6500",
    password="insy6500",
    host="localhost",
    database="insy6500"
    )
print("Successfully connected....")
print("Tables:")
cursor = cnx.cursor()
query = ("show tables")
cursor.execute(query)
for (db) in cursor:
    print ("\t{}".format(db[0]))
cursor.close()
print ("Database closed.")
