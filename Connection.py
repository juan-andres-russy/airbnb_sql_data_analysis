# -*- coding: utf-8 -*-
"""
Created on Thu May 12 08:54:32 2022

@author: danny
"""

import psycopg2
    
try:
    conexion = psycopg2.connect(user="postgres",
                                password="080803",
                                database="Airbnb",
                                host="localhost",
                                port="5432")
    print("Conexión correcta!")
    
    sql1 = """select *
         from neighbourhood;"""
         
    sql2 = """select *
         from host;"""
         
    sql3 = """select *
         from listings;"""
         
    sql4 = """select *
         from usser;"""
         
    sql5 = """select *
         from comment;"""
         
    sql6 = """select *
         from reserve;"""
         
         
    cursor = conexion.cursor()
    cursor.execute(sql1)
    country = cursor.fetchone()
    print("****Neighbourhood****")
    while country:
        print(str(country [0]) + " - " + country [1] + " - " + country [2])
        country = cursor.fetchone()
    
    cursor = conexion.cursor()
    cursor.execute(sql2)
    country = cursor.fetchone()
    print("****Host****")
    while country:
        print(str(country [0]) + " - " + country [1].strftime('%m/%d/%Y') + " - " + country [2])
        country = cursor.fetchone()

    cursor = conexion.cursor()
    cursor.execute(sql3)
    country = cursor.fetchone()
    print("****Listings****")
    while country:
        print(str(country [0]) + " - " + country [1] + " - " + country [2] + " - " + country [3] + " - " + str(country [4]) + " - " + str(country [5]))
        country = cursor.fetchone()
    
    cursor = conexion.cursor()
    cursor.execute(sql4)
    country = cursor.fetchone()
    print("****User****")
    while country:
        print(str(country [0]) + " - " + country [1])
        country = cursor.fetchone()
        
    cursor = conexion.cursor()
    cursor.execute(sql5)
    country = cursor.fetchone()
    print("****Comment****")
    while country:
        print(str(country [0]) + " - " + country [1].strftime('%m/%d/%Y') + " - " + country [2] + " - " + str(country [3]) + " - " + str(country [4]))
        country = cursor.fetchone()
        
    cursor = conexion.cursor()
    cursor.execute(sql6)
    country = cursor.fetchone()
    print("****Comment****")
    while country:
        print(str(country [0]) + " - " + country [1].strftime('%m/%d/%Y') + " - " + country [2] + " - " + str(country [3]) + " - " + str(country [4]))
        country = cursor.fetchone()
        
        

except psycopg2.Error as e:
    print("Ocurrió un error al consultar: ", e)

finally:
    cursor.close()
    conexion.close()
