--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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
-- Name: draws; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.draws (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    winning_random_number numeric(78,0) NOT NULL,
    "timestamp" bigint NOT NULL,
    beacon_period_started_at bigint NOT NULL,
    beacon_period_seconds integer NOT NULL,
    block_number bigint
);


ALTER TABLE public.draws OWNER TO pooltogether;

--
-- Name: prize_distributions; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prize_distributions (
    draw_id integer NOT NULL,
    network character varying(16) NOT NULL,
    bit_range_size smallint NOT NULL,
    match_cardinality smallint NOT NULL,
    start_timestamp_offset bigint NOT NULL,
    end_timestamp_offset bigint NOT NULL,
    max_picks_per_user integer NOT NULL,
    expiry_duration integer NOT NULL,
    number_of_picks bigint NOT NULL,
    tiers bigint[] NOT NULL,
    prize bigint NOT NULL
);


ALTER TABLE public.prize_distributions OWNER TO pooltogether;

--
-- Name: prizes; Type: TABLE; Schema: public; Owner: pooltogether
--

CREATE TABLE public.prizes (
    network character varying(16) NOT NULL,
    address bytea NOT NULL,
    draw_id integer NOT NULL,
    claimable_prizes bigint[],
    claimable_picks integer[],
    dropped_prizes bigint[],
    dropped_picks integer[],
    normalized_balance bigint NOT NULL,
    average_balance bigint
);


ALTER TABLE public.prizes OWNER TO pooltogether;

--
-- Name: draws pk_draws; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.draws
    ADD CONSTRAINT pk_draws PRIMARY KEY (draw_id, network);


--
-- Name: prize_distributions pk_prize_distributions; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prize_distributions
    ADD CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network);


--
-- Name: prizes pk_prizes; Type: CONSTRAINT; Schema: public; Owner: pooltogether
--

ALTER TABLE ONLY public.prizes
    ADD CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id);


--
-- PostgreSQL database dump complete
--

