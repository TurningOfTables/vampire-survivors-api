--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

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
-- Name: dlcs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dlcs (
    name text,
    uuid uuid NOT NULL
);


ALTER TABLE public.dlcs OWNER TO postgres;

--
-- Name: passiveitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passiveitems (
    name text,
    description text,
    unlockrequirements text,
    dlc text,
    maxlevel integer,
    rarity integer,
    uuid uuid NOT NULL
);


ALTER TABLE public.passiveitems OWNER TO postgres;

--
-- Name: weapons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weapons (
    name text,
    description text,
    unlockrequirements text,
    dlc text,
    basedamage numeric,
    maxlevel integer,
    rarity integer,
    evolution text,
    evolvedwith text[],
    uuid uuid NOT NULL
);


ALTER TABLE public.weapons OWNER TO postgres;

--
-- Name: dlcs dlcs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dlcs
    ADD CONSTRAINT dlcs_pkey PRIMARY KEY (uuid);


--
-- Name: passiveitems passiveitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passiveitems
    ADD CONSTRAINT passiveitems_pkey PRIMARY KEY (uuid);


--
-- Name: weapons weapons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapons
    ADD CONSTRAINT weapons_pkey PRIMARY KEY (uuid);


--
-- PostgreSQL database dump complete
--

