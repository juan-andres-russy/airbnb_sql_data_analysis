COPY PUBLIC.city FROM 'C:\city.csv' DELIMITER ',' CSV HEADER;

COPY PUBLIC.neighbourhood (zip_code,neighbour_name,city_id_city) FROM 'C:\neighbourhoods.csv' DELIMITER ',' CSV HEADER;

COPY PUBLIC.host (host_id,host_name,host_since) FROM 'C:\host.csv' DELIMITER ',' CSV HEADER;

COPY PUBLIC.listings (id,name,description,host_id_host,zip_code_neighbourhood,coordinates) FROM 'C:\listings.csv' DELIMITER ',' CSV HEADER;

COPY PUBLIC.user FROM 'C:\users.csv' DELIMITER ',' CSV HEADER;

COPY PUBLIC.comment (id_listings,id_comment,date_comment,id_user,comment) FROM 'C:\comment.csv' DELIMITER ',' CSV HEADER;

COPY PUBLIC.reserve (id_listings, booking_date, availability, price,id_user) FROM 'C:\reserve.csv' DELIMITER ',' CSV HEADER; 