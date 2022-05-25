-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE airbnb;
-- ddl-end --


-- object: public."user" | type: TABLE --
-- DROP TABLE IF EXISTS public."user" CASCADE;
CREATE TABLE public."user" (
	id bigint NOT NULL,
	name varchar(200) NOT NULL,
	CONSTRAINT user_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."user" OWNER TO postgres;
-- ddl-end --

-- object: public.comment | type: TABLE --
-- DROP TABLE IF EXISTS public.comment CASCADE;
CREATE TABLE public.comment (
	id_comment numeric NOT NULL,
	date_comment timestamp NOT NULL,
	comment varchar(10000),
	id_user bigint NOT NULL,
	id_listings integer NOT NULL,
	CONSTRAINT comment_pk PRIMARY KEY (id_comment)

);
-- ddl-end --
ALTER TABLE public.comment OWNER TO postgres;
-- ddl-end --

-- object: public.listings | type: TABLE --
-- DROP TABLE IF EXISTS public.listings CASCADE;
CREATE TABLE public.listings (
	id integer NOT NULL,
	name varchar(200),
	description varchar(10000),
	coordinates varchar(70),
	host_id_host integer NOT NULL,
	zip_code_neighbourhood integer NOT NULL,
	CONSTRAINT listings_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.listings OWNER TO postgres;
-- ddl-end --

-- object: public.reserve | type: TABLE --
-- DROP TABLE IF EXISTS public.reserve CASCADE;
CREATE TABLE public.reserve (
	booking_date date NOT NULL,
	price integer,
	availability smallint,
	id_user bigint NOT NULL,
	id_listings integer NOT NULL,
	CONSTRAINT reserve_pk PRIMARY KEY (booking_date,id_user,id_listings)

);
-- ddl-end --
ALTER TABLE public.reserve OWNER TO postgres;
-- ddl-end --

-- object: user_fk | type: CONSTRAINT --
-- ALTER TABLE public.reserve DROP CONSTRAINT IF EXISTS user_fk CASCADE;
ALTER TABLE public.reserve ADD CONSTRAINT user_fk FOREIGN KEY (id_user)
REFERENCES public."user" (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: user_fk | type: CONSTRAINT --
-- ALTER TABLE public.comment DROP CONSTRAINT IF EXISTS user_fk CASCADE;
ALTER TABLE public.comment ADD CONSTRAINT user_fk FOREIGN KEY (id_user)
REFERENCES public."user" (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: listings_fk | type: CONSTRAINT --
-- ALTER TABLE public.comment DROP CONSTRAINT IF EXISTS listings_fk CASCADE;
ALTER TABLE public.comment ADD CONSTRAINT listings_fk FOREIGN KEY (id_listings)
REFERENCES public.listings (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: listings_fk | type: CONSTRAINT --
-- ALTER TABLE public.reserve DROP CONSTRAINT IF EXISTS listings_fk CASCADE;
ALTER TABLE public.reserve ADD CONSTRAINT listings_fk FOREIGN KEY (id_listings)
REFERENCES public.listings (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.host | type: TABLE --
-- DROP TABLE IF EXISTS public.host CASCADE;
CREATE TABLE public.host (
	host_id integer NOT NULL,
	host_since date,
	host_name varchar(200),
	CONSTRAINT host_pk PRIMARY KEY (host_id)

);
-- ddl-end --
ALTER TABLE public.host OWNER TO postgres;
-- ddl-end --

-- object: host_fk | type: CONSTRAINT --
-- ALTER TABLE public.listings DROP CONSTRAINT IF EXISTS host_fk CASCADE;
ALTER TABLE public.listings ADD CONSTRAINT host_fk FOREIGN KEY (host_id_host)
REFERENCES public.host (host_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.neighbourhood | type: TABLE --
-- DROP TABLE IF EXISTS public.neighbourhood CASCADE;
CREATE TABLE public.neighbourhood (
	zip_code integer NOT NULL,
	neighbour_name varchar(70) NOT NULL,
	city_id_city smallint NOT NULL,
	CONSTRAINT neighbourhood_pk PRIMARY KEY (zip_code)

);
-- ddl-end --
ALTER TABLE public.neighbourhood OWNER TO postgres;
-- ddl-end --

-- object: public.city | type: TABLE --
-- DROP TABLE IF EXISTS public.city CASCADE;
CREATE TABLE public.city (
	city_name varchar(70),
	city_id smallint NOT NULL,
	CONSTRAINT city_pk PRIMARY KEY (city_id)

);
-- ddl-end --
ALTER TABLE public.city OWNER TO postgres;
-- ddl-end --

-- object: city_fk | type: CONSTRAINT --
-- ALTER TABLE public.neighbourhood DROP CONSTRAINT IF EXISTS city_fk CASCADE;
ALTER TABLE public.neighbourhood ADD CONSTRAINT city_fk FOREIGN KEY (city_id_city)
REFERENCES public.city (city_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: neighbourhood_fk | type: CONSTRAINT --
-- ALTER TABLE public.listings DROP CONSTRAINT IF EXISTS neighbourhood_fk CASCADE;
ALTER TABLE public.listings ADD CONSTRAINT neighbourhood_fk FOREIGN KEY (zip_code_neighbourhood)
REFERENCES public.neighbourhood (zip_code) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


