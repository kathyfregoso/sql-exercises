--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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

--
-- Name: spectral_type_enumerated; Type: TYPE; Schema: public; Owner: kathleenfregoso
--

CREATE TYPE public.spectral_type_enumerated AS ENUM (
    'O',
    'B',
    'A',
    'F',
    'G',
    'K',
    'M'
);


ALTER TYPE public.spectral_type_enumerated OWNER TO kathleenfregoso;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: moons; Type: TABLE; Schema: public; Owner: kathleenfregoso
--

CREATE TABLE public.moons (
    id integer NOT NULL,
    designation integer NOT NULL,
    semi_major_axis numeric,
    mass numeric,
    planet_id integer NOT NULL,
    CONSTRAINT moons_designation_check CHECK ((designation > 0)),
    CONSTRAINT moons_mass_check CHECK ((mass > 0.0)),
    CONSTRAINT moons_semi_major_axis_check CHECK ((semi_major_axis > 0.0))
);


ALTER TABLE public.moons OWNER TO kathleenfregoso;

--
-- Name: moons_designation_seq; Type: SEQUENCE; Schema: public; Owner: kathleenfregoso
--

CREATE SEQUENCE public.moons_designation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moons_designation_seq OWNER TO kathleenfregoso;

--
-- Name: moons_designation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kathleenfregoso
--

ALTER SEQUENCE public.moons_designation_seq OWNED BY public.moons.designation;


--
-- Name: moons_id_seq; Type: SEQUENCE; Schema: public; Owner: kathleenfregoso
--

CREATE SEQUENCE public.moons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moons_id_seq OWNER TO kathleenfregoso;

--
-- Name: moons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kathleenfregoso
--

ALTER SEQUENCE public.moons_id_seq OWNED BY public.moons.id;


--
-- Name: moons_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: kathleenfregoso
--

CREATE SEQUENCE public.moons_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moons_planet_id_seq OWNER TO kathleenfregoso;

--
-- Name: moons_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kathleenfregoso
--

ALTER SEQUENCE public.moons_planet_id_seq OWNED BY public.moons.planet_id;


--
-- Name: planets; Type: TABLE; Schema: public; Owner: kathleenfregoso
--

CREATE TABLE public.planets (
    id integer NOT NULL,
    designation character(1) NOT NULL,
    mass numeric,
    star_id integer NOT NULL,
    semi_major_axis numeric NOT NULL,
    CONSTRAINT planets_mass_check CHECK ((mass > 0.0))
);


ALTER TABLE public.planets OWNER TO kathleenfregoso;

--
-- Name: planets_id_seq; Type: SEQUENCE; Schema: public; Owner: kathleenfregoso
--

CREATE SEQUENCE public.planets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planets_id_seq OWNER TO kathleenfregoso;

--
-- Name: planets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kathleenfregoso
--

ALTER SEQUENCE public.planets_id_seq OWNED BY public.planets.id;


--
-- Name: stars; Type: TABLE; Schema: public; Owner: kathleenfregoso
--

CREATE TABLE public.stars (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    distance numeric NOT NULL,
    spectral_type public.spectral_type_enumerated,
    companions integer NOT NULL,
    CONSTRAINT companions_not_neg CHECK ((companions >= 0)),
    CONSTRAINT distance_not_zero CHECK ((distance > (0)::numeric))
);


ALTER TABLE public.stars OWNER TO kathleenfregoso;

--
-- Name: stars_id_seq; Type: SEQUENCE; Schema: public; Owner: kathleenfregoso
--

CREATE SEQUENCE public.stars_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stars_id_seq OWNER TO kathleenfregoso;

--
-- Name: stars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kathleenfregoso
--

ALTER SEQUENCE public.stars_id_seq OWNED BY public.stars.id;


--
-- Name: moons id; Type: DEFAULT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.moons ALTER COLUMN id SET DEFAULT nextval('public.moons_id_seq'::regclass);


--
-- Name: moons designation; Type: DEFAULT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.moons ALTER COLUMN designation SET DEFAULT nextval('public.moons_designation_seq'::regclass);


--
-- Name: moons planet_id; Type: DEFAULT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.moons ALTER COLUMN planet_id SET DEFAULT nextval('public.moons_planet_id_seq'::regclass);


--
-- Name: planets id; Type: DEFAULT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.planets ALTER COLUMN id SET DEFAULT nextval('public.planets_id_seq'::regclass);


--
-- Name: stars id; Type: DEFAULT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.stars ALTER COLUMN id SET DEFAULT nextval('public.stars_id_seq'::regclass);


--
-- Data for Name: moons; Type: TABLE DATA; Schema: public; Owner: kathleenfregoso
--



--
-- Data for Name: planets; Type: TABLE DATA; Schema: public; Owner: kathleenfregoso
--



--
-- Data for Name: stars; Type: TABLE DATA; Schema: public; Owner: kathleenfregoso
--



--
-- Name: moons_designation_seq; Type: SEQUENCE SET; Schema: public; Owner: kathleenfregoso
--

SELECT pg_catalog.setval('public.moons_designation_seq', 1, false);


--
-- Name: moons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kathleenfregoso
--

SELECT pg_catalog.setval('public.moons_id_seq', 1, false);


--
-- Name: moons_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kathleenfregoso
--

SELECT pg_catalog.setval('public.moons_planet_id_seq', 1, false);


--
-- Name: planets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kathleenfregoso
--

SELECT pg_catalog.setval('public.planets_id_seq', 1, false);


--
-- Name: stars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kathleenfregoso
--

SELECT pg_catalog.setval('public.stars_id_seq', 2, true);


--
-- Name: moons moons_pkey; Type: CONSTRAINT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.moons
    ADD CONSTRAINT moons_pkey PRIMARY KEY (id);


--
-- Name: planets planets_pkey; Type: CONSTRAINT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.planets
    ADD CONSTRAINT planets_pkey PRIMARY KEY (id);


--
-- Name: stars stars_name_key; Type: CONSTRAINT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_name_key UNIQUE (name);


--
-- Name: stars stars_pkey; Type: CONSTRAINT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (id);


--
-- Name: moons moons_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.moons
    ADD CONSTRAINT moons_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planets(id);


--
-- Name: planets planets_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kathleenfregoso
--

ALTER TABLE ONLY public.planets
    ADD CONSTRAINT planets_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.stars(id);


--
-- PostgreSQL database dump complete
--

