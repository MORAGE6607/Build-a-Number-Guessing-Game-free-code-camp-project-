--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES ('user_1736419775219', 2, 374);
INSERT INTO public.users VALUES ('user_1736419775220', 5, 98);
INSERT INTO public.users VALUES ('user_1736420221723', 2, 143);
INSERT INTO public.users VALUES ('user_1736420221724', 5, 106);
INSERT INTO public.users VALUES ('apple', 3, 11);
INSERT INTO public.users VALUES ('user_1736420915458', 2, 463);
INSERT INTO public.users VALUES ('user_1736420915459', 5, 49);
INSERT INTO public.users VALUES ('user_1736421165398', 2, 41);
INSERT INTO public.users VALUES ('user_1736421165399', 5, 161);
INSERT INTO public.users VALUES ('user_1736421302962', 2, 799);
INSERT INTO public.users VALUES ('user_1736421302963', 5, 294);
INSERT INTO public.users VALUES ('banana', 3, 8);
INSERT INTO public.users VALUES ('user_1736421627479', 2, 442);
INSERT INTO public.users VALUES ('user_1736421627480', 5, 95);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- PostgreSQL database dump complete
--

