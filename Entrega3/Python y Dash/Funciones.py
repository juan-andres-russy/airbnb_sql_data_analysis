def Indice_ocupacion():
    return """select booking_date, (Cast (num_occupied AS Float)  / Cast (num_properties AS Float) * 100) as indice_ocupacion
from (select booking_date, count(*) as num_properties
	from reserve
	group by booking_date) prop natural join
		(select booking_date, count(*) as num_occupied
		 from reserve
		 where availability = 0
		 group by booking_date
		) occupied"""
            
def Gini():
    return """with host_listings as (select host_id_host, count(host_id_host) from listings group by host_id_host),
Percentiles as (select host_id_host, count, Cast( ROW_NUMBER() OVER (ORDER BY count) AS Float) / 4475
AS Percent_host FROM host_listings),
Suma_percentiles as (select host_id_host, Cast( sum(count) over (order by Percent_host) as float ) / 5556 
AS Percent_prop, Percent_host from Percentiles)
select percent_host, percent_prop from Suma_percentiles order by percent_host desc"""

def net():
	return """select listin.host_id_host, list_user.id_user
from (select id_listings, id_user from reserve where id_user != 0
		group by id_listings, id_user having count(*) > 1) list_user natural join
		(select id, host_id_host from listings) listin
group by host_id_host, id_user
having count(*) > 1
FETCH FIRST 500 ROWS ONLY"""


def net2():
	return """select id_listings, id_user
from (select id_listings, id_user from comment
		group by id_listings, id_user) list_user
group by id_listings, id_user
FETCH FIRST 500 ROWS ONLY"""
