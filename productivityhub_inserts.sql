--
-- PostgreSQL database dump
--

\restrict pMayKJKdwhrkIFeyI4C5R0c3znznaa0d9BvEKDjaUGJOAr01YXYVRfz9qGNbmK7

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: backlog_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backlog_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    star_rating smallint DEFAULT 1 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(100) NOT NULL,
    color character varying(7) DEFAULT '#6B7280'::character varying NOT NULL,
    type character varying(20) DEFAULT 'general'::character varying NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: daily_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    log_date date NOT NULL,
    sprint_start time without time zone,
    sprint_end time without time zone,
    notes text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    sleep_hours real
);


--
-- Name: imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.imports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    filename character varying(255) NOT NULL,
    row_count integer DEFAULT 0 NOT NULL,
    rows_imported integer DEFAULT 0 NOT NULL,
    rows_skipped integer DEFAULT 0 NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    error_log text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    csv_data text
);


--
-- Name: task_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_entries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    daily_log_id uuid NOT NULL,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    backlog_item_id uuid,
    title character varying(255) NOT NULL,
    star_rating smallint DEFAULT 1 NOT NULL,
    tag character varying(10),
    time_start time without time zone,
    time_end time without time zone,
    duration_minutes integer,
    is_completed boolean DEFAULT false NOT NULL,
    completed_at timestamp without time zone,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: weekly_goals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.weekly_goals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    week_start date NOT NULL,
    target_minutes integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Data for Name: backlog_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.backlog_items VALUES ('b1b093d8-e4c5-438e-9434-a43942c76a56', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'beca9e3a-fc07-45c8-b063-8530a1803bdc', 'AI Engineer Core Track', 2, true, '2026-03-26 02:57:37.264445', '2026-03-26 02:57:37.264445', 0);
INSERT INTO public.backlog_items VALUES ('ebb4b631-55e9-4e1d-aead-d1c3c30baaf7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', 'CAC, LTV, Gross Profit', 1, true, '2026-03-26 03:04:25.643396', '2026-03-26 03:04:25.643396', 0);
INSERT INTO public.backlog_items VALUES ('9f4107c6-3e0b-4669-9a68-1c6fbb3ce943', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', 'how to pick markets, and find niches that are profitable', 1, true, '2026-03-26 03:04:34.452166', '2026-03-26 03:04:34.452166', 0);
INSERT INTO public.backlog_items VALUES ('6a46e27e-ea4a-49e1-bdd1-7555820a8243', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', 'Creating Grand Slam Offer for agency', 1, true, '2026-03-26 03:04:44.341119', '2026-03-26 03:04:44.341119', 0);
INSERT INTO public.backlog_items VALUES ('a3f2858f-15f6-4099-8687-77e98b3d7a64', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', 'Sales Script', 1, true, '2026-03-26 03:04:51.865578', '2026-03-26 03:04:51.865578', 0);
INSERT INTO public.backlog_items VALUES ('05afa9bc-ef76-486d-bdae-ee845dea1b89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', 'Claude Code Course Creation', 1, true, '2026-03-26 03:05:13.582398', '2026-03-26 03:05:13.582398', 0);
INSERT INTO public.backlog_items VALUES ('95a9a8b4-e041-44f7-85a0-6436f46a54c8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', 'Meme Generator', 1, true, '2026-03-26 03:05:19.367937', '2026-03-26 03:05:19.367937', 0);
INSERT INTO public.backlog_items VALUES ('6d4eb2fe-56dc-4acc-a054-a81ebda5be2d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'daa3df07-c5ef-4d94-8860-68aee194dd7e', 'Auto IGDM', 1, true, '2026-03-26 03:08:08.191316', '2026-03-26 03:08:08.191316', 0);
INSERT INTO public.backlog_items VALUES ('9fe6d999-17f8-494a-98bc-727be2ae3c87', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'daa3df07-c5ef-4d94-8860-68aee194dd7e', 'HeyReach', 1, true, '2026-03-26 03:08:13.490218', '2026-03-26 03:08:13.490218', 0);
INSERT INTO public.backlog_items VALUES ('1f101d16-8eb4-4e1b-ab2b-947b2463aac1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'daa3df07-c5ef-4d94-8860-68aee194dd7e', 'Expedite', 1, true, '2026-03-26 03:08:18.740101', '2026-03-26 03:08:18.740101', 0);
INSERT INTO public.backlog_items VALUES ('7e22b985-ee8e-412d-bbfb-1646c9115e79', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'daa3df07-c5ef-4d94-8860-68aee194dd7e', 'App Sumo', 1, true, '2026-03-26 03:08:23.672203', '2026-03-26 03:08:23.672203', 0);
INSERT INTO public.backlog_items VALUES ('d2f2a28d-adf5-4c77-ab9e-20a74a56b857', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'daa3df07-c5ef-4d94-8860-68aee194dd7e', 'Trigger.Dev', 1, true, '2026-03-26 03:08:28.390943', '2026-03-26 03:08:28.390943', 0);
INSERT INTO public.backlog_items VALUES ('5ffaf7bd-e0b6-401c-bbdb-d56013e6b3f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'daa3df07-c5ef-4d94-8860-68aee194dd7e', 'many chats', 1, true, '2026-03-26 03:08:34.430084', '2026-03-26 03:08:34.430084', 0);
INSERT INTO public.backlog_items VALUES ('a259550a-a3ce-43be-a64c-8a0257817643', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', 'AntiGravity NotebookLm', 1, true, '2026-03-26 02:58:20.763435', '2026-03-26 02:58:20.763435', 5);
INSERT INTO public.backlog_items VALUES ('ec50d416-2e70-4b99-a930-19f2a69f5548', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '76f79a24-39c1-44ba-8148-81f44fe680a2', 'polar-trends', 3, true, '2026-03-26 02:52:30.505963', '2026-03-26 13:18:57.018', 0);
INSERT INTO public.backlog_items VALUES ('07c8a2ac-be90-419f-afa7-c365189c14ad', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '76f79a24-39c1-44ba-8148-81f44fe680a2', 'Italian Stories', 2, true, '2026-03-26 02:52:00.681999', '2026-03-26 02:52:00.681999', 1);
INSERT INTO public.backlog_items VALUES ('16249e4b-5088-4eaa-b49f-25071ca27381', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', 'SOP Generation At', 1, true, '2026-03-26 03:07:24.295303', '2026-03-26 03:07:24.295303', 0);
INSERT INTO public.backlog_items VALUES ('eade85c5-65ed-4f21-962c-37b7812a99d5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '76f79a24-39c1-44ba-8148-81f44fe680a2', 'Project GSA', 2, true, '2026-03-26 02:53:23.430927', '2026-03-26 02:53:23.430927', 2);
INSERT INTO public.backlog_items VALUES ('6a993856-3fd6-4756-acf8-fcf52fbd34ea', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '76f79a24-39c1-44ba-8148-81f44fe680a2', 'Hunter Trading', 1, true, '2026-03-26 02:53:14.177604', '2026-03-26 02:53:14.177604', 3);
INSERT INTO public.backlog_items VALUES ('224036fa-0cf8-4eb6-a6d8-943d47faced9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '76f79a24-39c1-44ba-8148-81f44fe680a2', 'moji', 1, true, '2026-03-28 23:51:45.096167', '2026-03-28 23:51:45.096167', 4);
INSERT INTO public.backlog_items VALUES ('cc4a5526-8e7d-4d81-a1a8-d85e152d21bb', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', 'Website Design At', 2, true, '2026-03-26 03:07:38.081566', '2026-03-26 03:07:38.081566', 1);
INSERT INTO public.backlog_items VALUES ('b21c7180-6386-4260-b1a6-4ea743f49e17', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', 'Claude Instagram Strategy', 3, true, '2026-04-01 06:19:23.516201', '2026-04-01 06:19:23.516201', 0);
INSERT INTO public.backlog_items VALUES ('7d12070c-20b7-4d72-8297-d11f25ea7d80', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', 'Website Audit At', 1, true, '2026-03-26 03:07:29.655814', '2026-03-26 03:07:29.655814', 2);
INSERT INTO public.backlog_items VALUES ('9c171be9-a6dc-4f58-b47f-a9d9babe6408', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', '"Chief AI Officer"', 1, true, '2026-03-26 03:07:52.024518', '2026-03-26 03:07:52.024518', 4);
INSERT INTO public.backlog_items VALUES ('ee8bfc80-47bd-40b2-9d23-99decad351fb', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', 'ClawGravity Setup', 1, true, '2026-03-26 03:07:08.712315', '2026-03-26 03:07:08.712315', 5);
INSERT INTO public.backlog_items VALUES ('9a039a0d-dee9-4f2b-bcf1-e4d51f3ff3d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', 'OpenClaw Setup', 1, true, '2026-03-26 03:06:57.980289', '2026-03-26 03:06:57.980289', 6);
INSERT INTO public.backlog_items VALUES ('86e2a1d8-f024-4dd5-8f52-1099b3fe7924', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '1de1e2a6-3148-499a-ade2-50a06fc89cbd', '$100M Money Models', 3, true, '2026-03-28 08:13:23.306687', '2026-03-28 08:13:23.306687', 0);
INSERT INTO public.backlog_items VALUES ('10033b1b-ad7c-4605-b0eb-f4b217350515', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', 'Fri - AI RB - 09:35AM - 11:05, ML Lab - 01:15PM - 04:20PM, ML - 04:25PM - 05:55PM', 3, true, '2026-03-26 02:56:14.878252', '2026-03-29 19:18:17.481', 3);
INSERT INTO public.backlog_items VALUES ('66233adc-0068-424b-8035-7815247e3679', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', '$100M Money Models', 3, true, '2026-03-28 08:13:35.324941', '2026-03-28 08:13:35.324941', 9);
INSERT INTO public.backlog_items VALUES ('079e5c04-46cc-446e-adb2-b26d016b78ba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', 'Thr - DOA - 01:15PM - 02:45PM, DV - 02:50PM - 04:25PM', 3, true, '2026-03-26 02:56:07.273001', '2026-03-29 18:17:15.76', 2);
INSERT INTO public.backlog_items VALUES ('2389e953-985a-495a-a218-097b2d9d8377', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', 'Wed - DOA - 09:35AM - 11:05AM, DV - 01:46PM - 03:20PM, AI RB - 03:51PM - 05:25PM', 3, true, '2026-03-26 02:55:59.158144', '2026-03-29 18:18:34.012', 1);
INSERT INTO public.backlog_items VALUES ('aeb8a1ee-4e09-434d-8ae4-fe9ca2a46d39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', 'Tue - Aca - 09:35AM - 11:05AM, ML - 01:15PM - 02:45PM', 3, true, '2026-03-29 22:57:55.950242', '2026-03-29 18:18:58.81', 0);
INSERT INTO public.backlog_items VALUES ('ac590a14-3e93-4122-a9c4-68011df8786e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', '100M Offer At', 1, true, '2026-03-26 03:07:18.185305', '2026-03-26 03:07:18.185305', 7);
INSERT INTO public.backlog_items VALUES ('83e05a5e-d176-4579-a8de-885ff09b6d6d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c28c9378-2836-4293-8dfb-17db764a4a09', 'Finding Fiverr Expert', 2, true, '2026-03-26 03:02:48.50118', '2026-03-26 03:02:48.50118', 1);
INSERT INTO public.backlog_items VALUES ('6652fdb4-4669-4284-b1bb-2d26356aa867', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', 'LinkedIn & Insta Outreach', 2, true, '2026-03-26 02:59:08.567952', '2026-03-26 02:59:08.567952', 1);
INSERT INTO public.backlog_items VALUES ('bcf8d105-bf49-4938-866f-714b620850bc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', 'Mon - Aca - 08:00AM - 09:30AM, AI RB Lab - 02:50PM - 05:55PM', 3, true, '2026-03-26 02:56:22.567814', '2026-03-29 18:10:28.089', 0);
INSERT INTO public.backlog_items VALUES ('909342c8-76d2-46af-bbce-a61d1581102e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', 'Website Development At', 1, true, '2026-03-26 03:07:44.784307', '2026-03-26 03:07:44.784307', 3);
INSERT INTO public.backlog_items VALUES ('749fb1a6-520a-4751-a94e-09a20277fc3b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Upwork Job Postings At', 2, true, '2026-03-26 02:51:26.828913', '2026-03-26 02:51:26.828913', 7);
INSERT INTO public.backlog_items VALUES ('bd84452a-53c1-4b1b-91b0-697371d99634', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Loom Introductory Video', 2, true, '2026-03-26 02:51:34.783782', '2026-03-26 02:51:34.783782', 8);
INSERT INTO public.backlog_items VALUES ('0cbc3003-7694-4964-9a0f-07b8908f34d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c28c9378-2836-4293-8dfb-17db764a4a09', 'nSave Payment app', 1, true, '2026-03-26 05:51:21.940318', '2026-03-26 05:51:21.940318', 2);
INSERT INTO public.backlog_items VALUES ('ba15e656-f89c-4b9b-8994-598a05056b94', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Content Engine At', 3, true, '2026-03-26 02:51:10.927277', '2026-04-01 05:01:03.583', 4);
INSERT INTO public.backlog_items VALUES ('1adfc748-c06d-4d79-9a6e-e24861cbfc2c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', 'Claude Linkedin Strategy', 3, true, '2026-04-01 06:18:58.448596', '2026-04-01 06:18:58.448596', 0);
INSERT INTO public.backlog_items VALUES ('a74f2efc-87f9-4fb7-ad88-f8371a5f9668', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', 'SM Content Management', 1, true, '2026-03-26 02:57:58.456104', '2026-03-26 02:57:58.456104', 3);
INSERT INTO public.backlog_items VALUES ('4d360be1-22b4-40dc-ad5c-69d308b9f6bd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c28c9378-2836-4293-8dfb-17db764a4a09', 'Fiverr Growth Strategy', 3, true, '2026-04-01 05:48:42.906691', '2026-04-01 05:48:42.906691', 0);
INSERT INTO public.backlog_items VALUES ('2072479c-6971-40a0-9cfb-9791d7bd4c5a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c28c9378-2836-4293-8dfb-17db764a4a09', 'Fiverr Profile Optimization', 3, true, '2026-04-01 05:47:21.514188', '2026-04-01 05:47:21.514188', 0);
INSERT INTO public.backlog_items VALUES ('e0f80e8d-8de5-4a85-b21a-cc6f33c469ff', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', 'Upwork Consultations', 2, true, '2026-03-26 03:01:13.66425', '2026-03-26 03:01:13.66425', 5);
INSERT INTO public.backlog_items VALUES ('722197f3-bb13-43f8-bf39-ca261b9f773d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', 'Upwork Bidding', 3, true, '2026-03-26 03:00:50.884734', '2026-03-26 03:00:50.884734', 0);
INSERT INTO public.backlog_items VALUES ('9f524a5d-9d8e-4408-bbda-9cff6a2f2a5f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', 'Claude Upwork Profile Optimization', 3, true, '2026-04-01 05:46:39.557375', '2026-04-01 05:46:39.557375', 2);
INSERT INTO public.backlog_items VALUES ('c0fd9e98-6e1b-44d7-b683-b27a8a4da2a8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', 'Claude Upwork Proposals Generation', 3, true, '2026-04-01 05:47:03.410266', '2026-04-01 05:47:03.410266', 3);
INSERT INTO public.backlog_items VALUES ('91830066-5a1b-4e6c-b50c-2a4584b90308', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', 'AL/ML Projects Case Studies', 2, true, '2026-03-26 03:01:22.202117', '2026-03-26 03:01:22.202117', 4);
INSERT INTO public.backlog_items VALUES ('5b783c53-2754-4b34-a2fe-29abe35c2167', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', 'Claude Upwork Strategy', 3, true, '2026-04-01 05:55:41.24481', '2026-04-01 05:55:41.24481', 1);
INSERT INTO public.backlog_items VALUES ('dcf4cb84-6e6f-4a98-b340-583bc70412fe', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', 'Agency Website Launch', 3, true, '2026-03-26 03:04:17.175088', '2026-04-01 01:18:19.995', 0);
INSERT INTO public.backlog_items VALUES ('37e58212-4218-42ab-92c4-36b5ce2e18a4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', 'Manychat', 1, true, '2026-03-26 02:59:20.432119', '2026-03-26 02:59:20.432119', 4);
INSERT INTO public.backlog_items VALUES ('c2492650-a029-404a-9102-78e7985f7463', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', 'SM Content Posting', 2, true, '2026-03-26 02:59:29.253191', '2026-03-25 21:59:34.246', 2);
INSERT INTO public.backlog_items VALUES ('82c3f38e-687e-4c39-8536-1efb8a031910', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Agency Website Launch', 3, true, '2026-04-01 06:11:43.659166', '2026-04-01 06:11:43.659166', 1);
INSERT INTO public.backlog_items VALUES ('32df3d6a-b0ba-4f81-b4c2-178acbd6188c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Instagram & LinkedIn Outreach At', 2, true, '2026-03-26 02:51:19.202491', '2026-03-26 02:51:19.202491', 5);
INSERT INTO public.backlog_items VALUES ('5edf5bd5-fa7a-4e07-8698-8dfc599e8cdf', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '1de1e2a6-3148-499a-ade2-50a06fc89cbd', 'How AI Works From Sorcery', 1, true, '2026-03-26 03:05:39.131395', '2026-03-26 03:05:39.131395', 1);
INSERT INTO public.backlog_items VALUES ('4ccb3ed1-3a0c-4b46-812b-0530278eed8a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '1de1e2a6-3148-499a-ade2-50a06fc89cbd', 'Daily Brief', 1, true, '2026-03-26 03:05:58.468946', '2026-03-26 03:05:58.468946', 2);
INSERT INTO public.backlog_items VALUES ('0abeca21-e524-4b0b-b74e-45296650aeae', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Robotics Lab Assignment - 5 April', 2, true, '2026-04-01 04:41:08.014172', '2026-04-01 02:38:37.098', 0);
INSERT INTO public.backlog_items VALUES ('6c69baf3-e6d4-4290-9fbe-45c6b9d491da', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Cold Email Automations', 3, true, '2026-03-26 02:50:57.878445', '2026-03-30 15:43:53.083', 3);
INSERT INTO public.backlog_items VALUES ('6f8552e5-df89-4ebe-b219-53966c3521ea', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Working on quality leads', 3, true, '2026-04-02 06:23:05.701811', '2026-04-02 06:23:05.701811', 2);
INSERT INTO public.backlog_items VALUES ('94ce92ab-61d2-47a6-916e-8e79c870ac99', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Claude Code Projects Case Study', 2, true, '2026-04-01 13:07:56.446909', '2026-04-02 02:44:38.196', 6);
INSERT INTO public.backlog_items VALUES ('79fb130f-b1be-474d-a2e3-47c0bb14bccb', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'Webots Tutorial', 3, true, '2026-04-04 16:30:20.231895', '2026-04-04 16:30:20.231895', 0);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories VALUES ('ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'IM', 'Important', '#EF4444', 'priority', 0, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('76f79a24-39c1-44ba-8148-81f44fe680a2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'Projs', 'Projects', '#3B82F6', 'work', 1, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'UN', 'University', '#8B5CF6', 'education', 2, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('c5cb9969-0e49-4081-ac53-6cca8d0fba97', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'SM', 'Social Media', '#F59E0B', 'marketing', 4, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('69405924-8f59-4aa6-a293-8fa29748301f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'AGN', 'Agency', '#EC4899', 'business', 7, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('3c786214-76c5-4c7d-988e-5f1e71ae4c15', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ATs', 'Automations', '#F97316', 'tech', 9, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('daa3df07-c5ef-4d94-8860-68aee194dd7e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'TIs', 'Tools', '#84CC16', 'tech', 10, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'PR', 'Personal', '#E11D48', 'personal', 12, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('a721d8d8-8024-4917-9e16-3a0a8842dc62', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'LR', 'Learning', '#EAB308', 'education', 13, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('beca9e3a-fc07-45c8-b063-8530a1803bdc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'CR', 'Course', '#06B6D4', 'learning', 3, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('c28c9378-2836-4293-8dfb-17db764a4a09', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'Fv', 'Fiverr', '#14b881', 'freelance', 6, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('1de1e2a6-3148-499a-ade2-50a06fc89cbd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'RD', 'Reading', '#6366F1', 'learning', 8, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'GN', 'General', '#6B7280', 'general', 0, '2026-03-26 03:55:51.361849');
INSERT INTO public.categories VALUES ('c9ebe29d-e9b1-4c85-84de-21d2765711c0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'EN', 'Entertainment', '#F59E0B', 'general', 0, '2026-03-26 03:55:51.417761');
INSERT INTO public.categories VALUES ('9ca8ebbe-d5a4-46bf-8334-8acf8e2de85a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'N/A', 'N/A', '#6B7280', 'general', 0, '2026-03-26 03:55:52.514212');
INSERT INTO public.categories VALUES ('d8a81c72-e8e2-4a05-8ea7-62eab47c9eea', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'TW', 'Time Waste', '#6B7280', 'general', 0, '2026-03-26 03:55:52.701971');
INSERT INTO public.categories VALUES ('9ab651a4-b032-453f-9f03-57be13feffba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'EXECISE', 'Execise', '#6B7280', 'general', 0, '2026-03-26 03:55:53.261241');
INSERT INTO public.categories VALUES ('96645722-545e-46db-860e-8bea0567d90d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'EDUCATON', 'Educaton', '#6B7280', 'general', 0, '2026-03-26 03:55:53.571863');
INSERT INTO public.categories VALUES ('e4a1d9d3-48d9-423b-a6db-3e65424161df', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'UP', 'Upwork', '#82ee2b', 'freelance', 5, '2026-03-26 02:47:57.14009');
INSERT INTO public.categories VALUES ('6003c93e-fc70-4d70-86e5-39c7f700b329', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'WK', 'Work', '#16d48b', 'general', 11, '2026-03-26 02:47:57.14009');


--
-- Data for Name: daily_logs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.daily_logs VALUES ('1fd42315-992f-43ef-84c4-db3d3df92840', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-18', NULL, NULL, NULL, '2026-03-26 03:55:51.276749', '2026-03-26 03:55:51.276749', NULL);
INSERT INTO public.daily_logs VALUES ('d425d9a1-f28e-4d92-b51e-db2a46dfda7b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-20', NULL, NULL, NULL, '2026-03-26 03:55:51.306899', '2026-03-26 03:55:51.306899', NULL);
INSERT INTO public.daily_logs VALUES ('ea46d472-a9b5-4024-88cd-109d8c2ab4b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-21', NULL, NULL, NULL, '2026-03-26 03:55:51.334655', '2026-03-26 03:55:51.334655', NULL);
INSERT INTO public.daily_logs VALUES ('29f2a9a3-b585-45d9-ad26-80cb783286ba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-22', NULL, NULL, NULL, '2026-03-26 03:55:51.358147', '2026-03-26 03:55:51.358147', NULL);
INSERT INTO public.daily_logs VALUES ('7603b18c-22dd-4505-84c1-1eb612f0346b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-23', NULL, NULL, NULL, '2026-03-26 03:55:51.381696', '2026-03-26 03:55:51.381696', NULL);
INSERT INTO public.daily_logs VALUES ('2e223e66-7f5e-4907-bf89-3a554d4a7e7d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-24', NULL, NULL, NULL, '2026-03-26 03:55:51.395692', '2026-03-26 03:55:51.395692', NULL);
INSERT INTO public.daily_logs VALUES ('1765d700-4a27-43ef-a155-c443ed1ce809', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-25', NULL, NULL, NULL, '2026-03-26 03:55:51.4115', '2026-03-26 03:55:51.4115', NULL);
INSERT INTO public.daily_logs VALUES ('091e192b-bb65-450c-b1a2-92beb6e7bd57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-26', NULL, NULL, NULL, '2026-03-26 03:55:51.438423', '2026-03-26 03:55:51.438423', NULL);
INSERT INTO public.daily_logs VALUES ('801a5e40-b306-4456-ad95-0d4e85c38080', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-27', NULL, NULL, NULL, '2026-03-26 03:55:51.468265', '2026-03-26 03:55:51.468265', NULL);
INSERT INTO public.daily_logs VALUES ('5d385f2c-51b1-4d29-a2e1-bb0bfbb8b078', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-28', NULL, NULL, NULL, '2026-03-26 03:55:51.488383', '2026-03-26 03:55:51.488383', NULL);
INSERT INTO public.daily_logs VALUES ('7ec01752-76e1-4af0-b39e-97568d234d07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-29', NULL, NULL, NULL, '2026-03-26 03:55:51.495179', '2026-03-26 03:55:51.495179', NULL);
INSERT INTO public.daily_logs VALUES ('718cf95a-afd4-4c34-ad6c-def125f2af58', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-06-30', NULL, NULL, NULL, '2026-03-26 03:55:51.51979', '2026-03-26 03:55:51.51979', NULL);
INSERT INTO public.daily_logs VALUES ('d559c4f2-8647-473f-abbb-d05971dff53d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-01', NULL, NULL, NULL, '2026-03-26 03:55:51.549527', '2026-03-26 03:55:51.549527', NULL);
INSERT INTO public.daily_logs VALUES ('56b1eda5-083f-4210-8b9a-3b2ee60aa08d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-02', NULL, NULL, NULL, '2026-03-26 03:55:51.577529', '2026-03-26 03:55:51.577529', NULL);
INSERT INTO public.daily_logs VALUES ('903b21d8-9584-46b8-b70f-a9a9ef3861b3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-03', NULL, NULL, NULL, '2026-03-26 03:55:51.59405', '2026-03-26 03:55:51.59405', NULL);
INSERT INTO public.daily_logs VALUES ('98f12b19-aa87-472d-90fa-46da85a01a71', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-04', NULL, NULL, NULL, '2026-03-26 03:55:51.618469', '2026-03-26 03:55:51.618469', NULL);
INSERT INTO public.daily_logs VALUES ('5df8a6d0-e347-43ac-a1e8-d9d21c1b39d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-05', NULL, NULL, NULL, '2026-03-26 03:55:51.634187', '2026-03-26 03:55:51.634187', NULL);
INSERT INTO public.daily_logs VALUES ('615fb8ae-cd50-4cfa-b3c4-e87f6f4c6547', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-06', NULL, NULL, NULL, '2026-03-26 03:55:51.650874', '2026-03-26 03:55:51.650874', NULL);
INSERT INTO public.daily_logs VALUES ('bdef978b-eed6-4e1c-ac19-0643d97d719d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-07', NULL, NULL, NULL, '2026-03-26 03:55:51.67866', '2026-03-26 03:55:51.67866', NULL);
INSERT INTO public.daily_logs VALUES ('5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-08', NULL, NULL, NULL, '2026-03-26 03:55:51.697027', '2026-03-26 03:55:51.697027', NULL);
INSERT INTO public.daily_logs VALUES ('988c45ad-ab4a-4271-9b1c-c565d78dc7d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-09', NULL, NULL, NULL, '2026-03-26 03:55:51.727616', '2026-03-26 03:55:51.727616', NULL);
INSERT INTO public.daily_logs VALUES ('738233a8-81fa-414d-838d-6b924aad0fd5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-10', NULL, NULL, NULL, '2026-03-26 03:55:51.746806', '2026-03-26 03:55:51.746806', NULL);
INSERT INTO public.daily_logs VALUES ('c3bb2718-00cb-4b0f-83e6-94cfed642383', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-11', NULL, NULL, NULL, '2026-03-26 03:55:51.762535', '2026-03-26 03:55:51.762535', NULL);
INSERT INTO public.daily_logs VALUES ('6382f463-a5a8-4770-99ce-becbe4ea8aa9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-12', NULL, NULL, NULL, '2026-03-26 03:55:51.785432', '2026-03-26 03:55:51.785432', NULL);
INSERT INTO public.daily_logs VALUES ('b981dd5b-97f9-4cc5-99e4-ddfe1eabb88d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-13', NULL, NULL, NULL, '2026-03-26 03:55:51.81068', '2026-03-26 03:55:51.81068', NULL);
INSERT INTO public.daily_logs VALUES ('5862e4b4-ee88-465f-b599-4c4658d6eda3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-14', NULL, NULL, NULL, '2026-03-26 03:55:51.837907', '2026-03-26 03:55:51.837907', NULL);
INSERT INTO public.daily_logs VALUES ('ad0ef18a-4277-4941-990f-454fa78ae381', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-15', NULL, NULL, NULL, '2026-03-26 03:55:52.106156', '2026-03-26 03:55:52.106156', NULL);
INSERT INTO public.daily_logs VALUES ('bac53cc5-56a0-4c98-adf2-6f8ce5ff6a38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-16', NULL, NULL, NULL, '2026-03-26 03:55:52.133073', '2026-03-26 03:55:52.133073', NULL);
INSERT INTO public.daily_logs VALUES ('ab4a7c54-f512-48e8-96d3-111be9a2c1de', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-17', NULL, NULL, NULL, '2026-03-26 03:55:52.147972', '2026-03-26 03:55:52.147972', NULL);
INSERT INTO public.daily_logs VALUES ('4ac4b935-4575-439b-b712-5c119d062df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-18', NULL, NULL, NULL, '2026-03-26 03:55:52.165431', '2026-03-26 03:55:52.165431', NULL);
INSERT INTO public.daily_logs VALUES ('0e5ef3d0-c87c-4a07-a125-07fbe0a4d34f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-19', NULL, NULL, NULL, '2026-03-26 03:55:52.18299', '2026-03-26 03:55:52.18299', NULL);
INSERT INTO public.daily_logs VALUES ('103019ec-fb52-4afb-b863-706ac116ddba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-20', NULL, NULL, NULL, '2026-03-26 03:55:52.204344', '2026-03-26 03:55:52.204344', NULL);
INSERT INTO public.daily_logs VALUES ('e3504911-6f90-40bd-b6a7-b0228b528187', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-21', NULL, NULL, NULL, '2026-03-26 03:55:52.226741', '2026-03-26 03:55:52.226741', NULL);
INSERT INTO public.daily_logs VALUES ('7c958adf-89d4-493e-b7f4-ff36ad93b4e0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-22', NULL, NULL, NULL, '2026-03-26 03:55:52.245085', '2026-03-26 03:55:52.245085', NULL);
INSERT INTO public.daily_logs VALUES ('f330cd71-c460-4821-96a9-39af0efee85a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-23', NULL, NULL, NULL, '2026-03-26 03:55:52.49058', '2026-03-26 03:55:52.49058', NULL);
INSERT INTO public.daily_logs VALUES ('f3b097cb-3a3b-4402-9542-453d66940e16', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-24', NULL, NULL, NULL, '2026-03-26 03:55:52.508985', '2026-03-26 03:55:52.508985', NULL);
INSERT INTO public.daily_logs VALUES ('d425c5a3-54b6-402b-a90e-562cc647c6f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-25', NULL, NULL, NULL, '2026-03-26 03:55:52.528211', '2026-03-26 03:55:52.528211', NULL);
INSERT INTO public.daily_logs VALUES ('77409295-cae5-44c9-8238-59495feb0985', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-26', NULL, NULL, NULL, '2026-03-26 03:55:52.550847', '2026-03-26 03:55:52.550847', NULL);
INSERT INTO public.daily_logs VALUES ('70e0e7c2-3881-45a9-96fa-31b6c7324d6b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-29', NULL, NULL, NULL, '2026-03-26 03:55:52.571612', '2026-03-26 03:55:52.571612', NULL);
INSERT INTO public.daily_logs VALUES ('67c4365e-8e45-4e3c-b7aa-83d6eedf01e8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-30', NULL, NULL, NULL, '2026-03-26 03:55:52.591021', '2026-03-26 03:55:52.591021', NULL);
INSERT INTO public.daily_logs VALUES ('8ba34785-9be5-4492-94ec-d84d4e45e218', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-07-31', NULL, NULL, NULL, '2026-03-26 03:55:52.614395', '2026-03-26 03:55:52.614395', NULL);
INSERT INTO public.daily_logs VALUES ('195fc6ae-dd20-46e9-8d68-d7a2b36a93fc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-01', NULL, NULL, NULL, '2026-03-26 03:55:52.627616', '2026-03-26 03:55:52.627616', NULL);
INSERT INTO public.daily_logs VALUES ('c3df1f5a-602a-496a-a06d-b58d916654cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-02', NULL, NULL, NULL, '2026-03-26 03:55:52.643413', '2026-03-26 03:55:52.643413', NULL);
INSERT INTO public.daily_logs VALUES ('79a8f669-c6ae-4704-abdf-570f08644d82', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-05', NULL, NULL, NULL, '2026-03-26 03:55:52.653899', '2026-03-26 03:55:52.653899', NULL);
INSERT INTO public.daily_logs VALUES ('f24a07b1-ee49-481a-9a0d-6b8b886f4a53', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-06', NULL, NULL, NULL, '2026-03-26 03:55:52.679177', '2026-03-26 03:55:52.679177', NULL);
INSERT INTO public.daily_logs VALUES ('480e6e9d-aca7-44ee-8a40-3d4a7e9cc8b5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-07', NULL, NULL, NULL, '2026-03-26 03:55:52.708989', '2026-03-26 03:55:52.708989', NULL);
INSERT INTO public.daily_logs VALUES ('3334ec6a-b9a1-4691-b1b1-debced0ad420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-08', NULL, NULL, NULL, '2026-03-26 03:55:52.720206', '2026-03-26 03:55:52.720206', NULL);
INSERT INTO public.daily_logs VALUES ('02cdff23-bae7-4a22-895c-2574453ff271', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-09', NULL, NULL, NULL, '2026-03-26 03:55:52.746685', '2026-03-26 03:55:52.746685', NULL);
INSERT INTO public.daily_logs VALUES ('938b7e43-7fe1-4add-8562-8e4a44777e28', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-10', NULL, NULL, NULL, '2026-03-26 03:55:52.764909', '2026-03-26 03:55:52.764909', NULL);
INSERT INTO public.daily_logs VALUES ('920f7471-4c76-472a-90d1-91e89f62af30', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-11', NULL, NULL, NULL, '2026-03-26 03:55:53.003551', '2026-03-26 03:55:53.003551', NULL);
INSERT INTO public.daily_logs VALUES ('7feb2ddd-5282-4944-9ece-71e1375e9435', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-12', NULL, NULL, NULL, '2026-03-26 03:55:53.032481', '2026-03-26 03:55:53.032481', NULL);
INSERT INTO public.daily_logs VALUES ('f95ff566-9715-4f03-bf47-e42af93014d4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-14', NULL, NULL, NULL, '2026-03-26 03:55:53.057623', '2026-03-26 03:55:53.057623', NULL);
INSERT INTO public.daily_logs VALUES ('36d1d578-8748-43d3-8caf-c48d6feb0df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-15', NULL, NULL, NULL, '2026-03-26 03:55:53.069858', '2026-03-26 03:55:53.069858', NULL);
INSERT INTO public.daily_logs VALUES ('180afe42-a924-4540-80a0-7e2f3f08ba73', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-16', NULL, NULL, NULL, '2026-03-26 03:55:53.091744', '2026-03-26 03:55:53.091744', NULL);
INSERT INTO public.daily_logs VALUES ('ab57e926-c9bd-410d-8ad6-865ea8abd893', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-17', NULL, NULL, NULL, '2026-03-26 03:55:53.112858', '2026-03-26 03:55:53.112858', NULL);
INSERT INTO public.daily_logs VALUES ('43017e36-86f8-4e3f-b6c7-e563a4038719', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-18', NULL, NULL, NULL, '2026-03-26 03:55:53.130044', '2026-03-26 03:55:53.130044', NULL);
INSERT INTO public.daily_logs VALUES ('81304708-8ad4-49bf-8498-7f9425c274e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-19', NULL, NULL, NULL, '2026-03-26 03:55:53.152707', '2026-03-26 03:55:53.152707', NULL);
INSERT INTO public.daily_logs VALUES ('87321435-7a90-4eb3-ad26-48aa44b7d0b0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-20', NULL, NULL, NULL, '2026-03-26 03:55:53.179748', '2026-03-26 03:55:53.179748', NULL);
INSERT INTO public.daily_logs VALUES ('5613a8ac-9059-4416-a083-b760cc98723b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-21', NULL, NULL, NULL, '2026-03-26 03:55:53.200127', '2026-03-26 03:55:53.200127', NULL);
INSERT INTO public.daily_logs VALUES ('10d2dc4d-0350-44e9-b04c-6009521827a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-22', NULL, NULL, NULL, '2026-03-26 03:55:53.221725', '2026-03-26 03:55:53.221725', NULL);
INSERT INTO public.daily_logs VALUES ('d3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-23', NULL, NULL, NULL, '2026-03-26 03:55:53.235056', '2026-03-26 03:55:53.235056', NULL);
INSERT INTO public.daily_logs VALUES ('6f3b426d-8a2d-4ec5-bedc-fd283fbfd5f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-24', NULL, NULL, NULL, '2026-03-26 03:55:53.53388', '2026-03-26 03:55:53.53388', NULL);
INSERT INTO public.daily_logs VALUES ('4d34efa3-51b3-4e4a-a633-c5eda4389986', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-25', NULL, NULL, NULL, '2026-03-26 03:55:53.563893', '2026-03-26 03:55:53.563893', NULL);
INSERT INTO public.daily_logs VALUES ('583cc846-b02c-4890-806a-b75e2a7b7af7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-26', NULL, NULL, NULL, '2026-03-26 03:55:53.591491', '2026-03-26 03:55:53.591491', NULL);
INSERT INTO public.daily_logs VALUES ('5e89d6b1-84fb-453e-9ff2-f5aaf81c944b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-27', NULL, NULL, NULL, '2026-03-26 03:55:53.608115', '2026-03-26 03:55:53.608115', NULL);
INSERT INTO public.daily_logs VALUES ('65dde68d-ceda-4acc-a082-b658c696b72e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-28', NULL, NULL, NULL, '2026-03-26 03:55:53.627191', '2026-03-26 03:55:53.627191', NULL);
INSERT INTO public.daily_logs VALUES ('9452f206-ae3d-4e1a-b924-bbc2b58eefca', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-29', NULL, NULL, NULL, '2026-03-26 03:55:53.867485', '2026-03-26 03:55:53.867485', NULL);
INSERT INTO public.daily_logs VALUES ('ca3b0b9a-9e26-4307-839b-4ceb93948f44', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-08-31', NULL, NULL, NULL, '2026-03-26 03:55:53.926164', '2026-03-26 03:55:53.926164', NULL);
INSERT INTO public.daily_logs VALUES ('cf3ae147-8282-4915-ae67-cf06f3afa8c0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-01', NULL, NULL, NULL, '2026-03-26 03:55:53.941077', '2026-03-26 03:55:53.941077', NULL);
INSERT INTO public.daily_logs VALUES ('400add5b-a44b-4598-9ce3-421c257bad95', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-02', NULL, NULL, NULL, '2026-03-26 03:55:53.9636', '2026-03-26 03:55:53.9636', NULL);
INSERT INTO public.daily_logs VALUES ('5b21dca1-9638-4d49-b9f3-4d3b4d84afc0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-03', NULL, NULL, NULL, '2026-03-26 03:55:53.99503', '2026-03-26 03:55:53.99503', NULL);
INSERT INTO public.daily_logs VALUES ('9457a0cb-c608-42b3-a0c6-b35fb0b6be57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-04', NULL, NULL, NULL, '2026-03-26 03:55:54.01087', '2026-03-26 03:55:54.01087', NULL);
INSERT INTO public.daily_logs VALUES ('cfd2e9c9-f8b1-4efa-9425-21df22e696ff', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-05', NULL, NULL, NULL, '2026-03-26 03:55:54.025642', '2026-03-26 03:55:54.025642', NULL);
INSERT INTO public.daily_logs VALUES ('ccb188cf-90bb-46a2-82a8-e7208baede49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-06', NULL, NULL, NULL, '2026-03-26 03:55:54.03705', '2026-03-26 03:55:54.03705', NULL);
INSERT INTO public.daily_logs VALUES ('33cf24d0-2e40-4f2b-8887-c7d1983dc27f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-07', NULL, NULL, NULL, '2026-03-26 03:55:54.051058', '2026-03-26 03:55:54.051058', NULL);
INSERT INTO public.daily_logs VALUES ('42158637-e08e-41ef-acf7-236798ff4d08', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-08', NULL, NULL, NULL, '2026-03-26 03:55:54.063852', '2026-03-26 03:55:54.063852', NULL);
INSERT INTO public.daily_logs VALUES ('36772d97-e558-411c-af12-473f39477614', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-09', NULL, NULL, NULL, '2026-03-26 03:55:54.074551', '2026-03-26 03:55:54.074551', NULL);
INSERT INTO public.daily_logs VALUES ('71680dbd-31ba-4547-a5c0-4ca67e0abcdf', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-10', NULL, NULL, NULL, '2026-03-26 03:55:54.087741', '2026-03-26 03:55:54.087741', NULL);
INSERT INTO public.daily_logs VALUES ('4b93d9f4-c181-4e74-af01-feecf03d73c6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-12', NULL, NULL, NULL, '2026-03-26 03:55:54.094741', '2026-03-26 03:55:54.094741', NULL);
INSERT INTO public.daily_logs VALUES ('e3b08bcb-ad7d-4cde-a65a-f61af4d7e056', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-13', NULL, NULL, NULL, '2026-03-26 03:55:54.110985', '2026-03-26 03:55:54.110985', NULL);
INSERT INTO public.daily_logs VALUES ('c110b0c4-4f24-4da9-b9cb-4ab41c23f6f4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-14', NULL, NULL, NULL, '2026-03-26 03:55:54.128911', '2026-03-26 03:55:54.128911', NULL);
INSERT INTO public.daily_logs VALUES ('6992799e-5242-4325-84e6-6c0ead3f009a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-15', NULL, NULL, NULL, '2026-03-26 03:55:54.143724', '2026-03-26 03:55:54.143724', NULL);
INSERT INTO public.daily_logs VALUES ('a3f992fc-130c-4e02-b610-21f2fc60c673', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-16', NULL, NULL, NULL, '2026-03-26 03:55:54.380448', '2026-03-26 03:55:54.380448', NULL);
INSERT INTO public.daily_logs VALUES ('af683f2f-fbf3-4f60-b27c-e0135cdd2599', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-17', NULL, NULL, NULL, '2026-03-26 03:55:54.408363', '2026-03-26 03:55:54.408363', NULL);
INSERT INTO public.daily_logs VALUES ('de666590-8ab0-431e-9bc9-3fa96c6def56', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-18', NULL, NULL, NULL, '2026-03-26 03:55:54.423287', '2026-03-26 03:55:54.423287', NULL);
INSERT INTO public.daily_logs VALUES ('e08dff51-fdf4-4222-8ad7-8a5d28439bbf', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-19', NULL, NULL, NULL, '2026-03-26 03:55:54.438043', '2026-03-26 03:55:54.438043', NULL);
INSERT INTO public.daily_logs VALUES ('9a782f8f-e745-4361-9912-94d410db0c39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-20', NULL, NULL, NULL, '2026-03-26 03:55:54.458355', '2026-03-26 03:55:54.458355', NULL);
INSERT INTO public.daily_logs VALUES ('0b3c7256-fff1-4777-b740-f8b220201f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-21', NULL, NULL, NULL, '2026-03-26 03:55:54.478244', '2026-03-26 03:55:54.478244', NULL);
INSERT INTO public.daily_logs VALUES ('27bf24ed-2d73-445c-9235-a6b02836be8f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-22', NULL, NULL, NULL, '2026-03-26 03:55:54.498514', '2026-03-26 03:55:54.498514', NULL);
INSERT INTO public.daily_logs VALUES ('1b82dee9-63b0-4c10-b3ee-4d2b88dd6808', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-23', NULL, NULL, NULL, '2026-03-26 03:55:54.515885', '2026-03-26 03:55:54.515885', NULL);
INSERT INTO public.daily_logs VALUES ('ab5a8cec-b237-494a-8206-244ed5382597', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-24', NULL, NULL, NULL, '2026-03-26 03:55:54.539576', '2026-03-26 03:55:54.539576', NULL);
INSERT INTO public.daily_logs VALUES ('4b2181e9-2c5f-40a3-82a0-48aad5bdab4d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-25', NULL, NULL, NULL, '2026-03-26 03:55:54.561191', '2026-03-26 03:55:54.561191', NULL);
INSERT INTO public.daily_logs VALUES ('c18f13f8-6e05-4770-b10b-51f2008c9a55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-26', NULL, NULL, NULL, '2026-03-26 03:55:54.579444', '2026-03-26 03:55:54.579444', NULL);
INSERT INTO public.daily_logs VALUES ('c0e82c80-62b7-4c90-bc29-40a0bf4670cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-27', NULL, NULL, NULL, '2026-03-26 03:55:54.597854', '2026-03-26 03:55:54.597854', NULL);
INSERT INTO public.daily_logs VALUES ('ca72b88c-f211-48cc-b3f9-5c451316bb57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-28', NULL, NULL, NULL, '2026-03-26 03:55:54.620568', '2026-03-26 03:55:54.620568', NULL);
INSERT INTO public.daily_logs VALUES ('ea1749ce-86c9-4a9c-af77-3ec0791e275e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-09-30', NULL, NULL, NULL, '2026-03-26 03:55:54.636022', '2026-03-26 03:55:54.636022', NULL);
INSERT INTO public.daily_logs VALUES ('15e2a6d4-ee90-48a8-89ad-d34bd3fca6db', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-01', NULL, NULL, NULL, '2026-03-26 03:55:54.874543', '2026-03-26 03:55:54.874543', NULL);
INSERT INTO public.daily_logs VALUES ('1dad45bb-22e8-4545-a13e-b39faa90191f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-04', NULL, NULL, NULL, '2026-03-26 03:55:54.931853', '2026-03-26 03:55:54.931853', NULL);
INSERT INTO public.daily_logs VALUES ('1d3b56fe-5747-4dc0-9399-cdb402a652b8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-07', NULL, NULL, NULL, '2026-03-26 03:55:54.949235', '2026-03-26 03:55:54.949235', NULL);
INSERT INTO public.daily_logs VALUES ('72b0e73a-1f86-4162-8420-8d3b7e111830', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-08', NULL, NULL, NULL, '2026-03-26 03:55:54.967674', '2026-03-26 03:55:54.967674', NULL);
INSERT INTO public.daily_logs VALUES ('1cae38a1-6df4-4870-a43b-cbb1cc656f13', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-09', NULL, NULL, NULL, '2026-03-26 03:55:54.978976', '2026-03-26 03:55:54.978976', NULL);
INSERT INTO public.daily_logs VALUES ('ff8c7de5-3c57-4457-abba-4213398d0b88', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-10', NULL, NULL, NULL, '2026-03-26 03:55:55.001665', '2026-03-26 03:55:55.001665', NULL);
INSERT INTO public.daily_logs VALUES ('84c1b9b8-4014-4cb2-ad6d-017587509624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-11', NULL, NULL, NULL, '2026-03-26 03:55:55.02256', '2026-03-26 03:55:55.02256', NULL);
INSERT INTO public.daily_logs VALUES ('97e4ad78-17a8-4ee1-8231-50a23ea1a75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-12', NULL, NULL, NULL, '2026-03-26 03:55:55.035688', '2026-03-26 03:55:55.035688', NULL);
INSERT INTO public.daily_logs VALUES ('e2763731-7b85-4710-a0cc-58ead1bf87d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-13', NULL, NULL, NULL, '2026-03-26 03:55:55.063597', '2026-03-26 03:55:55.063597', NULL);
INSERT INTO public.daily_logs VALUES ('592a6f3d-62cb-4e19-85c4-d60c7c44f859', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-14', NULL, NULL, NULL, '2026-03-26 03:55:55.088864', '2026-03-26 03:55:55.088864', NULL);
INSERT INTO public.daily_logs VALUES ('ca17c7c8-6796-4bb7-8dd4-ca06f796fd50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-15', NULL, NULL, NULL, '2026-03-26 03:55:55.105918', '2026-03-26 03:55:55.105918', NULL);
INSERT INTO public.daily_logs VALUES ('d73e1ea2-3157-4b7f-9e6e-e4ffb7985e43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-16', NULL, NULL, NULL, '2026-03-26 03:55:55.119538', '2026-03-26 03:55:55.119538', NULL);
INSERT INTO public.daily_logs VALUES ('502e4c0a-83cc-4186-b80e-b908bcbcf0c6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-17', NULL, NULL, NULL, '2026-03-26 03:55:55.142285', '2026-03-26 03:55:55.142285', NULL);
INSERT INTO public.daily_logs VALUES ('cd568725-9a09-4948-87e9-ec720b87602b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-18', NULL, NULL, NULL, '2026-03-26 03:55:55.157394', '2026-03-26 03:55:55.157394', NULL);
INSERT INTO public.daily_logs VALUES ('e42f153f-c5e0-4ec1-95cb-8b35f3df76b6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-19', NULL, NULL, NULL, '2026-03-26 03:55:55.404114', '2026-03-26 03:55:55.404114', NULL);
INSERT INTO public.daily_logs VALUES ('53e9761f-1604-4446-a550-bf0db17487d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-20', NULL, NULL, NULL, '2026-03-26 03:55:55.422845', '2026-03-26 03:55:55.422845', NULL);
INSERT INTO public.daily_logs VALUES ('061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-21', NULL, NULL, NULL, '2026-03-26 03:55:55.449048', '2026-03-26 03:55:55.449048', NULL);
INSERT INTO public.daily_logs VALUES ('6a360cb2-1f2a-4ad0-af29-19643c5abed0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-22', NULL, NULL, NULL, '2026-03-26 03:55:55.482496', '2026-03-26 03:55:55.482496', NULL);
INSERT INTO public.daily_logs VALUES ('57775460-5746-4937-9314-939477fe1b4e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-23', NULL, NULL, NULL, '2026-03-26 03:55:55.50409', '2026-03-26 03:55:55.50409', NULL);
INSERT INTO public.daily_logs VALUES ('1f797a43-523a-4776-a829-6420190ff903', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-24', NULL, NULL, NULL, '2026-03-26 03:55:55.526824', '2026-03-26 03:55:55.526824', NULL);
INSERT INTO public.daily_logs VALUES ('539e1876-db5e-4a7c-9ed2-5bbc9b5d1010', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-25', NULL, NULL, NULL, '2026-03-26 03:55:55.541596', '2026-03-26 03:55:55.541596', NULL);
INSERT INTO public.daily_logs VALUES ('cea0ee2c-a983-417d-92b8-05ceb319e2f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-26', NULL, NULL, NULL, '2026-03-26 03:55:55.559077', '2026-03-26 03:55:55.559077', NULL);
INSERT INTO public.daily_logs VALUES ('2e350eef-d7b6-4198-9e24-07fce9ffa1fe', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-27', NULL, NULL, NULL, '2026-03-26 03:55:55.581886', '2026-03-26 03:55:55.581886', NULL);
INSERT INTO public.daily_logs VALUES ('8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-28', NULL, NULL, NULL, '2026-03-26 03:55:55.595768', '2026-03-26 03:55:55.595768', NULL);
INSERT INTO public.daily_logs VALUES ('7d6af30b-936f-4073-8fa6-c7bbfef92c31', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-29', NULL, NULL, NULL, '2026-03-26 03:55:55.632609', '2026-03-26 03:55:55.632609', NULL);
INSERT INTO public.daily_logs VALUES ('6a51ab67-4702-451d-8682-be618c989a05', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-30', NULL, NULL, NULL, '2026-03-26 03:55:55.646426', '2026-03-26 03:55:55.646426', NULL);
INSERT INTO public.daily_logs VALUES ('5078ef4c-6fb4-4d11-8ebe-4efe180d40e6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-10-31', NULL, NULL, NULL, '2026-03-26 03:55:55.890292', '2026-03-26 03:55:55.890292', NULL);
INSERT INTO public.daily_logs VALUES ('3ea35295-c5d0-4bbc-9ebe-3072155cba89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-01', NULL, NULL, NULL, '2026-03-26 03:55:55.906922', '2026-03-26 03:55:55.906922', NULL);
INSERT INTO public.daily_logs VALUES ('1e387471-770c-46a0-9ff1-0e913294a420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-02', '19:00:00', '03:00:00', NULL, '2026-03-26 03:55:55.932412', '2026-03-26 03:55:55.932412', NULL);
INSERT INTO public.daily_logs VALUES ('048f9f2a-6ee7-43be-b57a-5687aa4195a1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-03', '02:00:00', '09:00:00', NULL, '2026-03-26 03:55:55.959841', '2026-03-26 03:55:55.959841', NULL);
INSERT INTO public.daily_logs VALUES ('1544c7f9-004f-4d81-98eb-1d697353976f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-04', NULL, NULL, NULL, '2026-03-26 03:55:55.982639', '2026-03-26 03:55:55.982639', NULL);
INSERT INTO public.daily_logs VALUES ('5194463e-aac7-4a5c-8513-6b56a36d708e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-05', '21:00:00', '06:00:00', NULL, '2026-03-26 03:55:56.012871', '2026-03-26 03:55:56.012871', NULL);
INSERT INTO public.daily_logs VALUES ('bd5a5a61-5b3c-41bf-99bb-ff92d327f6d7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-06', '21:00:00', '06:00:00', NULL, '2026-03-26 03:55:56.028551', '2026-03-26 03:55:56.028551', NULL);
INSERT INTO public.daily_logs VALUES ('d3f8a53a-6e0b-45db-bd34-0a416065110c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-07', NULL, NULL, NULL, '2026-03-26 03:55:56.035555', '2026-03-26 03:55:56.035555', NULL);
INSERT INTO public.daily_logs VALUES ('4433106a-6bd3-422f-b851-2caa371f8a43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-09', '11:00:00', '14:00:00', NULL, '2026-03-26 03:55:56.064986', '2026-03-26 03:55:56.064986', NULL);
INSERT INTO public.daily_logs VALUES ('cbf5a6d2-7eb2-426b-a943-25999fdd22af', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-10', '03:00:00', '07:00:00', NULL, '2026-03-26 03:55:56.083384', '2026-03-26 03:55:56.083384', NULL);
INSERT INTO public.daily_logs VALUES ('5ba3fbd1-563c-4305-9d4a-d2f348f97e19', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-11', '00:00:00', '07:00:00', NULL, '2026-03-26 03:55:56.094109', '2026-03-26 03:55:56.094109', NULL);
INSERT INTO public.daily_logs VALUES ('d442b4c4-3438-4a3d-a3de-58e7a1f926d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-12', NULL, NULL, NULL, '2026-03-26 03:55:56.11405', '2026-03-26 03:55:56.11405', NULL);
INSERT INTO public.daily_logs VALUES ('6b90125a-0f05-40ca-a47e-db70e85ef1b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-13', '00:00:00', '07:00:00', NULL, '2026-03-26 03:55:56.128207', '2026-03-26 03:55:56.128207', NULL);
INSERT INTO public.daily_logs VALUES ('00c8f0b5-6986-445f-a05d-519e1c28a21b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-18', '04:00:00', '07:00:00', NULL, '2026-03-26 03:55:56.136127', '2026-03-26 03:55:56.136127', NULL);
INSERT INTO public.daily_logs VALUES ('965001c7-78f2-4426-8cab-d1f54a23fb50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-19', '03:00:00', '12:00:00', NULL, '2026-03-26 03:55:56.420629', '2026-03-26 03:55:56.420629', NULL);
INSERT INTO public.daily_logs VALUES ('60233948-d5c6-449e-923e-3a470fc787fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-20', '07:00:00', '12:00:00', NULL, '2026-03-26 03:55:56.477049', '2026-03-26 03:55:56.477049', NULL);
INSERT INTO public.daily_logs VALUES ('2b12006b-4694-4e28-8f4d-f2f2f0d6d9f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-21', '05:00:00', '11:00:00', NULL, '2026-03-26 03:55:56.507437', '2026-03-26 03:55:56.507437', NULL);
INSERT INTO public.daily_logs VALUES ('2aacb950-6caa-41ae-b81c-297735aa2c05', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-22', '07:00:00', '15:00:00', NULL, '2026-03-26 03:55:56.531933', '2026-03-26 03:55:56.531933', NULL);
INSERT INTO public.daily_logs VALUES ('192c685a-eecb-4817-9711-3c775e8f9200', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-23', '07:00:00', '16:00:00', NULL, '2026-03-26 03:55:56.545', '2026-03-26 03:55:56.545', NULL);
INSERT INTO public.daily_logs VALUES ('3893cc3c-d9cd-426f-9abc-2a6298924826', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-24', '09:00:00', '13:00:00', NULL, '2026-03-26 03:55:56.561855', '2026-03-26 03:55:56.561855', NULL);
INSERT INTO public.daily_logs VALUES ('3507c784-8d29-48a8-b610-afd5feff9ae4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-25', '11:00:00', '17:00:00', NULL, '2026-03-26 03:55:56.585148', '2026-03-26 03:55:56.585148', NULL);
INSERT INTO public.daily_logs VALUES ('287430ca-cb1b-434d-a17e-93bd1fe478e7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-26', NULL, NULL, NULL, '2026-03-26 03:55:56.617731', '2026-03-26 03:55:56.617731', NULL);
INSERT INTO public.daily_logs VALUES ('5df23281-8c25-4bfe-a010-36294b63e4ac', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-28', NULL, NULL, NULL, '2026-03-26 03:55:56.62433', '2026-03-26 03:55:56.62433', NULL);
INSERT INTO public.daily_logs VALUES ('10ad6bff-02e4-4ab6-a0c6-2efb6eaf2f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-29', NULL, NULL, NULL, '2026-03-26 03:55:56.653592', '2026-03-26 03:55:56.653592', NULL);
INSERT INTO public.daily_logs VALUES ('7dbcef98-6fd3-4c8f-8a20-8a603c2cc710', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-11-30', '12:00:00', '21:00:00', NULL, '2026-03-26 03:55:56.678029', '2026-03-26 03:55:56.678029', NULL);
INSERT INTO public.daily_logs VALUES ('5b7e5767-a02e-4fe8-89f4-c1ed0c371b24', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-01', '15:00:00', '12:00:00', NULL, '2026-03-26 03:55:56.699553', '2026-03-26 03:55:56.699553', NULL);
INSERT INTO public.daily_logs VALUES ('91285e2e-80ce-414b-9b88-0d57995ae9be', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-02', '17:00:00', '01:30:00', NULL, '2026-03-26 03:55:56.722639', '2026-03-26 03:55:56.722639', NULL);
INSERT INTO public.daily_logs VALUES ('f9c59b9a-0d5a-45e2-a5da-204196a024c2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-03', '15:00:00', '01:30:00', NULL, '2026-03-26 03:55:56.75296', '2026-03-26 03:55:56.75296', NULL);
INSERT INTO public.daily_logs VALUES ('28b22a9f-f1ad-45a8-b8bf-6ddd488608d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-04', NULL, NULL, NULL, '2026-03-26 03:55:56.771698', '2026-03-26 03:55:56.771698', NULL);
INSERT INTO public.daily_logs VALUES ('aa0e83ca-fc59-45cf-a695-5e3b25288730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-05', '19:00:00', '01:30:00', NULL, '2026-03-26 03:55:56.799862', '2026-03-26 03:55:56.799862', NULL);
INSERT INTO public.daily_logs VALUES ('590dc50a-9c1c-4058-90b4-37865d2fd9b4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-06', '19:00:00', '01:30:00', NULL, '2026-03-26 03:55:56.819267', '2026-03-26 03:55:56.819267', NULL);
INSERT INTO public.daily_logs VALUES ('fee40146-10df-40f1-bc00-1652a21a1a2c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-07', '02:00:00', '07:00:00', NULL, '2026-03-26 03:55:56.838593', '2026-03-26 03:55:56.838593', NULL);
INSERT INTO public.daily_logs VALUES ('d0c39bbb-71a0-4640-b64d-46d87ec66c57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-08', '22:00:00', '07:00:00', NULL, '2026-03-26 03:55:56.856723', '2026-03-26 03:55:56.856723', NULL);
INSERT INTO public.daily_logs VALUES ('0c7d67a1-430f-4a19-bc75-4ba810ed8d11', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-09', '22:00:00', '07:00:00', NULL, '2026-03-26 03:55:56.885581', '2026-03-26 03:55:56.885581', NULL);
INSERT INTO public.daily_logs VALUES ('fd5e19ad-c385-45c2-9f3f-32b5d85e1b65', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-10', '12:00:00', '08:00:00', NULL, '2026-03-26 03:55:56.916029', '2026-03-26 03:55:56.916029', NULL);
INSERT INTO public.daily_logs VALUES ('b4244dae-554d-4aca-8b14-238194f11ee4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-11', '03:00:00', '06:00:00', NULL, '2026-03-26 03:55:56.944772', '2026-03-26 03:55:56.944772', NULL);
INSERT INTO public.daily_logs VALUES ('4ba3af4e-8906-4bda-8cee-b5c52d4cc1b1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-12', '03:00:00', '06:00:00', NULL, '2026-03-26 03:55:56.960886', '2026-03-26 03:55:56.960886', NULL);
INSERT INTO public.daily_logs VALUES ('749b8e82-2f50-4dbc-b2d1-f7f0561b3652', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-13', NULL, NULL, NULL, '2026-03-26 03:55:56.97377', '2026-03-26 03:55:56.97377', NULL);
INSERT INTO public.daily_logs VALUES ('ab615ef5-0f66-4530-bc4e-e510dd3ded4f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-14', '11:00:00', '08:00:00', NULL, '2026-03-26 03:55:56.984509', '2026-03-26 03:55:56.984509', NULL);
INSERT INTO public.daily_logs VALUES ('7af0b30f-43da-4ca4-a01a-45fa5aba419a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-15', NULL, NULL, NULL, '2026-03-26 03:55:57.00292', '2026-03-26 03:55:57.00292', NULL);
INSERT INTO public.daily_logs VALUES ('2f0d7c41-e05d-45b9-944d-417053d8075e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-16', '05:00:00', '09:00:00', NULL, '2026-03-26 03:55:57.014882', '2026-03-26 03:55:57.014882', NULL);
INSERT INTO public.daily_logs VALUES ('9b088830-0951-4cbc-bdf6-9f78f17f98e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-17', '00:00:00', '06:00:00', NULL, '2026-03-26 03:55:57.040985', '2026-03-26 03:55:57.040985', NULL);
INSERT INTO public.daily_logs VALUES ('8d843cff-66b5-4309-bd75-b76daa4e786d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-18', NULL, NULL, NULL, '2026-03-26 03:55:57.055289', '2026-03-26 03:55:57.055289', NULL);
INSERT INTO public.daily_logs VALUES ('9e616173-818d-460e-9edc-d56a64d557dd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-19', '05:00:00', '12:00:00', NULL, '2026-03-26 03:55:57.074502', '2026-03-26 03:55:57.074502', NULL);
INSERT INTO public.daily_logs VALUES ('67a6625a-f10c-48ed-a3a2-201807a3d5f8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-20', NULL, NULL, NULL, '2026-03-26 03:55:57.095062', '2026-03-26 03:55:57.095062', NULL);
INSERT INTO public.daily_logs VALUES ('a36beb9e-9398-4157-889d-40d0c9c48c2b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-21', '05:00:00', '12:00:00', NULL, '2026-03-26 03:55:57.123195', '2026-03-26 03:55:57.123195', NULL);
INSERT INTO public.daily_logs VALUES ('b68e09d8-7c84-4ef1-b85b-164cef23e75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-22', '03:00:00', '08:00:00', NULL, '2026-03-26 03:55:57.157568', '2026-03-26 03:55:57.157568', NULL);
INSERT INTO public.daily_logs VALUES ('0a026232-e215-43d8-8bda-495dd0bd5e39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-23', '04:00:00', '13:00:00', NULL, '2026-03-26 03:55:57.182041', '2026-03-26 03:55:57.182041', NULL);
INSERT INTO public.daily_logs VALUES ('3e254983-36e7-452a-bf98-2bb5905ad08a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-24', NULL, NULL, NULL, '2026-03-26 03:55:57.193407', '2026-03-26 03:55:57.193407', NULL);
INSERT INTO public.daily_logs VALUES ('d3c76ea5-56a8-4c6b-a4f5-35d49952c239', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-25', '07:00:00', '15:00:00', NULL, '2026-03-26 03:55:57.222585', '2026-03-26 03:55:57.222585', NULL);
INSERT INTO public.daily_logs VALUES ('f90eca83-29d5-49bf-9822-d24725613285', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-26', NULL, NULL, NULL, '2026-03-26 03:55:57.244413', '2026-03-26 03:55:57.244413', NULL);
INSERT INTO public.daily_logs VALUES ('f1cebc74-53d2-4c98-a4c7-26aa457e378e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-27', NULL, NULL, NULL, '2026-03-26 03:55:57.264582', '2026-03-26 03:55:57.264582', NULL);
INSERT INTO public.daily_logs VALUES ('2c4d4ab6-10dd-40a0-92aa-2719b529ba75', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-28', NULL, NULL, NULL, '2026-03-26 03:55:57.27478', '2026-03-26 03:55:57.27478', NULL);
INSERT INTO public.daily_logs VALUES ('0edcf39f-8f53-492a-a465-8024ddb9821b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-29', NULL, NULL, NULL, '2026-03-26 03:55:57.29832', '2026-03-26 03:55:57.29832', NULL);
INSERT INTO public.daily_logs VALUES ('6208b703-af25-4a96-a7bf-ff319b9bd14a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-30', NULL, NULL, NULL, '2026-03-26 03:55:57.325789', '2026-03-26 03:55:57.325789', NULL);
INSERT INTO public.daily_logs VALUES ('46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2025-12-31', NULL, NULL, NULL, '2026-03-26 03:55:57.346231', '2026-03-26 03:55:57.346231', NULL);
INSERT INTO public.daily_logs VALUES ('2049cb7f-852e-4305-b45d-2314ecb852d4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-01', NULL, NULL, NULL, '2026-03-26 03:55:57.381897', '2026-03-26 03:55:57.381897', NULL);
INSERT INTO public.daily_logs VALUES ('c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-02', NULL, NULL, NULL, '2026-03-26 03:55:57.399282', '2026-03-26 03:55:57.399282', NULL);
INSERT INTO public.daily_logs VALUES ('abedbe81-44fb-4e76-ae00-6e7d0b94af55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-03', NULL, NULL, NULL, '2026-03-26 03:55:57.436543', '2026-03-26 03:55:57.436543', NULL);
INSERT INTO public.daily_logs VALUES ('2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-04', NULL, NULL, NULL, '2026-03-26 03:55:57.46212', '2026-03-26 03:55:57.46212', NULL);
INSERT INTO public.daily_logs VALUES ('e1ee0731-071f-464f-97f0-03b71ffc2076', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-05', NULL, NULL, NULL, '2026-03-26 03:55:57.493889', '2026-03-26 03:55:57.493889', NULL);
INSERT INTO public.daily_logs VALUES ('6013c019-5106-4d41-ae51-fc31fc43692e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-06', NULL, NULL, NULL, '2026-03-26 03:55:57.510517', '2026-03-26 03:55:57.510517', NULL);
INSERT INTO public.daily_logs VALUES ('98b155a1-5f8e-41a9-84fa-6f6af4f97723', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-07', NULL, NULL, NULL, '2026-03-26 03:55:57.556485', '2026-03-26 03:55:57.556485', NULL);
INSERT INTO public.daily_logs VALUES ('3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-09', NULL, NULL, NULL, '2026-03-26 03:55:57.570325', '2026-03-26 03:55:57.570325', NULL);
INSERT INTO public.daily_logs VALUES ('f4524712-ef44-4c14-948f-b79067bb3449', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-10', NULL, NULL, NULL, '2026-03-26 03:55:57.602652', '2026-03-26 03:55:57.602652', NULL);
INSERT INTO public.daily_logs VALUES ('1ae2ae88-30d7-4973-8e6c-f5a9496c2b09', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-11', NULL, NULL, NULL, '2026-03-26 03:55:57.614133', '2026-03-26 03:55:57.614133', NULL);
INSERT INTO public.daily_logs VALUES ('b29a9ee8-8fdb-4b66-b78c-9920668fd7c7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-12', NULL, NULL, NULL, '2026-03-26 03:55:57.627153', '2026-03-26 03:55:57.627153', NULL);
INSERT INTO public.daily_logs VALUES ('86675f2f-0b83-4503-b383-f0abf8240594', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-14', NULL, NULL, NULL, '2026-03-26 03:55:57.642273', '2026-03-26 03:55:57.642273', NULL);
INSERT INTO public.daily_logs VALUES ('48d1821e-71ff-4889-93d3-ccf916eeb963', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-15', NULL, NULL, NULL, '2026-03-26 03:55:57.669412', '2026-03-26 03:55:57.669412', NULL);
INSERT INTO public.daily_logs VALUES ('c4017946-ab89-421d-9c58-efbd8ddcf3ef', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-17', NULL, NULL, NULL, '2026-03-26 03:55:57.680705', '2026-03-26 03:55:57.680705', NULL);
INSERT INTO public.daily_logs VALUES ('f0324932-4e1e-4255-994a-248785644839', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-18', NULL, NULL, NULL, '2026-03-26 03:55:57.695712', '2026-03-26 03:55:57.695712', NULL);
INSERT INTO public.daily_logs VALUES ('4db2e8b7-0f38-4804-9e88-e49b9b36a7b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-19', NULL, NULL, NULL, '2026-03-26 03:55:57.711449', '2026-03-26 03:55:57.711449', NULL);
INSERT INTO public.daily_logs VALUES ('0e63aa02-498b-4a4c-a78e-50cf13db586d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-20', '02:00:00', '11:00:00', NULL, '2026-03-26 03:55:57.718199', '2026-03-26 03:55:57.718199', NULL);
INSERT INTO public.daily_logs VALUES ('e9a649ce-6c2f-4aaa-b090-0df0a6207330', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-21', NULL, NULL, NULL, '2026-03-26 03:55:57.739966', '2026-03-26 03:55:57.739966', NULL);
INSERT INTO public.daily_logs VALUES ('8ced5300-2b2f-4945-9a61-8795ee5b5f7f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-22', '03:00:00', '06:00:00', NULL, '2026-03-26 03:55:57.763027', '2026-03-26 03:55:57.763027', NULL);
INSERT INTO public.daily_logs VALUES ('22a6f19a-789d-4e42-b5ca-9dcd3de9338c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-23', '03:00:00', '06:00:00', NULL, '2026-03-26 03:55:57.781332', '2026-03-26 03:55:57.781332', NULL);
INSERT INTO public.daily_logs VALUES ('93e519fd-f642-4f58-b0f7-540c5c225704', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-24', NULL, NULL, NULL, '2026-03-26 03:55:57.797075', '2026-03-26 03:55:57.797075', NULL);
INSERT INTO public.daily_logs VALUES ('65fe41ae-3cbe-4c9e-8312-ca36e4870551', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-25', NULL, NULL, NULL, '2026-03-26 03:55:57.808209', '2026-03-26 03:55:57.808209', NULL);
INSERT INTO public.daily_logs VALUES ('6132f9ec-19db-49da-8236-c91b6770d1d7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-26', '04:00:00', '21:00:00', NULL, '2026-03-26 03:55:57.815127', '2026-03-26 03:55:57.815127', NULL);
INSERT INTO public.daily_logs VALUES ('f92560ee-2a4c-431a-a9c4-76a22ae81a47', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-27', NULL, NULL, NULL, '2026-03-26 03:55:57.827425', '2026-03-26 03:55:57.827425', NULL);
INSERT INTO public.daily_logs VALUES ('1bc8d6de-975f-4c49-a0bf-b65e08f93978', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-28', NULL, NULL, NULL, '2026-03-26 03:55:57.834467', '2026-03-26 03:55:57.834467', NULL);
INSERT INTO public.daily_logs VALUES ('73962dea-abfa-405c-8c46-ab4f32b7eea6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-29', NULL, NULL, NULL, '2026-03-26 03:55:57.842435', '2026-03-26 03:55:57.842435', NULL);
INSERT INTO public.daily_logs VALUES ('cd1b2c4c-5c7f-4862-94f6-cb09a474758d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-01-31', '06:00:00', '14:00:00', NULL, '2026-03-26 03:55:57.853038', '2026-03-26 03:55:57.853038', NULL);
INSERT INTO public.daily_logs VALUES ('d6b46188-2ba7-44d6-bd02-dc8a6b39cdd3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-01', '11:00:00', '18:00:00', NULL, '2026-03-26 03:55:57.871572', '2026-03-26 03:55:57.871572', NULL);
INSERT INTO public.daily_logs VALUES ('cea2e110-588d-4fd0-947e-dad89ea0fab3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-02', '11:00:00', '18:00:00', NULL, '2026-03-26 03:55:57.895789', '2026-03-26 03:55:57.895789', NULL);
INSERT INTO public.daily_logs VALUES ('e57dc2c0-f1be-4f99-b976-360593570609', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-03', '12:00:00', '18:00:00', NULL, '2026-03-26 03:55:57.923594', '2026-03-26 03:55:57.923594', NULL);
INSERT INTO public.daily_logs VALUES ('d01320da-34f3-4b3b-9b7c-fb11d2b3ea89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-04', '01:00:00', '04:00:00', NULL, '2026-03-26 03:55:57.953091', '2026-03-26 03:55:57.953091', NULL);
INSERT INTO public.daily_logs VALUES ('149b65f2-c1f8-47b0-a0b5-030bea48a2d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-05', '02:00:00', '06:00:00', NULL, '2026-03-26 03:55:57.970607', '2026-03-26 03:55:57.970607', NULL);
INSERT INTO public.daily_logs VALUES ('3c8101b0-138e-4e8a-ad4f-7905cda0f5a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-06', '14:00:00', '20:00:00', NULL, '2026-03-26 03:55:57.9829', '2026-03-26 03:55:57.9829', NULL);
INSERT INTO public.daily_logs VALUES ('586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-07', '05:00:00', '07:00:00', NULL, '2026-03-26 03:55:58.000369', '2026-03-26 03:55:58.000369', NULL);
INSERT INTO public.daily_logs VALUES ('1fa4903e-b497-4532-bb62-c1c4ebef0a1f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-08', '02:00:00', '04:00:00', NULL, '2026-03-26 03:55:58.038781', '2026-03-26 03:55:58.038781', NULL);
INSERT INTO public.daily_logs VALUES ('2def90ed-9bce-4a66-bf1d-1b24ba0f3cc9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-09', '22:00:00', '04:00:00', NULL, '2026-03-26 03:55:58.059744', '2026-03-26 03:55:58.059744', NULL);
INSERT INTO public.daily_logs VALUES ('044c8471-4e44-4b50-b96b-780502dbbfbc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-10', '23:00:00', '03:00:00', NULL, '2026-03-26 03:55:58.088453', '2026-03-26 03:55:58.088453', NULL);
INSERT INTO public.daily_logs VALUES ('48ca45e5-2be3-4580-af5a-c75109698ff8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-11', '21:00:00', '05:00:00', NULL, '2026-03-26 03:55:58.107023', '2026-03-26 03:55:58.107023', NULL);
INSERT INTO public.daily_logs VALUES ('066038d6-975d-4263-b4e6-a4061f26e5fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-12', '09:00:00', '14:00:00', NULL, '2026-03-26 03:55:58.124616', '2026-03-26 03:55:58.124616', NULL);
INSERT INTO public.daily_logs VALUES ('15e99cc0-54e4-4017-9471-afaafae19d1a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-13', '03:00:00', '08:00:00', NULL, '2026-03-26 03:55:58.150576', '2026-03-26 03:55:58.150576', NULL);
INSERT INTO public.daily_logs VALUES ('322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-14', '02:00:00', '07:00:00', NULL, '2026-03-26 03:55:58.17436', '2026-03-26 03:55:58.17436', NULL);
INSERT INTO public.daily_logs VALUES ('23c6f1f8-6cee-448e-9f97-4e91ed0f1260', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-15', '01:00:00', '08:00:00', NULL, '2026-03-26 03:55:58.207404', '2026-03-26 03:55:58.207404', NULL);
INSERT INTO public.daily_logs VALUES ('56e42524-ed3d-4f99-be08-3d57ab445818', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-16', '02:00:00', '04:00:00', NULL, '2026-03-26 03:55:58.224003', '2026-03-26 03:55:58.224003', NULL);
INSERT INTO public.daily_logs VALUES ('df96e1a1-baef-4cd9-84bb-449a51a946f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-17', '04:00:00', '12:00:00', NULL, '2026-03-26 03:55:58.254589', '2026-03-26 03:55:58.254589', NULL);
INSERT INTO public.daily_logs VALUES ('1b75ad4a-307d-419e-b534-fd3eb84c1679', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-18', '02:00:00', '11:00:00', NULL, '2026-03-26 03:55:58.281663', '2026-03-26 03:55:58.281663', NULL);
INSERT INTO public.daily_logs VALUES ('abb2f2db-1de6-46cc-896f-3dedf346df8b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-19', '03:00:00', '12:00:00', NULL, '2026-03-26 03:55:58.305208', '2026-03-26 03:55:58.305208', NULL);
INSERT INTO public.daily_logs VALUES ('2a4a390b-2844-4d36-aaf6-b7c162391dd2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-20', '07:00:00', '15:00:00', NULL, '2026-03-26 03:55:58.326251', '2026-03-26 03:55:58.326251', NULL);
INSERT INTO public.daily_logs VALUES ('86770511-173f-475d-a14e-c7f2c81e3805', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-21', '08:00:00', '12:00:00', NULL, '2026-03-26 03:55:58.378953', '2026-03-26 03:55:58.378953', NULL);
INSERT INTO public.daily_logs VALUES ('8f5fa31d-d1fb-496a-bbdc-b8002520bd28', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-22', '09:00:00', '15:00:00', NULL, '2026-03-26 03:55:58.402252', '2026-03-26 03:55:58.402252', NULL);
INSERT INTO public.daily_logs VALUES ('3007c545-c471-4a96-b89c-988d739918f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-23', NULL, NULL, NULL, '2026-03-26 03:55:58.423456', '2026-03-26 03:55:58.423456', NULL);
INSERT INTO public.daily_logs VALUES ('67841421-e143-4129-bee9-521be576dec2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-24', '15:00:00', '20:00:00', NULL, '2026-03-26 03:55:58.433715', '2026-03-26 03:55:58.433715', NULL);
INSERT INTO public.daily_logs VALUES ('f2e5d960-780e-46ba-8bef-749193538756', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-25', '11:00:00', '03:00:00', NULL, '2026-03-26 03:55:58.440936', '2026-03-26 03:55:58.440936', NULL);
INSERT INTO public.daily_logs VALUES ('eb8f709f-583d-49f8-9c4c-0dffaa1bb2d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-26', NULL, NULL, NULL, '2026-03-26 03:55:58.453963', '2026-03-26 03:55:58.453963', NULL);
INSERT INTO public.daily_logs VALUES ('784fb2d0-98f2-4b25-9ac5-24f3ba05e730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-27', NULL, NULL, NULL, '2026-03-26 03:55:58.484503', '2026-03-26 03:55:58.484503', NULL);
INSERT INTO public.daily_logs VALUES ('cecc9260-ed1c-48cf-b0d9-000660e0af0c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-02-28', '11:00:00', '03:00:00', NULL, '2026-03-26 03:55:58.507231', '2026-03-26 03:55:58.507231', NULL);
INSERT INTO public.daily_logs VALUES ('28c03cb0-024e-440f-9d84-840b271e9ba6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-01', NULL, NULL, NULL, '2026-03-26 03:55:58.531603', '2026-03-26 03:55:58.531603', NULL);
INSERT INTO public.daily_logs VALUES ('bd86d308-a807-4fb7-8d72-4e8952d0e9ce', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-02', NULL, NULL, NULL, '2026-03-26 03:55:58.633219', '2026-03-26 03:55:58.633219', NULL);
INSERT INTO public.daily_logs VALUES ('430ecfda-9d06-4790-9332-a5922dc4d4cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-03', '11:00:00', '02:00:00', NULL, '2026-03-26 03:55:58.664647', '2026-03-26 03:55:58.664647', NULL);
INSERT INTO public.daily_logs VALUES ('5e761d3f-9960-4e97-bec1-115cd0d1b208', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-04', '05:00:00', '07:00:00', NULL, '2026-03-26 03:55:58.683804', '2026-03-26 03:55:58.683804', NULL);
INSERT INTO public.daily_logs VALUES ('7691ba85-74b8-4c26-b284-8308f6dce6b1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-05', '00:00:00', '10:00:00', NULL, '2026-03-26 03:55:58.709976', '2026-03-26 03:55:58.709976', NULL);
INSERT INTO public.daily_logs VALUES ('b69e1fe3-d701-4149-aed5-fecd059124f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-06', '11:00:00', '03:00:00', NULL, '2026-03-26 03:55:58.726424', '2026-03-26 03:55:58.726424', NULL);
INSERT INTO public.daily_logs VALUES ('dc93b185-ac4b-4a93-90ff-51d4e061c578', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-07', '00:30:00', '04:00:00', NULL, '2026-03-26 03:55:58.75102', '2026-03-26 03:55:58.75102', NULL);
INSERT INTO public.daily_logs VALUES ('9d2dc3a8-d7ad-4c44-89e8-3e7eb4939bdd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-08', '05:30:00', '10:00:00', NULL, '2026-03-26 03:55:58.777287', '2026-03-26 03:55:58.777287', NULL);
INSERT INTO public.daily_logs VALUES ('230e91ae-d297-4304-899f-d7a527773b02', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-09', '07:00:00', '01:00:00', NULL, '2026-03-26 03:55:58.800769', '2026-03-26 03:55:58.800769', NULL);
INSERT INTO public.daily_logs VALUES ('5c3d6ec4-83d8-4212-b5e3-223b8a953416', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-10', '10:00:00', '16:00:00', NULL, '2026-03-26 03:55:59.372021', '2026-03-26 03:55:59.372021', NULL);
INSERT INTO public.daily_logs VALUES ('a184a27b-0de7-45f9-b4a7-f966fd310e31', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-12', '06:00:00', '09:00:00', NULL, '2026-03-26 03:55:59.442941', '2026-03-26 03:55:59.442941', NULL);
INSERT INTO public.daily_logs VALUES ('9bee413a-661c-4b3c-a938-9d82fa247dc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-13', '08:00:00', '10:00:00', NULL, '2026-03-26 03:55:59.460581', '2026-03-26 03:55:59.460581', NULL);
INSERT INTO public.daily_logs VALUES ('39299f98-4ee5-4fcb-b4e2-a59dd1542c51', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-14', '08:00:00', '10:00:00', NULL, '2026-03-26 03:55:59.484202', '2026-03-26 03:55:59.484202', NULL);
INSERT INTO public.daily_logs VALUES ('14e32472-4188-4e2f-a416-2171bc1d8624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-15', '07:00:00', '15:00:00', NULL, '2026-03-26 03:55:59.501426', '2026-03-26 03:55:59.501426', NULL);
INSERT INTO public.daily_logs VALUES ('ba0301c0-7170-4364-8d27-4714caebe2f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-16', '07:00:00', '10:00:00', NULL, '2026-03-26 03:55:59.531261', '2026-03-26 03:55:59.531261', NULL);
INSERT INTO public.daily_logs VALUES ('9fd52797-2317-467a-81ba-c26aaf7ad7d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-17', '07:00:00', '14:30:00', NULL, '2026-03-26 03:55:59.557451', '2026-03-26 03:55:59.557451', NULL);
INSERT INTO public.daily_logs VALUES ('4c367d5e-3bf2-423c-9274-01a110cca9bd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-18', '08:30:00', '16:00:00', NULL, '2026-03-26 03:55:59.58275', '2026-03-26 03:55:59.58275', NULL);
INSERT INTO public.daily_logs VALUES ('f85a544d-b5fa-4d7e-9048-cbe9c4db4d90', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-19', '07:00:00', '15:00:00', NULL, '2026-03-26 03:55:59.596672', '2026-03-26 03:55:59.596672', NULL);
INSERT INTO public.daily_logs VALUES ('520e08ab-bde0-4de9-92d5-2b8f4a2f01da', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-20', '08:00:00', '16:00:00', NULL, '2026-03-26 03:55:59.616036', '2026-03-26 03:55:59.616036', NULL);
INSERT INTO public.daily_logs VALUES ('9c482643-90e6-4822-a581-e2b4b935e4de', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-21', '09:00:00', '15:00:00', NULL, '2026-03-26 03:55:59.630783', '2026-03-26 03:55:59.630783', NULL);
INSERT INTO public.daily_logs VALUES ('70b328fa-e10c-4554-bbf2-3e078343891d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-23', '13:00:00', '18:00:00', NULL, '2026-03-26 03:55:59.644806', '2026-03-26 03:55:59.644806', NULL);
INSERT INTO public.daily_logs VALUES ('9119fb7e-c437-4eae-9bbd-32f5f1a5a36d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-24', '11:00:00', '16:00:00', NULL, '2026-03-26 03:55:59.657848', '2026-03-26 03:55:59.657848', NULL);
INSERT INTO public.daily_logs VALUES ('2e08f5f3-68cf-482d-8be4-cd60840d5528', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-25', NULL, NULL, NULL, '2026-03-26 03:55:59.681495', '2026-03-26 03:55:59.681495', NULL);
INSERT INTO public.daily_logs VALUES ('26b39b4f-aa3b-4979-a3b0-3f3e944e6bb8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-28', NULL, NULL, NULL, '2026-03-28 05:25:34.884582', '2026-03-28 17:53:08.122', 6);
INSERT INTO public.daily_logs VALUES ('3a0bb8a9-3377-465e-bfa5-fca3501d27ed', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-29', NULL, NULL, NULL, '2026-03-29 00:50:51.401145', '2026-03-29 00:50:51.401145', NULL);
INSERT INTO public.daily_logs VALUES ('a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-26', NULL, NULL, NULL, '2026-03-26 03:14:45.10664', '2026-03-26 13:04:21.565', 1);
INSERT INTO public.daily_logs VALUES ('be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-27', NULL, NULL, NULL, '2026-03-27 00:11:30.425469', '2026-03-27 17:49:35.517', 9);
INSERT INTO public.daily_logs VALUES ('23988d37-e233-4b4e-ba4f-6e29961c4aba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-30', NULL, NULL, NULL, '2026-03-30 02:31:26.109033', '2026-03-30 22:04:44.165', 7);
INSERT INTO public.daily_logs VALUES ('0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-03-31', NULL, NULL, NULL, '2026-03-31 02:57:15.180738', '2026-03-31 22:21:14.672', 7);
INSERT INTO public.daily_logs VALUES ('b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-04-01', NULL, NULL, NULL, '2026-03-31 03:04:52.401513', '2026-04-02 01:03:32.01', 8);
INSERT INTO public.daily_logs VALUES ('7f4d95bd-e182-41d3-b2c9-d2e2cf9d3b68', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-04-04', NULL, NULL, NULL, '2026-04-04 14:22:01.500487', '2026-04-04 14:22:01.500487', NULL);
INSERT INTO public.daily_logs VALUES ('398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-04-02', NULL, NULL, NULL, '2026-04-02 05:59:16.102348', '2026-04-03 01:46:03.377', 4);
INSERT INTO public.daily_logs VALUES ('8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '2026-04-03', NULL, NULL, NULL, '2026-04-03 06:43:33.451183', '2026-04-04 09:30:59.149', 8);


--
-- Data for Name: imports; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.imports VALUES ('6b49c675-7436-4bbf-8b9c-74c06e7d699b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'T D L - TD.csv', 2345, 0, 0, 'pending', NULL, '2026-03-26 02:54:33.198169', NULL);
INSERT INTO public.imports VALUES ('5e8418b5-2c29-439f-a3bd-9cbed184ffec', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'T D L - TD.csv', 2345, 0, 0, 'pending', NULL, '2026-03-26 03:33:03.156174', 'June,Task Name,Priority,Category,Timing,Notes,Break,Daily Brain Dump,,,Medium Priority (⭐️⭐️) ,,,High Priority (⭐️⭐️⭐️),,,,,,
Monday,Scheduling Exam,⭐️⭐️⭐️,Education,11:30 PM - 11:42 PM,,3:30 AM - 4:10,Scheduling Exam,,,Should do today if time allows,,,  Must do today (max 3 items),,,,,,
,Discrete Notes & Quiz Preparation,⭐️⭐️⭐️,Education,4:10 AM - 6:20 AM,,6:20 AM - 4:10 AM,Discrete Notes Preparation,,,,,,,,,,,,
,Steve Work,⭐️⭐️,Work,1:30 AM - 2:10 AM,Delegated to areeba,,Steve Work,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,"12:00 AM - 1:30 AM, 2:30 AM - 3:10 AM",,,Upwork Jobs Applying,,,,,,,,,,,,
missed,Book Reading,⭐️,Personal,,30 pages,,Book Reading,,,,,,,,,,,,
missed,Python Tutorial,⭐️,Learning,,,,Exercise,,,,,,,,,,,,
missed,Recording a Loom Video,⭐️,Work,,,,Python Tutorial,,,,,,,,,,,,
missed,Finding ways to optimize upwork profile,⭐️,Work,,,,Recording a Loom Video,,,,,,,,,,,,
Thursday,,,,,,,Finding ways to optimize upwork profile,,,,,,,,,,,,
,Attendence check,⭐️⭐️⭐️,Education,4:30AM - 5:05AM,,Uni 6:55 AM - 11:30 AM,18/06/2025,,,,,,,,,,,,
,nazra,⭐️⭐️⭐️,Education,5:05AM - 5:30AM,,,Attendence check,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,05:35AM - 06:55AM,,,nazra,,,,,,,,,,,,
missed,exams preparation date set,⭐️⭐️,Education,,,,Upwork Jobs Applying,,,,,,,,,,,,
missed,Book Reading,⭐️⭐️,Personal,,,,exams preparation date set,,,,,,,,,,,,
missed,Python Tutorial,⭐️⭐️,Learning,,,,Book Reading,,,,,,,,,,,,
,,,,,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,Upwork Interview Prep,,,,,,,,,,,,
Friday,,,,,,,,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️⭐️,Education,"4:30AM - 5:05AM, 7:30PM - 8:30PM, 8:50PM - 10:30PM",,Uni 6:00 AM - 11:30AM,20/06/2025,,,,,,,,,,,,
,Interview,⭐️⭐️⭐️,Work,8:30PM - 8:40PM,,Sleep 1:00PM - 4:00PM,Assignments check,,,,,,,,,,,,
,OLX ad,⭐️⭐️,Personal,10:40PM - 11:35PM,,,Upwork Jobs Applying,,,,,,,,,,,,
,Assignments check,⭐️⭐️⭐️,Education,11:35PM - 12:20AM,,,Upwork Interview Prep,,,,,,,,,,,,
Saturday,,,,,,,,,,,,,,,,,,,
,Exams preparation date set,⭐️⭐️⭐️,Education,12:20AM - 12:42AM,,,OLX ad,,,,,,,,,,,,
,Upwork SOP Setting,⭐️⭐️,Work,01:00AM - 2:40AM,,,,,,,,,,,,,,,
,Meeting with Moiz,⭐️⭐️,Work,1 Hour,,40 mints in misc,21/06/2025,,,,,,,,,,,,
,Book Reading,⭐️⭐️,Personal,"04:00AM - 6:00AM, 07:45AM - 9:45AM",,Bike Maintainance - 9:35AM,Exams preparation date set,,,,,,,,,,,,
,Habits Scorecard,⭐️⭐️,Personal,06:10AM - 07:45AM,,,,,,,,,,,,,,,
,Python Tutorial,⭐️⭐️,Learning,,,,Book Reading,,,,,,,,,,,,
,Bike Maintainance,⭐️⭐️⭐️,Personal,9:35AM - 1:20PM,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,"9:30PM Wake up, 3:00AM - 6:00AM",22/06/2025,,,,,,,,,,,,
,,,,11:30PM Dinner,,,Assignments,,,,,,,,,,,,
,Misc,⭐️,,1:15AM - 2:25AM,,,Quizes Preparation,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,,"11:30PM - 1:15AM, 6:50AM - 7:50AM",,,Upwork Jobs Applying,,,,,,,,,,,,
,Assignments Completion,⭐️⭐️⭐️,,"07:55AM - 10:10AM, 11:45AM",,Breakfast Break,Exercise,,,,,,,,,,,,
,Bike Sold,⭐️⭐️⭐️,,11:45AM - 2:15AM,,,Python Tutorial,,,,,,,,,,,,
,,,,,,Youtube Break - 02:45PM,World History - Quiz 2,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,Business Soft Skills Learning,23/06/2025,,,,,,,,,,,,
,World History - Quiz 2,⭐️⭐️⭐️,,08:00PM  - ,,Sleep 10:00PM - 4:30AM,,,,,,,,,,,,,
Monday,,,,,,4:30AM Wake up,,,,,,,,,,,,,
,Exercise,⭐️⭐️,,5:00AM - 5:30AM,,Uni 6:00 AM - 11:30AM,,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,,05:30AM -,,Youtube Break 12:10PM- 02:00PM,,,,,,,,,,,,,
,,,,,,03:00PM - Sleep,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,24/06/2025,,,,,,,,,,,,
Tuesday,,,,,13 Hours Sleep,5:30AM Wake up,Assignment Completion,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,,10:30AM -,,Breakfast 7:15AM- 7:45AM,Upwork Jobs Applying,,,,,,,,,,,,
,OS Assignment Completion,⭐️⭐️⭐️,,07:45AM - 8:30AM,,Uni Break 8:30AM - 6:00PM,Quizes Preparation,,,,,,,,,,,,
,Misc,⭐️,,1:15AM - 2:25AM,,"Youtube, TV show - 6:00PM - 11:00PM",Exercise,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,10:00PM - Sleep,25/06/2025,,,,,,,,,,,,
Wednesday,,,,,,4:30AM Wake up,,,,,,,,,,,,,
,Misc,⭐️,Entertainment,4:30AM - 6:30AM Overthinking,,,Upwork Jobs Applying,,,,,,,,,,,,
,,,,,,Breakfast 7:15AM- 7:45AM,Quiz Preparation,,,,,,,,,,,,
,University,⭐️⭐️⭐️,Education,8:00 AM - 02:30PM,,,Exercise,,,,,,,,,,,,
,Misc,⭐️,Entertainment,03:30PM - 05:30PM Youtube,,,Book Reading,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,05:30AM - 08:05PM,,Dinner 8:10PM,Soft Business Skills,,,,,,,,,,,,
,Misc,⭐️,Entertainment,8:30PM - 10:00PM Youtube,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,10:00PM - Sleep,,,,,,,,,,,,,
Thursday,,,,,,5:30AM Wake up,26/06/2025,,,,,,,,,,,,
,Notifications Check,⭐️⭐️⭐️,Work,7:00AM - 7:30AM,,Breakfast 7:30AM - ,Upwork Jobs Applying,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,07:50AM - 09:30PM,,,Receiving Naseeb,,,,,,,,,,,,
,Curriculum Check,⭐️⭐️,Education,09:30AM - 10:00PM,,,Quiz Preparation,,,,,,,,,,,,
,Soft Business Skills,⭐️⭐️,Work,10:00PM - 12:30PM,,Launch 1:00AM - 01:30AM ,Exercise,,,,,,,,,,,,
,Receiving Naseeb,⭐️⭐️⭐️,Personal,8:00AM - 8:30AM,,Uni 02:30 PM - 07:30PM,Book Reading,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,02:00AM - 3:15AM,,,Soft Business Skills,,,,,,,,,,,,
,Quiz Preparation,⭐️⭐️,Education,02:00AM - 3:15AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,03:00AM - Sleep,,,,,,,,,,,,,
Friday,,,,,,5:30AM Wake up,27/06/2025,,,,,,,,,,,,
,University,⭐️⭐️⭐️,Work,7:00AM - 11:30AM,,Breakfast 7:30AM - ,Upwork Jobs Applying,,,,,,,,,,,,
,Naseeb Academy,⭐️⭐️⭐️,Personal,11:30AM - 02:00PM,,,Quiz Preparation,,,,,,,,,,,,
,Outing ,⭐️⭐️,Personal,8:30PM - 12:00PM,,,Exercise,,,,,,,,,,,,
,,,,,,,Book Reading,,,,,,,,,,,,
,,,,,,,Soft Business Skills,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,01:00AM - Sleep,,,,,,,,,,,,,
Saturday,,,,,,08:00AM Wake up,28/06/2025,,,,,,,,,,,,
,Exams preparation date set & evaluation,⭐️⭐️⭐️,Education,9:00AM - 11:00AM,,Breakfast 11:10AM - ,Upwork Jobs Applying,,,,,,,,,,,,
,,⭐️⭐️⭐️,Personal,11:30AM - 02:00PM,,,Exams preparation date set,,,,,,,,,,,,
,,⭐️⭐️,Personal,8:30PM - 12:00PM,,,Exercise,,,,,,,,,,,,
,,,,,,,Expense Check,,,,,,,,,,,,
,,,,,,,CBT transfer,,,,,,,,,,,,
,,,,,,,Book Reading,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,12:00PM - Sleep,,,,,,,,,,,,,
Sunday,,,,,,08:00AM Wake up,29/06/2025,,,,,,,,,,,,
,Breakfast,⭐️⭐️⭐️,Personal,9:00AM - 11:00AM,,Breakfast 11:10AM - ,,,,,,,,,,,,,
,Sunday Bazaar,⭐️⭐️,Personal,11:30AM - 02:00PM,,,,,,,,,,,,,,,
,Sleep,⭐️⭐️,Personal,2:30PM - 6:00PM,,,,,,,,,,,,,,,
,Faisal Mosque,⭐️⭐️,Personal,6:30PM - 12:00PM,,,,,,,,,,,,,,,
,Sleep,⭐️⭐️,Personal,01:30AM - 05:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,05:00AM Wake up,30/06/2025,,,,,,,,,,,,
,Misc,⭐️,Personal,5:00AM - 06:00AM,,,Monthly Expense Calculation,,,,,,,,,,,,
,University,⭐️⭐️⭐️,Education,06:00AM - 12:00PM,,,Exam Schedule set,,,,,,,,,,,,
,Breakfast,⭐️⭐️,Personal,12:00PM - 01:00PM,,,Exam Preparation,,,,,,,,,,,,
,Monthly Expense Calculation,⭐️⭐️⭐️,Personal,01:30PM - 04:00PM,,,Upwork Jobs Applying,,,,,,,,,,,,
,Exam Schedule set,⭐️⭐️⭐️,Education,04:00PM - 04:40PM,,,Multi Calculas Assignment,,,,,,,,,,,,
,Multi Calculas Assignment,⭐️⭐️⭐️,Education,05:00PM - 06:00PM,,Dinner Break 06:10PM - 8:10PM,Exercise,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,09:00PM - 10:15PM,,,Book Reading,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,10:00PM - Sleep,,,,,,,,,,,,,
Tuesday,,,,,,08:00AM Wake up,01/07/2025,,,,,,,,,,,,
,Sleep,⭐️,Personal,08:30AM - 11:30AM,,,Upwork Jobs Applying,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️⭐️,Work,"12:30PM - 3:50PM,  04:30PM - 5:15PM, 09:30PM - 10:30PM",,Launch Break 1:40PM - 02:12PM,Exam Preparation Discrete,,,,,,,,,,,,
,Exam Preparation Discrete,⭐️⭐️⭐️,Education,5:15PM - ,,Dinner Break 8:20PM - 09:00PM,Exercise,,,,,,,,,,,,
,Upwork Interview,⭐️⭐️⭐️,Work,07:30PM - 07:50PM,,Hired,Book Reading,,,,,,,,,,,,
,Framer Project Despii,⭐️⭐️⭐️,Work,"10:30PM - 11:30PM, 11:50PM -",,,07:30PM - Upwork Interview,,,,,,,,,,,,
,Meeting with Moiz,⭐️⭐️⭐️,Work,11:30PM - 11:50PM,,,Framer Project Despii,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,05:00AM - Sleep,,,,,,,,,,,,,
Wednesday,,,,,,09:00AM Wake up,02/07/2025,,,,,,,,,,,,
,Misc,⭐️,Personal,09:00AM - 01:30PM,,Launch Break 1:30PM - 02:00PM,Framer Project Despii,,,,,,,,,,,,
,Framer Project Metaops,⭐️⭐️⭐️,Work,02:00PM - 02:30PM,,,Framer Project Metaops,,,,,,,,,,,,
,Framer Project Despii,⭐️⭐️⭐️,Work,"02:30PM - 04:40PM, 5:30PM - 7:40PM, 8:20PM - 10:00PM, 12:00AM - 12:35PM",,,Upwork Jobs Applying,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,"04:50PM - 5:30PM, 07:00PM - 07:10PM, 12:35PM - 02:05PM",,Break 7:40PM - ,Exam Preparation Discrete,,,,,,,,,,,,
,,,,,,,Exercise,,,,,,,,,,,,
,,,,,,,Book Reading,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,"04:00AM - 9:00AM, 11:00AM - 12:00PM Sleep",03/07/2025,,,,,,,,,,,,
,Team Managment,⭐️⭐️⭐️,Work,02:05AM - 03:32AM,,Launch Break 1:30PM - 02:00PM,Upwork Jobs Applying,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,"02:05PM - 04:00PM, 10:00PM - 11:00PM",,,Framer Project Despii,,,,,,,,,,,,
,Exam Preparation Discrete,⭐️⭐️⭐️,Education,04:00PM - 07:30PM,,,Framer Project Metaops,,,,,,,,,,,,
,Framer Project Despii,⭐️⭐️⭐️,Education,"07:30PM - 08:30PM, 12:30PM - 01:30PM ",,,Exam Preparation Discrete,,,,,,,,,,,,
,Outing,⭐️,Education,10:30PM - 12:30PM,,,Exercise,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,"06:00AM - 12:00PM, Sleep",04/07/2025,,,,,,,,,,,,
,Study + Project,⭐️⭐️⭐️,Work,01:05AM - 05:32AM,,Launch Break 1:30PM - 02:00PM,Upwork Jobs Applying,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,12:00PM - 01:30PM,,,Framer Project Despii,,,,,,,,,,,,
,Framer Project bg assets,⭐️⭐️⭐️,Work,"01:30PM - 08:00PM, 11:00PM - 3:00PM",,Dinner Break 08:10PM - 09:20PM,Framer Project bg assets,,,,,,,,,,,,
,,,,,,,Exam Preparation Discrete,,,,,,,,,,,,
,,,,,,,Exercise,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,,05/07/2025,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️⭐️,Work,3:00PM - 6:00PM,,,Exam Preparation Discrete,,,,,,,,,,,,
,Framer Project bg assets,⭐️⭐️⭐️,Work,6:00PM - 7:00PM,,,Exercise,,,,,,,,,,,,
,Outing,⭐️,Personal,7:00PM - 12:00PM,,,Upwork Jobs Applying,,,,,,,,,,,,
,,,,,,,Framer Project Metaops,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,"07:00AM - 01:30PM, Sleep",06/07/2025,,,,,,,,,,,,
,Framer Project bg assets,⭐️⭐️⭐️,Work,12:00AM - 2:30AM,,,Exam Preparation Discrete,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️⭐️,Work,2:30AM - 3:15AM,,,Exercise,,,,,,,,,,,,
,Framer Project bg assets,⭐️⭐️⭐️,Work,2:30AM - 5:00AM,,,Upwork Jobs Applying,,,,,,,,,,,,
,Framer Project Metaops,⭐️⭐️⭐️,Work,3:30AM - 4:00PM,,,Framer Project Metaops,,,,,,,,,,,,
,Framer Project bg assets,⭐️⭐️⭐️,Work,4:00PM - 8:00PM,,Dinner Break & Walk 8:00PM - 9:30PM,,,,,,,,,,,,,
,Upwork Jobs Applying & Meeting,⭐️⭐️⭐️,Work, 9:30PM - 10:10PM,,,,,,,,,,,,,,,
,Exam Preparation Discrete,⭐️⭐️⭐️,Work, 10:10PM - 01:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,"08:00AM - 12:30PM, 02:00 - 06:00PM Sleep",07/07/2025,,,,,,,,,,,,
,Framer Project bg assets,⭐️⭐️⭐️,Work,01:00AM - 03:00AM,, ,Upwork Jobs Applying,,,,,,,,,,,,
,Exam Preparation Discrete,⭐️⭐️⭐️,Education,03:00AM - 07:00AM,,,Team Management,,,,,,,,,,,,
,Launch & Outing,⭐️⭐️,Personal,8:30PM - 10:20PM,,,,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,10:30PM - 12:20AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,10:00AM - 03:00PM Sleep,08/07/2025,,,,,,,,,,,,
,Team Management,⭐️⭐️⭐️,Work,12:20AM - 02:40AM,,,,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,4:15AM - 4:30AM,,,Exam Preparation Discrete,,,,,,,,,,,,
,Exercise,⭐️⭐️⭐️,Personal,02:40AM - 4:15AM,,,Book Reading,,,,,,,,,,,,
,Book Reading,⭐️⭐️,Personal,"5:05AM - 07:00AM, 07:30AM - 09:30AM",,Breakfast 07:00AM - 07:30AM,Print Admit Card,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,4:15AM - 4:30AM,,,Team Management,,,,,,,,,,,,
,Team Management,⭐️⭐️,Work,4:30AM - 05:00AM,,,Upwork Jobs Applying,,,,,,,,,,,,
,Misc,⭐️,Personal,03:30PM - 07:00PM,,,Framer Project bg assets,,,,,,,,,,,,
,Hair Cut,⭐️,Personal,07:00PM - 09:00,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,09:00PM - 01:00AM Sleep,09/07/2025,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,"3:00AM - 4:00AM. 5:00AM - 6:00AM, 5:00PM - 07:00PM",,,Exam Preparation Discrete,,,,,,,,,,,,
,Framer Project bg assets,⭐️⭐️⭐️,Work,4:00AM - 5:00AM,,,Print Admit Card,,,,,,,,,,,,
,Discrete Exam,⭐️⭐️⭐️,Education,1:00PM - 4:30PM,,,,,,,,,,,,,,,
,Commercial Shopping,⭐️,Personal,07:00PM - 11:30PM,,,Upwork Jobs Applying,,,,,,,,,,,,
,,,,,,,Framer Project bg assets,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,,10/07/2025,,,,,,,,,,,,
,,,,,,"07:00AM - 10:00AM, 08:00PM - 11:00PM Sleep",,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,12:00AM - 02:30AM,,,Exam Preparation Sociology,,,,,,,,,,,,
,Exam Preparation Sociology,⭐️⭐️⭐️,Education,"02:30AM - 8:00AM, 12:00PM - 01:00PM",,,Upwork Interview 3:30AM,,,,,,,,,,,,
,Sociology Exam,⭐️⭐️⭐️,Education,1:00PM - 6:00PM,,Dinner 07:00AM - 08:00PM,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,"11:00AM - 07:00PM, Sleep",11/07/2025,,,,,,,,,,,,
,Mics,⭐️⭐️,Work,"11:00AM - 01:00AM, 11:00PM - 01:00AM ",,,Exam Preparation Calculas,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,"01:00AM - 4:00AM, 8:30PM - 09:30PM",,,Exam Preparation World History,,,,,,,,,,,,
,Exam Preparation World History,⭐️⭐️⭐️,Education,4:00AM - 6:00AM,,,Upwork Jobs Applying,,,,,,,,,,,,
,Trading Hunter Framer Project,⭐️⭐️⭐️,Work,7:10AM - 10:10AM,,Dinner 07:40PM - 08:30PM,PDF Money Project,,,,,,,,,,,,
,Markez,⭐️⭐️,Personal,09:30PM - 11:00PM,,,Trading Hunter Framer Project,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,"08:30AM - 03:30PM, Sleep",12/07/2025,,,,,,,,,,,,
,Mics,⭐️⭐️,Work, 11:00PM - 01:00AM ,,,Exam Preparation World History,,,,,,,,,,,,
,Excecise,⭐️⭐️,Personal,01:00AM - 2:30AM,,,Exam Preparation Calculas,,,,,,,,,,,,
,Exam Preparation World History,⭐️⭐️⭐️,Education,2:50AM - 7:30AM,,,Upwork Jobs Applying,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Education,4:30PM - 6:10PM,,,PDF Money Project,,,,,,,,,,,,
,Framer Project bg assets,⭐️⭐️⭐️,Work,6:10PM - 7:10PM,,,,,,,,,,,,,,,
,Exam Preparation World History,⭐️⭐️⭐️,Work,"7:10PM - 8:00PM, 9:20PM - 12:00PM",,Dinner Break 8:00PM - 9:00PM,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,,13/07/2025,,,,,,,,,,,,
,Mics,⭐️⭐️,Work,12:00AM - 01:00AM,,09:00AM - 06:00PM Sleep,Exam Preparation World History,,,,,,,,,,,,
,Exam Preparation World History,⭐️⭐️⭐️,Education,"01:10AM - 01:40AM, 04:00AM - 6:00AM",,,Exam Preparation Calculas,,,,,,,,,,,,
,Chai & Walking Break,⭐️⭐️,Personal,01:40AM - 3:00AM,,,Proposal About Update,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,"03:00AM - 04:00AM, 10:00PM - 11:00PM",,,PDF Money Project,,,,,,,,,,,,
,Mics,⭐️⭐️,Entertainment,06:00:00 AM - 09:00AM,,Dinner Break 7:30PM - 9:00PM,,,,,,,,,,,,,
,PDF Money Project,⭐️⭐️⭐️,Work,11:00PM - 12:30AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,,14/07/2025,,,,,,,,,,,,
,Mics,⭐️⭐️,Work,12:00AM - 01:00AM,,03:00PM - 08:00PM,Exam Preparation World History,,,,,,,,,,,,
,Exam Preparation World History,⭐️⭐️⭐️,Education,"01:10AM - 02:40AM, 4:30AM - 5:20AM, 9:00AM - 10:00AM",,,PDF Money Project,,,,,,,,,,,,
,Excercise,⭐️⭐️,Personal,02:40AM - 3:30AM,,,Exam Preparation Calculas,,,,,,,,,,,,
,Youtube,⭐️,Entertainment,03:30AM - 04:00AM,,,Proposal About Update,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,04:00AM - 4:30AM,,,,,,,,,,,,,,,
,Exam World History,⭐️⭐️⭐️,Education,10:00AM - 3:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,,15/07/2025,,,,,,,,,,,,
,Upwork Jobs Applying,⭐️⭐️,Work,02:40AM - 04:00AM,,09:30PM - 1:30AM Sleep,Exam Preparation Calculas,,,,,,,,,,,,
,Exam Preparation Calculas,⭐️⭐️⭐️,Education,04:00PM - 9:00PM,,Break 9:00PM - 11:00PM,Excecise,,,,,,,,,,,,
,,,,,,,Hunter Trading Project,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,,16/07/2025,,,,,,,,,,,,
,Exam Preparation Calculas,⭐️⭐️⭐️,Education,"11:00PM - 4:30AM, 9:30AM - 01:00PM",,,,,,,,,,,,,,,
,Exam Calculas,⭐️⭐️⭐️,Education,01:00PM - 6:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thurday,,,,,,03:30PM - 09:30PM Sleep,17/07/2025,,,,,,,,,,,,
,Mics,⭐️⭐️,Work,07:00PM - 03:00AM,,,,,,,,,,,,,,,
,Exam Preparation Communication,,Work,03:00AM - 07:30AM,,,,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,08:00PM - 03:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,04:00PM - 11:00PM Sleep,18/07/2025,,,,,,,,,,,,
,Exam Preparation OS,⭐️⭐️⭐️,Education,02:00AM - 07:300AM,,Break 8:00AM,,,,,,,,,,,,,
,Exam OS,⭐️⭐️⭐️,Education,10:00AM - 01:00PM,,,,,,,,,,,,,,,
,Gaming Zone,⭐️,Entertainment,10:00AM - 01:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,04:00PM - 01:00AM Sleep,19/07/2025,,,,,,,,,,,,
,Markez,⭐️,Education,01:00AM - 02:00AM,,,2-Month Semester Forethought ,,,,,,,,,,,,
,2-Month Semester Forethought ,⭐️⭐️⭐️,Personal,03:00AM - 05:40AM,,,Python Tutorial,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,05:40AM - 08:00AM,,,Book Atomic Habits,,,,,,,,,,,,
,Team Management,⭐️⭐️⭐️,Work,08:00AM - 08:20AM,,,How AI Works_ From Sorcery to Science...,,,,,,,,,,,,
,Python Tutorial,⭐️⭐️⭐️,Learning,08:20AM - 10:10AM ,,Break 10:10AM - 03:00PM,Upwork,,,,,,,,,,,,
,,,,,,,Train Areeba for Bidding,,,,,,,,,,,,
,,,,,,,Finishing Data Science Course,,,,,,,,,,,,
,,,,,,,Team Management,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,11:00AM - 01:00AM Sleep,20/07/2025,,,,,,,,,,,,
,Dinner,⭐️⭐️,Personal,01:00AM - 02:30AM,,,Proposal About Update,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,02:30AM - 06:30AM,,,Python Tutorial,,,,,,,,,,,,
,Expense Calculation,⭐️⭐️⭐️,Work,06:30AM - 08:30AM,,,Book Atomic Habits,,,,,,,,,,,,
,Proposal About Update,⭐️⭐️⭐️,Work,06:30AM - 08:30AM,,,Upwork,,,,,,,,,,,,
,Mics,⭐️⭐️,Work,08:30AM - 10:30AM,,Break 10:30AM - 4:00AM Mon,Expense Calculation,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,02:00PM -  01:00AM Sleep,21/07/2025,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,04:30AM - 05:40AM,,,Exam Preparation Communication,,,,,,,,,,,,
,Exam Preparation Communication,⭐️⭐️⭐️,Education,05:40AM - 8:30AM,,,Exam Communication,,,,,,,,,,,,
,Exam Communication,⭐️⭐️⭐️,Education,8:30AM -09:40AM,,,Python Tutorial,,,,,,,,,,,,
,Uni,⭐️⭐️,Personal,09:40AM - 2:00PM,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,"02:00AM - 03:00AM, 4:30PM - 6:30PM Sleep",22/07/2025,,,,,,,,,,,,
,Mics,⭐️⭐️,Entertainment,04:30AM - 07:30AM,,,Python Tutorial,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,07:30AM - 10:10AM,,,Book Atomic Habits,,,,,,,,,,,,
,Mics,⭐️⭐️,Learning,10:30AM - 11:30AM,,,Upwork,,,,,,,,,,,,
,Python Tutorial,⭐️⭐️⭐️,Learning,11:50AM - 01:15PM,,Launch Break 01:15PM - 2:00,Vibe Coding App,,,,,,,,,,,,
,Bazaar,⭐️⭐️,Personal,02:15PM - 4:30PM,,,Exercise,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,, 10:00PM -  7:00AM Sleep,23/07/2025,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,07:30AM - 10:40AM,,,Python Tutorial,,,,,,,,,,,,
,Mics,⭐️⭐️,Entertainment,10:40AM - 01:10AM,,Launch Break 01:15PM - 02:10PM,Book Atomic Habits,,,,,,,,,,,,
,Python Tutorial,⭐️⭐️⭐️,Learning,"02:10PM - 08:00PM, 09:40PM - 10 50PM",,Meeting 4:00PM - 4:40PM,Upwork,,,,,,,,,,,,
,,,,,,Dinner Break 08:00PM - 09:30PM,Vibe Coding App,,,,,,,,,,,,
,,,,,,,Exercise,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,," 11:00PM -  4:00AM, 3:00PM - 3:00AM  Sleep",24/07/2025,,,,,,,,,,,,
,Mics,⭐️⭐️,N/A,04:00AM - 07:40AM,,,,,,,,,,,,,,,
,Markez,⭐️⭐️,Personal,11:00AM - 02:40PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,," 07:00PM -  09:00AM, 5:00PM - 1:00AM  Sleep",25/07/2025,,,,,,,,,,,,
,Mics,⭐️⭐️,N/A,04:00AM - 07:00AM,,,Bg-assets,,,,,,,,,,,,
,Uni,⭐️⭐️,Work,11:00AM - 02:00PM,,,,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,02:00PM - 4:30PM,,,,,,,,,,,,,,,
,Mics,⭐️⭐️,N/A,01:00PM - 03:30PM,,,,,,,,,,,,,,,
,Bg-assets,⭐️⭐️⭐️,N/A,03:30PM - 4:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,5:00PM - 7:00AM  Sleep,26/07/2025,,,,,,,,,,,,
,Breakfast,⭐️⭐️,N/A,08:00AM - 09:00AM,,,Bg-assets,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,"09:00AM - 10:00AM, 02:30PM - 05:30PM",,,Python Tutorial,,,,,,,,,,,,
,Mics,⭐️⭐️,N/A,11:00AM - 12:00PM,,,Book Atomic Habits,,,,,,,,,,,,
,Bg-assets,⭐️⭐️,N/A,12:30PM - 02:00PM,,,Upwork,,,,,,,,,,,,
,Update Portfolio Website,⭐️⭐️⭐️,Work,05:30PM - 12:00AM,,,Exercise,,,,,,,,,,,,
,,,,,,,Update Portfolio Website,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,10:00AM - 02:00M Sleep,29/07/2025,,,,,,,,,,,,
,Traveling,⭐️⭐️⭐️,Personal,07:00PM - 08:00AM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,02:00PM - 05:00PM,,,,,,,,,,,,,,,
,Ulasyr,⭐️⭐️⭐️,Work,05:00PM - 08:00PM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,08:00PM - 11:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,"11:00PM - 4:30AM, 12:30PM - 2:30PM Sleep",30/07/2025,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,"04:30AM - 7:10AM, 3:00PM - 5:00PM, 12:00PM - 05:00PM",,,Meeting,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️,Work,08:10AM - 11:30PM,,,Project Managament ,,,,,,,,,,,,
,Python Tutorial,⭐️⭐️⭐️,Work,11:30PM - 12:00PM,,Break 12:00PM - 2:30PM,Python Tutorial,,,,,,,,,,,,
,Misc,⭐️⭐️,Personal,05:00PM - 08:00PM,,,Upwork Bidding,,,,,,,,,,,,
,Friends Meet,⭐️⭐️,Personal,08:00PM - 11:30PM,,,Adding case studies on upwork,,,,,,,,,,,,
,,,,,,,Expense Calculation,,,,,,,,,,,,
,,,,,,,application,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,10:00AM - 02:00PM Sleep,31/07/2025,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,"12:00PM - 05:00AM, 03:00PM - 09:30PM, 10:30PM - 11:10PM",,,Project Managament ,,,,,,,,,,,,
,Client Meeting,⭐️⭐️⭐️,Work,05:00AM - 05:20AM,,Launch - 2:00PM - 3:00PM,Expense Calculation,,,,,,,,,,,,
,Expense Calculation,⭐️⭐️⭐️,Personal,11:10PM - 12:00AM,,Break 09:30PM - 10:30PM,Upwork Bidding,,,,,,,,,,,,
,,,,,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,03:00AM - 11:30PM Sleep,01/08/2025,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,12:00AM - 02:30AM,,,Meeting,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,02:00PM - 5:30PM,,,Upwork Bidding,,,,,,,,,,,,
,Out,⭐️⭐️⭐️,Personal,05:30PM - 12:30AM,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,Adding Case Studies on upwork,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,,02/08/2025,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,"01:00AM - 2:00AM, 3:00PM -",,,Upwork Bidding,,,,,,,,,,,,
,Ringo Project,⭐️⭐️⭐️,Work,02:00PM - 3:00PM,,,Meeting,,,,,,,,,,,,
,,,,,,,Ringo Project,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,03:00AM - 3:00PM Sleep,05/08/2025,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,"05:00PM - 6:00PM, 9:30PM - 9: 45PM",,,Upwork Bidding,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,6:00PM - 8:30PM,,Dinner- 8:30PM - 9:00PM,Project Boomerang,,,,,,,,,,,,
,Cloths Setting,⭐️⭐️⭐️,Personal,9:00PM - 9:30PM,,,Project Ringo,,,,,,,,,,,,
,Expense Calculation,⭐️⭐️⭐️,Personal,09:45PM - 11:00PM,,,Project Land-Liebe,,,,,,,,,,,,
,Project Propulsion,⭐️⭐️⭐️,Work,11:00PM - 11:30PM,,,Project Propulsion,,,,,,,,,,,,
,Project Land-Liebe,⭐️⭐️⭐️,Work,11:00PM - 11:30PM,,,Exercise,,,,,,,,,,,,
,,,,,,,"Practice Project to Moiz, Anika, Usman",,,,,,,,,,,,
,,,,,,,University Assessment,,,,,,,,,,,,
,,,,,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,01:30AM - 3:00PM Sleep,06/08/2025,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,11:30AM - 01: 05AM,,,,,,,,,,,,,,,
,Project Hunter Trading,⭐️⭐️⭐️,Work,01: 05AM - 2:04AM,,,Upwork Bidding,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,2:04AM - 6:30AM,,,Project Ringo,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,08:00AM - 1:30PM,,Dinner- 7:30PM - 8:00PM,Project Boomerang,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,04:00PM - 7:30PM,,,Project Land-Liebe,,,,,,,,,,,,
,Misc,⭐️,Time Waste,08:00PM - ,,,Project Hunter,,,,,,,,,,,,
,,,,,,,DSA study,,,,,,,,,,,,
,,,,,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,"06:00AM - 10:00AM,  6:00PM - 9:00PM Sleep",07/08/2025,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,09:00AM - 4:00PM,,,,,,,,,,,,,,,
,Chess,⭐️,Education,04:00PM - 6:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,09:00AM - 02:00PM Sleep,08/08/2025,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,11:10AM - 01:25AM,,,Upwork Bidding,,,,,,,,,,,,
,Project Land-Liebe,⭐️⭐️⭐️,Work,11:10AM - 04:00AM,,,Project Land-Liebe,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,04:40AM - 6:30AM,,,Project Ringo,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,6:30AM - 8:00AM,,,Project Boomerang,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,02:00PM - 10:50PM,,Dinner- 7:30PM - 8:30PM,DSA study,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,10:50PM - 2:10PM,,,Indeed Job Posting,,,,,,,,,,,,
,,,,,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,08:00AM - 05:00PM Sleep,09/08/2025,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,10:50PM - 2:10AM,,,,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,2:10AM - 3:20AM,,,,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,05:00PM - 7:30PM,,Dinner- 7:30PM - 8:30PM,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"7:30PM - 3:00AM, 03:30AM - 9:00AM",,,DSA study,,,,,,,,,,,,
,,,,,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,Project Boomerang,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,01:00PM - 07:00PM Sleep,10/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,03:30AM - 9:00AM,,,DSA study,,,,,,,,,,,,
,Misc,⭐️,Time Waste,"9:00AM - 01:00PM, 9:00PM - 12:20AM",,,Python Tutorial,,,,,,,,,,,,
,,,,,,Dinner- 7:30PM - 8:30PM,Project Boomerang,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,01:00PM - 09:00PM Sleep,11/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,12:20AM - 4:30AM,,,DSA study,,,,,,,,,,,,
,DSA study,⭐️⭐️⭐️,Work,4:30AM - 6:30AM,,,Python Tutorial,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Work,6:30AM - 11:30AM,,,Project Boomerang,,,,,,,,,,,,
,,,,,,Dinner- 9:00PM - 9:30PM,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,01:00PM - 09:00PM Sleep,12/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"10:00AM - 10:50AM, 01:10AM - 2:30AM",,,Project Boomerang,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,"10:00AM - 01:10AM, 5:15AM - 5:25AM",,,DSA study,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,01:10AM - 4:30AM,,,Project Boomerang,,,,,,,,,,,,
,Team Management,⭐️⭐️⭐️,Work,5:30AM - 6:00AM,,,Project Ringo,,,,,,,,,,,,
,,,,,,,Python Tutorial,,,,,,,,,,,,
,,,,,,,Vibr Coding,,,,,,,,,,,,
,,,,,,,Web Design Market Research,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,08:00AM - 08:00PM Sleep,14/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,04:10AM - 07:00AM,,,Project Boomerang,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,07:00AM - 10:00AM,,,Project Ringo,,,,,,,,,,,,
,,,,,,,Project KOVA,,,,,,,,,,,,
,,,,,,,Project MetaOps,,,,,,,,,,,,
,,,,,,,DSA study,,,,,,,,,,,,
,,,,,,,Exercise,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,07:00PM - 11:00PM Sleep,15/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,11:00PM - 01:00AM,,,Project MetaOps,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,11:00PM - 02:00AM,,,Project KOVA,,,,,,,,,,,,
,Project KOVA,⭐️⭐️⭐️,Work,03:00AM - 5:30AM,,,DSA study,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,5:30AM - 08:30AM,,,Exercise,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,08:30AM - 10:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,07:00PM - 11:00AM Sleep,16/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,11:00AM - 01:30PM,,,DSA study,,,,,,,,,,,,
,Project KOVA,⭐️⭐️⭐️,Work,01:30PM - 01:50PM,,,Project KOVA,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,"01:50PM - 4:00PM, 9:10PM - 10:30PM",,Dinner- 8:10PM - 8:40PM,Project Boomerang,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,"4:00PM - 8:10PM, 08:40PM - 9:10PM",,,Exercise,,,,,,,,,,,,
,,,,,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,11:00AM - 8:00PM Sleep,17/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"11:00AM - 01:30AM, 3:00AM - 7:00AM",,,,,,,,,,,,,,,
,Misc,⭐️,Time Waste,7:00AM - 11:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,,18/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,10:00PM - 12:30AM,,,DSA study,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,12:30AM - 4:00AM,,,Project Boomerang,,,,,,,,,,,,
,Misc,⭐️,Time Waste,04:00PM - 07:00AM,,Launch 2:00PM - 2:30PM,Project Ringo,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,07:00AM - 11:00AM,,,Book Atomic Habits,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,"11:30AM - 2:00PM, 2:30PM - 3:10PM",,,Exercise,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,06:00PM - 03:00AM Sleep,19/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,03:00PM - 06:00AM,,,DSA study,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,06:00AM - 06:30AM,,,Project Boomerang,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,"06:30AM - 06:50AM, 08:00AM - 9:00AM",,,Project Ringo,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,"06:50AM - 8:00AM, 11:30AM - 3:30PM",,,Book Atomic Habits,,,,,,,,,,,,
,Project MetaOps,⭐️⭐️⭐️,Work,"9:00AM - 11:30AM, 4:00PM - 6:00PM",,,Exercise,,,,,,,,,,,,
,DSA Assignment,⭐️⭐️⭐️,Work,6:00PM - 9:00PM,,,Project MetaOps,,,,,,,,,,,,
,,,,,,,DSA Assignment,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,"09:00PM - 01:00AM, 04:00PM - 09:00PM Sleep",20/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,01:00AM - 02:30AM,,,,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,02:30AM - 06:25AM,,,,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,6:30AM - 11:30PM,,,,,,,,,,,,,,,
,PC Market,⭐️⭐️⭐️,Education,11:30PM - 1:00PM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,1:00PM - 3:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,09:00PM - 04:00AM Sleep,21/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"10:00PM - 1:30AM, 4:40AM - 6:30AM",,,Vibe Coding,,,,,,,,,,,,
,Project Boomerang,⭐️⭐️⭐️,Work,"1:30AM - 4:40AM, 4:50PM - 5:20PM",,,MVP Prototype,,,,,,,,,,,,
,Vibe Coding,⭐️⭐️⭐️,Work,6:50AM - 10:10AM,,,Project Boomerang,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,10:10AM - 03:30PM,,,Project Ringo,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,5:20PM - 6:40PM,,,Project MetaOps,,,,,,,,,,,,
,,,,,,,DSA Assignment,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,10:00PM - 08:00AM Sleep,22/08/2025,,,,,,,,,,,,
,Misc,⭐️,Time Waste,05:00AM - 03:00PM,,,Project Ringo,,,,,,,,,,,,
,Project MetaOps,⭐️⭐️⭐️,Work,3:15PM - 5:00PM,,,Project MetaOps,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,5:15PM - 10:00PM,,,DSA Assignment,,,,,,,,,,,,
,,,,,,,MVP Prototype,,,,,,,,,,,,
,,,,,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,Exercise,,,,,,,,,,,,
,,,,,,,Contra Profile Optimization,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,,23/08/2025,,,,,,,,,,,,
,Misc,⭐️,Time Waste,"8:00AM - 10:30AM, 08:30 - 11:40PM",,Breakfast 10:30AM - 11:00AM,Project Ringo,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,11:30PM - 12:50PM,,,Project MetaOps,,,,,,,,,,,,
,Project MetaOps,⭐️⭐️⭐️,Work,12:50PM - 01:30PM,,,DSA Assignment,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,01:30PM - 02:00PM,,,MVP Prototype,,,,,,,,,,,,
,MVP Prototype,⭐️⭐️⭐️,Work,02:00PM - 03:00PM,,,Exercise,,,,,,,,,,,,
,Pc Repair,⭐️⭐️⭐️,Work,04:00PM - 05:30PM,,,Contra Profile Optimization,,,,,,,,,,,,
,Ground,⭐️⭐️⭐️,Execise,05:30PM - 06:30PM,,,,,,,,,,,,,,,
,Haircut,⭐️⭐️⭐️,Execise,06:30PM - 07:30PM,,,,,,,,,,,,,,,
,Res,⭐️⭐️,Execise,07:30PM - 08:30PM,,,,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,11:40PM - ,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,12:00PM - 05:00AM Sleep,24/08/2025,,,,,,,,,,,,
,Misc,⭐️,Time Waste,05:30PM - 11:30PM,,,,,,,,,,,,,,,
,Sunday Bazaar,⭐️⭐️⭐️,Work,11:30PM - 04:00PM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,04:00PM - 3:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,"03:00AM - 06:00AM, 11:00AM - 01:30PM Sleep",25/08/2025,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,06:00PM - 11:00AM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"02:00PM - 6:00PM, 09:00PM - 03:00AM",,Launch 01:30PM - 2:00PM,,,,,,,,,,,,,
,Upwork BIdding,⭐️⭐️⭐️,Work,6:00PM - 08:20PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,03:00AM - 10:00AM Sleep,26/08/2025,,,,,,,,,,,,
,Team Hunting,⭐️⭐️⭐️,Work,2:00PM -  5:50PM,,,Project Ringo,,,,,,,,,,,,
,Project Ringo,⭐️⭐️⭐️,Work,5:50PM - 6:20PM,,Launch 01:30PM - 2:00PM,Project Behold,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,06:30PM - 11:40PM,,,DSA Assignment Lab,,,,,,,,,,,,
,,,,,,,Exercise,,,,,,,,,,,,
,,,,,,,AI Bidding,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,12:00PM - 06:00AM Sleep,27/08/2025,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,06:00AM - 01:00PM,,,DSA Mid Preparation,,,,,,,,,,,,
,Misc,⭐️,Time Waste,01:30PM - 06:00PM,,Launch 08:00PM - 08:30PM,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,09:00PM - 09:50PM,,,,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,09:50PM - 11:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,"04:00PM - 09:00AM, 03:00PM - 06:00PM Sleep",28/08/2025,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,11:00PM - 1:30PM,,,Loom Introduction Video,,,,,,,,,,,,
,Misc,⭐️,Time Waste,01:30PM - 03:00PM,,,Exercise,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,09:00PM - 09:50PM,,,AI Bidding,,,,,,,,,,,,
,,,,,,,Abbas MVP Prototype,,,,,,,,,,,,
,,,,,,,DSA Preparation,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,"09:00AM, 01:00PM - 02:00PM - 4:00PM Sleep",29/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"09:50PM - 08:00AM, 4:00PM - 9:00PM",,,Loom Introduction Video,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,09:00PM - 11:30PM,,,Exercise,,,,,,,,,,,,
,Abbas MVP Prototype,⭐️⭐️⭐️,Work,11:30PM -,,,AI Bidding,,,,,,,,,,,,
,,,,,,,Abbas MVP Prototype,,,,,,,,,,,,
,,,,,,,DSA Preparation,,,,,,,,,,,,
,,,,,,,Developing AI Projects,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,05:00AM - 1:00PM Sleep,31/08/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,01:00PM - 06:00PM,,,Expense Calculation,,,,,,,,,,,,
,Expense Calculation,⭐️⭐️⭐️,Work,06:00PM - 11:50PM,,,Loom Introduction Video,,,,,,,,,,,,
,,,,,,,AI Bidding,,,,,,,,,,,,
,,,,,,,DSA Preparation,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,,01/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,11:50PM - 6:00AM,,,DSA Preparation,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,11:00AM - 06:00PM,,Launch 08:00PM - 08:30PM,AI Bidding,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,08:30PM - 11:00AM,,,Loom Introduction Video,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,"06:00AM - 9:00AM, 10:00AM - 4:00PM Sleep",02/09/2025,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,11:00AM - 2:00AM,,,DSA Assignment,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"3:00AM - 6:00AM, 4:00PM - 11:05PM",,,DSA Preparation,,,,,,,,,,,,
,DSA Preparation,⭐️⭐️⭐️,Work,"3:00AM - 6:00AM, 4:00PM - 11:05PM",,,Upwork Bidding,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,12:00AM - 7:00PM Sleep,03/09/2025,,,,,,,,,,,,
,DSA Preparation,⭐️⭐️⭐️,Work,2:00AM - 7:00AM,,,Upwork Bidding,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,07:00AM - 12:00PM,,Launch 08:00PM - 08:30PM,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,4:00PM - 11:05PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,"06:00AM - 09:00AM, 05:00PM - 08:00PM Sleep",04/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,11:05PM - 6:00AM,,,,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,09:00AM - 2:00PM,,,,,,,,,,,,,,,
,Misc,⭐️,Entertainment,2:00PM - 05:05PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,"06:00AM - 09:00AM, 12:00PM - 08:00PM Sleep",05/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,09:00PM - 10:00PM,,Launch 08:00PM - 08:50PM,Client Meeting 5:00AM - 5:15AM,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,10:00PM - 2:00AM,,,DSA Preparation,,,,,,,,,,,,
,,,,,,,Upwork Bidding,,,,,,,,,,,,
,,,,,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,,06/09/2025,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,02:00AM - 06:30AM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"06:30AM - 12:00PM, ",,,,,,,,,,,,,,,
,Project,⭐️⭐️⭐️,Educaton,03:00PM - 07:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,,07/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,10:00PM - 3:00AM,,,DSA Preparation,,,,,,,,,,,,
,DSA Preparation,⭐️⭐️⭐️,Work,3:00AM - 6:00AM,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,AI Automations Learning,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,12:00PM - 09:00PM Sleep,08/09/2025,,,,,,,,,,,,
,DSA Preparation,⭐️⭐️⭐️,Work,3:00AM - 6:00AM,,,,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,06:00AM - 10:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
 ,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,,09/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,10:00PM - 2:00AM,,,DSA Preparation,,,,,,,,,,,,
,DSA Preparation,⭐️⭐️⭐️,Work,02:00AM - 6:00AM,,,Book Atomic Habits,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,08:00AM - 3:00PM,,,AI Automations Learning,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,03:00PM - 01:30AM Sleep,,,,,,,,,,,,,
Wednesday,,,,,,,10/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,01:30AM -  ,,,DSA Preparation,,,,,,,,,,,,
,,,,,,,AI Automations Learning,,,,,,,,,,,,
,,,,,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,08:00PM - 05:00AM Sleep,12/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,05:00AM - 03:30PM,,,,,,,,,,,,,,,
,DSA Preparation,⭐️⭐️⭐️,Work,03:30PM - 5:20PM,,,DSA Preparation,,,,,,,,,,,,
,Exercise,⭐️⭐️⭐️,Work,5:20PM - 7:00PM,,,AI Automations Learning,,,,,,,,,,,,
,,,,,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,10:00AM - 12:30PM Sleep,13/09/2025,,,,,,,,,,,,
,Entertainment,⭐️,Time Waste,05:00AM - 10:00AM,,,Book Atomic Habits,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,01:30PM - 02:40PM,,Launch 12:30PM - 01:30PM,DSA Preparation,,,,,,,,,,,,
,Book Atomic Habits,⭐️⭐️⭐️,Work,02:40PM - 8:30PM,,,AI Automations Learning,,,,,,,,,,,,
,DSA Preparation,⭐️⭐️⭐️,Work,8:30PM - 2:00AM,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,"05:00AM - 10:00AM, 2:00PM - 3:00PM Sleep",14/09/2025,,,,,,,,,,,,
,Entertainment,⭐️,Time Waste,"2:00AM - 5:00AM, 10:00AM - 1:00PM",,,Book Atomic Habits,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,05:00PM - 07:10PM,,,AI Automations Learning,,,,,,,,,,,,
,DSA Exam Preparation,⭐️⭐️⭐️,Education,8:30PM - 2:20AM,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,2:00PM - 3:00PM Sleep,15/09/2025,,,,,,,,,,,,
,DSA Exam Preparation,⭐️⭐️⭐️,Education,2:20AM - 7:00AM,,,,,,,,,,,,,,,
,DSA Exam,⭐️⭐️⭐️,Education,7:00AM - 2:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,11:00PM - 04:00AM Sleep,16/09/2025,,,,,,,,,,,,
,Entertainment,⭐️,Time Waste,04:00AM - 07:00AM,,,Plan 20 Days Off,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Educaton,08:00AM - 2:00PM,,,Expense Calculation,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"02:00PM - 3:00PM, 11:00PM - 12:00PM",,,Upwork Bidding,,,,,,,,,,,,
,Plan 20 Days Off,⭐️⭐️⭐️,Work,3:00PM - 06:00PM,,Break 08:00PM - 08:30PM,AI Automations Learning,,,,,,,,,,,,
,Expense Calculation,⭐️⭐️⭐️,Work,06:00PM - 7:00PM,,,Book Atomic Habits,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,"07:00PM - 8:00PM, 08:30PM -10:00PM",,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,12:00PM - 10:00AM Sleep,17/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,10:00AM - 11:30AM,,,Upwork Bidding,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,11:30AM - 01:30PM,,,AI Automations Learning,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,"01:30PM - 07:20PM, 09:00pm - 01:00am",,Break 07:20PM - 09:00PM,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,03:00AM - 10:00AM Sleep,18/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,10:00AM - 01:10PM,,,Project Ascendo,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,"01:10PM - 04:30PM,  08:30PM - 10:20PM",,,Upwork Bidding,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,"04:30PM - 7:50PM, 10:20PM - 3:00AM",,Break 07:50PM - 08:30PM,AI Automations Learning,,,,,,,,,,,,
,,,,,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,04:00AM - 01:00PM Sleep,19/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,01:00PM - 03:00PM,,,Project Ascendo,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,03:10PM - 05:40PM,,,Upwork Bidding,,,,,,,,,,,,
,Abbas MVP,⭐️⭐️⭐️,Work,05:40PM - 06:52PM,,,AI Automations Learning,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,06:52PM - 07:45PM,,Break 07:50PM - 08:50PM,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,Update Upwork Profile,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,04:00AM - 12:00PM Sleep,20/09/2025,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,08:50PM - 02:30AM,,,AI Automations Learning,,,,,,,,,,,,
,TDL Review,⭐️⭐️⭐️,Work,03:00AM - 03:30AM,,,Upwork Bidding,,,,,,,,,,,,
,Misc,⭐️⭐️,Work,01:00PM - 04:00PM,,,Book Atomic Habits,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,04:50PM - 06:10PM,,,Abbas MVP,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,06:10PM - 6:00AM,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,Update Upwork Profile,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,07:00AM - 02:00PM Sleep,21/09/2025,,,,,,,,,,,,
,Exercise,⭐️⭐️⭐️,Personal,6:00AM - 6:40AM,,,AI Automations Learning,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,04:00PM - 06:10PM,,,Upwork Bidding,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,06:10PM - 07:30PM,,"Break 07:30PM - 08:00PM, 11:50PM - 1:45AM",Book Atomic Habits,,,,,,,,,,,,
,Book Atomic Habits,⭐️⭐️⭐️,Personal,08:55PM - 11:50PM,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Interview Improvement,,,,,,,,,,,,
,,,,,,,Linkedin Post,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,08:00AM - 03:00PM Sleep,22/09/2025,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,02:10AM - 6:00AM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"04:00PM - 05:30P, 07:40PM - 9:10PM",,,AI Automations Learning,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,05:30PM - 07:20PM,,Break 07:20PM - 07:40PM,Upwork Bidding,,,,,,,,,,,,
,Book Atomic Habits,⭐️⭐️⭐️,Work,09:10PM - 12:00AM,,,Book Atomic Habits,,,,,,,,,,,,
,,,,,,,Linkedin Post,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,09:00AM - 05:00PM Sleep,23/09/2025,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,"01:00AM - 04:00AM, 05:20AM - 6:30AM",,,AI Automations Learning,,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,04:00AM - 04:40AM,,,Upwork Bidding,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,"06:40AM - 07:40PM, 08:10PM - 09:00PM",,"Break  07:40PM - 08:10PM, 01:45AM - 02:20AM",Book Atomic Habits,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,09:00PM - 11:10PM ,,,Linkedin Post,,,,,,,,,,,,
,Book Atomic Habits,⭐️⭐️⭐️,Personal,11:10PM - 01:45AM,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Cold Email Setup,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,09:00AM - 05:00PM Sleep,24/09/2025,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,"02:30AM - 04:10AM, 04:45AM - 07:00AM",,,AI Automations Learning,,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,04:10AM - 04:45AM,,"Break  07:00AM - 09:00AM, 07:20PM - 07:50PM",Upwork Bidding,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,06:30PM - 07:20PM ,,,Abbas MVP,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,07:50PM - 09:40PM,,,Project Hunter,,,,,,,,,,,,
,Misc,⭐️,Time Waste,09:40AM - 01:00AM,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,07:00AM - 05:00PM Sleep,25/09/2025,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Work,01:00AM -  04:00AM,,,AI Automations Learning,,,,,,,,,,,,
,TDL Review,⭐️⭐️⭐️,Work, 04:00AM - 04:30AM,,,Upwork Bidding,,,,,,,,,,,,
,Relexation,⭐️⭐️⭐️,Personal,04:30AM - 07:00AM,,,Abbas MVP,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,06:00PM - 09:20PM ,,,Project Hunter,,,,,,,,,,,,
,,,,,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,10:00AM - 07:00PM Sleep,26/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"09:30PM - 12:30AM, 7:00PM - 09:30PM",,,AI Automations Learning,,,,,,,,,,,,
,How AI Works From Sorcery,⭐️⭐️⭐️,Educaton,12:40AM - 04:00AM,,,Upwork Bidding,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,05:00AM - 07:10AM,,,Abbas MVP,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,"07:10AM - 08:30AM, 9:30PM - 12:00AM",,,Project Hunter,,,,,,,,,,,,
,,,,,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,09:00AM - 06:30PM Sleep,27/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"12:00AM - 12:30PM, 06:30PM - 07:30PM",,,AI Automations Learning,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,01:10AM - 05:00AM,,Break  07:30PM - 08:30PM,Upwork Bidding,,,,,,,,,,,,
,Markez,⭐️⭐️⭐️,Personal,09:30PM - 11:00PM,,,Abbas MVP,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,11:00PM - 11:30PM,,,Project Hunter,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,11:30PM - 12:35AM,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,,28/09/2025,,,,,,,,,,,,
,How AI Works From Sorcery,⭐️⭐️⭐️,Learning,12:40AM - 04:30AM,,,AI Automations Learning,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,04:30PM - 05:50AM,,Break  05:50PM - 06:30AM,Upwork Bidding,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,06:30AM - 10:30AM,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Project Hunter,,,,,,,,,,,,
,,,,,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,"06:00AM - 11:00AM, 06:00PM - 10:00PM Sleep",,,,,,,,,,,,,
Tuesday,,,,,,,30/09/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"08:00PM - 01:45PM, 3:30AM - 6:00AM",,,AI Automations Learning,,,,,,,,,,,,
,Expense Calculation,⭐️⭐️⭐️,Personal,01:45PM - 03:30AM,,,Upwork Bidding,,,,,,,,,,,,
,Mdeical Checkup,⭐️⭐️⭐️,Personal,01:00PM - 6:00PM,,,Project Form Spray,,,,,,,,,,,,
,,,,,,,Project Slipssy,,,,,,,,,,,,
,,,,,,,Project Hunter,,,,,,,,,,,,
,,,,,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,Expense Calculation,,,,,,,,,,,,
,,,,,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,PC Setup,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,AI Automations Learning - 11 Hours,,,,,,,,
Wednesday,,,,,,,01/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,10:00PM - 02:10AM,,,AI Automations Learning,,,,,,,,,,,,
,Project Slipssy,⭐️⭐️⭐️,Work,02:10AM - 06:10AM,,,Upwork Bidding,,,,,,,,,,,,
,Project Hunter,⭐️⭐️⭐️,Work,08:10AM - 9:30AM,,,Project Form Spray,,,,,,,,,,,,
,,,,,,,Project Slipssy,,,,,,,,,,,,
,,,,,,,Project Hunter,,,,,,,,,,,,
,,,,,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,PC Setup,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,,04/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"10:00PM - 02:10AM, 4:00AM - 06:00AM",,,Project Hunter,,,,,,,,,,,,
,Project Hunter,⭐️⭐️⭐️,Work,06:00AM - 7:15AM,,,AI Automations Learning,,,,,,,,,,,,
,,,,,,,Upwork Bidding,,,,,,,,,,,,
,,,,,,,Project Slipssy,,,,,,,,,,,,
,,,,,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,PC Setup,,,,,,,,,,,,
,,,,,,,Bike Purchase,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,"04:00PM - 3:00AM, 07:00PM - 11:00PM Sleep",,,,,,,,,,,,,
Tuesday,,,,,,,07/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"4:00AM - 09:15AM, 10:30AM - 12:00PM",,,Project Slipssy,,,,,,,,,,,,
,Project Slipssy,⭐️⭐️⭐️,Work,09:15AM - 10:30AM,,,AI Automations Learning,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Work,12:20PM - 06:00PM,,,Upwork Bidding,,,,,,,,,,,,
,,,,,,,How AI Works From Sorcery,,,,,,,,,,,,
,,,,,,,PC Setup,,,,,,,,,,,,
,,,,,,,Bike Purchase,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,02:00AM - 6:00AM Sleep,,,,,,,,,,,,,
Wednesday,,,,,,,08/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,8:00AM - 10:00AM,,,,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Work,10:00AM - 06:30PM,,,,,,,,,,,,,,,
,,,,,,Break  06:30PM - 07:30PM,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,10:00PM - 7:00AM Sleep,,,,,,,,,,,,,
Thursday,,,,,,,09/10/2025,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,07:00AM - 12:30PM,,,Upwork Bidding,,,,,,,,,,,,
,Uni Library,⭐️⭐️⭐️,Work,01:00PM - 03:30PM,,"Break  03:30PM - 04:30PM, 07:10PM - 07:30PM",How AI Works From Sorcery,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"04:30PM - 04:50PM, 06:10PM - 07:10PM",,,AI Automations Learning,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,04:50PM - 06:10PM,,,Harry Data Science Course,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,07:40PM - 09:30PM,,,,,,,AI Automations Learning - 11 Hours,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,10:00PM - 7:00AM Sleep,,,,,,,,,,,,,
Friday,,,,,,,10/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"08:00AM - 09:00AM, 02:40PM - 03:30PM",,,Upwork Bidding,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,09:20AM - 11:50AM,,"Break  09:00PM - 09:20PM, 02:10PM - 02:40PM",How AI Works From Sorcery,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,"11:50AM - 02:10PM, 03:40PM - 04:30PM, 08:45PM - 09:25PM",,,AI Automations Learning,,,,,,,,,,,,
,Misc,⭐️,Time Waste,04:30PM - 08:45PM,,,Harry Data Science Course,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,09:30PM - 11:35PM,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,"04:00AM - 7:00AM, 12:00PM - 02:00PM Sleep",,,,,,,,,,,,,
Saturday,,,,,,,11/10/2025,,,,,,,,,,,,
,Misc,⭐️,Time Waste,"07:30AM - 12:00PM, 07:00PM - 02:00AM",,,,,,,,,,,,,,,
,Bike Repair,⭐️⭐️⭐️,Personal,02:00PM - 06:00PM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,06:00M - 07:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,02:00AM - 11:00AM Sleep,,,,,,,,,,,,,
Sunday,,,,,,,12/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"12:00M - 02:00PM, 07:30PM - 08:30PM, 10:50PM - 01:10AM",,,Upwork Bidding,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,02:00PM - 05:00PM,,,How AI Works From Sorcery,,,,,,,,,,,,
,Project Hunter,⭐️⭐️⭐️,Work,05:00PM - 05:30PM,,,AI Automations Learning,,,,,,,,,,,,
,Upwork,⭐️⭐️⭐️,Work,05:30PM - 07:15PM,,Break  07:15PM - 07:30PM,Harry Data Science Course,,,,,,,,,,,,
,Framer Film Test Project,⭐️⭐️⭐️,Work,08:30PM - 10:50PM,,,Abbas MVP,,,,,,,,,,,,
,,,,,,,Framer Film Test Project,,,,,,,,,,,,
,,,,,,,Ludo Assignment,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,02:00AM - 07:00AM Sleep,,,,,,,,,,,,,
Monday,,,,,,,13/10/2025,,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,01:50PM - 02:30AM,,,Upwork Bidding,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"08:00PM - 09:50AM, 01:30PM - 03:50PM",,,How AI Works From Sorcery,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,09:50AM - 01:30PM,,,AI Automations Learning,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,03:50PM - 05:10PM,,,Harry Data Science Course,,,,,,,,,,,,
,How AI Works From Sorcery,⭐️⭐️⭐️,Learning,"05:30PM - 08:30PM, 08:45PM - 9:50PM",,Break  08:30PM - 08:45PM,Abbas MVP,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,10:05PM - 11:15PM,,,Framer Film Test Project,,,,,,,,,,,,
,,,,,,,Ludo Assignment,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,02:00AM - 10:00AM Sleep,,,,,,,,,,,,,
Tuesday,,,,,,,14/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"11:30AM - 01:15PM, 09:00PM - 10:00PM",,,Upwork Bidding,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,01:15PM - 03:50PM,,Break  07:30PM - 08:30PM,AI Automations Learning,,,,,,,,,,,,
,Abbas MVP,⭐️⭐️⭐️,Personal,04:00PM - 07:00PM,,,Abbas MVP,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,11:00PM - 02:00AM,,,AI Quiz,,,,,,,,,,,,
,,,,,,,Harry Data Science Course,,,,,,,,,,,,
,,,,,,,Adding Automation Projects to Portfolio,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,,15/10/2025,,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,02:00AM - 02:40AM,,03:00AM - 10:00AM Sleep,Upwork Bidding,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Work,"12:30PM - 07:00PM,",,Break  07:00PM - 07:30PM,How AI Works From Sorcery,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,07:30PM - 10:30PM,,,AI Automations Learning,,,,,,,,,,,,
,,,,,,,Harry Data Science Course,,,,,,,,,,,,
,,,,,,,Project Slipssy,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,03:00AM - 11:00AM Sleep,,,,,,,,,,,,,
Thursday,,,,,,,16/10/2025,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Work,12:00PM - 06:00PM,,,Upwork Bidding,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,06:00PM - 10:40PM,,,How AI Works From Sorcery,,,,,,,,,,,,
,Projects management,⭐️⭐️⭐️,Work,10:40PM - 11:30PM,,,AI Automations Learning,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,10:40PM - 02:05AM,,,Data Science Course,,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,02:05AM - 03:00AM,,,Project Slipssy,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,11:00AM - 10:00AM Sleep,,,,,,,,,,,,,
Friday,,,,,,,17/10/2025,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Work,08:00AM - 05:30PM,,,,,,,,,,,,,,,
,Bazaar,⭐️⭐️⭐️,Work,05:30PM - 08:00PM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,08:00PM - 10:40PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,,18/10/2025,,,,,,,,,,,,
,Misc,⭐️,Time Waste,12:00PM - 01:00PM,,,Upwork Bidding,,,,,,,,,,,,
,PC Setup,⭐️⭐️⭐️,Work,01:00PM - 03:00PM,,,How AI Works From Sorcery,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"03:00PM - 04:00PM, 09:30PM - 11:00PM ",,,AI Automations Learning,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,"04:00PM - 5:40PM, 05:50PM - 07:25PM, 08:40PM - 09:30PM",,,Data Science Course,,,,,,,,,,,,
,Project Blue Bill,⭐️⭐️⭐️,Work,05:40PM - 05:50PM,,,Project Slipssy,,,,,,,,,,,,
,,,,,,,Project Blue Bill,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,04:00AM - 12:00PM Sleep,,,,,,,,,,,,,
Sunday,,,,,,,19/10/2025,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,12:00AM - 03:00AM,,Break  08:00PM - 08:30PM,Upwork Bidding,,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,03:00AM - 03:30AM,,,How AI Works From Sorcery,,,,,,,,,,,,
,Misc,⭐️,Time Waste,12:00PM - 02:00PM,,,AI Automations Learning,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"03:00PM - 05:30PM, 06:00PM - 08:00PM, 08:30PM - 12:00AM",,,Data Science Course,,,,,,,,,,,,
,,,,,,,Project Slipssy,,,,,,,,,,,,
,,,,,,,Project Blue Bill,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,"04:00AM - 07:00AM, 06:00PM - 08:00PM Sleep",20/10/2025,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,01:20AM - 03:00AM,,,Meeting with Peter,,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,03:00AM - 03:30AM,,,Upwork Bidding,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Work,07:00AM - 02:30PM,,,How AI Works From Sorcery,,,,,,,,,,,,
,Misc Library,⭐️⭐️⭐️,Work,"03:00PM - 03:30PM, 04:00PM - 4:30PM",,,AI Automations Learning,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,08:00PM - 09:35PM,,,Data Science Course,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,08:00PM - 09:35PM,,,Project Slipssy,,,,,,,,,,,,
,,,,,,,Project Blue Bill,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Tuesday,,,,,,04:00AM - 10:00AM Sleep,21/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"08:00PM - 03:35AM, 07:30PM - 09:30PM, 12:15AM - 01:30AM",,,Meeting with Peter,,,,,,,,,,,,
,OT,⭐️,Time Waste,10:00AM - 12:00PM,,,Upwork Bidding,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,"12:00PM - 03:00PM, 04:40PM - 06:30PM",,,How AI Works From Sorcery,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,03:00PM - 04:40PM,,,AI Automations Learning,,,,,,,,,,,,
,Meeting with Peter,⭐️⭐️⭐️,Work,08:05PM - 08:40PM,,,Data Science Course,,,,,,,,,,,,
,How AI Works From Sorcery,⭐️⭐️⭐️,Learning,09:30PM - 12:15PM,,,Project Blue Bill,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,01:30AM - 03:30AM,,,,,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,03:30AM - 04:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,"05:00AM - 10:30AM, 07:00PM - 8:20PM Sleep",22/10/2025,,,,,,,,,,,,
,OT,⭐️,Time Waste,10:30AM - 12:00PM,,,,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,12:00PM - 06:30PM,,,Upwork Bidding,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"08:00PM - 10:40PM, 05:30AM - 06:20AM",,,How AI Works From Sorcery,,,,,,,,,,,,
,Meeting with Peter,⭐️⭐️⭐️,Work,10:40PM - 10:50PM,,,AI Automations Learning,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,10:50PM - 12:30AM,,,Data Science Course,,,,,,,,,,,,
,,,,,,,Project Blue Bill,,,,,,,,,,,,
,,,,,,,Meeting with Peter,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,12:00PM - 04:00PM Sleep,23/10/2025,,,,,,,,,,,,
,RAG assignment,⭐️⭐️⭐️,Work,12:50AM - 05:30AM,,,Upwork Bidding,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"05:30AM - 06:20AM, 07:30PM - 10:30PM",,,How AI Works From Sorcery,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,07:00AM - 10:00AM,,,AI Automations Learning,,,,,,,,,,,,
,OT,⭐️,Time Waste,04:00PM - 07:30PM,,,Data Science Course,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,10:30PM - 11:10PM,,,Project Blue Bill,,,,,,,,,,,,
,,,,,,,RAG assignment,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,06:00AM - 03:00PM Sleep,24/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"11:10PM - 01:10AM, 05:00PM - 07:00PM",,,Upwork Bidding,Data Science Course,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,"01:40AM - 04:05AM, 07:20 - 11:10PM",,,How AI Works From Sorcery,Project Blue Bill,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,04:20AM - 04:40AM,,,AI Automations Learning,AI Lab Python AI Model,,,,,,,,,,,
,,,,,,,,Python AI Lab Presentation,,,,,,,,,,,
,,,,,,,,AI Quiz,,,,,,,,,,,
,,,,,,,,DMS Assignment Quiz,,,,,,,,,,,
,,,,,,,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Saturday,,,,,,10:00AM - 06:00PM Sleep,25/10/2025,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,12:00AM - 06:30AM,,,Upwork Bidding,Python AI Lab Presentation,,,,,,,,,,,
,Excercise,⭐️⭐️⭐️,Personal,06:30AM - 07:15AM,,,AI Automations Learning,AI Quiz,,,,,,,,,,,
,Never split the difference ,⭐️⭐️⭐️,Learning,07:15AM - 09:05AM,,,Data Science Course,DMS Assignment & Quiz,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,10:00PM - 12:00AM,,,Project Blue Bill,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,,,,,,,AI Lab Python AI Model,DT,,,,,,,,,,,
,,,,,,,,Never split the difference ,,,,,,,,,,,
,,,,,,,,How AI Works From Sorcery,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Sunday,,,,,,12:00PM - 05:00PM Sleep,26/10/2025,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,12:00AM - 02:05AM,,,Upwork Bidding,AI Quiz,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,02:05AM - 07:00AM,,,AI Automations Learning,DMS Assignment & Quiz,,,,,,,,,,,
,Misc,⭐️,Time Waste,"07:00AM - 12:00PM, 05:00PM - 07:00PM",,,Data Science Course,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,07:00PM - 09:00PM,,,Project Blue Bill,DT,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,09:30PM - 12:40PM,,,AI Lab Python AI Model,Never split the difference ,,,,,,,,,,,
,,,,,,,Python AI Lab Presentation,How AI Works From Sorcery,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Monday,,,,,,10:00AM - 06:00PM Sleep,27/10/2025,,,,,,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,Learning,12:50AM - 04:00AM,,,Upwork Bidding,AI Quiz,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,"04:00AM - 08:00AM, 06:00PM - 07:30PM, 08:00PM - 09:00PM",,,AI Automations Learning,DMS Assignment & Quiz,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,09:00PM - 11:30PM,,,Data Science Course,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,,,,,,,Project Blue Bill,DT,,,,,,,,,,,
,,,,,,,AI Lab Python AI Model,Never split the difference ,,,,,,,,,,,
,,,,,,,Python AI Lab Presentation,How AI Works From Sorcery,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,07:00PM - 09:00PM Sleep,,,,,,,,,,,,,
Tuesday,,,,,,,28/10/2025,,,,,,,,,,,,
,DMS Assignment ,⭐️⭐️⭐️,Work,11:30PM - 12:30AM,,,Upwork Bidding,AI Quiz,,,,,,,,,,,
,Python AI Lab Presentation,⭐️⭐️⭐️,Work,12:30AM - 01:30AM,,,AI Automations Learning,DMS Assignment & Quiz,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,"01:50AM - 05:00AM, 06:00AM -06:30AM",,,Data Science Course,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,AI Lab Python AI Model,⭐️⭐️⭐️,Work,05:00AM - 06:00AM,,,Project Blue Bill,DT,,,,,,,,,,,
,Uni - DBMS LAB,⭐️⭐️⭐️,Education,07:00AM - 11:00AM,,,AI Lab Python AI Model,Never split the difference ,,,,,,,,,,,
,Lib - DBMS Quiz,⭐️⭐️⭐️,Education,11:30AM - 01:00PM,,,Python AI Lab Presentation,How AI Works From Sorcery,,,,,,,,,,,
,Uni - DBMS,⭐️⭐️⭐️,Education,01:00PM - 03:00PM,,,,,,,,,,,,,,,
,Uni - AI,⭐️⭐️⭐️,Education,03:00PM - 06:00PM,,,,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,10:00PM - 12:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Wednesday,,,,,,02:00AM - 06:00AM Sleep,29/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,12:00AM - 02:00AM,,,Upwork Bidding,AI Quiz,,,,,,,,,,,
,Misc,⭐️,Time Waste,06:00AM - 12:00PM,,,AI Automations Learning,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,12:00PM - 06:00PM,,,Data Science Course,DT,,,,,,,,,,,
,,,,,,,,Never split the difference ,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Thursday,,,,,,07:00PM - 11:00PM Sleep,30/10/2025,,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,Work,12:00AM - 02:40AM,,,Upwork Bidding,AI Quiz,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,Work,02:40AM - 06:10AM,,,AI Automations Learning,DMS Assignment,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,Education,"07:00AM - 12:00pm, 04:00PM - 06:30PM",,,Data Science Course,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,Lib - Content Automation Build,⭐️⭐️⭐️,Work,12:00PM - 04:00PM,,,,DT,,,,,,,,,,,
,,,,,,,,Never split the difference ,,,,,,,,,,,
,,,,,,,,How AI Works From Sorcery,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
Friday,,,,,,07:00PM - 11:00PM Sleep,31/10/2025,DMS Assignment,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,PR,"12:00AM - 02:40AM, 05:30AM - 07:00AM",,,Upwork Bidding,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,02:40AM - 05:30AM,,,AI Automations Learning,DT,,,,,,,,,,,
,Expense Calculation,⭐️⭐️⭐️,WK,07:00AM - 08:30AM,,,Data Science Course,Never split the difference ,,,,,,,,,,,
,,,,,,,Expense Calculation,How AI Works From Sorcery,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,10:00AM - 09:00PM Sleep,01/11/2025,DMS Assignment,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,WK,"09:00PM - 12:50AM, 05:00AM - 06:00AM, 04:00PM - 07:00PM",,,Upwork Bidding,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,,,,,,
,Hassan Project,⭐️⭐️⭐️,WK,"12:20PM - 12:50AM, 04:00AM - 05:00AM",,,AI Automations Learning,DT,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,12:50AM - 04:00AM,4,10,Data Science Course,Never split the difference ,,,,,,,,,,,
,SM Content Automation System Build,⭐️⭐️⭐️,WK,06:00AM - 04:00PM,,,hassan project,How AI Works From Sorcery,,,,,,,,,,,
,,,,,,,SM Content Automation System Build,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,07:00PM - 03:00AM SP,02/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️,TW,03:00AM - 07:00AM,,,,DT,,SM Content Automation System Build,Upwork Bidding,,C&D Assignment,,,,,,
,Misc,⭐️⭐️⭐️,WK,"07:00AM - 09:00AM, 12:00PM - 03:00PM, 08:00PM - 09:00PM",,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Creating AI Automation Offer for Upwork & Fiverr Clients,,DMS Assignment,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,"09:00AM - 11:00AM, 03:00PM - 03:30PM, 10:30PM - 11:00PM",3,BK 11:00AM - 12:00PM,,How AI Works From Sorcery,,,hassan project,,SE Assignment,,,,,,
,SM Content Automation System Build,⭐️⭐️⭐️,WK,03:40PM - 07:10PM,,,,Data Science Course,,,,,,,,,,,
,C & D Assignment,⭐️⭐️⭐️,UN,09:00PM - 10:30PM,,,,AI Automations Learning,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,"02:00AM - 09:00AM, 07:00PM - 09:00PM SP",03/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️⭐️⭐️,WK,"11:00PM - 12:40AM, 10:30PM - 12:00AM",,,,DT,,SM Content Automation System Build,Upwork Bidding,,DMS Assignment,,,,,,
,C & D,⭐️⭐️⭐️,UN,09:00AM - 12:40PM,,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Creating AI Automation Offer for Upwork & Fiverr Clients,,SE Assignment,,,,,,
,Misc - Lib,⭐️⭐️⭐️,UN,"12:40PM - 02:30PM, 03:30PM - 04:30PM",3,,,How AI Works From Sorcery,,,hassan project,,,,,,,,
,SE,⭐️⭐️⭐️,UN,04:30PM - 06:30PM,,BK 02:30PM - 03:30PM,,Data Science Course,,,,,,,,,,,
,,,,,,,,AI Automations Learning,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,,04/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️⭐️⭐️,WK,"12:00AM - 01:30AM, 05:00AM - 07:00AM, 07:00PM - 08:00PM",,,,DT,,SM Content Automation System Build,Upwork Bidding,,DMS Assignment,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,01:30AM - 02:30AM,3,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Creating AI Automation Offer for Upwork & Fiverr Clients,,SE Assignment,,,,,,
,SM Content Automation System Build,⭐️⭐️⭐️,WK,02:30AM - 05:00AM,,,,How AI Works From Sorcery,,,hassan project,,,,,,,,
,DBMS,⭐️⭐️⭐️,UN,07:30PM - 11:00AM,,,,Data Science Course,,,Detailed Web Proposals Automation,,,,,,,,
,Misc,⭐️⭐️⭐️,UN,11:00AM - 3:00PM,,,,AI Automations Learning,,,,,,,,,,,
,Project Foundation,⭐️⭐️⭐️,WK,03:00PM - 06:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,09:00PM - 06:00AM SP,05/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️⭐️⭐️,WK,"08:00AM - 09:30AM, 06:00PM - 11:00PM",,,,DT,,SM Content Automation System Build,Upwork Bidding,,DMS Assignment,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,09:30AM - 12:30PM,2,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Creating AI Automation Offer for Upwork & Fiverr Clients,,SE Assignment,,,,,,
,Misc,⭐️⭐️⭐️,UN,12:30PM - 06:00PM,,,,How AI Works From Sorcery,,,hassan project,,,,,,,,
,,,,,,,,Data Science Course,,,Detailed Web Proposals Automation,,,,,,,,
,,,,,,,,AI Automations Learning,,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,,,
,,,,,,,,,,,Project Foundation,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,,06/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️⭐️⭐️,WK,11:00AM - 07:00PM,2,09:00PM - 06:00AM SP,,DT,,SM Content Automation System Build,Upwork Bidding,,DMS Assignment,,,,,,
,,,,,,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Creating AI Automation Offer for Upwork & Fiverr Clients,,SE Assignment,,,,,,
,,,,,,,,How AI Works From Sorcery,,,hassan project,,,,,,,,
,,,,,,,,Data Science Course,,,Detailed Web Proposals Automation,,,,,,,,
,,,,,,,,AI Automations Learning,,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,,,
,,,,,,,,,,,Project Foundation,,,,,,,,
,,,,,,,,,,,Project Hunter Trading,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,,07/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️⭐️⭐️,WK,12:00AM - 05:00AM,,,,DT,,SM Content Automation System Build,Creating AI Automation Offer for Upwork & Fiverr Clients,,DMS Assignment,,,,,,
,hassan project,⭐️⭐️⭐️,WK,06:00AM - 10:30AM,,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,hassan project,,SE Assignment,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:30AM - 12:00PM,3,,,How AI Works From Sorcery,,,Detailed Web Proposals Automation,,,,,,,,
,Misc,⭐️⭐️⭐️,WK,"12:00PM - 04:30PM, 09:30PM - 10:45PM",,,,Data Science Course,,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,,,
,AI Automations Learning,⭐️⭐️⭐️,LR,04:30PM - 09:30PM,,,,AI Automations Learning,,,Project Foundation,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,11:00AM - 02:00PM SP,09/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Traveling,⭐️⭐️⭐️,PR,07:00PM - 11:00AM,,,,DT,,SM Content Automation System Build,Creating AI Automation Offer for Upwork & Fiverr Clients,,DMS Assignment,,,,,,
,Misc,⭐️⭐️⭐️,WK,"02:00PM - 04:45PM, 06:30PM - 08:10PM",,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Detailed Web Proposals Automation,,SE Assignment,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,04:45PM - 6:30PM,2,15,,How AI Works From Sorcery,,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,,,
,OWF,⭐️⭐️⭐️,PR,07:00PM - 02:00AM,,,,Data Science Course,,,Content Posting Schedule,,,,,,,,
,,,,,,,,AI Automations Learning,,,Upwork Bidding,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,03:00AM - 07:00AM SP,10/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️⭐️⭐️,PR,"07:00AM - 04:00PM, 09:00PM -12:00AM",,,,DT,,SM Content Automation System Build,Creating AI Automation Offer for Upwork & Fiverr Clients,,DMS Assignment,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,04:45PM - 08:30PM,4,15,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Detailed Web Proposals Automation,,SE Assignment,,,,,,
,,,,,,,,How AI Works From Sorcery,,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,,,
,,,,,,,,Data Science Course,,,Upwork Bidding,,,,,,,,
,,,,,,,,AI Automations Learning,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,12:00AM - 07:00AM SP,11/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️⭐️⭐️,PR,07:00AM - 02:00PM,,,,DT,,SM Content Automation System Build,Creating AI Automation Offer for Upwork & Fiverr Clients,,DMS Assignment,,,,,,
,Misc,⭐️⭐️⭐️,WK,02:00PM - 03:00PM,,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Detailed Web Proposals Automation,,SE Assignment,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,03:00PM - 06:00PM,3,,,How AI Works From Sorcery,,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,,,
,OT,⭐️⭐️⭐️,PR,08:00PM - 12:00AM,,,,Data Science Course,,,Upwork Bidding,,,,,,,,
,,,,,,,,AI Automations Learning,,,SM Automation Case Study,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,,12/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Misc,⭐️⭐️⭐️,PR,07:00AM - 02:00PM,,,,DT,,SM Content Automation System Build,Creating AI Automation Offer for Upwork & Fiverr Clients,,DMS Assignment,,,,,,
,Misc,⭐️⭐️⭐️,WK,05:00PM - 07:00PM,,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Detailed Web Proposals Automation,,SE Assignment,,,,,,
,OT,⭐️⭐️⭐️,PR,08:00PM - 12:00AM,,,,How AI Works From Sorcery,,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,,,
,,,,,,,,Data Science Course,,,Upwork Bidding,,,,,,,,
,,,,,,,,AI Automations Learning,,,SM Automation Case Study,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,12:00AM - 07:00AM SP,13/11/2025,LR,,P-PR,WK,,UN,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,12:00AM - 02:00AM,2,,,DT,,SM Content Automation System Build,Creating AI Automation Offer for Upwork & Fiverr Clients,,DMS Assignment,,,,,,
,,,,,,,,Never split the difference ,,Client Brand Identity and Website Creation Automation,Detailed Web Proposals Automation,,SE Assignment,,,,,,
,,,,,,,,How AI Works From Sorcery,,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,,,
,,,,,,,,Data Science Course,,,Upwork Bidding,,,,,,,,
,,,,,,,,AI Automations Learning,,,SM Automation Case Study,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,04:00AM - 07:00AM SP,18/11/2025,IM,,UN,LR,,WK,,,,,,
,DBMS Lab,⭐️⭐️⭐️,UN,07:00AM - 11:00AM,,,,Peter meeting 11pm,,DMS Assignment,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Misc - Lib,⭐️⭐️⭐️,UN,11:00AM - 01:20PM,,,,Min meeting 9pm,,SE Assignment,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,DBMS,⭐️⭐️⭐️,UN,01:20PM - 02:20PM,,BK 07:40PM - 08:10PM,,AI Quiz,,,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,Misc - Upwork Bidding,⭐️⭐️⭐️,UN,02:20PM - 04:10PM,1,50,,DBMS Quiz,,,Data Science Course,,SM Automation Case Study,,,,,,
,AI,⭐️⭐️⭐️,UN,04:20PM - 06:30PM,,,,Project foundation,,,AI Automations Learning,,,,,,,,
,Misc,⭐️⭐️⭐️,WK,06:30PM - 09:00PM,,,,Project propwatchlist,,,,,,,,,,,
,Min meeting 9pm,⭐️⭐️⭐️,WK,09:00PM - 09:35PM,,,,Upwork Bidding,,,,,,,,,,,
,,,,,,,,2 SE Assignment - 24,,, ,,,,,,,,
,,,,,,,,C&D Assignment - 20,,,,,,,,,,,
,,,,,,,,WL Assignment - 21,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,03:00AM - 12:00PM SP,19/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,09:35PM - 01:10AM,,,,Peter meeting 11pm,,DMS Assignment,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Misc,⭐️⭐️⭐️,UN,12:00PM - 06:00PM,2,,,AI Quiz,,SE Assignment,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,BK W,⭐️⭐️⭐️,PR,06:00PM - 07:10PM,,,,DBMS Quiz,,,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,Project foundation,⭐️⭐️⭐️,WK,08:00PM - 10:30PM,,,,Project foundation,,,Data Science Course,,SM Automation Case Study,,,,,,
,Expense Calc,⭐️⭐️⭐️,WK,10:30PM - 01:00AM,,,,Project propwatchlist,,,AI Automations Learning,,,,,,,,
,,,,,,,,Upwork Bidding,,,,,,,,,,,
,,,,,,,,2 SE Assignment - 24,,,,,,,,,,,
,,,,,,,,C&D Assignment - 20,,, ,,,,,,,,
,,,,,,,,WL Assignment - 21,,,,,,,,,,,
,,,,,,,,Expense Calc,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,07:00AM - 12:00PM SP,20/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,01:10AM - 02:30AM,,,,Peter Automation Quote,,DMS Assignment,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Assignments,⭐️⭐️⭐️,UN,02:30AM - 07:30AM,,,,Project foundation,,SE Assignment,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,AI - Lab,⭐️⭐️⭐️,UN,07:30AM - 11:40AM,,,,Project propwatchlist,,,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,Misc - Lib,⭐️⭐️⭐️,WK,11:40AM - 03:50PM,3,,,Upwork Bidding,,,Data Science Course,,SM Automation Case Study,,,,,,
,C&D - Lab,⭐️⭐️⭐️,UN,04:30PM - 06:30PM,,,,2 SE Assignment - 24,,,AI Automations Learning,,,,,,,,
,,,,,,,,C&D Assignment - 20,,,,,,,,,,,
,,,,,,,,WL Assignment - 21,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,,21/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️,TW,12:00AM - 05:00AM,,05:00AM - 11:00AM SP,,Project foundation,,SE Assignment,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Misc,⭐️⭐️⭐️,UN,11:30AM - 06:30PM,,,,Project propwatchlist,,C&D Quiz,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,Misc,⭐️⭐️⭐️,WK,06:30PM - 07:50PM,,,,Upwork Bidding,,,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,08:00PM - 11:10PM,3,10,,SE Assignment - 24,,,Data Science Course,,SM Automation Case Study,,,,,,
,Exam Schedule,⭐️⭐️⭐️,WK,11:10PM - 12:00AM,,,,C&D Lab Assignment - 24,,,AI Automations Learning,,,,,,,,
,,,,,,,,AI Lab Assignment - 24,,,,,,,,,,,
,,,,,,,,Exam Schedule,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,,22/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"12:00AM - 05:00AM, 04:00PM - 10:00PM",,07:00AM - 03:00PM SP,,Project foundation,,SE Assignment - 24,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:00PM - 01:00AM,3,,,Project propwatchlist,,SE Quiz - 24,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,,,,,,,,Upwork Bidding,,C&D Quiz - 27,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,,,,,,,,SE Assignment - 24,,WL Assignment Upload - 28,Data Science Course,,SM Automation Case Study,,,,,,
,,,,,,,,,,C&D Lab Assignment - 24,AI Automations Learning,,,,,,,,
,,,,,,,,,,AI Project - 27,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,07:00AM - 04:00PM SP,23/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"01:00AM - 05:00AM, 06:00PM - 07:00PM",,,,Project foundation,,C&D Quiz - 27,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Misc,⭐️,TW,05:00AM - 07:00AM,,,,Project propwatchlist,,WL Assignment Upload - 28,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,07:00PM - 01:00AM,5,,,Upwork Bidding,,C&D Lab Assignment - 24,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,,,,,,,,SE Assignment - 24,,AI Lab Assignment - 24,Data Science Course,,SM Automation Case Study,,,,,,
,,,,,,,,SE Quiz - 24,,AI Project - 27,AI Automations Learning,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,,24/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"01:00AM - 03:30AM, 06:00AM - 09:00AM, 08:00PM - 11:00PM",,,,Project foundation,,C&D Quiz - 27,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,03:30AM - 06:00AM,2.5,09:00AM - 01:00PM SP,,Project propwatchlist,,WL Assignment Upload - 28,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,Misc,⭐️⭐️⭐️,UN,04:00PM - 06:00PM,,,,Upwork Bidding,,C&D Lab Assignment - 24,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,RD,⭐️⭐️⭐️,PR,06:00PM - 07:30PM,,,,SE Assignment - 24,,AI Lab Assignment - 24,Data Science Course,,SM Automation Case Study,,,,,,
,Shekhar Meeting,⭐️⭐️⭐️,WK,11:30PM - 11:50PM,,,,SE Quiz - 24,,AI Project - 27,AI Automations Learning,,Agency Upwork Profile Niche Down,,,,,,
,,,,,,,,Shekhar Meeting,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,11:00AM - 05:00PM SP,25/11/2025,IM,,UN,LR,,WK,,,,,,
,Project Inbox,⭐️⭐️⭐️,WK,"12:00AM - 03:00AM, 05:00AM - 07:00AM",,,,Project foundation,,C&D Quiz - 27,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,03:00AM - 04:00AM,1,,,Project propwatchlist,,WL Assignment Upload - 28,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,Shekhar Automation Quote,⭐️⭐️⭐️,WK,04:00AM - 04:30AM,,,,Project Inbox,,C&D Lab Assignment - 24,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,Project foundation,⭐️⭐️⭐️,WK,04:30AM - 05:00AM,,,,Fiverr Project,,AI Lab Assignment - 24,Data Science Course,,SM Automation Case Study,,,,,,
,Misc,⭐️⭐️⭐️,UN,07:00AM - 11:00AM,,,,Shekhar Automation Quote,,AI Project - 27,AI Automations Learning,,Agency Upwork Profile Niche Down,,,,,,
,OUT,⭐️⭐️⭐️,PR,06:00PM - 09:30PM,,,,Peter Proposal,,,,,,,,,,,
,,,,,,,,Finding n8n Automation Devs,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,,26/11/2025,IM,,UN,LR,,WK,,,,,,
,WD,⭐️⭐️⭐️,PR,06:00PM - 07:30PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,,28/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,PR,06:00PM - 09:00PM,,,,Project foundation,,C&D Quiz - 27,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Misc,⭐️⭐️⭐️,WK,"09:00PM - 10:00PM, 02:00AM - 07:00AM",,,,Project propwatchlist,,WL Assignment Upload - 28,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:00PM - 02:00AM,4,,,Project Inbox,,C&D Lab Assignment - 24,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,Misc,⭐️⭐️⭐️,UN,07:00AM - 11:00AM,,,,Fiverr Project,,AI Lab Assignment - 24,Data Science Course,,SM Automation Case Study,,,,,,
,Lib - Upwork Bidding,⭐️⭐️⭐️,UN,11:30AM - 01:30PM,2,,,Peter Proposal,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,UN,11:30AM - 06:30PM,,,,Finding n8n Automation Devs,,,,,,,,,,,
,,,,,,,,Upwork Agency Profile Update,,,,,,,,,,,
,,,,,,,,Finding Video Editor,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,,29/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"06:00PM - 09:30PM, 11:50PM - 01:00PM",,,,Project foundation,,C&D Quiz - 27,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Upwork Bidder Interview,⭐️⭐️⭐️,WK,09:30PM - 10:00PM,,,,Project propwatchlist,,WL Assignment Upload - 28,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,Peter Interview Proposal,⭐️⭐️⭐️,WK,10:00PM - 10:30PM,,,,Project Inbox,,C&D Lab Assignment - 24,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,Upwork Agency Profile Update,⭐️⭐️⭐️,WK,10:30PM - 11:00PM,,,,Fiverr Project,,AI Lab Assignment - 24,Data Science Course,,SM Automation Case Study,,,,,,
,Project Inbox Review,⭐️⭐️⭐️,WK,11:00PM - 11:50PM,,,,Peter Meeting,,,,,Finding n8n Automation Devs,,,,,,
,,,,,,,,Upwork Agency Profile Update,,,,,Finding Video Editor,,,,,,
,,,,,,,,SE Exam Preparation,,,,,,,,,,,
,,,,,,,,AI Exam Preparation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,12:00PM - 09:00PM SP,30/11/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"11:50PM - 01:00AM, 07:00Am - 10:00AM",,BK 01:00AM - 01:40PM,,Project foundation,,C&D Quiz - 27,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Upwork Bidder Meeting - Abdul Basit,⭐️⭐️⭐️,WK,01:40AM - 02:20AM,,,,Project propwatchlist,,WL Assignment Upload - 28,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,02:40AM - 05:00AM,2,20,,Project Inbox,,C&D Lab Assignment - 24,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,Expense Calc,⭐️⭐️⭐️,PR,05:00AM - 07:00AM,,,,Fiverr Project,,AI Lab Assignment - 24,Data Science Course,,SM Automation Case Study,,,,,,
,,,,,,,,Peter Meeting,,,,,Finding n8n Automation Devs,,,,,,
,,,,,,,,Upwork Agency Profile Update,,,,,Finding Video Editor,,,,,,
,,,,,,,,SE Exam Preparation,,,,,,,,,,,
,,,,,,,,AI Exam Preparation,,,,,,,,,,,
,,,,,,,,Upwork Bidder Meeting - Abdul Basit,,,,,,,,,,,
,,,,,,,,Expense Calc,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,Tentatively 60 hours in bidding,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,03:00PM - 12:00PM SP,01/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,10:30PM - 01:00AM,,,,SE Exam Preparation,,Exams,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,01:00AM - 02:40AM,,,,AI Exam Preparation,,,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,SE Exam Preparation,⭐️⭐️⭐️,UN,02:40AM - 08:00AM,,,,Project foundation,,,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,SE Exam,⭐️⭐️⭐️,UN,09:00AM - 01:00PM,,,,Project propwatchlist,,,Data Science Course,,SM Automation Case Study,,,,,,
,TE,⭐️,TW,01:00PM - 03:00PM,,,,Project Inbox,,,,,Finding n8n Automation Devs,,,,,,
,,,,,,,,Fiverr Project,,,,,Finding Video Editor,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,,02/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,02:00AM - 04:00AM,,05:00PM - 01:30AM SP,,AI Exam Preparation,,Exams,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,04:00AM - 05:00AM,,,,Project propwatchlist,,,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,Project propwatchlist,⭐️⭐️⭐️,WK,05:00AM - 05:40AM,,,,Project Inbox,,,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,AI Exam Preparation,⭐️⭐️⭐️,UN,"05:40AM - 08:00AM, 08:30AM - 10:10AM",,BK 08:00AM - 08:30AM,,Fiverr Project,,,Data Science Course,,SM Automation Case Study,,,,,,
,AI Exam,⭐️⭐️⭐️,UN,11:00AM - 01:00PM,,,,,,,,,Finding n8n Automation Devs,,,,,,
,Misc,⭐️,TW,01:00PM - 05:00PM,,,,,,,,,Finding Video Editor,,,,,,
,,,,,,        ,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,,03/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,01:00AM - 02:00AM,,,,WL Exam Preparation,,Exams,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,Project propwatchlist,⭐️⭐️⭐️,WK,02:00AM - 04:00AM,,,,Project propwatchlist,,,Never split the difference ,,Detailed Web Proposals Automation,,,,,,
,WL Exam Preparation,⭐️⭐️⭐️,UN,04:00AM - 07:00AM,,,,Project Inbox,,,How AI Works From Sorcery,,"Agency Landing Page, Domain, Hosting, Email,  ",,,,,,
,AI Exam,⭐️⭐️⭐️,UN,11:00AM - 01:00PM,,,,Fiverr Project,,,Data Science Course,,SM Automation Case Study,,,,,,
,,,,,,,,Peter Automation Project,,,,,Finding n8n Automation Devs,,,,,,
,,,,,,,,,,,,,Finding Video Editor,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,03:00PM - 01:30AM SP,,,,,,,,,,,,,
TH,,,,,,,04/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️,TW,01:30AM - 05:00AM,,,,CD Exam Preparation,,Exams,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,DT,⭐️⭐️⭐️,PR,05:00AM - 07:00AM,,,,DB Exam Preparation,,,Never split the difference ,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,WK,"07:00AM - 09:00AM, 01:30PM - 02:30PM",,,,Project propwatchlist,,,How AI Works From Sorcery,,Detailed Web Proposals Automation,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:00AM - 11:40AM,,,,Project Inbox,,,Data Science Course,,"Agency Landing Page, Domain, Hosting, Email",,,,,,
,Peter Automation Project,⭐️⭐️⭐️,WK,12:00PM - 12:16PM,,BK 01:00PM - 01:30PM,,Fiverr Project,,,,,SM Automation Case Studies Creations,,,,,,
,"Finding Video Editor, Bidder & N8N ",⭐️⭐️⭐️,WK,12:16PM - 01:00PM,,,,Peter Automation Project,,,,,Finding n8n Automation Devs,,,,,,
,,,,,,,,,,,,,Finding Video Editor,,,,,,
,,,,,,,,,,,,,Finding Upwork Bidder,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,"07:00PM - 01:30AM, 04:00AM - 07:00AM SP",05/12/2025,IM,,UN,LR,,WK,,,,,,
,DB Exam Preparation,⭐️⭐️⭐️,UN,05:00AM - 07:00AM,,,,CD Exam Preparation,,Exams,DT,,Creating AI Automation Offer for Upwork & Fiverr Clients,,,,,,
,DB Exam,⭐️⭐️⭐️,UN,08:30AM - 10:00AM,,,,DB Exam Preparation,,,Never split the difference ,,Upwork Bidding,,,,,,
,CD Exam Preparation,⭐️⭐️⭐️,UN,11:00AM - 01:30PM,,,,Project propwatchlist,,,How AI Works From Sorcery,,Detailed Web Proposals Automation,,,,,,
,DB Exam,⭐️⭐️⭐️,UN,01:30PM - 03:00PM,,,,Project Inbox,,,Data Science Course,,"Agency Landing Page, Domain, Hosting, Email",,,,,,
,Misc,⭐️⭐️⭐️,TW,"03:00PM - 07:00PM, 01:30AM - 04:00AM",,,,Fiverr Project,,,,,SM Automation Case Studies Creations,,,,,,
,,,,,,,,Peter Automation Project,,,,,Finding n8n Automation Devs,,,,,,
,,,,,,,,,,,,,Finding Video Editor,,,,,,
,,,,,,,,,,,,,Finding Upwork Bidder,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,"07:00PM - 01:30AM, 04:00AM - 07:00AM SP",06/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,09:30AM - 04:30PM,,,,Project Propwatchlist,,,How AI Works From Sorcery,,Detailed Web Proposals Automation,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,04:30PM - 08:00PM,,,,Project Inbox,,,Data Science Course,,"Agency Landing Page, Domain, Hosting, Email",,,,,,
,"Finding Video Editor, Bidder & N8N ",⭐️⭐️⭐️,WK,08:16PM - 11:30PM,,,,Fiverr Project,,,Never split the difference ,,SM Automation Case Studies Creations,,,,,,
,Project Inbox,⭐️⭐️⭐️,WK,11:30PM - 12:00AM,,,,Project Slipssy,,,Starting Data Science Course,,Upwork Bidding,,,,,,
,,,,,,,,Automation Learning,,,,,Automation Offer to Pitch Upwork Clients,,,,,,
,,,,,,,,Automation Project,,,,,,,,,,,
,,,,,,,,"Finding Video Editor, Bidder & N8N ",,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,02:00AM - 07:00AM SP,07/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"12:00AM - 01:10AM, 07:00PM - 08:20PM",,,,Project Propwatchlist,,,How AI Works From Sorcery,,Detailed Web Proposals Automation,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:40AM - 04:20PM,,BK 04:40PM - 05:00PM,,Project Inbox,,,Data Science Course,,"Agency Landing Page, Domain, Hosting, Email",,,,,,
,Project Inbox,⭐️⭐️⭐️,WK,05:30PM - 06:00PM,,,,Fiverr Project,,,Never split the difference ,,SM Automation Case Studies Creations,,,,,,
,Upwork Bidding Areeba Training,⭐️⭐️⭐️,WK,08:30PM - 09:40PM,,,,Project Slipssy,,,Starting Data Science Course,,Upwork Bidding,,,,,,
,,,,,,,,Automation Learning,,,,,Automation Offer to Pitch Upwork Clients,,,,,,
,,,,,,,,Automation Project,,,,,,,,,,,
,,,,,,,,"Finding Video Editor, Bidder & N8N ",,,,,,,,,,,
,,,,,,,,Shuja Uddin upwork bidder meeting 8pm,,,,,,,,,,,
,,,,,,,,Muhamad Hasan upwork bidder meeting 9pm,,,,,,,,,,,
,,,,,,,,Ade Dar Upwork Automation Meeting 4:15pm - 05:00PM,,,,,,,,,,,
,,,,,,,,14:30,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,10:00PM - 07:00AM SP,08/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"10:00AM - 11:50AM, 05:00PM - 07:00PM",,,,Mohammad Saad Gohar upwork bidder meeting 02:30 pm,,DBMS Lab Exam ,Automation Learning,,Upwork Bidding,,,,,,
,SM Management,⭐️⭐️⭐️,WK,11:50AM - 02:25PM,,,,Ade Dar Upwork Automation Meeting 4:15pm - 05:00pm,,,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,Mohammad Saad Gohar upwork bidder meeting 02:30 pm,⭐️⭐️⭐️,WK,02:25PM - 02:40PM,,,,Shuja Uddin upwork bidder meeting 8pm,,,Data Science Course,,SM Automation Case Studies Creations,,,,,,
,Weekly Content Upload,⭐️⭐️⭐️,WK,02:40PM - 03:30PM,,,,Muhamad Hasan upwork bidder meeting 9pm,,,Never split the difference ,,Automation Project,,,,,,
,Ade Dar Upwork Automation Meeting 4:15pm - 05:00pm,⭐️⭐️⭐️,WK,04:15PM - 04:40PM,,BK 04:40PM - 05:00PM,,Eman upwork bidder meeting 10pm,,,Starting Data Science Course,,Project Propwatchlist,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,07:30PM - 08:30PM,,,,,,,,,Project Inbox,,,,,,
,,,,,,,,,,,,,Fiverr Project,,,,,,
,,,,,,,,,,,,,Project Slipssy,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,10:00PM - 07:00AM SP,09/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,07:00AM - 08:00AM,,,,Automation Learning,,DBMS Lab Exam ,Automation Learning,,Upwork Bidding,,,,,,
,DBMS Lab Exam ,⭐️⭐️⭐️,UN,08:00AM - 11:00AM,,"BK 11:00AM - 12:00PM, 07:30PM - 07:50PM",,Automation Project,,,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,"MIcs Lib - Upwork, SM",⭐️⭐️⭐️,UN,12:00PM - 02:30PM,,,,,,,Data Science Course,,SM Automation Case Studies Creations,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,UN,02:30PM - 04:30PM,,,,,,,Never split the difference ,,Automation Project,,,,,,
,AI,⭐️⭐️⭐️,UN,04:30PM - 06:00PM,,,,,,,Starting Data Science Course,,Project Propwatchlist,,,,,,
,SM Content Scraping,⭐️⭐️⭐️,WK,07:00PM - 10:00PM,,,,,,,,,Project Inbox,,,,,,
,,,,,,,,,,,,,Fiverr Project,,,,,,
,,,,,,,,,,,,,Project Slipssy,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,12:00PM - 08:00AM SP,10/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️,TW,08:00AM - 11:00AM,,,,Automation Learning,,DBMS Lab Exam ,Automation Learning,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,WK,"11:30AM - 12:30PM, 05:40PM - 09:10PM",,,,Automation Project,,,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,Uni WL ,⭐️⭐️⭐️,UN,12:30PM - 02:45PM,,BK 08:00PM - 08:30PM,,AI Project Setup,,,Data Science Course,,SM Automation Case Studies Creations,,,,,,
,Bank,⭐️⭐️⭐️,PR,02:50PM - 04:10PM,,,,,,,Never split the difference ,,Automation Project,,,,,,
,Uni DBMS,⭐️⭐️⭐️,UN,04:30PM - 05:20PM,,,,,,,Starting Data Science Course,,Project Propwatchlist,,,,,,
,AI Project Setup,⭐️⭐️⭐️,UN,09:10PM - 10:20PM,,,,,,,,,Project Inbox,,,,,,
,Upwork,⭐️⭐️⭐️,WK,10:20PM - 02:00AM,,,,,,,,,Fiverr Project,,,,,,
,,,,,,,,,,,,,Project Slipssy,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,"03:00AM - 06:00AM, 11:00AM - 03:00PM SP",11/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"02:00AM - 03:00AM, 06:00PM -  07:30PM",,,,Project Succession,,DBMS Lab Exam ,Automation Learning,,Upwork Bidding,,,,,,
,Uni AI Lab,⭐️⭐️⭐️,UN,06:30AM - 11:00AM,,BK 07:30PM - 08:00PM,,Automation Learning,,,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,Misc,⭐️,TW,03:00PM - 06:00PM,,,,Automation Project,,,Data Science Course,,SM Automation Case Studies Creations,,,,,,
,Project Succession,⭐️⭐️⭐️,UN,08:00PM - 09:00PM,,,,AI Project Setup,,,Never split the difference ,,Project Slipssy,,,,,,
,,,,,,,,Fiverr Project,,,Starting Data Science Course,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,"03:00AM - 06:00AM, 11:00AM - 03:00PM SP",12/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,09:00PM - 01:20AM,,,,Project Succession,,DBMS Lab Exam ,Automation Learning,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,UN,11:00AM - ,,,,Automation Learning,,,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,,,,,,,,Automation Project,,,Data Science Course,,SM Automation Case Studies Creations,,,,,,
,,,,,,,,AI Project Setup,,,Never split the difference ,,Project Slipssy,,,,,,
,,,,,,,,Fiverr Project,,,Starting Data Science Course,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,,13/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,09:30PM - 10:00PM,,,,Project Succession,,DBMS Lab Exam ,Automation Learning,,Upwork Bidding,,,,,,
,Upwork,⭐️⭐️⭐️,UN,10:00PM - 03:00AM,,,,Automation Learning,,,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,,,,,,,,Automation Project,,,Data Science Course,,SM Automation Case Studies Creations,,,,,,
,,,,,,,,AI Project Setup,,,Never split the difference ,,Project Slipssy,,,,,,
,,,,,,,,Fiverr Project,,,Starting Data Science Course,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,,14/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️,TW,08:00AM - 12:00PM,,,,Project Succession,, AI,Automation Learning,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,WK,"12:00PM - 02:00PM, 08:00PM - 08:30PM",,,,Automation Learning,,,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,SM Content Management,⭐️⭐️⭐️,WK,02:00PM - 06:30PM,,,,Automation Project,,,Data Science Course,,,,,,,,
,Freelancers Payment Cleared,⭐️⭐️⭐️,WK,06:30PM - 07:05PM,,BK 07:05PM - 08:00PM,,AI Project Setup,,,Never split the difference ,,Project Slipssy,,,,,,
,,,,,,,,IGACDL Fiverr Project,,,Starting Data Science Course,,,,,,,,
,,,,,,,,SM Automation Case Studies Creations,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,11:00AM - 08:00AM SP,,,,,,,,,,,,,
MD,,,,,,,15/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,UN,11:00AM - 06:30PM,,,,Project Succession,, AI,Automation Learning,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,WK,07:30PM - 02:00AM,,,,Automation Learning,,,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,,,,,,,,Automation Project,,,Data Science Course,,,,,,,,
,,,,,,,,AI Project Setup,,,Never split the difference ,,Project Slipssy,,,,,,
,,,,,,,,IGACDL Fiverr Project,,,Starting Data Science Course,,,,,,,,
,,,,,,,,11 PM Upwork Bidding Meeting,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,,16/12/2025,IM,,UN,LR,,WK,,,,,,
,AI Project Setup,⭐️⭐️⭐️,UN,02:00AM - 04:30AM,,05:00AM - 09:00AM SP,,Project Succession,, AI,Automation Learning,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,WK,"11:00AM - 12:30PM, 05:40PM - 08:10PM ",,,,Automation Learning,,SE Quiz Monday,How AI Works From Sorcery,,Automation Offer to Pitch Upwork Clients,,,,,,
,DBMS,⭐️⭐️⭐️,UN,12:30PM - 02:45PM,,,,AI Automation Proposals,,,Data Science Course,,Project Slipssy,,,,,,
,AI Project Setup,⭐️⭐️⭐️,UN, 02:45PM - 04:30PM,,,,AI Project Setup,,,Never split the difference ,,,,,,,,
,AI Class,⭐️⭐️⭐️,UN, 04:30PM - 05:40PM,,,,,,,Starting Data Science Course,,,,,,,,
,Upwork,⭐️⭐️⭐️,WK,08:10PM - 11:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,,17/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"08:00AM - 09:45AM, 06:30PM - 09:30PM",,"12:00AM - 06:00AM, 11:00AM - 01:00PM SP",,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,09:45AM - 10:45AM,,,,AI Automation Proposals,,SE Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,Classes,⭐️⭐️⭐️,UN, 04:30PM - 06:30PM,,,,Project GSA,,,Never split the difference ,,Project Slipssy,,,,,,
,,,,,,,,Project Toy-Finder,,,Starting Data Science Course,,,,,,,,
,,,,,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Succession,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,,18/12/2025,IM,,UN,LR,,WK,,,,,,
,AI Lab,⭐️⭐️⭐️,UN,07:30AM - 10:50AM,,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,WK,11:00AM - 12:30PM,,,,AI Automation Proposals,,SE Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,SM Content Management ,⭐️⭐️⭐️,WK,12:30PM - 01:30PM,,,,Project GSA,,,Never split the difference ,,Project Slipssy,,,,,,
,Project GSA,⭐️⭐️⭐️,WK,01:30PM - 02:15PM,,,,Project Toy-Finder,,,Starting Data Science Course,,,,,,,,
,,,,,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Succession,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,,19/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,"01:00PM - 03:00PM, 06:30PM - 08:00PM",,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,03:00PM - 06:00PM,,,,AI Automation Proposals,,SE Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,Fiverr,⭐️⭐️⭐️,WK,08:00PM - 10:00PM,,,,Project GSA,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,Automation Learning,⭐️⭐️⭐️,WK,11:00PM - 03:00AM,,,,Project Toy-Finder,,,Starting Data Science Course,,,,,,,,
,,,,,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Succession,,,,,,,,,,,
,,,,,,,,Project Moji,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,05:00AM - 12:00PM SP,,,,,,,,,,,,,
ST,,,,,,,20/12/2025,IM,,UN,LR,,WK,,,,,,
,Out,⭐️⭐️⭐️,PR,01:00PM - 02:30PM,,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,WK,"03:00PM - 04:30PM, 11:00PM - 12:00AM",,,,AI Automation Proposals,,SE Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,SM Content Management ,⭐️⭐️⭐️,WK,04:30PM - 07:00PM,,,,Project GSA,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,"07:00PM - 08:00PM, 09:40PM - 10:30PM",,,,Project Toy-Finder,,,Starting Data Science Course,,SM Content Management ,,,,,,
,Project GSA,⭐️⭐️⭐️,WK,08:00PM - 09:20PM,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Moji,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,05:00AM - 12:00PM SP,21/12/2025,IM,,UN,LR,,WK,,,,,,
,Finding Fiverr Expert,⭐️⭐️⭐️,WK,12:00AM - 12:30AM,,,,SE Quiz Monday,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Automation Learning,⭐️⭐️⭐️,WK,12:30AM - 03:30AM,,BK 02:00PM - 03:00PM,,Automation Learning,,DBMS Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,Misc,⭐️,TW,"12:00PM - 01:30PM, 10:30PM - 12:20AM",,,,AI Automation Proposals,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,Project Moji,⭐️⭐️⭐️,WK,03:00PM - 03:30PM,,,,Project GSA,,,Starting Data Science Course,,SM Content Management ,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,03:30PM - 05:45PM,,,,Project Toy-Finder,,,,,,,,,,,
,Automation Learning,⭐️⭐️⭐️,WK,06:30PM - 10:30PM,,,,Project Eco System,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,WK,10:30PM - 12:20AM,,,,Project Moji,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,03:00AM - 08:00AM SP,22/12/2025,IM,,UN,LR,,WK,,,,,,
,C&D,⭐️⭐️⭐️,UN,10:00AM - 12:30PM,,,,SE Quiz Monday,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,KNCT - Misc,⭐️⭐️⭐️,WK,12:30PM - 4:30PM,,,,Automation Learning,,DBMS Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,SE,⭐️⭐️⭐️,UN,04:30PM - 06:30PM,,,,AI Automation Proposals,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,Misc,⭐️⭐️⭐️,WK,06:30PM - 07:30PM,,,,Project GSA,,,Starting Data Science Course,,SM Content Management ,,,,,,
,Shana Meeting,⭐️⭐️⭐️,WK,08:00PM - 08:20PM,,,,Project Toy-Finder,,,,,,,,,,,
,,,,,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Moji,,,,,,,,,,,
,,,,,,,,Project halloEnergie,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,03:00AM - 08:00AM SP,23/12/2025,IM,,UN,LR,,WK,,,,,,
,Misc,⭐️⭐️⭐️,WK,01:00PM - 01:30PM,,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,SM Content Management ,⭐️⭐️⭐️,WK,"01:30PM - 08:40PM, 09:10PM - 01:10AM",,BK 08:40PM - 09:10PM,,AI Automation Proposals,,DBMS Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,,,,,,,,Project GSA,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,,,,,,,,Project Toy-Finder,,,Starting Data Science Course,,,,,,,,
,,,,,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Moji,,,,,,,,,,,
,,,,,,,,Project halloEnergie,,,,,,,,,,,
,,,,,,,,SM Content Management ,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,04:00AM - 01:00PM SP,,,,,,,,,,,,,
WD,,,,,,,24/12/2025,IM,,UN,LR,,WK,,,,,,
,Project GSA,⭐️⭐️⭐️,WK,01:10AM - 01:40AM,,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Project halloEnergie,⭐️⭐️⭐️,WK,01:40AM - 02:00AM,,,,AI Automation Proposals,,DBMS Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,"02:00AM - 02:50AM, 05:30PM - 07:40PM, 08:20PM - 10:00PM",,BK 07:40PM - 08:20PM,,Project GSA,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,Misc,⭐️⭐️⭐️,WK,03:00PM - 05:30PM,,,,Project Toy-Finder,,,Starting Data Science Course,,Cold Email Setup,,,,,,
,Automation Learning,⭐️⭐️⭐️,WK,10:20PM - 03:40AM,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Moji,,,,,,,,,,,
,,,,,,,,Project halloEnergie,,,,,,,,,,,
,,,,,,,,SM Content Management ,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,07:00AM - 03:00PM SP,25/12/2025,IM,,UN,LR,,WK,,,,,,
,SM Content Management ,⭐️⭐️⭐️,WK,03:40AM - 04:20AM,,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Misc,⭐️⭐️⭐️,WK,"04:20AM - 05:00AM, 04:30PM - 05:40PM, 07:30PM - 08:00PM",,BK 08:00PM - 09:00PM,,AI Automation Proposals,,DBMS Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,05:40PM - 07:30PM,,,,Project GSA,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,Automation Learning,⭐️⭐️⭐️,WK,09:00PM - 12:10AM,,,,Project Toy-Finder,,,Starting Data Science Course,,Cold Email Setup,,,,,,
,,,,,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Moji,,,,,,,,,,,
,,,,,,,,Project halloEnergie,,,,,,,,,,,
,,,,,,,,SM Content Management ,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,08:00AM - 12:00PM,26/12/2025,IM,,UN,LR,,WK,,,,,,
,Automation Learning,⭐️⭐️⭐️,LR,12:55AM - 06:30AM,,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Misc,⭐️,WK,06:30AM - 08:00AM,,BK 06:00PM - 08:00PM,,AI Automation Proposals,,DBMS Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,Misc,⭐️⭐️⭐️,WK,04:00PM - 06:00PM,,,,Project GSA,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,Automation Learning,⭐️⭐️⭐️,LR,09:15PM - 06:00AM,,,,Project Toy-Finder,,,Starting Data Science Course,,Cold Email Setup,,,,,,
,,,,,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Moji,,,,,,,,,,,
,,,,,,,,Project halloEnergie,,,,,,,,,,,
,,,,,,,,SM Content Management ,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,08:00AM - 04:00PM,27/12/2025,IM,,UN,LR,,WK,,,,,,
,,,,,,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Automation Learning,⭐️⭐️⭐️,LR,08:30PM - 05:30AM,,,,AI Automation Proposals,,DBMS Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,,,,,,,,Project GSA,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,,,,,,,,Project Toy-Finder,,,Starting Data Science Course,,Cold Email Setup,,,,,,
,,,,,,,,Project Eco System,,,,,,,,,,,
,,,,,,,,Project Moji,,,,,,,,,,,
,,,,,,,,Project halloEnergie,,,,,,,,,,,
,,,,,,,,SM Content Management ,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,01:00PM - 06:00PM,28/12/2025,IM,,UN,LR,,WK,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,05:30AM - 07:00AM,,,,Automation Learning,, AI,How AI Works From Sorcery,,Upwork Bidding,,,,,,
,Automation Learning,⭐️⭐️⭐️,LR,07:00AM - 11:30AM,,,,AI Automation Proposals,,DBMS Quiz Monday,Data Science Course,,Automation Offer to Pitch Upwork Clients,,,,,,
,Laiveai AI Meeting 10PM,⭐️⭐️⭐️,WK,12:00PM - 12:40PM,,,,Laiveai AI Meeting 10PM,,,Never split the difference ,,Finding Fiverr Expert,,,,,,
,HC,⭐️⭐️⭐️,PR,07:00PM - 10:00PM,,,,Project halloEnergie,,,Starting Data Science Course,,Cold Email Setup,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:30PM - 11:00PM,,,,SM Content Management ,,,,,Project GSA,,,,,,
,,,,,,,,,,,,,Project Toy-Finder,,,,,,
,,,,,,,,,,,,,Project Eco System,,,,,,
,,,,,,,,,,,,,Project Moji,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,Sleep 11:00AM - 06:00PM,29/12/2025,IM,Projs,UN,LR,SM,WK,,,RD,CL,,
,Automation Learning,⭐️⭐️⭐️,LR,12:00AM - 03:30AM,,,,AI Automation Proposals,Project GSA, AI,Resuming Data Science Course,SM Content Posting,Automation Case Studies,,,How AI Works From Sorcery,DT,,
,Misc,⭐️⭐️⭐️,WK,03:30PM - 04:40AM,,,,Project halloEnergie,Project Toy-Finder,DBMS Lab Task,Python Data Science Libraries,SM Automated DMs,Cold Email Setup,,,Data Science Course,,,
,Agentic Workflow,⭐️⭐️⭐️,LR,05:30AM - 08:00AM,,,,SM Content Management ,Project Eco System,,,,Automation Offer to Pitch Upwork Clients,,,Never split the difference ,,,
,Misc,⭐️⭐️⭐️,WK,06:30PM - 10:30PM,,,,Upwork Bidding,Project Moji,,,,Finding Fiverr Expert,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:30PM - 11:40PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,Sleep 04:00PM - 09:00PM,30/12/2025,IM,Projs,UN,LR,SM,WK,,,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,"11:40PM - 12:25AM, 06:00AM - 06:30AM",,,,AI Automation Proposals,Project GSA, AI,Resuming Data Science Course,SM Content Posting,Automation Case Studies,,,How AI Works From Sorcery,SM Content Automation System Build,DT,
,,⭐️⭐️⭐️,LR,12:30AM - 03:00AM,,BK 06:30AM - 07:00AM,,Project halloEnergie,Project Toy-Finder,Class,Python Data Science Libraries,SM Automated DMs,Cold Email Setup,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,PR Productivity MVP,⭐️⭐️⭐️,LR,03:00AM - 05:00AM,,,,SM Content Management ,Project Eco System,,,,Automation Offer to Pitch Upwork Clients,,,Never split the difference ,Insta DM Automation,,
,SM Content Posting,⭐️⭐️⭐️,SM,05:30AM - 06:00AM,,,,,Project Moji,,,,Agency Website Setup,,,,,,
,DBMS Lab,⭐️⭐️⭐️,UN,07:30AM - 11:00AM,,,,,PR Productivity MVP,,,,Finding Fiverr Expert,,,,,,
,Agency Website Setup,⭐️⭐️⭐️,UN,11:20AM - 12:20PM,,,,,,,,,Upwork Bidding,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,,31/12/2025,IM,Projs,UN,LR,SM,WK,,,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,"10:00PM - 02:05AM, 07:00PM - 07:40PM",,,,AI Automation Proposals,Project halloEnergie, AI,Resuming Data Science Course,SM Content Posting,Automation Case Studies,,,How AI Works From Sorcery,SM Content Automation System Build,DT,
,Expense Calculation,⭐️⭐️⭐️,PR,02:05AM - 05:40AM,,,,Project GSA,Project Toy-Finder,Class,Python Data Science Libraries,SM Automated DMs,Cold Email Setup,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,SM Content Management ,⭐️⭐️⭐️,SM,05:40AM - 07:00AM,,BK 08:10AM - 09:00AM,,Expense Calculation,Project Eco System,,,SM Content Management ,Automation Offer to Pitch Upwork Clients,,,Never split the difference ,Insta DM Automation,,
,Upwork Bidding,⭐️⭐️⭐️,WK,07:00AM - 08:00AM,,,,Hassan Projects Report,Project Moji,,,,Agency Website Setup,,,,,,
,SM Content Management ,⭐️⭐️⭐️,WK,08:00PM - 09:00PM,,,,Quiz DBMS,PR Productivity MVP,,,,Finding Fiverr Expert,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,09:30PM - 10:30PM,,,,Upwork Bidder Meeting,,,,,Upwork Bidding,,,,,,
,Project GSA,⭐️⭐️⭐️,WK,10:30PM - 11:30PM,,,,Automation Case Studies,,,,,,,,,,,
,Project halloEnergie,⭐️⭐️⭐️,WK,11:30PM - 12:00AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,Sleep 01:00PM - 09:00PM,01/01/2026,IM,Projs,UN,LR,SM,WK,,,RD,ATs,CL,
,Upwork Bidding,⭐️⭐️⭐️,WK,12:00AM - 02:00AM,,,,AI Automation Proposals,Project halloEnergie, AI,Resuming Data Science Course,SM Content Posting,Automation Case Studies,,,How AI Works From Sorcery,SM Content Automation System Improvements,,
,SM Content Management ,⭐️⭐️⭐️,WK,02:00AM - 07:05AM,,,,Project GSA,Project Toy-Finder,Class,Python Data Science Libraries,SM Automated DMs,Cold Email Setup,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,AI Lab,⭐️⭐️⭐️,UN,07:05AM - 11:00AM,,,,Hassan Projects Report,Project Moji,,,SM Content Management ,Automation Offer to Pitch Upwork Clients,,,Never split the difference ,Insta DM Automation,,
,Misc,⭐️⭐️⭐️,WK,10:00PM - 01:00AM,,,,Upwork Bidder Meeting - 8PM,PR Productivity MVP,,,,Agency Website Setup,,,,,,
,,,,,,,,Automation Case Studies,Agency Website,,,,Finding Fiverr Expert,,,,,,
,,,,,,,,,,,,,Upwork Bidding,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,Sleep 08:00PM - 04:00AM,02/01/2026,IM,Projs,UN,LR,SM,WK,,,RD,ATs,CL,
,Upwork Agency Setup,⭐️⭐️⭐️,WK,01:00AM - 03:00AM,,,,AI Automation Proposals,Project Toy-Finder, AI,Resuming Data Science Course,SM Content Posting,Cold Email Setup,,,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Agency Website and Email Setup,⭐️⭐️⭐️,WK,03:00AM - 04:00AM,,,,Project GSA,Project Moji,Class,Python Data Science Libraries,SM Automated DMs,Automation Offer to Pitch Upwork Clients,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,Automation Case Studies,⭐️⭐️⭐️,WK,04:30AM - 07:30AM,,,,Hassan Projects Report,PR Productivity MVP,,,SM Content Management ,Agency Website and Email Setup,,,Never split the difference ,Insta DM Automation,,
,Mics,⭐️⭐️⭐️,UN,07:30AM - 08:30AM,,,,Automation Case Studies,Agency Website,,,,Finding Fiverr Expert,,,,,,
,C&D Lab,⭐️⭐️⭐️,UN,08:30AM - 11:00AM,,,,Hunter Trading invoice,,,,,Upwork Bidding,,,,,,
,WL,⭐️⭐️⭐️,UN,01:30PM - 03:00PM,,,,,,,,,,,,,,,
,Lib - Misc,⭐️⭐️⭐️,WK,03:00PM - 04:25PM,,,,,,,,,,,,,,,
,SE,⭐️⭐️⭐️,UN,04:30PM - 06:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,,03/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,04:00AM - 05:30AM,,"BK 08:20AM - 09:00AM, 08:00PM - 08:20PM",,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Project GSA,⭐️⭐️⭐️,WK,05:30AM - 08:20AM,,,,Hunter Trading invoice,Project Moji,SE Assignments,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,Agency Website and Email Setup,Data Science Course,Client Brand Identity and Website Creation Automation,,
,PG,⭐️⭐️⭐️,LR,09:00AM - 10:00AM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,AI Project,Agentic Workflow,,,,,Never split the difference ,Insta DM Automation,,
,Upwork Bidding,⭐️⭐️⭐️,WK,11:00AM - 01:00PM,,,,Agency Website and Email Setup,Agency Website,,,,,,,,,,
,SM Content Posting,⭐️⭐️⭐️,SM,01:30PM - 05:40PM,,,,SM Content Posting,,,,,,,,,,,
,Agentic Workflow,⭐️⭐️⭐️,LR,"05:40PM - 08:00PM, 08:20PM - 10:30PM",,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,Sleep 11:00PM - 04:00AM,04/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,PG,⭐️⭐️⭐️,LR,04:30AM - 05:30AM,,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Misc,⭐️⭐️⭐️,WK,07:30AM - 08:00AM,,BK 06:30AM - 07:30AM,,Hunter Trading invoice,Project Moji,AI Project,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,Upwork Bidding,⭐️⭐️⭐️,WK,08:00AM - 10:00AM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,,Agentic Workflow,,,,,Never split the difference ,Insta DM Automation,,
,SM Content Posting,⭐️⭐️⭐️,SM,10:00AM - 11:30AM,,,,Agency Website and Email Setup,Agency Website,,,,,,,,n8n Extension,,
,Hunter Trading invoice,⭐️⭐️⭐️,WK,11:30AM - 11:40AM,,,,SM Content Posting,,,,,,,,,,,
,Automation Offer to Pitch Upwork Clients,⭐️⭐️⭐️,WK,11:40AM - 02:00PM,,,,SE Assignments,,,,,,,,,,,
,Agency Website and Email Setup,⭐️⭐️⭐️,WK,03:00PM - 04:00PM,,,,,,,,,,,,,,,
,Never split the difference ,⭐️⭐️⭐️,LR,05:00PM - 05:50PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,Sleep 07:00PM - 04:00AM,05/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Upwork Bidding,⭐️⭐️⭐️,WK,"04:40AM - 07:30AM, 08:00AM - 09:00AM",,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Agency Website and Email Setup,⭐️⭐️⭐️,WK,"04:40AM - 07:30AM, 08:00AM - 09:00AM, 10:30AM - 2:00PM",,,,Automation Offer to Pitch Upwork Clients,Project Moji,AI Project,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,SE,⭐️⭐️⭐️,UN,03:30PM - 06:00PM,,,,Agency Website and Email Setup,PR Productivity MVP,,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,,,,,,,,SM Content Posting,Agency Website,,,,,,,,n8n Extension,,
,,,,,,,,SE Assignments,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,Sleep 07:00PM - 05:00AM,06/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,06:30AM - 09:00AM,,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Upwork Bidding,⭐️⭐️⭐️,WK,09:00AM - 11:00AM,,,,Automation Offer to Pitch Upwork Clients,Project Moji,AI Project,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,DBMS,⭐️⭐️⭐️,UN,12:00PM - 3:00PM,,,,Agency Website,PR Productivity MVP,,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,Lib Misc,⭐️⭐️⭐️,WK,03:00PM - 04:30PM,,,,SM Content Posting,,,,,,,,,n8n Extension,,
,AI,⭐️⭐️⭐️,UN,04:30PM - 06:00PM,,,,SE Assignment,,,,,,,,,,,
,Agency Website,⭐️⭐️⭐️,WK,07:00PM - 10:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,Sleep 11:00PM - 06:00AM,07/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,08:00AM - 11:00AM,,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Upwork Bidding,⭐️⭐️⭐️,WK,09:00AM - 11:00AM,,,,Automation Offer to Pitch Upwork Clients,Project Moji,AI Project,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,,,,,,,,Agency Website,PR Productivity MVP,,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,,,,,,,,SM Content Posting,,,,,,,,,n8n Extension,,
,,,,,,,,SE Assignment,,,,,,,,,Trend Finder n8n Automation,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,,09/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,08:00AM - 10:00AM,,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,SE Assignment,⭐️⭐️⭐️,WK,10:00AM - 10:20AM,,,,Automation Offer to Pitch Upwork Clients,Project Moji,DBMS Project,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,Upwork Bidding,⭐️⭐️⭐️,WK,"11:00AM - 12:20PM, 10:30PM - 12:10PM",,,,Agency Website,PR Productivity MVP,SE Assignment,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,WL,⭐️⭐️⭐️,UN,01:20PM - 03:00PM,,,,SM Content Posting,,,,,,,,,n8n Extension,,
,SE,⭐️⭐️⭐️,UN,04:25PM - 06:00PM,,,,Trend Finder n8n Automation,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,WK,06:30PM - 07:20PM,,,,,,,,,,,,,,,
,SM Content Posting,⭐️⭐️⭐️,WK,07:25PM - 08:00PM,,,,,,,,,,,,,,,
,Agency Website,⭐️⭐️⭐️,WK,08:00PM - 10:30PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,,10/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,03:00PM - 06:30PM,,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Upwork Bidding,⭐️⭐️⭐️,WK,06:30PM - 07:00PM,,,,Automation Offer to Pitch Upwork Clients,Project Moji,DBMS Project,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,,,,,,,,Agency Website,PR Productivity MVP,SE Assignment,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,,,,,,,,SM Content Posting,,,,,,,,,n8n Extension,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,,11/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,"08:00AM - 02:30PM, 08:00PM - 02:30AM",,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Upwork Bidding,⭐️⭐️⭐️,WK,02:30PM - 03:30PM,,BK 07:30AM - 08:00PM,,Automation Offer to Pitch Upwork Clients,Project Moji,DBMS Project,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,SM Content Management ,⭐️⭐️⭐️,WK,03:30PM - 07:30PM,,,,Agency Website,PR Productivity MVP,SE Assignment,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,,,,,,,,SM Content Posting,,,,,,,,,n8n Extension,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,,12/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,C&D,⭐️⭐️⭐️,UN,11:00AM - 01:30PM,,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,SE,⭐️⭐️⭐️,UN,04:30PM - 06:00PM,,,,Automation Offer to Pitch Upwork Clients,Project Moji,DBMS Project,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,Misc,⭐️⭐️⭐️,WK,06:00PM - 07:30PM,,,,Agency Website,PR Productivity MVP,SE Assignment,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,DBMS Project,⭐️⭐️⭐️,UN,08:00PM - 03:00AM,,,,SM Content Posting,,,,,,,,,n8n Extension,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,DBMS Project,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,,14/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,C&D,⭐️⭐️⭐️,UN,11:00AM - 03:00PM,,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Out,⭐️⭐️⭐️,PR,04:30PM - 07:00PM,,,,Automation Offer to Pitch Upwork Clients,Project Moji,AI NLP Assignment,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,Misc,⭐️⭐️⭐️,WK,07:30PM - 09:00PM,,,,Agency Website,PR Productivity MVP,AI NBC Assignment,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,Exam Scheduling,⭐️⭐️⭐️,UN,09:30PM - 10:00PM,,,,SM Content Posting,,AI KNN Assignment,,,,,,,n8n Extension,,
,Assignment Management,⭐️⭐️⭐️,UN,10:00PM - 10:45PM,,,,Trend Finder n8n Automation,,"AI Lab Assignment 03
",,,,,,,,,
, AI Pres,⭐️⭐️⭐️,UN,10:45PM - 12:00AM,,,,,,Exam Scheduling,,,,,,,,,
,,,,,,,,,,WL Assignment,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,,15/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,SM Content Posting,⭐️⭐️⭐️,SM,12:00AM - 01:00AM,,,,Project GSA,Project Toy-Finder, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Upwork Bidding,⭐️⭐️⭐️,WK,01:00AM - 02:45AM,,,,Automation Offer to Pitch Upwork Clients,Project Moji,AI NLP Assignment,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,,,,,,,,Agency Website,PR Productivity MVP,AI NBC Assignment,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,,,,,,,,SM Content Posting,,AI KNN Assignment,,,,,,,n8n Extension,,
,,,,,,,,Trend Finder n8n Automation,,"AI Lab Assignment 03
",,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,Sleep 11:00PM - 06:00AM,  ,,,,,,,,,,,,
ST,,,,,,,17/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,ET,⭐️⭐️⭐️,TW,07:00AM - 10:00AM,,,,Project GSA,Project Moji, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Shifting,⭐️⭐️⭐️,PR,11:00AM - 08:00PM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,AI NLP Assignment,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,Misc,⭐️⭐️⭐️,WK,09:00PM - 12:00AM,,,,Agency Website Hosting,,AI NBC Assignment,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,,,,,,,,SM Content Posting,,AI KNN Assignment,,,,,,,n8n Extension,,
,,,,,,,,Trend Finder n8n Automation,,AI Lab Assignment 03,,,,,,,,,
,,,,,,,,,,DBMS,,,,,,,,,
,,,,,,,,,,WL Assignment,,,,,,,,,
,,,,,,,,,,SE Quiz & Viva,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,Sleep 02:00AM - 01:00PM,18/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Upwork Bidding,⭐️⭐️⭐️,WK,12:00AM - 01:10AM,,,,Project GSA,Project Moji, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,Misc,⭐️⭐️⭐️,WK,01:00PM - 03:20PM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,AI NLP Assignment,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,Upwork Bidding,⭐️⭐️⭐️,WK,03:20PM - 04:30PM,,,,Agency Website Hosting,,AI NBC Assignment,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,,,,,,,,SM Content Posting,,AI KNN Assignment,,,,,,,n8n Extension,,
,,,,,,,,Trend Finder n8n Automation,,AI Lab Assignment 03,,,,,,,,,
,,,,,,,,,,DBMS Project Report,,,,,,,,,
,,,,,,,,,,WL Assignment,,,,,,,,,
,,,,,,,,,,SE Quiz & Viva,,,,,,,,,
MD,,,,,,,19/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,08:00PM - 04:30AM,,,,Project GSA,Project Moji, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,,,,,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,WL Assignment - 22/1/26,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,,,,,,,,Agency Website Hosting,,SE Quiz & Viva,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,,,,,,,,SM Content Posting,,,,,,,,,n8n Extension,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,,20/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Uni,⭐️⭐️⭐️,UN,08:00AM - 04:00PM,,,,Project GSA,Project Moji, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,SM Content Automation System Improvements,,
,WL Assignment,⭐️⭐️⭐️,UN,04:00PM - 08:00PM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,WL Assignment - 22/1/26,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,Client Brand Identity and Website Creation Automation,,
,Upwork Bidding,⭐️⭐️⭐️,WK,08:00PM - 09:00PM ,,,,Agency Website Hosting,,SE Quiz & Viva,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,Insta DM Automation,,
,Hassan Automation Meeting,⭐️⭐️⭐️,WK,09:00PM - 10:10PM,,,,SM Content Posting,,,,,,,,,n8n Extension,,
,Misc,⭐️⭐️⭐️,WK,10:10PM - 01:00AM,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,Sp 02:00AM - 11:00AM,,,,,,,,,,,,,
WD,,,,,,,21/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,WL,⭐️⭐️⭐️,UN,12:00PM - 02:00PM,,,,Project GSA,Project Moji, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,AI,⭐️⭐️⭐️,UN,02:00PM - 04:25PM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,WL Assignment - 22/1/26,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,TW,⭐️,TW,04:25PM - 06:00PM,,,,Agency Website Hosting,,,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,,,
,Out,⭐️⭐️⭐️,PR,06:00PM - 08:00PM,,,,SM Content Posting,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,WK,08:10PM - 12:00PM,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,,22/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Upwork Bidding,⭐️⭐️⭐️,WK,12:00AM - 02:00AM,,,,Project GSA,Project Moji, AI,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,AI Lab Exam,⭐️⭐️⭐️,UN,06:00AM - 11:00AM,,"Sp 03:00AM - 06:00AM, 01:00PM - 05:00PM",,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,TW,⭐️,TW,06:00PM - 08:00PM,,,,Agency Website Hosting,,,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,,,
,Misc,⭐️⭐️⭐️,WK,08:00PM - 11:00PM,,,,SM Content Posting,,,,,,,,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,,23/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Upwork Bidding,⭐️⭐️⭐️,WK,11:10PM - 12:40AM,,Sp 03:00AM - 06:00AM,,Project GSA,Project Moji, AI Task & Final Project Upload,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Misc,⭐️⭐️⭐️,WK,12:40AM - 02:35AM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,C&D Lab Exam,⭐️⭐️⭐️,UN,06:00AM - 11:00AM,,,,Agency Website Hosting,,,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,,,
,,,,,,,,SM Content Posting,,,,,,,,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,,24/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,02:00PM - 05:30PM,,,,Project GSA,Project Moji, AI Task & Final Project Upload,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,SE Exam,⭐️⭐️⭐️,UN,05:30PM - 10:30PM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,SE Exam,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,,,,,,,,Agency Website Hosting,,,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,,,
,,,,,,,,SM Content Posting,,,,,,,,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,,25/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,SE Exam Prep,⭐️⭐️⭐️,UN,11:30PM - 03:10AM,,,,Project GSA,Project Moji, AI Task & Final Project Upload,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,,,,,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,SE Exam,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,,,,,,,,Agency Website Hosting,,AI Exam,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,,,
,,,,,,,,SM Content Posting,,WL Exam,,,,,,,,,
,,,,,,,,Trend Finder n8n Automation,,C&D Exam,,,,,,,,,
,,,,,,,,,,DBMS Exam,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,,26/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,SE Exam,⭐️⭐️⭐️,UN,11:30AM - 02:00PM,,Sp 04:00AM - 09:00PM,,Project GSA,Project Moji, AI Task & Final Project Upload,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Misc,⭐️⭐️⭐️,WK,09:00PM - 11:00PM,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,SE Exam,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,,,,,,,,Agency Website Hosting,,AI Exam,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,,,
,,,,,,,,SM Content Posting,,WL Exam,,,,,,,,,
,,,,,,,,Trend Finder n8n Automation,,C&D Exam,,,,,,,,,
,,,,,,,,,,DBMS Exam,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,,27/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,AI Exam Prep,⭐️⭐️⭐️,UN,12:30AM - 07:00AM,,,,Project GSA,Project Moji, AI Task & Final Project Upload,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,,,,,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,AI Exam,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,,,,,,,,Agency Website Hosting,,WL Exam,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,,,
,,,,,,,,SM Content Posting,,C&D Exam,,,,,,,,,
,,,,,,,,Trend Finder n8n Automation,,DBMS Exam,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,,28/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,AI Exam,⭐️⭐️⭐️,UN,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,,29/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,,,,,Project GSA,Project Moji, AI Task & Final Project Upload,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,,,,,,,,Automation Offer to Pitch Upwork Clients,PR Productivity MVP,AI Exam,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,,,,,,,,Agency Website Hosting,,WL Exam,Agentic Workflow,,Upwork Consultations,,,Never split the difference ,,,
,,,,,,,,SM Content Posting,,C&D Exam,,,,,,,,,
,Exams,,,,,,,Trend Finder n8n Automation,,DBMS Exam,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,,31/01/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,WK,03:30PM - 05:00PM,,Sp 06:00AM - 02:00PM,,Project GSA,Project Moji, AI Task & Final Project Upload,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Expense Calc,⭐️⭐️⭐️,PR,03:30PM - 07:00PM,,,,Expense Calc,PR Productivity MVP,,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,08:10PM - 10:30PM,,BK 07:30AM - 08:00PM,,Python Data Science Libraries,,,,,Upwork Consultations,,,Never split the difference ,,,
,SM Content Posting,⭐️⭐️⭐️,WK,10:30PM - 12:00AM,,,,Agency Website Hosting,,,,,,,,,,,
,,,,,,,,SM Content Posting,,,,,,,,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,Sp 11:00AM - 06:00PM,01/02/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,Python Data Science Libraries,⭐️⭐️⭐️,WK,12:10AM - 08:10AM,,,,Project GSA,Project Moji, AI Task & Final Project Upload,Resuming Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Excercise,⭐️⭐️⭐️,WK,08:10AM - 08:35AM,,,,Python Data Science Libraries,PR Productivity MVP,,Python Data Science Libraries,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,Misc,⭐️⭐️⭐️,WK,07:00PM - 09:00PM,,,,Agency Website Hosting,,,,,Upwork Consultations,,,Never split the difference ,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,09:00PM - 12:15AM,,,,SM Content Posting,,,,,,,,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,Sp 11:00AM - 06:00PM,02/02/2026,IM,Projs,UN,LR,SM,UP,FR,CDM,RD,ATs,CL,
,SM Content Management ,⭐️⭐️⭐️,WK,09:00PM - 05:00AM,,,,Project GSA,Project Moji, AI Task & Final Project Upload,Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,05:00AM - 05:40AM ,,,,Python Data Science Libraries,PR Productivity MVP,,,SM Content Management ,Upwork AI Automation Proposals,,,Data Science Course,,,
,Python Data Science Libraries,⭐️⭐️⭐️,WK,05:40AM - 7:00AM,,,,Agency Website Hosting,,,,,Upwork Consultations,,,Never split the difference ,,,
,Data Science Course,⭐️⭐️⭐️,WK,7:00AM - 09:30AM,,,,SM Content Posting,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,PR,06:00PM - 07:00PM,,,,Trend Finder n8n Automation,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,WK,07:00PM - 08:00PM,,,,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,08:00PM - 11:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,Sp 12:00PM - 06:00PM,03/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,SM Content Posting,⭐️⭐️⭐️,WK,11:00PM - 12:30AM,,,,Project GSA,Project Moji,,Data Science Course,SM Automated DMs,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Cold Email Setup,⭐️⭐️⭐️,WK,"12:30AM - 03:00AM, 05:00AM - 07:00AM",,,,Cold Email Setup,PR Productivity MVP,,,SM Content Management ,Upwork AI Automation Proposals,,Agency Website Hosting,Never split the difference ,,,
,Misc,⭐️⭐️⭐️,PR,"03:00AM - 04:40AM, 06:30PM - 07:30PM",,,,Agency Website,,,,Expedite,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,"04:40AM - 05:00AM, 09:30AM - 10:00AM, 08:00 - ",,,,SM Content Posting,,,,,,,LinkedIn Outreach,,,,
,Data Science Course,⭐️⭐️⭐️,LR,07:10AM - 09:30AM,,,,Trend Finder n8n Automation,,,,,,,App Sumo,,,,
,SM Content Management ,⭐️⭐️⭐️,SM,10:00AM - 11:20AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,Sp 01:00AM - 04:00AM,04/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Upwork Bidding,⭐️⭐️⭐️,WK,"12:30PM - 02:20PM, 04:45 - 05:30PM",,,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,Trend Finder n8n Automation,,
,SM Content Posting,⭐️⭐️⭐️,SM,02:20PM - 04:45PM,,,,Cold Email Setup,Project GSA,,,Expedite,Upwork AI Automation Proposals,,Agency Website,Never split the difference ,,,
,Cold Email Setup,⭐️⭐️⭐️,WK,05:30PM - 09:00PM,,BK 09:10PM - 10:00PM,,Agency Website,PR Productivity MVP,,,,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,Data Science Course,⭐️⭐️⭐️,LR,10:10PM - 01:10AM,,,,SM Content Posting,,,,,,,LinkedIn Outreach,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,App Sumo,,,,
,,,,,,,,,,,,,,,SM Automated DMs,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,"Sp 02:00AM - 06:00AM, 12:00PM - 08:00PM ",05/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,PR,09:00PM - 10:30PM,,,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,Trend Finder n8n Automation,,
,SM Content Posting,⭐️⭐️⭐️,SM,10:30PM - 01:20AM,,,,Cold Email Setup,Project GSA,,,Expedite,Upwork AI Automation Proposals,,Agency Website,Never split the difference ,,,
,,,,,,,,Agency Website,PR Productivity MVP,,,,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,,,,,,,,SM Content Posting,,,,,,,LinkedIn Outreach,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,App Sumo,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,"Sp 02:00PM - 08:00PM, 10:00PM - 12:00AM ",06/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Upwork Bidding,⭐️⭐️⭐️,WK,01:30AM - 05:15AM,,,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,Trend Finder n8n Automation,,
,Cold Email Setup,⭐️⭐️⭐️,WK,05:45AM - 08:15AM,,,,Cold Email Setup,Project GSA,,,Expedite,Upwork AI Automation Proposals,,Agency Website,Never split the difference ,,,
,Misc,⭐️⭐️⭐️,PR,08:10AM - 09:15AM,,,,Agency Website,PR Productivity MVP,,,,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,Data Science Course,⭐️⭐️⭐️,LR,10:10PM - 01:10PM,,,,SM Content Posting,,,,,,,LinkedIn Outreach,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,App Sumo,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,Sp 05:00AM - 07:00AM,07/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Misc,⭐️⭐️,TW,12:00AM - 05:00AM,,,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,Trend Finder n8n Automation,,
,Misc,⭐️⭐️⭐️,PR,07:00AM - 09:30AM,,BK 01:00PM - 02:00PM,,Cold Email Setup,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,,Agency Website,Never split the difference ,Cold Email Automations,,
,Upwork Bidding,⭐️⭐️⭐️,WK,09:30AM - 11:00AM,,,,Agency Website,,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,SM Content Posting,⭐️⭐️⭐️,SM,11:00AM - 01:00PM,,,,SM Content Posting,,,,LinkedIn Virtual Events,,,LinkedIn Outreach,,,,
,Misc,⭐️⭐️⭐️,WK,02:00PM - 03:00PM,,,,Trend Finder n8n Automation,,,,,,,App Sumo,,,,
,DT,⭐️⭐️⭐️,PR,03:00PM - 05:00PM,,,,LinkedIn Outreach,,,,,,,,,,,
,Cold Email Setup,⭐️⭐️⭐️,WK,05:00PM - 06:00PM,,,,,,,,,,,,,,,
,LinkedIn Outreach,⭐️⭐️⭐️,WK,06:00PM - 08:20PM,,,,,,,,,,,,,,,
,Data Science Course,⭐️⭐️⭐️,WK,08:30PM - 12:20AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,"Sp 02:00AM - 04:00AM, 08:00AM - 11:00AM",08/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Misc,⭐️,TW,04:00AM - 08:00AM,,,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Misc,⭐️⭐️⭐️,PR,11:00AM - 05:30PM,,,,Cold Email Setup,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,,Agency Website,Never split the difference ,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,05:30PM - 07:10PM,,,,Agency Website,,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,SM Content Posting,⭐️⭐️⭐️,WK,07:10PM - 09:00PM,,,,SM Content Posting,,,,LinkedIn Virtual Events,,,LinkedIn Outreach,,,,
,Data Science Course,⭐️⭐️⭐️,WK,09:00PM - 10:00PM,,,,Trend Finder n8n Automation,,,,AntiGravity NotebookLm,,,App Sumo,,,,
,,,,,,,,LinkedIn Outreach,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,Sp 10:00PM - 04:00AM,09/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Misc,⭐️,TW,04:00AM - 09:00AM,,,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Misc,⭐️⭐️⭐️,WK,09:00AM - 10:30AM,,,,Cold Email Setup,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,,
,SM Content Posting,⭐️⭐️⭐️,WK,10:30AM - 11:30AM,,,,Agency Website,,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,11:30AM - 01:30PM,,,,SM Content Posting,,,,LinkedIn Virtual Events,,,LinkedIn Outreach,,,,
,Cold Email Setup,⭐️⭐️⭐️,WK,01:30PM - 02:30PM,,,,Trend Finder n8n Automation,,,,AntiGravity NotebookLm,,,App Sumo,,,,
,Data Science Course,⭐️⭐️⭐️,WK,02:30PM - 08:10PM,,,,LinkedIn Outreach,,,,,,,,,,,
,09:00PM Meeting Husna,⭐️⭐️⭐️,WK,09:10PM - 09:40PM,,,,09:00PM Meeting Husna,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,Sp 11:00PM - 03:00AM,10/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Misc,⭐️⭐️,PR,04:00AM - 09:00AM,,,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Misc,⭐️⭐️⭐️,WK,"10:00AM - 12:00PM, 02:00PM - 04:00PM",,,,Cold Email Setup,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,12:00PM - 02:00PM,,,,Agency Website,,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,Data Science Course,⭐️⭐️⭐️,LR,04:00PM - 07:30PM,,,,SM Content Posting,,,,AntiGravity NotebookLm,,,LinkedIn Outreach,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,App Sumo,,,,
,,,,,,,,LinkedIn Outreach,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,"Sp 09:00PM - 05:00AM, 8:00AM - 10:00AM",11/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Misc,⭐️,TW,05:00AM - 08:00AM,,,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,,,
,Out,⭐️⭐️⭐️,WK,12:00PM - 10:00PM,,,,Cold Email Setup,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,,
,Misc,⭐️⭐️⭐️,WK,10:00PM - 10:30PM,,,,Agency Website,,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:30PM - 12:20AM,,,,SM Content Posting,,,,AntiGravity NotebookLm,,,LinkedIn Outreach,,,,
,,,,,,,,Trend Finder n8n Automation,,,,,,,App Sumo,,,,
,,,,,,,,LinkedIn Outreach,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,,12/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,,,,,,Sp 09:00AM - 02:00PM,,Project GSA,Project Moji,,Data Science Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,Openclaw,,
,,,,,,,,Cold Email Setup,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,,
,Hassan''s Contract,⭐️⭐️⭐️,WK,12:20AM - 12:40AM,,,,Agency Website,,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,SM Content Posting,⭐️⭐️⭐️,WK,12:40AM - 01:10AM,,,,SM Content Posting,,,,AntiGravity NotebookLm,,,LinkedIn Outreach,,,,
,Data Science Course,⭐️⭐️⭐️,LR,01:10AM - 05:30AM,,,,Trend Finder n8n Automation,,,,,,,App Sumo,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,"05:30AM - 05:50AM, 06:10PM - 09:00PM",,,,LinkedIn Outreach,,,,,,,,,,,
,Misc,⭐️⭐️⭐️,PR,03:00PM - 06:10PM,,,,certificate addition,,,,,,,,,,,
,Openclaw,⭐️⭐️⭐️,WK,09:00PM - 12:30AM,,,,AL/ML Projects Case Studies,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,Sp 03:00AM - 08:00AM,13/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,CL,
,Misc,⭐️⭐️⭐️,PR,12:30AM - 01:30AM,,,,Project GSA,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,Openclaw,,
,Vibe Coding,⭐️⭐️⭐️,WK,01:30AM - 02:50AM,,,,Cold Email Setup,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,,
,Misc,⭐️⭐️⭐️,WK,"09:30AM - 12:00PM, 07:10PM - 07:40PM, 08:20PM - 11:00PM",,BK 07:40PM - 08:20PM,,Agency Website,Hunter Trading,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,SM Content Management ,⭐️⭐️⭐️,SM,12:00PM - 05:00PM,,,,SM Content Posting,,,,AntiGravity NotebookLm,,,LinkedIn Outreach,,,,
,Hunter Trading,⭐️⭐️⭐️,WK,05:00PM - 05:30PM,,,,Trend Finder n8n Automation,,,,HeyReach,,,App Sumo,,,,
,Upwork Bidding,⭐️⭐️⭐️,SM,05:30PM - 07:10PM,,,,LinkedIn Outreach,,,,,,,,,,,
,,,,,,,,certificate addition,,,,,,,,,,,
,,,,,,,,AL/ML Projects Case Studies,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,Sp 02:00AM - 07:00AM,14/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,,,,,,,,Project GSA,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,Openclaw,Auto IGDM,
,LinkedIn Outreach,⭐️⭐️⭐️,SM,11:00PM - 01:30AM,,,,Trend Finder n8n Automation,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,HeyReach,
,Misc,⭐️⭐️,TW,07:00AM - 12:00PM,,,,SM Content Posting,Hunter Trading,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,12:30PM - 01:20PM,,,,Cold Email Setup,,,,AntiGravity NotebookLm,,,LinkedIn Outreach,,,,
,Certificate Addition,⭐️⭐️⭐️,WK,01:40PM - 01:50PM,,,,LinkedIn Outreach,,,,,,,App Sumo,,,,
,SM Content Management ,⭐️⭐️⭐️,SM,01:50PM - 03:00PM,,,,certificate addition,,,,,,,Offer Creation,,,,
,LinkedIn Outreach,⭐️⭐️⭐️,SM,03:00PM - 04:30PM,,,,AL/ML Projects Case Studies,,,,,,,,,,,
,Instagram Outreach,⭐️⭐️⭐️,SM,05:00PM - 07:30PM,,,,Never split the difference ,,,,,,,,,,,
,Never split the difference ,⭐️⭐️⭐️,LR,07:30PM - 11:30PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,Sp 01:00AM - 08:00AM,15/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️⭐️⭐️,WK,10:30AM - 01:30PM,,,,Never split the difference ,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Setup,How AI Works From Sorcery,Openclaw,Auto IGDM,
,Upwork Bidding,⭐️⭐️⭐️,WK,01:30PM - 03:00PM,,,,Trend Finder n8n Automation,PR Productivity MVP,,,Expedite,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,HeyReach,
,SM Content Posting,⭐️⭐️⭐️,SM,03:00PM - 05:00PM,,,,SM Content Posting,Hunter Trading,,,Youtube Video Upload,Upwork Consultations,,Instagram Outreach,Alex''s Books,,,
,Never split the difference ,⭐️⭐️⭐️,LR,"05:10PM - 08:10PM, 08:30PM - 12:40PM",,,,AL/ML Projects Case Studies,Project GSA,,,AntiGravity NotebookLm,,,LinkedIn Outreach,,,,
,,,,,,,,,,,,LinkedIn Outreach,,,App Sumo,,,,
,,,,,,,,,,,,Cold Email Setup,,,Offer Creation,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,"Sp 02:00AM - 04:00AM, 12:00PM - 03:00PM",16/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Uni,⭐️⭐️⭐️,UN,07:00AM - 10:30PM,,,,Never split the difference ,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,Openclaw,Auto IGDM,
,Upwork Bidding,⭐️⭐️⭐️,WK,04:00PM - 05:10PM,,,,Trend Finder n8n Automation,PR Productivity MVP,,,Youtube Video Upload,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,HeyReach,
,SM Content Posting,⭐️⭐️⭐️,SM,04:00PM - 05:10PM,,,,SM Content Posting,Hunter Trading,,,AntiGravity NotebookLm,Upwork Consultations,,Offer Creation,Alex''s Books,,Expedite,
,Out,⭐️⭐️⭐️,PR,05:10PM - 08:30PM,,,,AL/ML Projects Case Studies,Project GSA,,,LinkedIn & Insta Outreach,,,,,,App Sumo,
,Misc,⭐️⭐️⭐️,WK,05:10PM - 08:30PM,,,,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,08:30PM - 10:05PM,,,,,,,,,,,,,,,
,Insta & LinkedIn Outreach,⭐️⭐️⭐️,SM,10:05PM - 12:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,Sp 04:00AM - 12:00PM,17/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Never split the difference ,⭐️⭐️⭐️,LR,12:00AM - 03:30AM,,,,Never split the difference ,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,Openclaw,Auto IGDM,
,ML,⭐️⭐️⭐️,UN,12:00PM - 03:00PM,,,,Trend Finder n8n Automation,PR Productivity MVP,,,Youtube Video Upload,Upwork AI Automation Proposals,nSave Payment app,Agency Website,Never split the difference ,,HeyReach,
,Stamp,⭐️⭐️⭐️,PR,03:00PM - 05:30PM,,,,SM Content Posting,Hunter Trading,,,AntiGravity NotebookLm,Upwork Consultations,,Offer Creation,100M Offer,,Expedite,
,Upwork Bidding,⭐️⭐️⭐️,WK,05:30PM - 06:30PM,,,,AL/ML Projects Case Studies,Project GSA,,,LinkedIn & Insta Outreach,,,,,,App Sumo,
,SM Content Posting & Outreach,⭐️⭐️⭐️,WK,06:30PM - 09:20PM,,,,Upwork AI consultation,,,,,,,,,,,
,Machine Learning Course,⭐️⭐️⭐️,LR,09:20PM - 01:30AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,Sp 02:00AM - 11:00AM,18/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️⭐️,TW,12:00PM - 03:00PM,,,,Trend Finder n8n Automation,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,Openclaw,Auto IGDM,
,Misc,⭐️⭐️⭐️,WK,03:00PM - 04:30PM,,,,SM Content Posting,PR Productivity MVP,,,Youtube Video Upload,Upwork AI Automation Proposals,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,Upwork Bidding,⭐️⭐️⭐️,WK,04:30PM - 06:45PM,,,,AL/ML Projects Case Studies,Hunter Trading,,,AntiGravity NotebookLm,Upwork Consultations,,Offer Creation,,,Expedite,
,SM Content Posting,⭐️⭐️⭐️,WK,07:10PM - 09:00PM,,,,Upwork AI consultation,Project GSA,,,LinkedIn & Insta Outreach,,,,,,App Sumo,
,LinkedIn & Insta Outreach,⭐️⭐️⭐️,WK,09:00PM - 09:30PM,,,,Cold Email Automations,,,,,,,,,,,
,Machine Learning Course,⭐️⭐️⭐️,LR,09:30PM - 01:20AM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,"Sp 03:00AM - 12:00PM, 02:00PM - 04:00PM",19/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️⭐️⭐️,WK,04:00PM - 05:35PM,,,,Trend Finder n8n Automation,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,Openclaw,Auto IGDM,
,Upwork Bidding,⭐️⭐️⭐️,WK,05:35PM - 07:30PM,,BK 08:00PM - 08:30PM,,SM Content Posting,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,SM Content Posting,⭐️⭐️⭐️,SM,07:30PM - 08:00PM,,,,AL/ML Projects Case Studies,Hunter Trading,,,LinkedIn & Insta Outreach,,,Offer Creation,,,Expedite,
,Misc,⭐️⭐️⭐️,WK,08:30PM - 10:00PM,,,,Upwork AI consultation,Project GSA,,,,,,,,,App Sumo,
,LinkedIn & Insta Outreach,⭐️⭐️⭐️,SM,10:00PM - 12:30AM,,,,Cold Email Automations,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,Sp 07:00AM - 03:00PM,20/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Machine Learning Course,⭐️⭐️⭐️,LR,12:30PM - 05:00AM,,,,Trend Finder n8n Automation,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,Openclaw,Auto IGDM,
,Misc,⭐️⭐️⭐️,PR,04:00PM - 06:00PM,,,,SM Content Posting,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,Upwork Bidding,⭐️⭐️⭐️,WK,06:00PM - 08:00PM,,BK 08:00PM - 09:00PM,,AL/ML Projects Case Studies,Hunter Trading,,,LinkedIn & Insta Outreach,,,Offer Creation,,,Expedite,
,Meeting Fabrizio,⭐️⭐️⭐️,WK,07:10PM - 07:35PM,,,,Upwork AI consultation,Project GSA,,,,,,,,,App Sumo,
,Misc,⭐️⭐️⭐️,WK,09:00PM - 12:30AM,,,,Cold Email Automations,,,,,,,,,,,
,,,,,,,,Meeting Fabrizio,,,,,,,,,,,
,,,,,,,,OpenClaw Setup,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,"Sp 08:00AM - 12:00PM, 05:00PM - 08:00PM",21/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,LinkedIn & Insta Outreach,⭐️⭐️⭐️,SM,12:30AM - 01:20AM,,,,Trend Finder n8n Automation,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,Openclaw,Auto IGDM,
,Machine Learning Course,⭐️⭐️⭐️,LR, 01:30AM - 06:05AM,,,,SM Content Posting,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,Misc,⭐️,TW,12:00PM - 05:00PM,,,,Upwork AI consultation,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,Misc,⭐️⭐️⭐️,WK,08:00PM - 10:15PM,,,,Cold Email Automations,Project GSA,,,,,,,,,App Sumo,
,SM Content Posting,⭐️⭐️⭐️,SM,10:30PM - 01:00AM,,,,OpenClaw Setup,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,"Sp 09:00AM - 03:00PM, 05:00PM - 08:00PM",22/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Upwork Bidding,⭐️⭐️⭐️,WK,"01:00AM - 01:40AM, 02:30AM - 03:00AM, 10:10PM -",,,,Trend Finder n8n Automation,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,Openclaw,Auto IGDM,
,OpenClaw Setup,⭐️⭐️⭐️,WK,01:40AM - 02:30AM,,,,SM Content Posting,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,Machine Learning Course,⭐️⭐️⭐️,LR,03:00AM - 08:30AM,,,,Upwork AI consultation,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,Misc,⭐️⭐️⭐️,WK,08:00PM - 10:10PM,,,,Cold Email Automations,Project GSA,,,,,,,,,App Sumo,
,,,,,,,,OpenClaw Setup,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,,23/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,DT,⭐️⭐️⭐️⭐️,LR,10:10PM - 05:50AM,,,,Trend Finder n8n Automation,Project Moji,AD,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,AD,⭐️⭐️⭐️,UN,07:00AM - 08:30AM,,,,SM Content Posting,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,,,,,,,,Upwork AI consultation,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,,,,,,,,Cold Email Automations,Project GSA,,,,,,,,,App Sumo,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,Misc,⭐️⭐️⭐️,WK,08:00PM - 12:10AM,,,24/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,,,,,,,,Trend Finder n8n Automation,Project Moji,AD,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,,,,,,,,SM Content Posting,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,,,,,,,,Upwork AI consultation,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,,,,,,,,Cold Email Automations,Project GSA,,,,,,,,,App Sumo,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,Sp 03:00PM - 08:00PM,,,,,,,,,,,,,
WD,Upwork Bidding,⭐️⭐️⭐️,WK,12:10AM - 02:00AM,,,25/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Uni,⭐️⭐️⭐️,UN,09:00AM - 03:00PM,,,,Trend Finder n8n Automation,Project Moji,AD,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,,,,,,,,SM Content Posting,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,,,,,,,,Upwork AI consultation,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,,,,,,,,Cold Email Automations,Project GSA,,,,,,,,,App Sumo,
,,,,,,,,,,,,,,,,,,,
,,,,,,Sp 11:00AM - 03:00AM,,,,,,,,,,,,,
TH,Misc,⭐️⭐️⭐️,WK,05:00AM - 07:30AM,,,26/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,SM Content Posting,⭐️⭐️⭐️,SM,07:30AM - 08:20AM,,,,,,,,,,,,,,,
,SM Management & Outreach,⭐️⭐️⭐️,SM,08:20AM - 09:30AM,,,,,,,,,,,,,,,
,Trend Finder n8n Automation,⭐️⭐️⭐️,WK,09:30AM - 10:30AM,,,,,,,,,,,,,,,
,Uni,⭐️⭐️⭐️,UN,10:30AM - 01:40PM,,,,,,,,,,,,,,,
,Upwork Bidding,⭐️⭐️⭐️,WK,03:00PM - 03:40PM,,,,,,,,,,,,,,,
,Machine Learning Course,⭐️⭐️⭐️,LR,03:40PM - 06:00PM,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,Misc,⭐️⭐️⭐️,WK,12:00AM - 03:00AM,,,27/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,SM Content Posting,⭐️⭐️⭐️,WK,03:00AM - 04:10AM,,,,SM Content Posting,Project Moji,Robotics Task,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Robotics Task,⭐️⭐️⭐️,UN,03:00AM - 05:10AM,,,,Upwork AI consultation,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,Machine Learning Course,⭐️⭐️⭐️,LR,05:10AM - 06:05AM,,,,Cold Email Automations,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,Uni,⭐️⭐️⭐️,UN,10:30AM - 02:30PM,,,,"08:00pm - Friday, 27 Zavia Meeting",Project GSA,,,Manychat,,,,,,App Sumo,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,SM Management & Outreach,⭐️⭐️⭐️,SM,08:00AM - 10:20AM,,,28/02/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Upwork Bidding,⭐️⭐️⭐️,WK,10:20AM - 12:20PM,,,,SM Content Posting,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Expense Calc,⭐️⭐️⭐️,PR,12:30PM - 02:10PM,,,,Upwork AI consultation,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,Case Study Posting,⭐️⭐️⭐️,SM,02:10PM - 03:00PM,,BK 08:00PM - 08:30PM,,Cold Email Automations,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,Misc,⭐️⭐️⭐️,SM,03:00PM - 04:00PM,,,,Case Study Posting,Project GSA,,,Manychat,,,,,,App Sumo,
,Machine Learning Course,⭐️⭐️⭐️,LR,"04:00PM - 07:00PM, 08:30PM - 10:30PM",,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,"Sp 11:00AM - 03:00AM, 12:00PM - 03:00PM",,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,Misc,⭐️⭐️,TW,03:00AM - 12:20PM,,,01/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️⭐️⭐️,WK,03:00PM - 05:00PM,,,,SM Content Posting,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Upwork Bidding,⭐️⭐️⭐️,WK,05:00PM - 07:00PM,,,,Upwork AI consultation,PR Productivity MVP,,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,,,,,,,,Cold Email Automations,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,,,,,,,,Case Study Posting,Project GSA,,,Manychat,,,,,,App Sumo,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,Misc,⭐️⭐️⭐️,WK,"10:00AM - 11:20AM, 08:20PM - 10:30PM",,,02/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Upwork Bidding,⭐️⭐️⭐️,WK,11:20PM - 01:30PM,,,,SM Content Posting,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,SM Management & Outreach,⭐️⭐️⭐️,SM,01:30PM - 03:30PM,,BK 08:30PM - 09:00PM,,Upwork AI consultation,PR Productivity MVP,,AI Engineer Core Track,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,Machine Learning Course,⭐️⭐️⭐️,LR,03:30PM - 08:20PM,,,,Cold Email Automations,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,,,,,,,,AL/ML Projects Case Studies,Project GSA,,,Manychat,,,,,,App Sumo,
,,,,,,,,100M Offer,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,ML,⭐️⭐️⭐️,UN,10:30AM - 01:00PM,,Sp 11:00AM - 02:00AM,03/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️⭐️⭐️,WK,01:00PM - 02:00PM,,,,SM Content Posting,Project Moji,,Machine Learning Course,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Upwork Bidding,⭐️⭐️⭐️,WK,08:00PM - 10:00PM,,,,Upwork AI consultation,PR Productivity MVP,,AI Engineer Core Track,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,100M Offer,,HeyReach,
,SM Management & Outreach,⭐️⭐️⭐️,SM,10:00PM -12:30AM,,,,Cold Email Automations,Hunter Trading,,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,,,,,,,,AL/ML Projects Case Studies,Project GSA,,,Manychat,,,,,,App Sumo,
,,,,,,,,100M Offer,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
WD,,,,,,"Sp 05:00AM - 07:00AM, 03:00PM - 06:00PM",04/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,AL/ML Projects Case Studies & Portfolio Update,⭐️⭐️⭐️,WK,12:30AM - 05:00AM,,,,SM Content Posting,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,DOA,⭐️⭐️⭐️,UN,07:30AM - 10:00AM,,,,Upwork AI consultation,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,,,HeyReach,
,Misc - Lib,⭐️⭐️⭐️,UN,10:30AM - 01:20PM,,,,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,,AL/ML Projects Case Studies,Offer Creation,,,Expedite,
,RB,⭐️⭐️⭐️,UN,01:20PM - 03:00PM,,,,AL/ML Projects Case Studies,Project GSA,AC,,Manychat,,,,,,App Sumo,
,Misc,⭐️⭐️⭐️,WK,06:00PM - 06:40PM,,,,100M Offer,,RB,,,,,,,,,
,100M Offer,⭐️⭐️⭐️,LR,06:40PM - 11:20PM,,,,Linkedin & Instagram Outreach Script,,,,,,,,,,,
,,,,,,,,Creating Grand Slam Offer for agency,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,Sp 12:00AM - 10:00AM,05/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,DOA & DV,⭐️⭐️⭐️,UN,10:00AM - 02:30PM,,,,SM Content Posting,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Misc,⭐️⭐️⭐️,WK,"02:30PM - 03:30PM, 05:00PM - 06:05PM",,,,Upwork AI consultation,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,,ClawGravity Setup,HeyReach,
,SM Content Posting & Outreach,⭐️⭐️⭐️,SM,03:30PM - 05:00PM,,,,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,,,Offer Creation,,,Expedite,
,,,,,,,,AL/ML Projects Case Studies,Project GSA,AC,,Manychat,,,,,,App Sumo,
,,,,,,,,100M Offer,,RB,,,,,,,,,
,,,,,,,,Linkedin & Instagram Outreach Script,,,,,,,,,,,
,,,,,,,,Creating Grand Slam Offer for agency,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
FR,,,,,,"Sp 11:00AM - 03:00AM, 06:30AM - 10:00AM",06/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️,TW,03:00AM - 06:30AM,,,,SM Content Posting,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,ML,⭐️⭐️⭐️,UN,10:30AM - 02:30PM,,,,Upwork AI consultation,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,,,HeyReach,
,Upwork Bidding,⭐️⭐️⭐️,WK,02:30PM - 05:10PM,,,,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,,,Offer Creation,,,Expedite,
,SM Content Posting & Outreach,⭐️⭐️⭐️,SM,05:00PM - 07:15PM,,BK 07:15PM - 08:20PM,,AL/ML Projects Case Studies,Project GSA,AC,,Manychat,,,"CAC, LTV, Gross Profit",,,App Sumo,
,100M Offer,⭐️⭐️⭐️,LR,07:15PM - 11:50PM,,,,100M Offer,,RB,,,,,"how to pick markets, and find niches that are profitable",,,,
,,,,,,,,Linkedin & Instagram Outreach Script,,,,,,,,,,,
,,,,,,,,Creating Grand Slam Offer for agency,,,,,,,,,,,
,,,,,,,,ClawGravity Setup,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,"Sp 12:30AM - 04:00AM, 07:30AM - 12:00PM",07/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️,TW,"04:00AM - 07:30AM, 12:00PM - 03:00PM",,,,SM Content Posting,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Misc,⭐️⭐️⭐️,WK,03:00PM - 04:15PM,,,,Upwork AI consultation,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,,,HeyReach,
,Upwork Bidding,⭐️⭐️⭐️,WK,04:15PM - 05:50PM,,,,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,,,Offer Creation,,,Expedite,
,WF,⭐️⭐️⭐️,PR,05:50PM - 07:00PM,,,,AL/ML Projects Case Studies,Project GSA,AC,,Manychat,,,"CAC, LTV, Gross Profit",,,App Sumo,
,SM Content Posting & Outreach,⭐️⭐️⭐️,SM,07:15PM - 12:10AM,,,,100M Offer,,RB,,,,,"how to pick markets, and find niches that are profitable",,,,
,,,,,,,,Linkedin & Instagram Outreach Script,,,,,,,,,,,
,,,,,,,,Creating Grand Slam Offer for agency,,,,,,,,,,,
,,,,,,,,ClawGravity Setup,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,,08/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,100M Offer,⭐️⭐️⭐️,LR,12:20AM - 04:50AM,,"Sp 05:30AM - 10:00AM, 12:30PM - 03:30PM",,Cold Email Automations,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Misc,⭐️⭐️⭐️,WK,03:30PM - 04:50PM,,,,AL/ML Projects Case Studies,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,,,HeyReach,
,SM Content Posting & Outreach,⭐️⭐️⭐️,SM,05:50PM - 07:30PM,,BK 09:10PM - 10:05PM,,100M Offer,Hunter Trading,ML,,LinkedIn & Insta Outreach,,,Offer Creation,,,Expedite,
,Upwork Bidding,⭐️⭐️⭐️,WK,07:30PM - 09:10PM,,,,Creating Grand Slam Offer for agency,Project GSA,AC,,Manychat,,,"CAC, LTV, Gross Profit",,,App Sumo,
,100M Offer,⭐️⭐️⭐️,LR,10:10PM - 02:10AM,,,,ClawGravity Setup,,RB,,SM Content Posting,,,"how to pick markets, and find niches that are profitable",,,,
,,,,,,,,ML Quiz,,,,,,,,,,,
,,,,,,,,Robotics Quiz,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,,09/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,100M Offer,⭐️⭐️⭐️,LR,02:30AM - 04:00AM,,"Sp 07:00AM - 01:00AM, 03:00PM - 04:00PM",,Cold Email Automations,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Cold Email Automations,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Agentic Workflows,⭐️⭐️⭐️,LR,04:00AM - 06:10AM,,,,AL/ML Projects Case Studies,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,Agency Website,,,HeyReach,
,Misc,⭐️⭐️⭐️,WK,04:50PM - 06:10PM,,,,100M Offer,Hunter Trading,ML,,LinkedIn & Insta Outreach,,,Offer Creation,,,Expedite,
,Upwork Bidding,⭐️⭐️⭐️,WK,06:10PM - 08:00PM,,BK 11:10PM - 11:40PM,,Creating Grand Slam Offer for agency,Project GSA,AC,,Manychat,,,"CAC, LTV, Gross Profit",,,App Sumo,
,SM Content Posting & Outreach,⭐️⭐️⭐️,SM,08:00PM - 10:00PM,,,,ClawGravity Setup,,RB,,SM Content Posting,,,"how to pick markets, and find niches that are profitable",,,,
,,,,,,,,ML Quiz,,,,,,,,,,,
,,,,,,,,Robotics Quiz,,,,,,,,,,,
,,,,,,,,12 Thu Roy Meeting 10:30PM,,,,,,,,,,,
,,,,,,,,21 Lazavia Meeting 9PM,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,Sp 10:00AM - 04:00PM,10/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,100M Offer,⭐️⭐️⭐️,LR,12:00AM - 06:00AM,,,,Cold Email Automations,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Creating Grand Slam Offer for agency,⭐️⭐️⭐️,WK,06:00AM - 07:50AM,,,,AL/ML Projects Case Studies,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",,,HeyReach,
,SM Content Posting,⭐️⭐️⭐️,SM,07:50AM - 08:40AM,,,,100M Leads,Hunter Trading,ML,,LinkedIn & Insta Outreach,,,"how to pick markets, and find niches that are profitable",,,Expedite,
,Misc,⭐️⭐️⭐️,WK,"08:40AM - 09:20AM, 05:00PM - 06:00PM",,,,Creating Grand Slam Offer for agency,Project GSA,AC,,Manychat,,,12 Thu Roy Meeting 10:30PM,,,App Sumo,
,Offer Crafting and Strategy Adjustment,⭐️⭐️⭐️,WK,06:00PM - 09:50PM,,,,ClawGravity Setup,,RB,,SM Content Posting,,,21 Lazavia Meeting 9PM,,,,
,,,,,,,,,,ML Quiz,,,,,,,,,
,,,,,,,,,,Robotics Quiz,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TH,,,,,,"Sp 06:00AM - 09:00AM, 01:00PM - 04:00PM",12/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️⭐️⭐️,WK,04:40PM - 06:20PM,,,,Cold Email Automations,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,"SM Content Posting & Outreach, Portfolio Update",⭐️⭐️⭐️,WK,"06:20PM - 10:20PM, 10:40PM - 12:00PM",,,,AL/ML Projects Case Studies,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",,,HeyReach,
,12 Thu Roy Meeting 10:30PM,⭐️⭐️⭐️,WK,10:20PM - 10:40PM,,,,100M Leads,Hunter Trading,ML,,LinkedIn & Insta Outreach,,,"how to pick markets, and find niches that are profitable",,,Expedite,
,,,,,,,,ClawGravity Setup,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,,App Sumo,
,,,,,,,,12 Thu Roy Meeting 10:30PM,,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,,,
,,,,,,,,,,ML Quiz,,,,,,,,,
,,,,,,,,,,Robotics Quiz,,,,,,,,,
FR,,,,,,Sp 08:00AM - 10:00AM,13/03/2026,IM,Projs,UN,LR,SM,UP,FR,AGN,RD,ATs,Tls,
,LinkedIn & Insta Outreach,⭐️⭐️⭐️,SM,12:00AM - 01:00AM,,,,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Upwork Bidding & Consulation,⭐️⭐️⭐️,WK,01:00AM - 03:20AM,,,,Cold Email Automations,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",,Content Creation & Research,HeyReach,
,Agentic AI,⭐️⭐️⭐️,LR,03:20AM - 07:50AM,,,,AL/ML Projects Case Studies,Hunter Trading,ML,,LinkedIn & Insta Outreach,,,"how to pick markets, and find niches that are profitable",,Instagram & LinkedIn Outreach,Expedite,
,Misc,⭐️⭐️,WK,11:40PM - 08:20PM,,,,100M Leads,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,,App Sumo,
,Out,⭐️⭐️⭐️,PR,08:30PM - 02:30AM,,,,ClawGravity Setup,,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,,,
,,,,,,,,Loom Introductory Video,,DV Assignment 18,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
ST,,,,,,"Sp 08:00AM - 10:00AM, 07:00PM  - 11:00PM",14/03/2026,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls,
,Misc,⭐️⭐️⭐️,WK,02:30AM - 03:40AM,,,,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM,
,Agentic AI,⭐️⭐️⭐️,LR,"03:50AM - 07:00AM, 02:00PM",,,,Cold Email Automations,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",,ClawGravity Setup,HeyReach,
,Misc,⭐️⭐️⭐️,WK,12:00PM - 02:00PM,,,,Content Creation & Research At,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite,
,Gaming,⭐️⭐️,PR,11:00PM - 01:30AM,,,,Instagram & LinkedIn Outreach At,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo,
,,,,,,,,Upwork Job Postings At,,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,,
,,,,,,,,Full proposal generator Alex Hormozi Style,,DV Assignment 18,,,,,Sales Script,,Website Design At,,
,,,,,,,,100M Leads,,,,,,,,,Website Development At,,
,,,,,,,,Loom Introductory Video,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
SU,,,,,,Sp 07:00AM - 03:00PM,15/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Agentic AI,⭐️⭐️⭐️,LR,01:30AM - 05:20AM,,,,Agentic AI,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,Misc,⭐️⭐️⭐️,PR,03:00PM - 05:20PM,,,,DV Assignment 18,DV Assignment 18,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,RB & DV Assignments,⭐️⭐️⭐️,UN,05:40PM - 06:30PM,,,,RB Assignment 15,RB Assignment 15,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,Daily News Workflow,⭐️⭐️⭐️,WK,06:30PM - 09:40PM,,,,Daily News Workflow,Cold Email Automations,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo
,SM Content Posting,⭐️⭐️⭐️,SM,09:40PM - 10:10PM,,,,SM Content Posting,Content Creation & Research At,,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,Trigger.Dev
,Youtube Daily Workflow,⭐️⭐️⭐️,WK,10:10PM - 11:40PM,,,,Youtube Daily Workflow,Instagram & LinkedIn Outreach At,,,,,,,Sales Script,,Website Design At,
,Upwork Bidding,⭐️⭐️⭐️,WK,11:40PM - 01:00AM,,,,Upwork Bidding,Upwork Job Postings At,,,,,,,,,Website Development At,
,,,,,,,,,100M Leads,,,,,,,,,"""Chief AI Officer"" ",
,,,,,,,,,Loom Introductory Video,,,,,,,,,Client Job Description to Structured Scope Requirements,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
MD,,,,,,"Sp 07:00AM - 10:00AM, 07:00PM - 11:00PM",16/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Files Organization,⭐️⭐️⭐️,WK,01:30AM - 03:50AM,,,,Files Organization,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,Agentic AI,⭐️⭐️⭐️,LR,05:20AM - 06:10AM,,,,Agentic AI,DV Assignment 18,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,Misc,⭐️⭐️⭐️,WK,12:00PM - 02:00PM,,,,n8n workflow to claude workflow,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,Upwork Bidding,⭐️⭐️⭐️,WK,"02:00PM - 03:00PM, 11:30PM",,,,,Content Creation & Research At,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo
,n8n workflow to claude workflow,⭐️⭐️⭐️,WK,03:00PM - 05:20PM,,,,,Instagram & LinkedIn Outreach At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,Trigger.Dev
,Agentic AI,⭐️⭐️⭐️,LR,05:20PM - 06:10PM,,,,,Upwork Job Postings At,,,,,,,Sales Script,,Website Design At,
,,,,,,,,,100M Leads,,,,,,,Claude Code Course Creation,,Website Development At,
,,,,,,,,,Loom Introductory Video,,,,,,,Meme Generator,,"""Chief AI Officer"" ",
,,,,,,,,,,,,,,,,,,Files & Folder Organizer,
,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,
TU,,,,,,Sp 07:00AM - 02:30PM,17/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Upwork Bidding,⭐️⭐️⭐️,WK,11:30PM - 01:30AM,,,,Upwork Bidding,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,n8n workflow to claude workflow,⭐️⭐️⭐️,WK,01:30AM - 02:20AM,,,,n8n workflow to claude workflow,DV Assignment 18,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,Agentic AI,⭐️⭐️⭐️,LR,02:20AM - 06:10AM,,,,Agentic AI,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,Misc,⭐️⭐️⭐️,WK,02:00PM - 04:05PM,,,,Misc,Content Creation & Research At,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo
,SM Content Posting & Outreach,⭐️⭐️⭐️,SM,04:05PM - 05:15PM,,,,SM Content Posting & Outreach,Instagram & LinkedIn Outreach At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,Trigger.Dev
,Out,⭐️⭐️⭐️,PR,05:15PM - 03:05AM,,,,,Upwork Job Postings At,,,,,,,Sales Script,,Website Design At,many chats
,,,,,,,,,100M Leads,,,,,,,Claude Code Course Creation,,Website Development At,
,,,,,,,,,Loom Introductory Video,,,,,,,Meme Generator,,"""Chief AI Officer"" ",
,,,,,,,,,,,,,,,,,,Client Job Description to Structured Scope Requirements,
,,,,,,,,,,,,,,,,,,Files & Folder Organizer,
WD,,,,,,Sp 08:30AM - 04:00PM,18/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Agentic AI,⭐️⭐️⭐️,LR,03:05AM - 07:30AM,,,,Agentic AI,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,Misc,⭐️⭐️⭐️,WK,"04:05PM - 05:00PM, 08:00PM - 11:00PM",,,,Client Job Description to Structured Scope Requirements,DV Assignment 18,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,Client Job Description to Structured Scope Requirements,⭐️⭐️⭐️,WK,03:05PM - 07:30PM,,,,AI Content Engine,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,,,,,,,,Website Audit At,Content Creation & Research At,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo
,,,,,,,,Executive Assistant Nexis,Instagram & LinkedIn Outreach At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,Trigger.Dev
,,,,,,,,,Upwork Job Postings At,,,,,,,Sales Script,,Website Design At,many chats
,,,,,,,,,100M Leads,,,,,,,Claude Code Course Creation,,Website Development At,
,,,,,,,,,Loom Introductory Video,,,,,,,Meme Generator,,"""Chief AI Officer"" ",
,,,,,,,,,,,,,,,,,,Client Job Description to Structured Scope Requirements,
,,,,,,,,,,,,,,,,,,Files & Folder Organizer,
TH,,,,,,Sp 07:00AM - 03:00PM,19/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Agentic AI,⭐️⭐️⭐️,LR,11:00PM - 07:40AM,,,,Agentic AI,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,Misc,⭐️⭐️⭐️,WK,"03:05PM - 06:30PM, 07:30PM - 10:00PM",,,,Executive Assistant Nexis,DV Assignment 18,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,Gaming,⭐️⭐️,PR,10:00PM - 12:00PM,,,,,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,Out,⭐️⭐️⭐️,PR,12:15PM - 04:05AM,,,,,Content Creation & Research At,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo
,,,,,,,,,Instagram & LinkedIn Outreach At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,Trigger.Dev
,,,,,,,,,Upwork Job Postings At,,,,,,,Sales Script,,Website Design At,many chats
,,,,,,,,,100M Leads,,,,,,,Claude Code Course Creation,,Website Development At,
,,,,,,,,,Loom Introductory Video,,,,,,,Meme Generator,,"""Chief AI Officer"" ",
,,,,,,,,,,,,,,,,,,Client Job Description to Structured Scope Requirements,
FR,,,,,,Sp 08:00AM - 04:00PM,20/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Misc,⭐️⭐️⭐️,WK,04:05PM - 06:00PM,,,,Agentic AI,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,Out,⭐️⭐️⭐️,PR,06:15PM - 09:10PM,,,,Testing Claude Fullstack Skills on Upwork Demo Project,DV Assignment 18,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,Gaming,⭐️⭐️,PR,09:10PM - 11:10PM,,,,,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,,,,,,,,,Content Creation & Research At,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo
,,,,,,,,,Instagram & LinkedIn Outreach At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,Trigger.Dev
,,,,,,,,,Upwork Job Postings At,,,,,,,Sales Script,,Website Design At,many chats
,,,,,,,,,100M Leads,,,,,,,Claude Code Course Creation,,Website Development At,
,,,,,,,,,Loom Introductory Video,,,,,,,Meme Generator,,"""Chief AI Officer"" ",
,,,,,,,,,,,,,,,,Trojan Horse Strategy,,Client Job Description to Structured Scope Requirements,
ST,,,,,,Sp 09:00AM - 03:00PM,21/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Agentic AI,⭐️⭐️⭐️,LR,11:10PM - 08:20AM,,,,Agentic AI,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,Misc,⭐️⭐️⭐️,PR,04:05PM - 05:00PM,,,,SM Content Management ,100M Leads,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,"Agentic AI, SM Content Management ",⭐️⭐️⭐️,WK,05:00PM - 10:30PM,,,,,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,,,,,,,,,Content Creation & Research At,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo
,,,,,,,,,Instagram & LinkedIn Outreach At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,Trigger.Dev
,,,,,,,,,Upwork Job Postings At,,,,,,,Sales Script,,Website Design At,many chats
,,,,,,,,,Loom Introductory Video,,,,,,,Claude Code Course Creation,,Website Development At,
,,,,,,,,,,,,,,,,Meme Generator,,"""Chief AI Officer"" ",
,,,,,,,,,,,,,,,,,,,
MD,,,,,,Sp 01:00PM - 06:00PM,23/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Misc,⭐️⭐️⭐️,WK,07:30PM - 09:30PM,,,,,Agentic AI,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,WF,⭐️⭐️⭐️,PR,09:30PM - 12:00AM,,,,,100M Leads,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,,,,,,,,,Cold Email Automations,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,,,,,,,,,Content Creation & Research At,Project GSA,AC,,Manychat,,,21 Lazavia Meeting 9PM,,SOP Generation At,App Sumo
,,,,,,,,,Instagram & LinkedIn Outreach At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Creating Grand Slam Offer for agency,,Website Audit At,Trigger.Dev
,,,,,,,,,Upwork Job Postings At,,,,,,,Sales Script,,Website Design At,many chats
,,,,,,,,,Loom Introductory Video,,,,,,,Claude Code Course Creation,,Website Development At,
,,,,,,,,,,,,,,,,Meme Generator,,"""Chief AI Officer"" ",
,,,,,,,,,,,,,,,,,,,
TU,,,,,,Sp 11:00AM - 04:00PM,24/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Misc,⭐️⭐️⭐️,WK,12:00AM - 01:30AM,,,,100M Leads,100M Leads,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,100M Leads,⭐️⭐️⭐️,LR,01:50AM - 09:30AM,,,,Upwork Job Postings At,Cold Email Automations,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,Misc,⭐️⭐️⭐️,PR,04:00PM - 05:20PM,,,,,Content Creation & Research At,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,Upwork Bidding,⭐️⭐️⭐️,WK,05:20PM - 06:30PM,,,,,Instagram & LinkedIn Outreach At,Project GSA,AC,,Manychat,,,Creating Grand Slam Offer for agency,,SOP Generation At,App Sumo
,Upwork Job Postings At,⭐️⭐️⭐️,WK,06:30PM - 08:40PM,,,,,Upwork Job Postings At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Sales Script,,Website Audit At,Trigger.Dev
,100M Leads,⭐️⭐️⭐️,LR,08:50PM - 10:30PM,,,,,Loom Introductory Video,,,,,,,Claude Code Course Creation,,Website Design At,many chats
,,,,,,,,,,,,,,,,Meme Generator,,Website Development At,
,,,,,,,,,,,,,,,,,,"""Chief AI Officer"" ",
WD,,,,,,,25/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,100M Leads,⭐️⭐️⭐️,LR,11:00AM - 02:15AM,,,,100M Leads,100M Leads,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,SH,⭐️⭐️⭐️,PR,05:00PM - 11:30PM,,,,,Cold Email Automations,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,,,,,,,,,Content Creation & Research At,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,,,,,,,,,Instagram & LinkedIn Outreach At,Project GSA,AC,,Manychat,,,Creating Grand Slam Offer for agency,,SOP Generation At,App Sumo
,,,,,,,,,Upwork Job Postings At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Sales Script,,Website Audit At,Trigger.Dev
,,,,,,,,,Loom Introductory Video,,,,,,,Claude Code Course Creation,,Website Design At,many chats
,,,,,,,,,,,,,,,,Meme Generator,,Website Development At,
TH,,,,,,,26/03/2026,DN,IM,Projs,UN,CR,SM,UP,FR,AGN,RD,ATs,Tls
,Misc,⭐️⭐️⭐️,WK,11:30PM - 02:00AM,,,,,100M Leads,Project Moji,DOA,AI Engineer Core Track,SM Content Management ,Upwork Bidding,Finding Fiverr Expert,Agency Website,How AI Works From Sorcery,OpenClaw Setup,Auto IGDM
,,,,,,,,,Cold Email Automations,PR Productivity MVP,DV,,AntiGravity NotebookLm,Upwork Consultations,nSave Payment app,"CAC, LTV, Gross Profit",Daily Brief,ClawGravity Setup,HeyReach
,,,,,,,,,Content Creation & Research At,Hunter Trading,ML,,LinkedIn & Insta Outreach,AL/ML Projects Case Studies,,"how to pick markets, and find niches that are profitable",,100M Offer At,Expedite
,,,,,,,,,Instagram & LinkedIn Outreach At,Project GSA,AC,,Manychat,,,Creating Grand Slam Offer for agency,,SOP Generation At,App Sumo
,,,,,,,,,Upwork Job Postings At,Testing Claude Fullstack Skills on Upwork Demo Project,RB,,SM Content Posting,,,Sales Script,,Website Audit At,Trigger.Dev
,,,,,,,,,Loom Introductory Video,,,,,,,Claude Code Course Creation,,Website Design At,many chats
,,,,,,,,,,,,,,,,Meme Generator,,Website Development At,
,,,,,,,,,,,,,,,,,,"""Chief AI Officer"" ",');
INSERT INTO public.imports VALUES ('619b4974-7779-4de8-a615-6bda2c8a2e47', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'T D L - TD.csv', 2346, 1074, 1272, 'complete', NULL, '2026-03-26 03:55:51.046202', NULL);


--
-- Data for Name: task_entries; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.task_entries VALUES ('d6d30daf-7d76-4fc8-916f-6092e6c2a212', '1fd42315-992f-43ef-84c4-db3d3df92840', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Attendence check', 3, NULL, '04:30:00', '05:05:00', 35, true, '2026-03-25 22:55:51.28', 0, '2026-03-26 03:55:51.281687', '2026-03-26 03:55:51.281687');
INSERT INTO public.task_entries VALUES ('e91cc9c6-2640-4b92-97e0-5280c9fc2bfb', '1fd42315-992f-43ef-84c4-db3d3df92840', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'nazra', 3, NULL, '05:05:00', '05:30:00', 25, true, '2026-03-25 22:55:51.287', 1, '2026-03-26 03:55:51.288306', '2026-03-26 03:55:51.288306');
INSERT INTO public.task_entries VALUES ('c05a40b8-ef10-44f1-ac27-745bcc404af5', '1fd42315-992f-43ef-84c4-db3d3df92840', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '05:35:00', '06:55:00', 80, true, '2026-03-25 22:55:51.291', 2, '2026-03-26 03:55:51.291912', '2026-03-26 03:55:51.291912');
INSERT INTO public.task_entries VALUES ('807ab2aa-3951-4ac6-a8c7-b72657c6948d', '1fd42315-992f-43ef-84c4-db3d3df92840', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'exams preparation date set', 2, 'missed', NULL, NULL, NULL, false, NULL, 3, '2026-03-26 03:55:51.295928', '2026-03-26 03:55:51.295928');
INSERT INTO public.task_entries VALUES ('79314c9c-236e-45e8-ab4f-1e235cee2c5f', '1fd42315-992f-43ef-84c4-db3d3df92840', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Book Reading', 2, 'missed', NULL, NULL, NULL, false, NULL, 4, '2026-03-26 03:55:51.299652', '2026-03-26 03:55:51.299652');
INSERT INTO public.task_entries VALUES ('8e3a3a02-418b-4321-a6b4-fbb12c2c8164', '1fd42315-992f-43ef-84c4-db3d3df92840', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Python Tutorial', 2, 'missed', NULL, NULL, NULL, false, NULL, 5, '2026-03-26 03:55:51.303279', '2026-03-26 03:55:51.303279');
INSERT INTO public.task_entries VALUES ('ae8548e0-758d-4c53-8e40-0136e971457e', 'd425d9a1-f28e-4d92-b51e-db2a46dfda7b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Upwork Jobs Applying', 3, NULL, '04:30:00', '05:05:00', 195, true, '2026-03-25 22:55:51.309', 6, '2026-03-26 03:55:51.310592', '2026-03-26 03:55:51.310592');
INSERT INTO public.task_entries VALUES ('512df2e3-5425-4875-b925-665ef11d96b4', 'd425d9a1-f28e-4d92-b51e-db2a46dfda7b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Interview', 3, NULL, '20:30:00', '20:40:00', 10, true, '2026-03-25 22:55:51.314', 7, '2026-03-26 03:55:51.314879', '2026-03-26 03:55:51.314879');
INSERT INTO public.task_entries VALUES ('8c55042b-0cac-41f6-b1c4-e1e014a9fcca', 'd425d9a1-f28e-4d92-b51e-db2a46dfda7b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'OLX ad', 2, NULL, '22:40:00', '23:35:00', 55, true, '2026-03-25 22:55:51.317', 8, '2026-03-26 03:55:51.318113', '2026-03-26 03:55:51.318113');
INSERT INTO public.task_entries VALUES ('30015b0e-4d57-465d-b8ed-4aca91b3f41d', 'd425d9a1-f28e-4d92-b51e-db2a46dfda7b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Assignments check', 3, NULL, '23:35:00', '00:20:00', 45, true, '2026-03-25 22:55:51.321', 9, '2026-03-26 03:55:51.321738', '2026-03-26 03:55:51.321738');
INSERT INTO public.task_entries VALUES ('dd4c6a94-a4bb-4531-b8e5-3dd3c31d9a2b', 'd425d9a1-f28e-4d92-b51e-db2a46dfda7b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exams preparation date set', 3, NULL, '00:20:00', '00:42:00', 22, true, '2026-03-25 22:55:51.326', 10, '2026-03-26 03:55:51.327082', '2026-03-26 03:55:51.327082');
INSERT INTO public.task_entries VALUES ('5abd9592-aab4-4369-8a54-6c86411ae574', 'd425d9a1-f28e-4d92-b51e-db2a46dfda7b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork SOP Setting', 2, NULL, '01:00:00', '02:40:00', 100, true, '2026-03-25 22:55:51.33', 11, '2026-03-26 03:55:51.331419', '2026-03-26 03:55:51.331419');
INSERT INTO public.task_entries VALUES ('bc2a01d2-5cd5-4af4-a9e8-cd58714852f8', 'ea46d472-a9b5-4024-88cd-109d8c2ab4b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Meeting with Moiz', 2, NULL, NULL, NULL, 60, true, '2026-03-25 22:55:51.338', 12, '2026-03-26 03:55:51.339061', '2026-03-26 03:55:51.339061');
INSERT INTO public.task_entries VALUES ('d6b8f8a3-8c39-42b4-a6ab-f1e549b1a5bb', 'ea46d472-a9b5-4024-88cd-109d8c2ab4b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Book Reading', 2, NULL, '04:00:00', '06:00:00', 240, true, '2026-03-25 22:55:51.342', 13, '2026-03-26 03:55:51.343145', '2026-03-26 03:55:51.343145');
INSERT INTO public.task_entries VALUES ('3b919ad7-e651-4aa5-abf9-92548bee1c5c', 'ea46d472-a9b5-4024-88cd-109d8c2ab4b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Habits Scorecard', 2, NULL, '06:10:00', '07:45:00', 95, true, '2026-03-25 22:55:51.346', 14, '2026-03-26 03:55:51.346882', '2026-03-26 03:55:51.346882');
INSERT INTO public.task_entries VALUES ('544c0f6c-3977-436d-bf1e-86f7e7c4103f', 'ea46d472-a9b5-4024-88cd-109d8c2ab4b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Python Tutorial', 2, NULL, NULL, NULL, NULL, true, '2026-03-25 22:55:51.349', 15, '2026-03-26 03:55:51.350313', '2026-03-26 03:55:51.350313');
INSERT INTO public.task_entries VALUES ('ca0bca4c-8725-4934-b60f-68be9e54ddf9', 'ea46d472-a9b5-4024-88cd-109d8c2ab4b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Bike Maintainance', 3, NULL, '09:35:00', '13:20:00', 225, true, '2026-03-25 22:55:51.353', 16, '2026-03-26 03:55:51.353763', '2026-03-26 03:55:51.353763');
INSERT INTO public.task_entries VALUES ('1bafa2b9-a07d-4634-84db-20d175c4a8c1', '29f2a9a3-b585-45d9-ad26-80cb783286ba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Misc', 1, NULL, '01:15:00', '02:25:00', 70, true, '2026-03-25 22:55:51.365', 17, '2026-03-26 03:55:51.366201', '2026-03-26 03:55:51.366201');
INSERT INTO public.task_entries VALUES ('4fd67775-7ccc-4d13-a65b-518b224e411d', '29f2a9a3-b585-45d9-ad26-80cb783286ba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Upwork Jobs Applying', 2, NULL, '23:30:00', '01:15:00', 165, true, '2026-03-25 22:55:51.37', 18, '2026-03-26 03:55:51.371212', '2026-03-26 03:55:51.371212');
INSERT INTO public.task_entries VALUES ('19d0e103-9c75-40a2-8638-6a2ecccac30b', '29f2a9a3-b585-45d9-ad26-80cb783286ba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Assignments Completion', 3, NULL, '07:55:00', '10:10:00', 135, true, '2026-03-25 22:55:51.374', 19, '2026-03-26 03:55:51.374891', '2026-03-26 03:55:51.374891');
INSERT INTO public.task_entries VALUES ('0ccea240-387e-428d-81ba-da1192ec5d17', '29f2a9a3-b585-45d9-ad26-80cb783286ba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Bike Sold', 3, NULL, '11:45:00', '02:15:00', 870, true, '2026-03-25 22:55:51.377', 20, '2026-03-26 03:55:51.378308', '2026-03-26 03:55:51.378308');
INSERT INTO public.task_entries VALUES ('eba0e798-cdee-464c-8d33-918e637a71ad', '7603b18c-22dd-4505-84c1-1eb612f0346b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'World History - Quiz 2', 3, NULL, '20:00:00', NULL, NULL, true, '2026-03-25 22:55:51.384', 21, '2026-03-26 03:55:51.385337', '2026-03-26 03:55:51.385337');
INSERT INTO public.task_entries VALUES ('852aadbb-df60-41d3-a7b9-7f220c0ac486', '7603b18c-22dd-4505-84c1-1eb612f0346b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Exercise', 2, NULL, '05:00:00', '05:30:00', 30, true, '2026-03-25 22:55:51.388', 22, '2026-03-26 03:55:51.388644', '2026-03-26 03:55:51.388644');
INSERT INTO public.task_entries VALUES ('ad0505b2-4cba-473d-a5df-12065088cd47', '7603b18c-22dd-4505-84c1-1eb612f0346b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Upwork Jobs Applying', 2, NULL, '05:30:00', NULL, NULL, true, '2026-03-25 22:55:51.391', 23, '2026-03-26 03:55:51.39231', '2026-03-26 03:55:51.39231');
INSERT INTO public.task_entries VALUES ('985ab763-74a2-4309-adf5-1f75a2b15a5b', '2e223e66-7f5e-4907-bf89-3a554d4a7e7d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Upwork Jobs Applying', 2, NULL, '10:30:00', NULL, NULL, true, '2026-03-25 22:55:51.398', 24, '2026-03-26 03:55:51.399224', '2026-03-26 03:55:51.399224');
INSERT INTO public.task_entries VALUES ('3ec35cb6-cfc8-407b-a6ee-b3a4fc2cadf2', '2e223e66-7f5e-4907-bf89-3a554d4a7e7d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'OS Assignment Completion', 3, NULL, '07:45:00', '08:30:00', 45, true, '2026-03-25 22:55:51.402', 25, '2026-03-26 03:55:51.402648', '2026-03-26 03:55:51.402648');
INSERT INTO public.task_entries VALUES ('cc9c844c-e66b-4f56-88ee-277fbf46eaab', '2e223e66-7f5e-4907-bf89-3a554d4a7e7d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Misc', 1, NULL, '01:15:00', '02:25:00', 70, true, '2026-03-25 22:55:51.406', 26, '2026-03-26 03:55:51.407226', '2026-03-26 03:55:51.407226');
INSERT INTO public.task_entries VALUES ('cb0523aa-7af7-4e62-a581-6c84e1d24f1a', '1765d700-4a27-43ef-a155-c443ed1ce809', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Misc', 1, NULL, '04:30:00', '06:30:00', 120, true, '2026-03-25 22:55:51.42', 27, '2026-03-26 03:55:51.421258', '2026-03-26 03:55:51.421258');
INSERT INTO public.task_entries VALUES ('219e298f-c0d4-4c4e-9e5c-241dcd28f9c0', '1765d700-4a27-43ef-a155-c443ed1ce809', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'University', 3, NULL, '08:00:00', '14:30:00', 390, true, '2026-03-25 22:55:51.424', 28, '2026-03-26 03:55:51.424681', '2026-03-26 03:55:51.424681');
INSERT INTO public.task_entries VALUES ('25b8658a-fd3a-4ba6-9916-91ca8e39f5c5', '1765d700-4a27-43ef-a155-c443ed1ce809', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Misc', 1, NULL, '15:30:00', '17:30:00', 120, true, '2026-03-25 22:55:51.427', 29, '2026-03-26 03:55:51.42802', '2026-03-26 03:55:51.42802');
INSERT INTO public.task_entries VALUES ('a3b89f97-98f1-4530-8fc0-1d9b85974a28', '1765d700-4a27-43ef-a155-c443ed1ce809', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '05:30:00', '20:05:00', 875, true, '2026-03-25 22:55:51.43', 30, '2026-03-26 03:55:51.431509', '2026-03-26 03:55:51.431509');
INSERT INTO public.task_entries VALUES ('aa8b0872-03d4-4b73-ac32-0e795ad91528', '1765d700-4a27-43ef-a155-c443ed1ce809', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Misc', 1, NULL, '20:30:00', '22:00:00', 90, true, '2026-03-25 22:55:51.434', 31, '2026-03-26 03:55:51.435082', '2026-03-26 03:55:51.435082');
INSERT INTO public.task_entries VALUES ('2da6e23c-c464-40e4-9b76-991b35eebd9a', '091e192b-bb65-450c-b1a2-92beb6e7bd57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Notifications Check', 3, NULL, '07:00:00', '07:30:00', 30, true, '2026-03-25 22:55:51.44', 32, '2026-03-26 03:55:51.441201', '2026-03-26 03:55:51.441201');
INSERT INTO public.task_entries VALUES ('f9e7a154-97fe-486d-a50f-b70d51b52c60', '091e192b-bb65-450c-b1a2-92beb6e7bd57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '07:50:00', '21:30:00', 820, true, '2026-03-25 22:55:51.443', 33, '2026-03-26 03:55:51.444546', '2026-03-26 03:55:51.444546');
INSERT INTO public.task_entries VALUES ('20419c91-05fe-4cba-a8f1-cc070670fe1e', '091e192b-bb65-450c-b1a2-92beb6e7bd57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Curriculum Check', 2, NULL, '09:30:00', '22:00:00', 750, true, '2026-03-25 22:55:51.447', 34, '2026-03-26 03:55:51.448123', '2026-03-26 03:55:51.448123');
INSERT INTO public.task_entries VALUES ('c7d12769-39cb-4720-91e8-d4c4fda32b47', '091e192b-bb65-450c-b1a2-92beb6e7bd57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Soft Business Skills', 2, NULL, '22:00:00', '12:30:00', 870, true, '2026-03-25 22:55:51.451', 35, '2026-03-26 03:55:51.451703', '2026-03-26 03:55:51.451703');
INSERT INTO public.task_entries VALUES ('cafa8ac2-33ab-4562-918c-3660ae9c4925', '091e192b-bb65-450c-b1a2-92beb6e7bd57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Receiving Naseeb', 3, NULL, '08:00:00', '08:30:00', 30, true, '2026-03-25 22:55:51.454', 36, '2026-03-26 03:55:51.455053', '2026-03-26 03:55:51.455053');
INSERT INTO public.task_entries VALUES ('98e79f2e-cef3-4f8d-8665-dfe95b70e6dd', '091e192b-bb65-450c-b1a2-92beb6e7bd57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '02:00:00', '03:15:00', 75, true, '2026-03-25 22:55:51.459', 37, '2026-03-26 03:55:51.460442', '2026-03-26 03:55:51.460442');
INSERT INTO public.task_entries VALUES ('7e4bd1f5-ac81-440a-b12f-2a0178037b0c', '091e192b-bb65-450c-b1a2-92beb6e7bd57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Quiz Preparation', 2, NULL, '02:00:00', '03:15:00', 75, true, '2026-03-25 22:55:51.463', 38, '2026-03-26 03:55:51.463765', '2026-03-26 03:55:51.463765');
INSERT INTO public.task_entries VALUES ('78d1869e-19f0-4d92-bdfe-fd8166f03c67', '801a5e40-b306-4456-ad95-0d4e85c38080', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'University', 3, NULL, '07:00:00', '11:30:00', 270, true, '2026-03-25 22:55:51.471', 39, '2026-03-26 03:55:51.471629', '2026-03-26 03:55:51.471629');
INSERT INTO public.task_entries VALUES ('6760ac3e-168a-4299-92ca-21b772b4c10e', '801a5e40-b306-4456-ad95-0d4e85c38080', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Naseeb Academy', 3, NULL, '11:30:00', '14:00:00', 150, true, '2026-03-25 22:55:51.475', 40, '2026-03-26 03:55:51.476124', '2026-03-26 03:55:51.476124');
INSERT INTO public.task_entries VALUES ('e5fd760b-1e11-4b95-ba6a-e511048d0f40', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '76f79a24-39c1-44ba-8148-81f44fe680a2', NULL, 'Projects Work', 3, NULL, '16:30:00', '18:00:00', 90, true, '2026-03-26 13:06:53.497', 6, '2026-03-26 18:06:50.96797', '2026-03-26 13:06:53.497');
INSERT INTO public.task_entries VALUES ('f3870cdb-682f-4fb9-bd11-aa419099a35d', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', NULL, 'Upwork Bidding', 2, NULL, '04:32:00', '05:45:00', 73, true, '2026-03-26 00:45:20.8', 2, '2026-03-26 04:32:27.89015', '2026-03-26 00:45:20.8');
INSERT INTO public.task_entries VALUES ('50c64b41-2c7c-4514-9a61-0953fdb12ae3', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Gaming', 1, NULL, '09:00:00', '12:00:00', 180, true, '2026-03-26 11:55:48.468', 4, '2026-03-26 16:55:43.780141', '2026-03-26 11:55:57.551');
INSERT INTO public.task_entries VALUES ('18718684-0915-469a-b10a-d52dadd83b7b', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '76f79a24-39c1-44ba-8148-81f44fe680a2', NULL, 'PR Productivity MVP', 2, NULL, '02:16:00', '04:30:00', 134, true, '2026-03-25 22:17:18.387', 1, '2026-03-26 03:17:14.776749', '2026-03-25 23:24:58.523');
INSERT INTO public.task_entries VALUES ('892885d1-88d0-4aea-8fde-0fb459d2c798', '801a5e40-b306-4456-ad95-0d4e85c38080', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Outing', 2, NULL, '20:30:00', '12:00:00', 930, true, '2026-03-25 22:55:51.478', 41, '2026-03-26 03:55:51.479467', '2026-03-26 03:55:51.479467');
INSERT INTO public.task_entries VALUES ('40a4e505-d63f-4ba3-ba28-a1a6dedbbe65', '5d385f2c-51b1-4d29-a2e1-bb0bfbb8b078', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exams preparation date set & evaluation', 3, NULL, '09:00:00', '11:00:00', 120, true, '2026-03-25 22:55:51.491', 42, '2026-03-26 03:55:51.491864', '2026-03-26 03:55:51.491864');
INSERT INTO public.task_entries VALUES ('7bcef1dc-1ef2-4cb3-95e0-320ab25b9d15', '7ec01752-76e1-4af0-b39e-97568d234d07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Breakfast', 3, NULL, '09:00:00', '11:00:00', 120, true, '2026-03-25 22:55:51.497', 43, '2026-03-26 03:55:51.497831', '2026-03-26 03:55:51.497831');
INSERT INTO public.task_entries VALUES ('72ea0d2d-6c64-40bc-b041-0f4ae9ad098b', '7ec01752-76e1-4af0-b39e-97568d234d07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Sunday Bazaar', 2, NULL, '11:30:00', '14:00:00', 150, true, '2026-03-25 22:55:51.5', 44, '2026-03-26 03:55:51.501502', '2026-03-26 03:55:51.501502');
INSERT INTO public.task_entries VALUES ('2a211ac2-8b29-4d48-8c4c-e768f7ef7060', '7ec01752-76e1-4af0-b39e-97568d234d07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Sleep', 2, NULL, '14:30:00', '18:00:00', 210, true, '2026-03-25 22:55:51.504', 45, '2026-03-26 03:55:51.504812', '2026-03-26 03:55:51.504812');
INSERT INTO public.task_entries VALUES ('259b1103-5468-4d6c-8ea0-751d2f292f59', '7ec01752-76e1-4af0-b39e-97568d234d07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Faisal Mosque', 2, NULL, '18:30:00', '12:00:00', 1050, true, '2026-03-25 22:55:51.508', 46, '2026-03-26 03:55:51.509304', '2026-03-26 03:55:51.509304');
INSERT INTO public.task_entries VALUES ('3d0f0509-cade-4e55-93da-1558ebc6238a', '7ec01752-76e1-4af0-b39e-97568d234d07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Sleep', 2, NULL, '01:30:00', '05:00:00', 210, true, '2026-03-25 22:55:51.513', 47, '2026-03-26 03:55:51.514453', '2026-03-26 03:55:51.514453');
INSERT INTO public.task_entries VALUES ('63ab612c-ad00-49c1-bee9-5e2f9f69d84d', '718cf95a-afd4-4c34-ad6c-def125f2af58', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 1, NULL, '05:00:00', '06:00:00', 60, true, '2026-03-25 22:55:51.522', 48, '2026-03-26 03:55:51.523185', '2026-03-26 03:55:51.523185');
INSERT INTO public.task_entries VALUES ('4058332f-e958-493c-bb17-22ca83f76065', '718cf95a-afd4-4c34-ad6c-def125f2af58', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'University', 3, NULL, '06:00:00', '12:00:00', 360, true, '2026-03-25 22:55:51.526', 49, '2026-03-26 03:55:51.526807', '2026-03-26 03:55:51.526807');
INSERT INTO public.task_entries VALUES ('6c610856-0f33-4fe9-8b00-444ff1a67b47', '718cf95a-afd4-4c34-ad6c-def125f2af58', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Breakfast', 2, NULL, '12:00:00', '13:00:00', 60, true, '2026-03-25 22:55:51.529', 50, '2026-03-26 03:55:51.53022', '2026-03-26 03:55:51.53022');
INSERT INTO public.task_entries VALUES ('06726e4b-b5ca-455a-b5d2-05721631a890', '718cf95a-afd4-4c34-ad6c-def125f2af58', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Monthly Expense Calculation', 3, NULL, '13:30:00', '16:00:00', 150, true, '2026-03-25 22:55:51.533', 51, '2026-03-26 03:55:51.533813', '2026-03-26 03:55:51.533813');
INSERT INTO public.task_entries VALUES ('25aef930-d03f-4aa5-97d8-5615ae55955d', '718cf95a-afd4-4c34-ad6c-def125f2af58', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Schedule set', 3, NULL, '16:00:00', '16:40:00', 40, true, '2026-03-25 22:55:51.537', 52, '2026-03-26 03:55:51.538041', '2026-03-26 03:55:51.538041');
INSERT INTO public.task_entries VALUES ('b0336f3f-c565-4ed9-8579-43e38938c6ce', '718cf95a-afd4-4c34-ad6c-def125f2af58', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Multi Calculas Assignment', 3, NULL, '17:00:00', '18:00:00', 60, true, '2026-03-25 22:55:51.541', 53, '2026-03-26 03:55:51.541667', '2026-03-26 03:55:51.541667');
INSERT INTO public.task_entries VALUES ('c371cae8-22d8-4830-9b0f-a2139f1a2a69', '718cf95a-afd4-4c34-ad6c-def125f2af58', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '21:00:00', '22:15:00', 75, true, '2026-03-25 22:55:51.545', 54, '2026-03-26 03:55:51.546114', '2026-03-26 03:55:51.546114');
INSERT INTO public.task_entries VALUES ('69748b91-6f65-4e69-9179-615d2a3484f8', 'd559c4f2-8647-473f-abbb-d05971dff53d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Sleep', 1, NULL, '08:30:00', '11:30:00', 180, true, '2026-03-25 22:55:51.552', 55, '2026-03-26 03:55:51.55292', '2026-03-26 03:55:51.55292');
INSERT INTO public.task_entries VALUES ('ca6c3753-1886-4d07-8fbe-986c5303240d', 'd559c4f2-8647-473f-abbb-d05971dff53d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 3, NULL, '12:30:00', '15:50:00', 305, true, '2026-03-25 22:55:51.555', 56, '2026-03-26 03:55:51.556365', '2026-03-26 03:55:51.556365');
INSERT INTO public.task_entries VALUES ('621a5f2b-9d2f-4562-869a-024b11175091', 'd559c4f2-8647-473f-abbb-d05971dff53d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation Discrete', 3, NULL, '17:15:00', NULL, NULL, true, '2026-03-25 22:55:51.561', 57, '2026-03-26 03:55:51.561764', '2026-03-26 03:55:51.561764');
INSERT INTO public.task_entries VALUES ('dfa96369-5147-4b95-9ce0-f2231deafe20', 'd559c4f2-8647-473f-abbb-d05971dff53d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Interview', 3, NULL, '19:30:00', '19:50:00', 20, true, '2026-03-25 22:55:51.565', 58, '2026-03-26 03:55:51.566168', '2026-03-26 03:55:51.566168');
INSERT INTO public.task_entries VALUES ('bc780f81-e126-4ed9-881a-8ccfac26df1f', 'd559c4f2-8647-473f-abbb-d05971dff53d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project Despii', 3, NULL, '22:30:00', '23:30:00', 60, true, '2026-03-25 22:55:51.568', 59, '2026-03-26 03:55:51.569454', '2026-03-26 03:55:51.569454');
INSERT INTO public.task_entries VALUES ('d4e2f400-7ae5-48a6-bc82-76d2f0354655', 'd559c4f2-8647-473f-abbb-d05971dff53d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Meeting with Moiz', 3, NULL, '23:30:00', '23:50:00', 20, true, '2026-03-25 22:55:51.572', 60, '2026-03-26 03:55:51.572998', '2026-03-26 03:55:51.572998');
INSERT INTO public.task_entries VALUES ('4429866c-93d0-4fe0-8132-890065579c47', '56b1eda5-083f-4210-8b9a-3b2ee60aa08d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 1, NULL, '09:00:00', '13:30:00', 270, true, '2026-03-25 22:55:51.58', 61, '2026-03-26 03:55:51.580865', '2026-03-26 03:55:51.580865');
INSERT INTO public.task_entries VALUES ('5e02558c-659e-427e-9877-f408c821adbe', '56b1eda5-083f-4210-8b9a-3b2ee60aa08d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project Metaops', 3, NULL, '14:00:00', '14:30:00', 30, true, '2026-03-25 22:55:51.583', 62, '2026-03-26 03:55:51.584462', '2026-03-26 03:55:51.584462');
INSERT INTO public.task_entries VALUES ('5427e9c3-d716-4906-96af-39ac75de35a3', '56b1eda5-083f-4210-8b9a-3b2ee60aa08d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project Despii', 3, NULL, '14:30:00', '16:40:00', 1115, true, '2026-03-25 22:55:51.587', 63, '2026-03-26 03:55:51.5878', '2026-03-26 03:55:51.5878');
INSERT INTO public.task_entries VALUES ('b79d6113-6b6a-4405-983f-7517bdf45dfd', '56b1eda5-083f-4210-8b9a-3b2ee60aa08d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '16:50:00', '17:30:00', 140, true, '2026-03-25 22:55:51.589', 64, '2026-03-26 03:55:51.590509', '2026-03-26 03:55:51.590509');
INSERT INTO public.task_entries VALUES ('1e65a672-c8b5-4c9a-942c-55572c8b59c2', '903b21d8-9584-46b8-b70f-a9a9ef3861b3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Team Managment', 3, NULL, '02:05:00', '03:32:00', 87, true, '2026-03-25 22:55:51.597', 65, '2026-03-26 03:55:51.598556', '2026-03-26 03:55:51.598556');
INSERT INTO public.task_entries VALUES ('b306dd7e-600e-41da-9b89-d66414275807', '903b21d8-9584-46b8-b70f-a9a9ef3861b3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '14:05:00', '16:00:00', 175, true, '2026-03-25 22:55:51.603', 66, '2026-03-26 03:55:51.604574', '2026-03-26 03:55:51.604574');
INSERT INTO public.task_entries VALUES ('e69420e5-ec0f-4a68-8037-1d3eafb89890', '903b21d8-9584-46b8-b70f-a9a9ef3861b3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation Discrete', 3, NULL, '16:00:00', '19:30:00', 210, true, '2026-03-25 22:55:51.607', 67, '2026-03-26 03:55:51.608106', '2026-03-26 03:55:51.608106');
INSERT INTO public.task_entries VALUES ('0970ff9f-fed0-4279-9800-8a00a2b6acf7', '903b21d8-9584-46b8-b70f-a9a9ef3861b3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Framer Project Despii', 3, NULL, '19:30:00', '20:30:00', 120, true, '2026-03-25 22:55:51.61', 68, '2026-03-26 03:55:51.611422', '2026-03-26 03:55:51.611422');
INSERT INTO public.task_entries VALUES ('c68510f8-79e8-4bf3-b36f-3329d6a32b9d', '903b21d8-9584-46b8-b70f-a9a9ef3861b3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Outing', 1, NULL, '22:30:00', '12:30:00', 840, true, '2026-03-25 22:55:51.614', 69, '2026-03-26 03:55:51.615026', '2026-03-26 03:55:51.615026');
INSERT INTO public.task_entries VALUES ('9cc1b13c-794c-4822-96a0-31be509b884f', '98f12b19-aa87-472d-90fa-46da85a01a71', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Study + Project', 3, NULL, '01:05:00', '05:32:00', 267, true, '2026-03-25 22:55:51.623', 70, '2026-03-26 03:55:51.623861', '2026-03-26 03:55:51.623861');
INSERT INTO public.task_entries VALUES ('c8fae589-15b1-4d4a-be57-d0fd80678d17', '98f12b19-aa87-472d-90fa-46da85a01a71', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '12:00:00', '13:30:00', 90, true, '2026-03-25 22:55:51.626', 71, '2026-03-26 03:55:51.62743', '2026-03-26 03:55:51.62743');
INSERT INTO public.task_entries VALUES ('c4201588-9c1e-4551-bd8d-6a34bdf467cb', '98f12b19-aa87-472d-90fa-46da85a01a71', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project bg assets', 3, NULL, '13:30:00', '20:00:00', 1350, true, '2026-03-25 22:55:51.63', 72, '2026-03-26 03:55:51.630656', '2026-03-26 03:55:51.630656');
INSERT INTO public.task_entries VALUES ('0133783e-b37b-4c0a-9653-ab52949fa042', '5df8a6d0-e347-43ac-a1e8-d9d21c1b39d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 3, NULL, '15:00:00', '18:00:00', 180, true, '2026-03-25 22:55:51.637', 73, '2026-03-26 03:55:51.637654', '2026-03-26 03:55:51.637654');
INSERT INTO public.task_entries VALUES ('ca099085-4ef9-42be-a534-334273b6c62e', '5df8a6d0-e347-43ac-a1e8-d9d21c1b39d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project bg assets', 3, NULL, '18:00:00', '19:00:00', 60, true, '2026-03-25 22:55:51.641', 74, '2026-03-26 03:55:51.64216', '2026-03-26 03:55:51.64216');
INSERT INTO public.task_entries VALUES ('b758d3dc-21af-409f-9ba9-48eb52f04d7c', '5df8a6d0-e347-43ac-a1e8-d9d21c1b39d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Outing', 1, NULL, '19:00:00', '12:00:00', 1020, true, '2026-03-25 22:55:51.644', 75, '2026-03-26 03:55:51.645493', '2026-03-26 03:55:51.645493');
INSERT INTO public.task_entries VALUES ('df7628f3-cb0a-4e99-b1a9-52145ed35038', '615fb8ae-cd50-4cfa-b3c4-e87f6f4c6547', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project bg assets', 3, NULL, '00:00:00', '02:30:00', 150, true, '2026-03-25 22:55:51.653', 76, '2026-03-26 03:55:51.654314', '2026-03-26 03:55:51.654314');
INSERT INTO public.task_entries VALUES ('6067a2e5-0ef5-4f2b-8c59-f9c32984226b', '615fb8ae-cd50-4cfa-b3c4-e87f6f4c6547', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 3, NULL, '02:30:00', '03:15:00', 45, true, '2026-03-25 22:55:51.657', 77, '2026-03-26 03:55:51.657934', '2026-03-26 03:55:51.657934');
INSERT INTO public.task_entries VALUES ('5d57e64a-105a-47f7-9173-188af7f80f9e', '615fb8ae-cd50-4cfa-b3c4-e87f6f4c6547', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project bg assets', 3, NULL, '02:30:00', '05:00:00', 150, true, '2026-03-25 22:55:51.66', 78, '2026-03-26 03:55:51.661325', '2026-03-26 03:55:51.661325');
INSERT INTO public.task_entries VALUES ('6783fbbe-427a-4548-8a1c-b0ff00447b44', '615fb8ae-cd50-4cfa-b3c4-e87f6f4c6547', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project Metaops', 3, NULL, '03:30:00', '16:00:00', 750, true, '2026-03-25 22:55:51.664', 79, '2026-03-26 03:55:51.664775', '2026-03-26 03:55:51.664775');
INSERT INTO public.task_entries VALUES ('a5bfd5a7-1b82-4aca-9865-af7682c0c52a', '615fb8ae-cd50-4cfa-b3c4-e87f6f4c6547', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project bg assets', 3, NULL, '16:00:00', '20:00:00', 240, true, '2026-03-25 22:55:51.667', 80, '2026-03-26 03:55:51.668332', '2026-03-26 03:55:51.668332');
INSERT INTO public.task_entries VALUES ('fe575680-b786-4b00-8269-9535ec51cc2e', '615fb8ae-cd50-4cfa-b3c4-e87f6f4c6547', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying & Meeting', 3, NULL, '21:30:00', '22:10:00', 40, true, '2026-03-25 22:55:51.671', 81, '2026-03-26 03:55:51.671758', '2026-03-26 03:55:51.671758');
INSERT INTO public.task_entries VALUES ('0ad3bb18-2d59-41cc-9b43-8437daef5fba', '615fb8ae-cd50-4cfa-b3c4-e87f6f4c6547', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Exam Preparation Discrete', 3, NULL, '22:10:00', '01:00:00', 170, true, '2026-03-25 22:55:51.674', 82, '2026-03-26 03:55:51.675361', '2026-03-26 03:55:51.675361');
INSERT INTO public.task_entries VALUES ('d76666e3-4255-423e-9517-d181c5825410', 'bdef978b-eed6-4e1c-ac19-0643d97d719d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project bg assets', 3, NULL, '01:00:00', '03:00:00', 120, true, '2026-03-25 22:55:51.68', 83, '2026-03-26 03:55:51.681337', '2026-03-26 03:55:51.681337');
INSERT INTO public.task_entries VALUES ('dd6d710e-af24-4c57-b2b6-6aeaee1ef457', 'bdef978b-eed6-4e1c-ac19-0643d97d719d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation Discrete', 3, NULL, '03:00:00', '07:00:00', 240, true, '2026-03-25 22:55:51.684', 84, '2026-03-26 03:55:51.684946', '2026-03-26 03:55:51.684946');
INSERT INTO public.task_entries VALUES ('4287acac-9194-4ef1-9b29-b92a352ff92d', 'bdef978b-eed6-4e1c-ac19-0643d97d719d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Launch & Outing', 2, NULL, '20:30:00', '22:20:00', 110, true, '2026-03-25 22:55:51.687', 85, '2026-03-26 03:55:51.688509', '2026-03-26 03:55:51.688509');
INSERT INTO public.task_entries VALUES ('f97ecead-971f-4e6a-a352-b771a6790d1e', 'bdef978b-eed6-4e1c-ac19-0643d97d719d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '22:30:00', '00:20:00', 110, true, '2026-03-25 22:55:51.693', 86, '2026-03-26 03:55:51.693724', '2026-03-26 03:55:51.693724');
INSERT INTO public.task_entries VALUES ('82f8145b-d81b-4c40-9d8a-c5a77436da31', '5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Team Management', 3, NULL, '00:20:00', '02:40:00', 140, true, '2026-03-25 22:55:51.699', 87, '2026-03-26 03:55:51.699852', '2026-03-26 03:55:51.699852');
INSERT INTO public.task_entries VALUES ('f18f783d-8246-4431-aec8-6b81e554ce5b', '5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '04:15:00', '04:30:00', 15, true, '2026-03-25 22:55:51.702', 88, '2026-03-26 03:55:51.703306', '2026-03-26 03:55:51.703306');
INSERT INTO public.task_entries VALUES ('4c80f931-e797-4e56-b615-be6119b65846', '5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Exercise', 3, NULL, '02:40:00', '04:15:00', 95, true, '2026-03-25 22:55:51.706', 89, '2026-03-26 03:55:51.706706', '2026-03-26 03:55:51.706706');
INSERT INTO public.task_entries VALUES ('94ae1f9b-ea8a-4983-8c1a-ceae47124df4', '5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Book Reading', 2, NULL, '05:05:00', '07:00:00', 235, true, '2026-03-25 22:55:51.709', 90, '2026-03-26 03:55:51.710244', '2026-03-26 03:55:51.710244');
INSERT INTO public.task_entries VALUES ('e6a4b20b-dd6b-4ab1-b81a-162664d8882e', '5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '04:15:00', '04:30:00', 15, true, '2026-03-25 22:55:51.713', 91, '2026-03-26 03:55:51.713656', '2026-03-26 03:55:51.713656');
INSERT INTO public.task_entries VALUES ('ccde562e-c8e7-4215-8605-0ee34e337332', '5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Team Management', 2, NULL, '04:30:00', '05:00:00', 30, true, '2026-03-25 22:55:51.716', 92, '2026-03-26 03:55:51.717284', '2026-03-26 03:55:51.717284');
INSERT INTO public.task_entries VALUES ('df446118-8a44-4ec1-8976-445617fe8538', '5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 1, NULL, '15:30:00', '19:00:00', 210, true, '2026-03-25 22:55:51.72', 93, '2026-03-26 03:55:51.720786', '2026-03-26 03:55:51.720786');
INSERT INTO public.task_entries VALUES ('5f6ccaf3-a20d-42a2-aa5c-d904005f9937', '5f2925bd-747a-413c-9b4e-e0a977ae6eda', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Hair Cut', 1, NULL, '19:00:00', '09:00:00', 840, true, '2026-03-25 22:55:51.723', 94, '2026-03-26 03:55:51.724293', '2026-03-26 03:55:51.724293');
INSERT INTO public.task_entries VALUES ('2e42dbda-fb14-40ae-ade2-3ca48c80ea0e', '988c45ad-ab4a-4271-9b1c-c565d78dc7d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '03:00:00', '04:00:00', 180, true, '2026-03-25 22:55:51.73', 95, '2026-03-26 03:55:51.731167', '2026-03-26 03:55:51.731167');
INSERT INTO public.task_entries VALUES ('f2a4fa8a-a9b8-49d6-8866-ffd9861e80ee', '988c45ad-ab4a-4271-9b1c-c565d78dc7d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project bg assets', 3, NULL, '04:00:00', '05:00:00', 60, true, '2026-03-25 22:55:51.735', 96, '2026-03-26 03:55:51.736537', '2026-03-26 03:55:51.736537');
INSERT INTO public.task_entries VALUES ('d2302390-442b-4747-9e35-6cf04ada3a41', '988c45ad-ab4a-4271-9b1c-c565d78dc7d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Discrete Exam', 3, NULL, '13:00:00', '16:30:00', 210, true, '2026-03-25 22:55:51.739', 97, '2026-03-26 03:55:51.739886', '2026-03-26 03:55:51.739886');
INSERT INTO public.task_entries VALUES ('de310d46-26ed-471a-845c-d71354dfc40b', '988c45ad-ab4a-4271-9b1c-c565d78dc7d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Commercial Shopping', 1, NULL, '19:00:00', '23:30:00', 270, true, '2026-03-25 22:55:51.742', 98, '2026-03-26 03:55:51.743487', '2026-03-26 03:55:51.743487');
INSERT INTO public.task_entries VALUES ('9dc379dd-3577-446e-9912-ec0db5d8eed3', '738233a8-81fa-414d-838d-6b924aad0fd5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '00:00:00', '02:30:00', 150, true, '2026-03-25 22:55:51.749', 99, '2026-03-26 03:55:51.749632', '2026-03-26 03:55:51.749632');
INSERT INTO public.task_entries VALUES ('3deca944-f303-4944-8a37-def1b92c68de', '738233a8-81fa-414d-838d-6b924aad0fd5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation Sociology', 3, NULL, '02:30:00', '08:00:00', 390, true, '2026-03-25 22:55:51.755', 100, '2026-03-26 03:55:51.755681', '2026-03-26 03:55:51.755681');
INSERT INTO public.task_entries VALUES ('245d6c5e-0fe0-4257-924a-90313f15f399', '738233a8-81fa-414d-838d-6b924aad0fd5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Sociology Exam', 3, NULL, '13:00:00', '18:00:00', 300, true, '2026-03-25 22:55:51.758', 101, '2026-03-26 03:55:51.759202', '2026-03-26 03:55:51.759202');
INSERT INTO public.task_entries VALUES ('0101f369-85dd-46b5-9655-c8993ce9d174', 'c3bb2718-00cb-4b0f-83e6-94cfed642383', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics', 2, NULL, '11:00:00', '01:00:00', 960, true, '2026-03-25 22:55:51.764', 102, '2026-03-26 03:55:51.765418', '2026-03-26 03:55:51.765418');
INSERT INTO public.task_entries VALUES ('2c64a9a5-81d8-40da-8ce0-d2783e63ff5c', 'c3bb2718-00cb-4b0f-83e6-94cfed642383', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '01:00:00', '04:00:00', 240, true, '2026-03-25 22:55:51.768', 103, '2026-03-26 03:55:51.768835', '2026-03-26 03:55:51.768835');
INSERT INTO public.task_entries VALUES ('c9d98d61-757c-46dc-bac7-3285b3d98adc', 'c3bb2718-00cb-4b0f-83e6-94cfed642383', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation World History', 3, NULL, '04:00:00', '06:00:00', 120, true, '2026-03-25 22:55:51.771', 104, '2026-03-26 03:55:51.772342', '2026-03-26 03:55:51.772342');
INSERT INTO public.task_entries VALUES ('855d7dc8-6788-48ce-a921-139d48999857', 'c3bb2718-00cb-4b0f-83e6-94cfed642383', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Trading Hunter Framer Project', 3, NULL, '07:10:00', '10:10:00', 180, true, '2026-03-25 22:55:51.776', 105, '2026-03-26 03:55:51.776783', '2026-03-26 03:55:51.776783');
INSERT INTO public.task_entries VALUES ('21f9d0f4-ea65-4877-a7e5-eca315252114', 'c3bb2718-00cb-4b0f-83e6-94cfed642383', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Markez', 2, NULL, '21:30:00', '23:00:00', 90, true, '2026-03-25 22:55:51.781', 106, '2026-03-26 03:55:51.781935', '2026-03-26 03:55:51.781935');
INSERT INTO public.task_entries VALUES ('d04c25ff-b355-4148-b932-ead543df001e', '6382f463-a5a8-4770-99ce-becbe4ea8aa9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics', 2, NULL, '23:00:00', '01:00:00', 120, true, '2026-03-25 22:55:51.788', 107, '2026-03-26 03:55:51.788806', '2026-03-26 03:55:51.788806');
INSERT INTO public.task_entries VALUES ('b17c9fdc-3542-42dc-bc06-afb9aedadd9f', '6382f463-a5a8-4770-99ce-becbe4ea8aa9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excecise', 2, NULL, '01:00:00', '02:30:00', 90, true, '2026-03-25 22:55:51.792', 108, '2026-03-26 03:55:51.793304', '2026-03-26 03:55:51.793304');
INSERT INTO public.task_entries VALUES ('6405021e-2eaa-42d2-8b7c-f1272dde36cc', '6382f463-a5a8-4770-99ce-becbe4ea8aa9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation World History', 3, NULL, '02:50:00', '07:30:00', 280, true, '2026-03-25 22:55:51.796', 109, '2026-03-26 03:55:51.796682', '2026-03-26 03:55:51.796682');
INSERT INTO public.task_entries VALUES ('3e07a3aa-6590-48b5-ad59-fd582a517fe1', '6382f463-a5a8-4770-99ce-becbe4ea8aa9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Upwork Jobs Applying', 2, NULL, '16:30:00', '18:10:00', 100, true, '2026-03-25 22:55:51.799', 110, '2026-03-26 03:55:51.800288', '2026-03-26 03:55:51.800288');
INSERT INTO public.task_entries VALUES ('765c78c7-1464-46d3-a0c0-8d9201b87991', '6382f463-a5a8-4770-99ce-becbe4ea8aa9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Project bg assets', 3, NULL, '18:10:00', '19:10:00', 60, true, '2026-03-25 22:55:51.803', 111, '2026-03-26 03:55:51.803843', '2026-03-26 03:55:51.803843');
INSERT INTO public.task_entries VALUES ('93e78a26-aec1-4bf6-b8c6-7a1594c57176', '6382f463-a5a8-4770-99ce-becbe4ea8aa9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Exam Preparation World History', 3, NULL, '19:10:00', '20:00:00', 930, true, '2026-03-25 22:55:51.806', 112, '2026-03-26 03:55:51.807461', '2026-03-26 03:55:51.807461');
INSERT INTO public.task_entries VALUES ('f3749920-c727-4283-9270-033191f27a1d', 'b981dd5b-97f9-4cc5-99e4-ddfe1eabb88d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics', 2, NULL, '00:00:00', '01:00:00', 60, true, '2026-03-25 22:55:51.813', 113, '2026-03-26 03:55:51.814369', '2026-03-26 03:55:51.814369');
INSERT INTO public.task_entries VALUES ('08b7095d-c980-4f9d-bbc3-2c640ac63823', 'b981dd5b-97f9-4cc5-99e4-ddfe1eabb88d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation World History', 3, NULL, '01:10:00', '01:40:00', 150, true, '2026-03-25 22:55:51.817', 114, '2026-03-26 03:55:51.817934', '2026-03-26 03:55:51.817934');
INSERT INTO public.task_entries VALUES ('0b11f5c4-fca7-4463-b43e-2999822adeb4', 'b981dd5b-97f9-4cc5-99e4-ddfe1eabb88d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Chai & Walking Break', 2, NULL, '01:40:00', '03:00:00', 80, true, '2026-03-25 22:55:51.82', 115, '2026-03-26 03:55:51.821294', '2026-03-26 03:55:51.821294');
INSERT INTO public.task_entries VALUES ('133ce2d5-8611-45fe-9610-6fd1fd1e0c58', 'b981dd5b-97f9-4cc5-99e4-ddfe1eabb88d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '03:00:00', '04:00:00', 120, true, '2026-03-25 22:55:51.826', 116, '2026-03-26 03:55:51.827526', '2026-03-26 03:55:51.827526');
INSERT INTO public.task_entries VALUES ('16f3e7ce-99b8-492c-8792-a4585029690d', 'b981dd5b-97f9-4cc5-99e4-ddfe1eabb88d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Mics', 2, NULL, '00:00:00', '09:00:00', 540, true, '2026-03-25 22:55:51.83', 117, '2026-03-26 03:55:51.830797', '2026-03-26 03:55:51.830797');
INSERT INTO public.task_entries VALUES ('4660f305-5e4c-4620-83eb-82132365a35e', 'b981dd5b-97f9-4cc5-99e4-ddfe1eabb88d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'PDF Money Project', 3, NULL, '23:00:00', '00:30:00', 90, true, '2026-03-25 22:55:51.833', 118, '2026-03-26 03:55:51.83438', '2026-03-26 03:55:51.83438');
INSERT INTO public.task_entries VALUES ('fc90c804-9fef-4032-aebe-0e871a3906ad', '5862e4b4-ee88-465f-b599-4c4658d6eda3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics', 2, NULL, '00:00:00', '01:00:00', 60, true, '2026-03-25 22:55:51.84', 119, '2026-03-26 03:55:51.841521', '2026-03-26 03:55:51.841521');
INSERT INTO public.task_entries VALUES ('45d605d0-113f-451b-b114-da85dc0f59cb', '5862e4b4-ee88-465f-b599-4c4658d6eda3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation World History', 3, NULL, '01:10:00', '02:40:00', 200, true, '2026-03-25 22:55:51.844', 120, '2026-03-26 03:55:51.844844', '2026-03-26 03:55:51.844844');
INSERT INTO public.task_entries VALUES ('bfc8c346-e20e-4b69-b522-7d39e4a00e82', '5862e4b4-ee88-465f-b599-4c4658d6eda3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 2, NULL, '02:40:00', '03:30:00', 50, true, '2026-03-25 22:55:51.847', 121, '2026-03-26 03:55:51.848452', '2026-03-26 03:55:51.848452');
INSERT INTO public.task_entries VALUES ('d0dce8e6-15d1-4a41-84ff-107cee7228bb', '5862e4b4-ee88-465f-b599-4c4658d6eda3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Youtube', 1, NULL, '03:30:00', '04:00:00', 30, true, '2026-03-25 22:55:51.851', 122, '2026-03-26 03:55:51.852024', '2026-03-26 03:55:51.852024');
INSERT INTO public.task_entries VALUES ('27e034b0-223d-465d-8144-d834cd338eb1', '5862e4b4-ee88-465f-b599-4c4658d6eda3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '04:00:00', '04:30:00', 30, true, '2026-03-25 22:55:51.854', 123, '2026-03-26 03:55:51.855446', '2026-03-26 03:55:51.855446');
INSERT INTO public.task_entries VALUES ('294f8a2b-3b12-409e-b5c4-e360603b0611', '5862e4b4-ee88-465f-b599-4c4658d6eda3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam World History', 3, NULL, '10:00:00', '15:00:00', 300, true, '2026-03-25 22:55:52.082', 124, '2026-03-26 03:55:52.082716', '2026-03-26 03:55:52.082716');
INSERT INTO public.task_entries VALUES ('d47fed20-d132-4e44-a400-186966d0d258', 'ad0ef18a-4277-4941-990f-454fa78ae381', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Jobs Applying', 2, NULL, '02:40:00', '04:00:00', 80, true, '2026-03-25 22:55:52.121', 125, '2026-03-26 03:55:52.121985', '2026-03-26 03:55:52.121985');
INSERT INTO public.task_entries VALUES ('f108bf24-fd1c-4d81-a5e3-871226d5aab1', 'ad0ef18a-4277-4941-990f-454fa78ae381', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation Calculas', 3, NULL, '16:00:00', '21:00:00', 300, true, '2026-03-25 22:55:52.127', 126, '2026-03-26 03:55:52.128017', '2026-03-26 03:55:52.128017');
INSERT INTO public.task_entries VALUES ('483791c5-2358-4e21-a81c-c345084e8468', 'bac53cc5-56a0-4c98-adf2-6f8ce5ff6a38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation Calculas', 3, NULL, '23:00:00', '04:30:00', 540, true, '2026-03-25 22:55:52.137', 127, '2026-03-26 03:55:52.138296', '2026-03-26 03:55:52.138296');
INSERT INTO public.task_entries VALUES ('eac627d8-1a4d-4af8-8c85-be206b08cd58', 'bac53cc5-56a0-4c98-adf2-6f8ce5ff6a38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Calculas', 3, NULL, '13:00:00', '18:00:00', 300, true, '2026-03-25 22:55:52.142', 128, '2026-03-26 03:55:52.142907', '2026-03-26 03:55:52.142907');
INSERT INTO public.task_entries VALUES ('8076ac12-692f-488f-ac7a-cfc527f920fa', 'ab4a7c54-f512-48e8-96d3-111be9a2c1de', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics', 2, NULL, '19:00:00', '03:00:00', 480, true, '2026-03-25 22:55:52.151', 129, '2026-03-26 03:55:52.152465', '2026-03-26 03:55:52.152465');
INSERT INTO public.task_entries VALUES ('91ce4798-4a55-403b-b5a2-8f481d283d45', 'ab4a7c54-f512-48e8-96d3-111be9a2c1de', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Exam Preparation Communication', 1, NULL, '03:00:00', '07:30:00', 270, true, '2026-03-25 22:55:52.156', 130, '2026-03-26 03:55:52.156729', '2026-03-26 03:55:52.156729');
INSERT INTO public.task_entries VALUES ('2abb7950-f4ff-4c61-92b4-4845627418f4', 'ab4a7c54-f512-48e8-96d3-111be9a2c1de', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '20:00:00', '15:00:00', 1140, true, '2026-03-25 22:55:52.16', 131, '2026-03-26 03:55:52.161146', '2026-03-26 03:55:52.161146');
INSERT INTO public.task_entries VALUES ('0e396037-9e4b-41c8-b400-a4d5a911c6d7', '4ac4b935-4575-439b-b712-5c119d062df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation OS', 3, NULL, '02:00:00', '07:30:00', 330, true, '2026-03-25 22:55:52.169', 132, '2026-03-26 03:55:52.169875', '2026-03-26 03:55:52.169875');
INSERT INTO public.task_entries VALUES ('2b740812-2f0e-4fd1-91ad-8cd502a36deb', '4ac4b935-4575-439b-b712-5c119d062df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam OS', 3, NULL, '10:00:00', '13:00:00', 180, true, '2026-03-25 22:55:52.173', 133, '2026-03-26 03:55:52.174418', '2026-03-26 03:55:52.174418');
INSERT INTO public.task_entries VALUES ('9fff8166-e8ba-4152-bcb8-f49cbe713c4a', '4ac4b935-4575-439b-b712-5c119d062df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Gaming Zone', 1, NULL, '10:00:00', '13:00:00', 180, true, '2026-03-25 22:55:52.177', 134, '2026-03-26 03:55:52.177679', '2026-03-26 03:55:52.177679');
INSERT INTO public.task_entries VALUES ('a192add2-5989-4237-b7e4-ae1ff790d6e9', '0e5ef3d0-c87c-4a07-a125-07fbe0a4d34f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Markez', 1, NULL, '01:00:00', '02:00:00', 60, true, '2026-03-25 22:55:52.185', 135, '2026-03-26 03:55:52.186545', '2026-03-26 03:55:52.186545');
INSERT INTO public.task_entries VALUES ('9df01e24-a825-4e1c-80a0-268859eb8dd0', '0e5ef3d0-c87c-4a07-a125-07fbe0a4d34f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, '2-Month Semester Forethought', 3, NULL, '03:00:00', '05:40:00', 160, true, '2026-03-25 22:55:52.189', 136, '2026-03-26 03:55:52.190064', '2026-03-26 03:55:52.190064');
INSERT INTO public.task_entries VALUES ('00c591f8-7b3d-41a5-9c48-5f6cae48fca7', '0e5ef3d0-c87c-4a07-a125-07fbe0a4d34f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '05:40:00', '08:00:00', 140, true, '2026-03-25 22:55:52.193', 137, '2026-03-26 03:55:52.193616', '2026-03-26 03:55:52.193616');
INSERT INTO public.task_entries VALUES ('360468c7-f197-4fff-a431-15d65edc071e', '0e5ef3d0-c87c-4a07-a125-07fbe0a4d34f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Team Management', 3, NULL, '08:00:00', '08:20:00', 20, true, '2026-03-25 22:55:52.196', 138, '2026-03-26 03:55:52.197263', '2026-03-26 03:55:52.197263');
INSERT INTO public.task_entries VALUES ('165a67fd-890a-424f-9a94-e342ffbcc941', '0e5ef3d0-c87c-4a07-a125-07fbe0a4d34f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Python Tutorial', 3, NULL, '08:20:00', '10:10:00', 110, true, '2026-03-25 22:55:52.2', 139, '2026-03-26 03:55:52.200707', '2026-03-26 03:55:52.200707');
INSERT INTO public.task_entries VALUES ('d5aff4c5-9d7c-4f1d-a460-7e6cbeb4a49d', '103019ec-fb52-4afb-b863-706ac116ddba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Dinner', 2, NULL, '01:00:00', '02:30:00', 90, true, '2026-03-25 22:55:52.207', 140, '2026-03-26 03:55:52.207665', '2026-03-26 03:55:52.207665');
INSERT INTO public.task_entries VALUES ('99efb2f7-a8bc-4bb6-9a19-2df5084e1c57', '103019ec-fb52-4afb-b863-706ac116ddba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '02:30:00', '06:30:00', 240, true, '2026-03-25 22:55:52.21', 141, '2026-03-26 03:55:52.211069', '2026-03-26 03:55:52.211069');
INSERT INTO public.task_entries VALUES ('e3ddeba4-e057-4679-8f45-0f769fdaa439', '103019ec-fb52-4afb-b863-706ac116ddba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Expense Calculation', 3, NULL, '06:30:00', '08:30:00', 120, true, '2026-03-25 22:55:52.213', 142, '2026-03-26 03:55:52.214477', '2026-03-26 03:55:52.214477');
INSERT INTO public.task_entries VALUES ('af045c02-36e6-483c-89eb-2981f8828e1f', '103019ec-fb52-4afb-b863-706ac116ddba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Proposal About Update', 3, NULL, '06:30:00', '08:30:00', 120, true, '2026-03-25 22:55:52.217', 143, '2026-03-26 03:55:52.218163', '2026-03-26 03:55:52.218163');
INSERT INTO public.task_entries VALUES ('08d78762-6bdc-47b0-b3e5-fa2951635a01', '103019ec-fb52-4afb-b863-706ac116ddba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics', 2, NULL, '08:30:00', '10:30:00', 120, true, '2026-03-25 22:55:52.22', 144, '2026-03-26 03:55:52.221365', '2026-03-26 03:55:52.221365');
INSERT INTO public.task_entries VALUES ('522c717b-e5f4-4335-afc6-8728fd612f61', 'e3504911-6f90-40bd-b6a7-b0228b528187', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '04:30:00', '05:40:00', 70, true, '2026-03-25 22:55:52.229', 145, '2026-03-26 03:55:52.230552', '2026-03-26 03:55:52.230552');
INSERT INTO public.task_entries VALUES ('cb11d395-6a47-458b-978f-0fa05dcaa48b', 'e3504911-6f90-40bd-b6a7-b0228b528187', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Preparation Communication', 3, NULL, '05:40:00', '08:30:00', 170, true, '2026-03-25 22:55:52.233', 146, '2026-03-26 03:55:52.233665', '2026-03-26 03:55:52.233665');
INSERT INTO public.task_entries VALUES ('4192a551-dcaa-4d56-a644-94e2517499c1', 'e3504911-6f90-40bd-b6a7-b0228b528187', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Communication', 3, NULL, '08:30:00', '09:40:00', 70, true, '2026-03-25 22:55:52.236', 147, '2026-03-26 03:55:52.23739', '2026-03-26 03:55:52.23739');
INSERT INTO public.task_entries VALUES ('dc5a3103-9e8b-46f6-8964-0c1df7e834da', 'e3504911-6f90-40bd-b6a7-b0228b528187', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Uni', 2, NULL, '09:40:00', '14:00:00', 260, true, '2026-03-25 22:55:52.24', 148, '2026-03-26 03:55:52.241487', '2026-03-26 03:55:52.241487');
INSERT INTO public.task_entries VALUES ('b340b54e-faed-4f5d-ad6c-f97a2daa21c0', '7c958adf-89d4-493e-b7f4-ff36ad93b4e0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Mics', 2, NULL, '04:30:00', '07:30:00', 180, true, '2026-03-25 22:55:52.248', 149, '2026-03-26 03:55:52.248827', '2026-03-26 03:55:52.248827');
INSERT INTO public.task_entries VALUES ('2e1872ed-3d3a-435b-83cb-2abc47c5bdf2', '7c958adf-89d4-493e-b7f4-ff36ad93b4e0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '07:30:00', '10:10:00', 160, true, '2026-03-25 22:55:52.251', 150, '2026-03-26 03:55:52.252099', '2026-03-26 03:55:52.252099');
INSERT INTO public.task_entries VALUES ('8446cd3e-104c-4e36-99f3-c5faaa5993cc', '7c958adf-89d4-493e-b7f4-ff36ad93b4e0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Mics', 2, NULL, '10:30:00', '11:30:00', 60, true, '2026-03-25 22:55:52.255', 151, '2026-03-26 03:55:52.256358', '2026-03-26 03:55:52.256358');
INSERT INTO public.task_entries VALUES ('97156d18-4c7f-457b-a179-6ee86822aaa0', '7c958adf-89d4-493e-b7f4-ff36ad93b4e0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Python Tutorial', 3, NULL, '11:50:00', '13:15:00', 85, true, '2026-03-25 22:55:52.259', 152, '2026-03-26 03:55:52.259988', '2026-03-26 03:55:52.259988');
INSERT INTO public.task_entries VALUES ('1eef9b83-6138-440b-9ad5-005b3fa714c0', '7c958adf-89d4-493e-b7f4-ff36ad93b4e0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Bazaar', 2, NULL, '14:15:00', '16:30:00', 135, true, '2026-03-25 22:55:52.262', 153, '2026-03-26 03:55:52.263224', '2026-03-26 03:55:52.263224');
INSERT INTO public.task_entries VALUES ('4816d1c4-321a-4d1c-88ae-a807d303b37e', 'f330cd71-c460-4821-96a9-39af0efee85a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '07:30:00', '10:40:00', 190, true, '2026-03-25 22:55:52.496', 154, '2026-03-26 03:55:52.496781', '2026-03-26 03:55:52.496781');
INSERT INTO public.task_entries VALUES ('0d8734f9-5fb4-4009-b9c4-cb77c17d8c6f', 'f330cd71-c460-4821-96a9-39af0efee85a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Mics', 2, NULL, '10:40:00', '01:10:00', 870, true, '2026-03-25 22:55:52.5', 155, '2026-03-26 03:55:52.501062', '2026-03-26 03:55:52.501062');
INSERT INTO public.task_entries VALUES ('51358ac6-d45f-4b59-bed1-c1be99b39163', 'f330cd71-c460-4821-96a9-39af0efee85a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Python Tutorial', 3, NULL, '14:10:00', '20:00:00', 350, true, '2026-03-25 22:55:52.503', 156, '2026-03-26 03:55:52.504438', '2026-03-26 03:55:52.504438');
INSERT INTO public.task_entries VALUES ('10e15fe1-877b-44d9-9ab5-3be993d0a7e8', 'f3b097cb-3a3b-4402-9542-453d66940e16', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ca8ebbe-d5a4-46bf-8334-8acf8e2de85a', NULL, 'Mics', 2, NULL, '04:00:00', '07:40:00', 220, true, '2026-03-25 22:55:52.518', 157, '2026-03-26 03:55:52.518648', '2026-03-26 03:55:52.518648');
INSERT INTO public.task_entries VALUES ('2fffba99-5906-4563-ba9a-d1b570c81c9f', 'f3b097cb-3a3b-4402-9542-453d66940e16', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Markez', 2, NULL, '11:00:00', '14:40:00', 220, true, '2026-03-25 22:55:52.523', 158, '2026-03-26 03:55:52.523855', '2026-03-26 03:55:52.523855');
INSERT INTO public.task_entries VALUES ('6ef3b580-f5f0-40d9-81f6-038e839a6925', 'd425c5a3-54b6-402b-a90e-562cc647c6f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ca8ebbe-d5a4-46bf-8334-8acf8e2de85a', NULL, 'Mics', 2, NULL, '04:00:00', '07:00:00', 180, true, '2026-03-25 22:55:52.531', 159, '2026-03-26 03:55:52.531605', '2026-03-26 03:55:52.531605');
INSERT INTO public.task_entries VALUES ('57f4a773-571d-4b3f-aa8c-ccd9f92cbfd5', 'd425c5a3-54b6-402b-a90e-562cc647c6f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni', 2, NULL, '11:00:00', '14:00:00', 180, true, '2026-03-25 22:55:52.534', 160, '2026-03-26 03:55:52.53511', '2026-03-26 03:55:52.53511');
INSERT INTO public.task_entries VALUES ('786c13f2-c935-4e65-97e3-dd638dfb3c83', 'd425c5a3-54b6-402b-a90e-562cc647c6f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '14:00:00', '16:30:00', 150, true, '2026-03-25 22:55:52.537', 161, '2026-03-26 03:55:52.538551', '2026-03-26 03:55:52.538551');
INSERT INTO public.task_entries VALUES ('f10318d3-72a0-446e-a9a3-87a88218a559', 'd425c5a3-54b6-402b-a90e-562cc647c6f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ca8ebbe-d5a4-46bf-8334-8acf8e2de85a', NULL, 'Mics', 2, NULL, '13:00:00', '15:30:00', 150, true, '2026-03-25 22:55:52.541', 162, '2026-03-26 03:55:52.542149', '2026-03-26 03:55:52.542149');
INSERT INTO public.task_entries VALUES ('78a8443a-6928-455b-992e-f19f0b62b880', 'd425c5a3-54b6-402b-a90e-562cc647c6f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ca8ebbe-d5a4-46bf-8334-8acf8e2de85a', NULL, 'Bg-assets', 3, NULL, '15:30:00', '16:00:00', 30, true, '2026-03-25 22:55:52.545', 163, '2026-03-26 03:55:52.545522', '2026-03-26 03:55:52.545522');
INSERT INTO public.task_entries VALUES ('ef392b69-8b51-450a-b92a-a3ebfa193f61', '77409295-cae5-44c9-8238-59495feb0985', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ca8ebbe-d5a4-46bf-8334-8acf8e2de85a', NULL, 'Breakfast', 2, NULL, '08:00:00', '09:00:00', 60, true, '2026-03-25 22:55:52.553', 164, '2026-03-26 03:55:52.55431', '2026-03-26 03:55:52.55431');
INSERT INTO public.task_entries VALUES ('84e1a1b4-6c2e-4f54-8ece-7c24f76c3323', '77409295-cae5-44c9-8238-59495feb0985', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '09:00:00', '10:00:00', 240, true, '2026-03-25 22:55:52.557', 165, '2026-03-26 03:55:52.557791', '2026-03-26 03:55:52.557791');
INSERT INTO public.task_entries VALUES ('d581e016-2be6-4eec-9f2c-e256cbe27ac1', '77409295-cae5-44c9-8238-59495feb0985', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ca8ebbe-d5a4-46bf-8334-8acf8e2de85a', NULL, 'Mics', 2, NULL, '11:00:00', '12:00:00', 60, true, '2026-03-25 22:55:52.56', 166, '2026-03-26 03:55:52.561372', '2026-03-26 03:55:52.561372');
INSERT INTO public.task_entries VALUES ('9ff75582-d764-48d4-a74e-c377755c47e2', '77409295-cae5-44c9-8238-59495feb0985', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ca8ebbe-d5a4-46bf-8334-8acf8e2de85a', NULL, 'Bg-assets', 2, NULL, '12:30:00', '14:00:00', 90, true, '2026-03-25 22:55:52.564', 167, '2026-03-26 03:55:52.56493', '2026-03-26 03:55:52.56493');
INSERT INTO public.task_entries VALUES ('63eed5a2-5ade-4495-b2f3-bd94da34d490', '77409295-cae5-44c9-8238-59495feb0985', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Update Portfolio Website', 3, NULL, '17:30:00', '00:00:00', 390, true, '2026-03-25 22:55:52.567', 168, '2026-03-26 03:55:52.568283', '2026-03-26 03:55:52.568283');
INSERT INTO public.task_entries VALUES ('147e1cd8-3bf6-4d26-86e2-f1a7d497c0fb', '70e0e7c2-3881-45a9-96fa-31b6c7324d6b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Traveling', 3, NULL, '19:00:00', '08:00:00', 780, true, '2026-03-25 22:55:52.574', 169, '2026-03-26 03:55:52.574604', '2026-03-26 03:55:52.574604');
INSERT INTO public.task_entries VALUES ('c2d82bc9-83c8-4d4e-85d1-104e971e3e6f', '70e0e7c2-3881-45a9-96fa-31b6c7324d6b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:00:00', '17:00:00', 180, true, '2026-03-25 22:55:52.577', 170, '2026-03-26 03:55:52.577831', '2026-03-26 03:55:52.577831');
INSERT INTO public.task_entries VALUES ('17712e45-a9b6-4605-a048-de721712951d', '70e0e7c2-3881-45a9-96fa-31b6c7324d6b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Ulasyr', 3, NULL, '17:00:00', '20:00:00', 180, true, '2026-03-25 22:55:52.58', 171, '2026-03-26 03:55:52.581517', '2026-03-26 03:55:52.581517');
INSERT INTO public.task_entries VALUES ('54313103-64ed-405f-9165-8d052ececf97', '70e0e7c2-3881-45a9-96fa-31b6c7324d6b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '23:00:00', 180, true, '2026-03-25 22:55:52.586', 172, '2026-03-26 03:55:52.586625', '2026-03-26 03:55:52.586625');
INSERT INTO public.task_entries VALUES ('4d21172a-0871-499c-b5cc-23dfb3a9b33e', '67c4365e-8e45-4e3c-b7aa-83d6eedf01e8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '04:30:00', '07:10:00', 580, true, '2026-03-25 22:55:52.595', 173, '2026-03-26 03:55:52.596205', '2026-03-26 03:55:52.596205');
INSERT INTO public.task_entries VALUES ('44fbbfff-5be8-43d3-8fbd-97d7ea626c45', '67c4365e-8e45-4e3c-b7aa-83d6eedf01e8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 2, NULL, '08:10:00', '23:30:00', 920, true, '2026-03-25 22:55:52.599', 174, '2026-03-26 03:55:52.59972', '2026-03-26 03:55:52.59972');
INSERT INTO public.task_entries VALUES ('c97c4f36-94ab-447e-8c70-807c2af93a7e', '67c4365e-8e45-4e3c-b7aa-83d6eedf01e8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Python Tutorial', 3, NULL, '23:30:00', '12:00:00', 750, true, '2026-03-25 22:55:52.603', 175, '2026-03-26 03:55:52.604401', '2026-03-26 03:55:52.604401');
INSERT INTO public.task_entries VALUES ('b7bb9d77-12fb-437a-99c3-3b20ccf4201d', '67c4365e-8e45-4e3c-b7aa-83d6eedf01e8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 2, NULL, '17:00:00', '20:00:00', 180, true, '2026-03-25 22:55:52.607', 176, '2026-03-26 03:55:52.607608', '2026-03-26 03:55:52.607608');
INSERT INTO public.task_entries VALUES ('577475c2-012a-4972-9990-cf1ea8f78aec', '67c4365e-8e45-4e3c-b7aa-83d6eedf01e8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Friends Meet', 2, NULL, '20:00:00', '23:30:00', 210, true, '2026-03-25 22:55:52.61', 177, '2026-03-26 03:55:52.611047', '2026-03-26 03:55:52.611047');
INSERT INTO public.task_entries VALUES ('3bc6599e-7c20-4584-a4fb-16e9b5e72715', '8ba34785-9be5-4492-94ec-d84d4e45e218', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '12:00:00', '05:00:00', 1450, true, '2026-03-25 22:55:52.616', 178, '2026-03-26 03:55:52.617295', '2026-03-26 03:55:52.617295');
INSERT INTO public.task_entries VALUES ('80ce82b8-5622-476a-82e6-c3f74c0db1fe', '8ba34785-9be5-4492-94ec-d84d4e45e218', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Client Meeting', 3, NULL, '05:00:00', '05:20:00', 20, true, '2026-03-25 22:55:52.62', 179, '2026-03-26 03:55:52.620607', '2026-03-26 03:55:52.620607');
INSERT INTO public.task_entries VALUES ('efd9c5c3-e77e-4052-acda-ae77bef28234', '8ba34785-9be5-4492-94ec-d84d4e45e218', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Expense Calculation', 3, NULL, '23:10:00', '00:00:00', 50, true, '2026-03-25 22:55:52.623', 180, '2026-03-26 03:55:52.624284', '2026-03-26 03:55:52.624284');
INSERT INTO public.task_entries VALUES ('548e6615-01f9-4151-95bd-18543dba62e0', '195fc6ae-dd20-46e9-8d68-d7a2b36a93fc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '00:00:00', '02:30:00', 150, true, '2026-03-25 22:55:52.63', 181, '2026-03-26 03:55:52.631151', '2026-03-26 03:55:52.631151');
INSERT INTO public.task_entries VALUES ('e7bf78ed-55d3-4902-860a-239ba8cce733', '195fc6ae-dd20-46e9-8d68-d7a2b36a93fc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '14:00:00', '17:30:00', 210, true, '2026-03-25 22:55:52.634', 182, '2026-03-26 03:55:52.634774', '2026-03-26 03:55:52.634774');
INSERT INTO public.task_entries VALUES ('773f9c73-924b-48ce-97fb-ff606fe1199f', '195fc6ae-dd20-46e9-8d68-d7a2b36a93fc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '17:30:00', '00:30:00', 420, true, '2026-03-25 22:55:52.639', 183, '2026-03-26 03:55:52.639982', '2026-03-26 03:55:52.639982');
INSERT INTO public.task_entries VALUES ('9cc92bd5-53d0-4b81-a28c-68d1852a8e1d', 'c3df1f5a-602a-496a-a06d-b58d916654cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '01:00:00', '02:00:00', 60, true, '2026-03-25 22:55:52.646', 184, '2026-03-26 03:55:52.646975', '2026-03-26 03:55:52.646975');
INSERT INTO public.task_entries VALUES ('0ec0bee2-ffe5-40d1-94fb-17d4d137b294', 'c3df1f5a-602a-496a-a06d-b58d916654cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Ringo Project', 3, NULL, '14:00:00', '15:00:00', 60, true, '2026-03-25 22:55:52.649', 185, '2026-03-26 03:55:52.650524', '2026-03-26 03:55:52.650524');
INSERT INTO public.task_entries VALUES ('dfa2de8d-bd4d-4536-8ed8-b6dcb2fb7d26', '79a8f669-c6ae-4704-abdf-570f08644d82', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '17:00:00', '18:00:00', 60, true, '2026-03-25 22:55:52.656', 186, '2026-03-26 03:55:52.657506', '2026-03-26 03:55:52.657506');
INSERT INTO public.task_entries VALUES ('f5fde95c-1147-4e84-93dc-05aae9b03a61', '79a8f669-c6ae-4704-abdf-570f08644d82', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '18:00:00', '20:30:00', 150, true, '2026-03-25 22:55:52.661', 187, '2026-03-26 03:55:52.661794', '2026-03-26 03:55:52.661794');
INSERT INTO public.task_entries VALUES ('e7ead33a-df90-4a7a-85d4-15e8bd8721a2', '79a8f669-c6ae-4704-abdf-570f08644d82', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Cloths Setting', 3, NULL, '21:00:00', '21:30:00', 30, true, '2026-03-25 22:55:52.664', 188, '2026-03-26 03:55:52.665387', '2026-03-26 03:55:52.665387');
INSERT INTO public.task_entries VALUES ('b7d5c175-4d95-43e8-be91-f54417ddf486', '79a8f669-c6ae-4704-abdf-570f08644d82', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Expense Calculation', 3, NULL, '21:45:00', '23:00:00', 75, true, '2026-03-25 22:55:52.668', 189, '2026-03-26 03:55:52.668776', '2026-03-26 03:55:52.668776');
INSERT INTO public.task_entries VALUES ('a7a62d5c-1439-4f98-925f-dd11114bd37d', '79a8f669-c6ae-4704-abdf-570f08644d82', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Propulsion', 3, NULL, '23:00:00', '23:30:00', 30, true, '2026-03-25 22:55:52.671', 190, '2026-03-26 03:55:52.672173', '2026-03-26 03:55:52.672173');
INSERT INTO public.task_entries VALUES ('4d577e5e-fa6d-46dc-a507-edef912cff8b', '79a8f669-c6ae-4704-abdf-570f08644d82', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Land-Liebe', 3, NULL, '23:00:00', '23:30:00', 30, true, '2026-03-25 22:55:52.675', 191, '2026-03-26 03:55:52.675828', '2026-03-26 03:55:52.675828');
INSERT INTO public.task_entries VALUES ('587ce20e-add7-41f3-95c8-9061174f3839', 'f24a07b1-ee49-481a-9a0d-6b8b886f4a53', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, NULL, NULL, NULL, true, '2026-03-25 22:55:52.684', 192, '2026-03-26 03:55:52.684624', '2026-03-26 03:55:52.684624');
INSERT INTO public.task_entries VALUES ('2e0c657f-4858-4212-bb28-17eb5b830a29', 'f24a07b1-ee49-481a-9a0d-6b8b886f4a53', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Hunter Trading', 3, NULL, NULL, NULL, NULL, true, '2026-03-25 22:55:52.687', 193, '2026-03-26 03:55:52.687873', '2026-03-26 03:55:52.687873');
INSERT INTO public.task_entries VALUES ('36af2ab9-50e4-4ca7-8581-91cb669b6875', 'f24a07b1-ee49-481a-9a0d-6b8b886f4a53', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '02:04:00', '06:30:00', 266, true, '2026-03-25 22:55:52.69', 194, '2026-03-26 03:55:52.691576', '2026-03-26 03:55:52.691576');
INSERT INTO public.task_entries VALUES ('0ce578f6-d4bb-49be-a32b-f897fd520900', 'f24a07b1-ee49-481a-9a0d-6b8b886f4a53', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '08:00:00', '13:30:00', 330, true, '2026-03-25 22:55:52.694', 195, '2026-03-26 03:55:52.695042', '2026-03-26 03:55:52.695042');
INSERT INTO public.task_entries VALUES ('242a6a70-b164-4974-9b11-cfa65dc6ef2f', 'f24a07b1-ee49-481a-9a0d-6b8b886f4a53', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:00:00', '19:30:00', 210, true, '2026-03-25 22:55:52.697', 196, '2026-03-26 03:55:52.698519', '2026-03-26 03:55:52.698519');
INSERT INTO public.task_entries VALUES ('34b1ff58-e29b-4016-a524-2a9d9a5c6d71', 'f24a07b1-ee49-481a-9a0d-6b8b886f4a53', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '20:00:00', NULL, NULL, true, '2026-03-25 22:55:52.704', 197, '2026-03-26 03:55:52.705585', '2026-03-26 03:55:52.705585');
INSERT INTO public.task_entries VALUES ('8adb1775-4eb1-421e-b491-38c6253928b4', '480e6e9d-aca7-44ee-8a40-3d4a7e9cc8b5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '09:00:00', '16:00:00', 420, true, '2026-03-25 22:55:52.712', 198, '2026-03-26 03:55:52.713343', '2026-03-26 03:55:52.713343');
INSERT INTO public.task_entries VALUES ('e2695373-9318-4db0-8a22-48025c3df58b', '480e6e9d-aca7-44ee-8a40-3d4a7e9cc8b5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Chess', 1, NULL, '16:00:00', '18:00:00', 120, true, '2026-03-25 22:55:52.716', 199, '2026-03-26 03:55:52.716839', '2026-03-26 03:55:52.716839');
INSERT INTO public.task_entries VALUES ('f548624f-76bd-4b69-9df9-0c2df1f0a61a', '3334ec6a-b9a1-4691-b1b1-debced0ad420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '11:10:00', '01:25:00', 855, true, '2026-03-25 22:55:52.722', 200, '2026-03-26 03:55:52.723582', '2026-03-26 03:55:52.723582');
INSERT INTO public.task_entries VALUES ('568e5c07-da22-49a1-8441-52cbe191fecc', '3334ec6a-b9a1-4691-b1b1-debced0ad420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Land-Liebe', 3, NULL, '11:10:00', '04:00:00', 1010, true, '2026-03-25 22:55:52.726', 201, '2026-03-26 03:55:52.727337', '2026-03-26 03:55:52.727337');
INSERT INTO public.task_entries VALUES ('6f9be064-1fa0-4353-b56f-d0a4f77f08ee', '3334ec6a-b9a1-4691-b1b1-debced0ad420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '04:40:00', '06:30:00', 110, true, '2026-03-25 22:55:52.732', 202, '2026-03-26 03:55:52.732528', '2026-03-26 03:55:52.732528');
INSERT INTO public.task_entries VALUES ('0ce42207-06ba-49cb-b22d-f96624c4fa31', '3334ec6a-b9a1-4691-b1b1-debced0ad420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '06:30:00', '08:00:00', 90, true, '2026-03-25 22:55:52.735', 203, '2026-03-26 03:55:52.736217', '2026-03-26 03:55:52.736217');
INSERT INTO public.task_entries VALUES ('0508ae2f-c5cb-4d24-83ff-ac038ab18bff', '3334ec6a-b9a1-4691-b1b1-debced0ad420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '14:00:00', '22:50:00', 530, true, '2026-03-25 22:55:52.739', 204, '2026-03-26 03:55:52.739795', '2026-03-26 03:55:52.739795');
INSERT INTO public.task_entries VALUES ('35a72ada-6974-4863-be80-7a83a4fd25a7', '3334ec6a-b9a1-4691-b1b1-debced0ad420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '22:50:00', '14:10:00', 920, true, '2026-03-25 22:55:52.742', 205, '2026-03-26 03:55:52.743204', '2026-03-26 03:55:52.743204');
INSERT INTO public.task_entries VALUES ('430098d5-5648-465d-a627-91b88a3d27f0', '02cdff23-bae7-4a22-895c-2574453ff271', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '22:50:00', '02:10:00', 200, true, '2026-03-25 22:55:52.749', 206, '2026-03-26 03:55:52.750206', '2026-03-26 03:55:52.750206');
INSERT INTO public.task_entries VALUES ('b6e0adb7-9913-41db-b8a8-9973a7a42a80', '02cdff23-bae7-4a22-895c-2574453ff271', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '02:10:00', '03:20:00', 70, true, '2026-03-25 22:55:52.752', 207, '2026-03-26 03:55:52.753559', '2026-03-26 03:55:52.753559');
INSERT INTO public.task_entries VALUES ('c0a2b63a-401c-4541-af01-8d847f2b07e5', '02cdff23-bae7-4a22-895c-2574453ff271', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '17:00:00', '19:30:00', 150, true, '2026-03-25 22:55:52.757', 208, '2026-03-26 03:55:52.758003', '2026-03-26 03:55:52.758003');
INSERT INTO public.task_entries VALUES ('a09b9665-5de0-40ac-9bee-967bb4451b38', '02cdff23-bae7-4a22-895c-2574453ff271', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:30:00', '03:00:00', 780, true, '2026-03-25 22:55:52.76', 209, '2026-03-26 03:55:52.761377', '2026-03-26 03:55:52.761377');
INSERT INTO public.task_entries VALUES ('1df3ce33-a231-4d16-a715-7966c956241b', '938b7e43-7fe1-4add-8562-8e4a44777e28', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '03:30:00', '09:00:00', 330, true, '2026-03-25 22:55:52.991', 210, '2026-03-26 03:55:52.992146', '2026-03-26 03:55:52.992146');
INSERT INTO public.task_entries VALUES ('49da3e04-3c9f-49b2-8d4c-1409e920b0e2', '938b7e43-7fe1-4add-8562-8e4a44777e28', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '09:00:00', '13:00:00', 440, true, '2026-03-25 22:55:52.997', 211, '2026-03-26 03:55:52.998181', '2026-03-26 03:55:52.998181');
INSERT INTO public.task_entries VALUES ('331b2697-45a3-45c1-8a03-703431b5a18a', '920f7471-4c76-472a-90d1-91e89f62af30', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:20:00', '04:30:00', 250, true, '2026-03-25 22:55:53.013', 212, '2026-03-26 03:55:53.013999', '2026-03-26 03:55:53.013999');
INSERT INTO public.task_entries VALUES ('75ab1a7c-a1a2-49d0-a221-b9649ec15152', '920f7471-4c76-472a-90d1-91e89f62af30', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA study', 3, NULL, '04:30:00', '06:30:00', 120, true, '2026-03-25 22:55:53.016', 213, '2026-03-26 03:55:53.017571', '2026-03-26 03:55:53.017571');
INSERT INTO public.task_entries VALUES ('7eaf2237-9239-455f-a1bf-c5a9f0e923a9', '920f7471-4c76-472a-90d1-91e89f62af30', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni', 3, NULL, '06:30:00', '11:30:00', 300, true, '2026-03-25 22:55:53.028', 214, '2026-03-26 03:55:53.028941', '2026-03-26 03:55:53.028941');
INSERT INTO public.task_entries VALUES ('64ec47e3-ba2b-46e0-990f-f19d6bb0d426', '7feb2ddd-5282-4944-9ece-71e1375e9435', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '10:00:00', '10:50:00', 130, true, '2026-03-25 22:55:53.042', 215, '2026-03-26 03:55:53.042928', '2026-03-26 03:55:53.042928');
INSERT INTO public.task_entries VALUES ('6e4e1909-b30f-44af-b920-b4b7336f865f', '7feb2ddd-5282-4944-9ece-71e1375e9435', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '10:00:00', '01:10:00', 920, true, '2026-03-25 22:55:53.046', 216, '2026-03-26 03:55:53.047151', '2026-03-26 03:55:53.047151');
INSERT INTO public.task_entries VALUES ('28a98dbd-daa6-4da7-817e-5f2b6452988e', '7feb2ddd-5282-4944-9ece-71e1375e9435', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:10:00', '04:30:00', 200, true, '2026-03-25 22:55:53.05', 217, '2026-03-26 03:55:53.050619', '2026-03-26 03:55:53.050619');
INSERT INTO public.task_entries VALUES ('b785a5d2-f033-4fee-9061-32f48ebaf6e0', '7feb2ddd-5282-4944-9ece-71e1375e9435', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Team Management', 3, NULL, '05:30:00', '06:00:00', 30, true, '2026-03-25 22:55:53.053', 218, '2026-03-26 03:55:53.054043', '2026-03-26 03:55:53.054043');
INSERT INTO public.task_entries VALUES ('4e3347cd-c8b6-4035-a035-91fedfd0569c', 'f95ff566-9715-4f03-bf47-e42af93014d4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '04:10:00', '07:00:00', 170, true, '2026-03-25 22:55:53.06', 219, '2026-03-26 03:55:53.061091', '2026-03-26 03:55:53.061091');
INSERT INTO public.task_entries VALUES ('e3f97bd4-936c-4b0a-8648-c96a23293951', 'f95ff566-9715-4f03-bf47-e42af93014d4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '07:00:00', '10:00:00', 180, true, '2026-03-25 22:55:53.064', 220, '2026-03-26 03:55:53.06478', '2026-03-26 03:55:53.06478');
INSERT INTO public.task_entries VALUES ('89bef076-15ff-4ac5-a427-cacf0adf668a', '36d1d578-8748-43d3-8caf-c48d6feb0df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:00:00', '01:00:00', 120, true, '2026-03-25 22:55:53.072', 221, '2026-03-26 03:55:53.073356', '2026-03-26 03:55:53.073356');
INSERT INTO public.task_entries VALUES ('88a49f62-8dd1-47b5-b2c9-97b45568ddbd', '36d1d578-8748-43d3-8caf-c48d6feb0df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:00:00', '02:00:00', 180, true, '2026-03-25 22:55:53.076', 222, '2026-03-26 03:55:53.07696', '2026-03-26 03:55:53.07696');
INSERT INTO public.task_entries VALUES ('045dd360-77fb-4585-a07b-549f2c923733', '36d1d578-8748-43d3-8caf-c48d6feb0df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project KOVA', 3, NULL, '03:00:00', '05:30:00', 150, true, '2026-03-25 22:55:53.079', 223, '2026-03-26 03:55:53.080219', '2026-03-26 03:55:53.080219');
INSERT INTO public.task_entries VALUES ('68ceba9f-ed56-42b7-b189-14695b507413', '36d1d578-8748-43d3-8caf-c48d6feb0df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '05:30:00', '08:30:00', 180, true, '2026-03-25 22:55:53.083', 224, '2026-03-26 03:55:53.083798', '2026-03-26 03:55:53.083798');
INSERT INTO public.task_entries VALUES ('9537bb6d-a890-4ec6-ae0b-47346feaf643', '36d1d578-8748-43d3-8caf-c48d6feb0df3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '08:30:00', '10:00:00', 90, true, '2026-03-25 22:55:53.087', 225, '2026-03-26 03:55:53.088116', '2026-03-26 03:55:53.088116');
INSERT INTO public.task_entries VALUES ('a0e822c8-8e03-4aad-892a-ad2f477b510f', '180afe42-a924-4540-80a0-7e2f3f08ba73', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '11:00:00', '13:30:00', 150, true, '2026-03-25 22:55:53.094', 226, '2026-03-26 03:55:53.095174', '2026-03-26 03:55:53.095174');
INSERT INTO public.task_entries VALUES ('8e5deb53-c5e9-480f-934e-cde69d6e4c01', '180afe42-a924-4540-80a0-7e2f3f08ba73', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project KOVA', 3, NULL, '13:30:00', '13:50:00', 20, true, '2026-03-25 22:55:53.099', 227, '2026-03-26 03:55:53.099506', '2026-03-26 03:55:53.099506');
INSERT INTO public.task_entries VALUES ('a8b3fd56-55a2-4827-b3e7-17c7f25f0b84', '180afe42-a924-4540-80a0-7e2f3f08ba73', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '13:50:00', '16:00:00', 210, true, '2026-03-25 22:55:53.102', 228, '2026-03-26 03:55:53.102899', '2026-03-26 03:55:53.102899');
INSERT INTO public.task_entries VALUES ('94ead265-5909-4ae1-b101-5bc67b34c302', '180afe42-a924-4540-80a0-7e2f3f08ba73', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '16:00:00', '20:10:00', 280, true, '2026-03-25 22:55:53.105', 229, '2026-03-26 03:55:53.10663', '2026-03-26 03:55:53.10663');
INSERT INTO public.task_entries VALUES ('861e90e1-f3a5-461c-9e6a-0dd1c7fe363e', 'ab57e926-c9bd-410d-8ad6-865ea8abd893', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '11:00:00', '01:30:00', 1110, true, '2026-03-25 22:55:53.121', 230, '2026-03-26 03:55:53.122392', '2026-03-26 03:55:53.122392');
INSERT INTO public.task_entries VALUES ('5fb4dc31-25da-4750-991f-d38b3e6b97af', 'ab57e926-c9bd-410d-8ad6-865ea8abd893', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '07:00:00', '11:00:00', 240, true, '2026-03-25 22:55:53.126', 231, '2026-03-26 03:55:53.126765', '2026-03-26 03:55:53.126765');
INSERT INTO public.task_entries VALUES ('ea790e8f-8995-4ad9-80bc-9ebe20dc5c93', '43017e36-86f8-4e3f-b6c7-e563a4038719', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '00:30:00', 150, true, '2026-03-25 22:55:53.133', 232, '2026-03-26 03:55:53.134531', '2026-03-26 03:55:53.134531');
INSERT INTO public.task_entries VALUES ('b38c9275-528f-40c1-ad2e-7bc118ef50ec', '43017e36-86f8-4e3f-b6c7-e563a4038719', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '00:30:00', '04:00:00', 210, true, '2026-03-25 22:55:53.138', 233, '2026-03-26 03:55:53.13886', '2026-03-26 03:55:53.13886');
INSERT INTO public.task_entries VALUES ('cc3d73da-e096-484a-a8cc-2d19b1c741fe', '43017e36-86f8-4e3f-b6c7-e563a4038719', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '16:00:00', '07:00:00', 900, true, '2026-03-25 22:55:53.141', 234, '2026-03-26 03:55:53.142466', '2026-03-26 03:55:53.142466');
INSERT INTO public.task_entries VALUES ('8fe6830b-cd14-4cea-b676-278d940476b6', '43017e36-86f8-4e3f-b6c7-e563a4038719', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '07:00:00', '11:00:00', 240, true, '2026-03-25 22:55:53.145', 235, '2026-03-26 03:55:53.145784', '2026-03-26 03:55:53.145784');
INSERT INTO public.task_entries VALUES ('857c608a-654c-4df2-a7a4-672c3de6f52b', '43017e36-86f8-4e3f-b6c7-e563a4038719', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '11:30:00', '14:00:00', 190, true, '2026-03-25 22:55:53.148', 236, '2026-03-26 03:55:53.149359', '2026-03-26 03:55:53.149359');
INSERT INTO public.task_entries VALUES ('71f6ca1c-606e-4387-9123-b8740b2cca48', '81304708-8ad4-49bf-8498-7f9425c274e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '06:00:00', 900, true, '2026-03-25 22:55:53.155', 237, '2026-03-26 03:55:53.156474', '2026-03-26 03:55:53.156474');
INSERT INTO public.task_entries VALUES ('3dbb2289-5705-4330-aa1a-c3162cd55a9a', '81304708-8ad4-49bf-8498-7f9425c274e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '06:00:00', '06:30:00', 30, true, '2026-03-25 22:55:53.16', 238, '2026-03-26 03:55:53.16073', '2026-03-26 03:55:53.16073');
INSERT INTO public.task_entries VALUES ('2aa26147-4ef5-414c-823e-6daa1bd03482', '81304708-8ad4-49bf-8498-7f9425c274e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '06:30:00', '06:50:00', 80, true, '2026-03-25 22:55:53.165', 239, '2026-03-26 03:55:53.16603', '2026-03-26 03:55:53.16603');
INSERT INTO public.task_entries VALUES ('5e096e92-c3b2-4598-b542-a41c466f7244', '81304708-8ad4-49bf-8498-7f9425c274e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '06:50:00', '08:00:00', 310, true, '2026-03-25 22:55:53.168', 240, '2026-03-26 03:55:53.169335', '2026-03-26 03:55:53.169335');
INSERT INTO public.task_entries VALUES ('933ae3b5-f854-41d1-9d07-c81ce64b3fa0', '81304708-8ad4-49bf-8498-7f9425c274e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project MetaOps', 3, NULL, '09:00:00', '11:30:00', 270, true, '2026-03-25 22:55:53.172', 241, '2026-03-26 03:55:53.172744', '2026-03-26 03:55:53.172744');
INSERT INTO public.task_entries VALUES ('a6ec54d1-451b-40cb-8970-bfdd05e98870', '81304708-8ad4-49bf-8498-7f9425c274e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA Assignment', 3, NULL, '18:00:00', '21:00:00', 180, true, '2026-03-25 22:55:53.175', 242, '2026-03-26 03:55:53.176323', '2026-03-26 03:55:53.176323');
INSERT INTO public.task_entries VALUES ('5a1021df-52b6-4d17-b606-14b373b0be6e', '87321435-7a90-4eb3-ad26-48aa44b7d0b0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '01:00:00', '02:30:00', 90, true, '2026-03-25 22:55:53.182', 243, '2026-03-26 03:55:53.182485', '2026-03-26 03:55:53.182485');
INSERT INTO public.task_entries VALUES ('9d7860a2-b7e1-4a18-aeef-b8b1d9441f50', '87321435-7a90-4eb3-ad26-48aa44b7d0b0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '02:30:00', '06:25:00', 235, true, '2026-03-25 22:55:53.185', 244, '2026-03-26 03:55:53.185975', '2026-03-26 03:55:53.185975');
INSERT INTO public.task_entries VALUES ('68b47cdd-5172-4cbb-b7e8-306ad9bd20f9', '87321435-7a90-4eb3-ad26-48aa44b7d0b0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '06:30:00', '23:30:00', 1020, true, '2026-03-25 22:55:53.188', 245, '2026-03-26 03:55:53.189562', '2026-03-26 03:55:53.189562');
INSERT INTO public.task_entries VALUES ('4e38f718-5589-4bd9-9832-6301a47fea37', '87321435-7a90-4eb3-ad26-48aa44b7d0b0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'PC Market', 3, NULL, '23:30:00', '13:00:00', 810, true, '2026-03-25 22:55:53.192', 246, '2026-03-26 03:55:53.193069', '2026-03-26 03:55:53.193069');
INSERT INTO public.task_entries VALUES ('a08ba5e3-f38e-4580-bcf8-dfdb5d645181', '87321435-7a90-4eb3-ad26-48aa44b7d0b0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '13:00:00', '15:00:00', 120, true, '2026-03-25 22:55:53.195', 247, '2026-03-26 03:55:53.196512', '2026-03-26 03:55:53.196512');
INSERT INTO public.task_entries VALUES ('284120c4-e92c-45e1-b76f-9a37a49e9b0d', '5613a8ac-9059-4416-a083-b760cc98723b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '01:30:00', 320, true, '2026-03-25 22:55:53.202', 248, '2026-03-26 03:55:53.203419', '2026-03-26 03:55:53.203419');
INSERT INTO public.task_entries VALUES ('3d5da287-ffb0-4a00-b07a-fe1c9a128731', '5613a8ac-9059-4416-a083-b760cc98723b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Boomerang', 3, NULL, '01:30:00', '04:40:00', 220, true, '2026-03-25 22:55:53.208', 249, '2026-03-26 03:55:53.208805', '2026-03-26 03:55:53.208805');
INSERT INTO public.task_entries VALUES ('b6185d78-5aaf-43b8-ba48-60658ff380be', '5613a8ac-9059-4416-a083-b760cc98723b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Vibe Coding', 3, NULL, '06:50:00', '10:10:00', 200, true, '2026-03-25 22:55:53.211', 250, '2026-03-26 03:55:53.212214', '2026-03-26 03:55:53.212214');
INSERT INTO public.task_entries VALUES ('d23baa59-5ae5-4d1c-ad88-a3f2fc6140d3', '5613a8ac-9059-4416-a083-b760cc98723b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '10:10:00', '15:30:00', 320, true, '2026-03-25 22:55:53.215', 251, '2026-03-26 03:55:53.215948', '2026-03-26 03:55:53.215948');
INSERT INTO public.task_entries VALUES ('ddd294a1-06fb-4da7-a798-a008a0c6aab0', '5613a8ac-9059-4416-a083-b760cc98723b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '17:20:00', '18:40:00', 80, true, '2026-03-25 22:55:53.218', 252, '2026-03-26 03:55:53.219112', '2026-03-26 03:55:53.219112');
INSERT INTO public.task_entries VALUES ('301cea56-78b2-4a7c-a600-5980d0c88233', '10d2dc4d-0350-44e9-b04c-6009521827a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '05:00:00', '15:00:00', 600, true, '2026-03-25 22:55:53.224', 253, '2026-03-26 03:55:53.224668', '2026-03-26 03:55:53.224668');
INSERT INTO public.task_entries VALUES ('d2f063f8-7785-47b7-8eca-c6dd1835f9a0', '10d2dc4d-0350-44e9-b04c-6009521827a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project MetaOps', 3, NULL, '15:15:00', '17:00:00', 105, true, '2026-03-25 22:55:53.227', 254, '2026-03-26 03:55:53.228007', '2026-03-26 03:55:53.228007');
INSERT INTO public.task_entries VALUES ('322d8797-711a-41ce-a1a7-056abea123c1', '10d2dc4d-0350-44e9-b04c-6009521827a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '17:15:00', '22:00:00', 285, true, '2026-03-25 22:55:53.23', 255, '2026-03-26 03:55:53.231531', '2026-03-26 03:55:53.231531');
INSERT INTO public.task_entries VALUES ('3d0e96f1-c5d9-4f0f-96e3-4914261a5f21', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '08:00:00', '10:30:00', 1060, true, '2026-03-25 22:55:53.237', 256, '2026-03-26 03:55:53.238455', '2026-03-26 03:55:53.238455');
INSERT INTO public.task_entries VALUES ('8d7fc195-0f00-4e4f-9684-17c4e0194c99', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:30:00', '12:50:00', 800, true, '2026-03-25 22:55:53.241', 257, '2026-03-26 03:55:53.242053', '2026-03-26 03:55:53.242053');
INSERT INTO public.task_entries VALUES ('d15133c6-2e4d-4376-b62b-4e7e1fe27d7b', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project MetaOps', 3, NULL, '12:50:00', '13:30:00', 40, true, '2026-03-25 22:55:53.244', 258, '2026-03-26 03:55:53.245292', '2026-03-26 03:55:53.245292');
INSERT INTO public.task_entries VALUES ('c3b87808-63fc-4bf3-ad02-1006d5a54a86', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '13:30:00', '14:00:00', 30, true, '2026-03-25 22:55:53.25', 259, '2026-03-26 03:55:53.250788', '2026-03-26 03:55:53.250788');
INSERT INTO public.task_entries VALUES ('43e5146d-3525-4b4a-bec2-865762ae9159', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'MVP Prototype', 3, NULL, '14:00:00', '15:00:00', 60, true, '2026-03-25 22:55:53.253', 260, '2026-03-26 03:55:53.254607', '2026-03-26 03:55:53.254607');
INSERT INTO public.task_entries VALUES ('00cc9ca2-6327-4ebd-9cc2-0865a34cbf2c', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Pc Repair', 3, NULL, '16:00:00', '17:30:00', 90, true, '2026-03-25 22:55:53.257', 261, '2026-03-26 03:55:53.25778', '2026-03-26 03:55:53.25778');
INSERT INTO public.task_entries VALUES ('de20688d-2307-483c-8489-8595ed744864', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ab651a4-b032-453f-9f03-57be13feffba', NULL, 'Ground', 3, NULL, '17:30:00', '18:30:00', 60, true, '2026-03-25 22:55:53.487', 262, '2026-03-26 03:55:53.488494', '2026-03-26 03:55:53.488494');
INSERT INTO public.task_entries VALUES ('4d644808-c6f3-4e81-bac5-f57dc59f037d', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ab651a4-b032-453f-9f03-57be13feffba', NULL, 'Haircut', 3, NULL, '18:30:00', '19:30:00', 60, true, '2026-03-25 22:55:53.51', 263, '2026-03-26 03:55:53.511184', '2026-03-26 03:55:53.511184');
INSERT INTO public.task_entries VALUES ('aeda42ef-595b-42cb-84f1-4531f5871780', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '9ab651a4-b032-453f-9f03-57be13feffba', NULL, 'Res', 2, NULL, '19:30:00', '20:30:00', 60, true, '2026-03-25 22:55:53.522', 264, '2026-03-26 03:55:53.523012', '2026-03-26 03:55:53.523012');
INSERT INTO public.task_entries VALUES ('59705ea6-679f-45d5-a1b6-be42471614c5', 'd3b19421-c9cb-47b6-9434-2996bafa9d57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '23:40:00', NULL, NULL, true, '2026-03-25 22:55:53.528', 265, '2026-03-26 03:55:53.528672', '2026-03-26 03:55:53.528672');
INSERT INTO public.task_entries VALUES ('9d39ee50-1018-4428-bf46-27e03a5ac7bb', '6f3b426d-8a2d-4ec5-bedc-fd283fbfd5f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '17:30:00', '23:30:00', 360, true, '2026-03-25 22:55:53.54', 266, '2026-03-26 03:55:53.54098', '2026-03-26 03:55:53.54098');
INSERT INTO public.task_entries VALUES ('b9f116b2-7c0f-435f-831f-e10e930e09a5', '6f3b426d-8a2d-4ec5-bedc-fd283fbfd5f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Sunday Bazaar', 3, NULL, '23:30:00', '16:00:00', 990, true, '2026-03-25 22:55:53.546', 267, '2026-03-26 03:55:53.546947', '2026-03-26 03:55:53.546947');
INSERT INTO public.task_entries VALUES ('25f08f8e-7ce3-435a-a77e-6b3e5420b785', '6f3b426d-8a2d-4ec5-bedc-fd283fbfd5f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:00:00', '03:00:00', 660, true, '2026-03-25 22:55:53.553', 268, '2026-03-26 03:55:53.553972', '2026-03-26 03:55:53.553972');
INSERT INTO public.task_entries VALUES ('e78eb95b-0481-4bcc-b102-d226952571cf', '4d34efa3-51b3-4e4a-a633-c5eda4389986', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '18:00:00', '11:00:00', 1020, true, '2026-03-25 22:55:53.576', 269, '2026-03-26 03:55:53.576713', '2026-03-26 03:55:53.576713');
INSERT INTO public.task_entries VALUES ('932194f1-1ad0-4a80-8abd-d5b2f71e349e', '4d34efa3-51b3-4e4a-a633-c5eda4389986', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:00:00', '18:00:00', 600, true, '2026-03-25 22:55:53.581', 270, '2026-03-26 03:55:53.58192', '2026-03-26 03:55:53.58192');
INSERT INTO public.task_entries VALUES ('b0164615-763f-4517-ac3e-5882a04c3062', '4d34efa3-51b3-4e4a-a633-c5eda4389986', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork BIdding', 3, NULL, '18:00:00', '20:20:00', 140, true, '2026-03-25 22:55:53.586', 271, '2026-03-26 03:55:53.587217', '2026-03-26 03:55:53.587217');
INSERT INTO public.task_entries VALUES ('8d564ec7-e393-40c1-94c9-92b5c19f7b00', '583cc846-b02c-4890-806a-b75e2a7b7af7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Team Hunting', 3, NULL, '14:00:00', '17:50:00', 230, true, '2026-03-25 22:55:53.596', 272, '2026-03-26 03:55:53.596726', '2026-03-26 03:55:53.596726');
INSERT INTO public.task_entries VALUES ('95a74a53-925e-474f-82c7-ca1660f162c0', '583cc846-b02c-4890-806a-b75e2a7b7af7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Ringo', 3, NULL, '17:50:00', '18:20:00', 30, true, '2026-03-25 22:55:53.6', 273, '2026-03-26 03:55:53.601191', '2026-03-26 03:55:53.601191');
INSERT INTO public.task_entries VALUES ('87c59a03-3aaa-4f66-b6db-8be1937bde58', '583cc846-b02c-4890-806a-b75e2a7b7af7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:30:00', '23:40:00', 310, true, '2026-03-25 22:55:53.603', 274, '2026-03-26 03:55:53.60447', '2026-03-26 03:55:53.60447');
INSERT INTO public.task_entries VALUES ('c22107ee-5dbb-4337-afaf-2bd41d43921d', '5e89d6b1-84fb-453e-9ff2-f5aaf81c944b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '06:00:00', '13:00:00', 420, true, '2026-03-25 22:55:53.61', 275, '2026-03-26 03:55:53.611506', '2026-03-26 03:55:53.611506');
INSERT INTO public.task_entries VALUES ('14c675fc-075b-49c1-b56f-ccd150f171a1', '5e89d6b1-84fb-453e-9ff2-f5aaf81c944b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '13:30:00', '18:00:00', 270, true, '2026-03-25 22:55:53.614', 276, '2026-03-26 03:55:53.615272', '2026-03-26 03:55:53.615272');
INSERT INTO public.task_entries VALUES ('f679f98a-8c0b-482a-89fd-d38dc9b0ffcc', '5e89d6b1-84fb-453e-9ff2-f5aaf81c944b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '21:50:00', 50, true, '2026-03-25 22:55:53.617', 277, '2026-03-26 03:55:53.618526', '2026-03-26 03:55:53.618526');
INSERT INTO public.task_entries VALUES ('138acb53-aeea-4d88-988f-5e7bb2ad8e01', '5e89d6b1-84fb-453e-9ff2-f5aaf81c944b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '21:50:00', '23:00:00', 70, true, '2026-03-25 22:55:53.623', 278, '2026-03-26 03:55:53.623934', '2026-03-26 03:55:53.623934');
INSERT INTO public.task_entries VALUES ('5dd35ef6-df59-428a-a1e2-770ffd7af5c0', '65dde68d-ceda-4acc-a082-b658c696b72e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '23:00:00', '13:30:00', 870, true, '2026-03-25 22:55:53.63', 279, '2026-03-26 03:55:53.630734', '2026-03-26 03:55:53.630734');
INSERT INTO public.task_entries VALUES ('33f6439d-1785-43ca-97c5-123318dd1d68', '65dde68d-ceda-4acc-a082-b658c696b72e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '13:30:00', '15:00:00', 90, true, '2026-03-25 22:55:53.857', 280, '2026-03-26 03:55:53.858057', '2026-03-26 03:55:53.858057');
INSERT INTO public.task_entries VALUES ('1f0b9c81-85a9-4e67-853f-d8d0c815b34b', '65dde68d-ceda-4acc-a082-b658c696b72e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '21:50:00', 50, true, '2026-03-25 22:55:53.861', 281, '2026-03-26 03:55:53.862284', '2026-03-26 03:55:53.862284');
INSERT INTO public.task_entries VALUES ('1b48c29b-09a5-4bc0-99d3-4ccbaf3cef26', '9452f206-ae3d-4e1a-b924-bbc2b58eefca', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:50:00', '08:00:00', 910, true, '2026-03-25 22:55:53.912', 282, '2026-03-26 03:55:53.913164', '2026-03-26 03:55:53.913164');
INSERT INTO public.task_entries VALUES ('8d1f240e-f0c4-4940-b3f7-b821ece40a55', '9452f206-ae3d-4e1a-b924-bbc2b58eefca', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '21:00:00', '23:30:00', 150, true, '2026-03-25 22:55:53.916', 283, '2026-03-26 03:55:53.917524', '2026-03-26 03:55:53.917524');
INSERT INTO public.task_entries VALUES ('b263607b-7426-47f5-ac0b-1b0da9a1783b', '9452f206-ae3d-4e1a-b924-bbc2b58eefca', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Abbas MVP Prototype', 3, NULL, '23:30:00', NULL, NULL, true, '2026-03-25 22:55:53.921', 284, '2026-03-26 03:55:53.921699', '2026-03-26 03:55:53.921699');
INSERT INTO public.task_entries VALUES ('2cffd533-6ffa-4a53-982d-a428e279bc0a', 'ca3b0b9a-9e26-4307-839b-4ceb93948f44', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '13:00:00', '18:00:00', 300, true, '2026-03-25 22:55:53.93', 285, '2026-03-26 03:55:53.931487', '2026-03-26 03:55:53.931487');
INSERT INTO public.task_entries VALUES ('7e553bb5-84e7-4fd7-bcef-69a8d4b2a8db', 'ca3b0b9a-9e26-4307-839b-4ceb93948f44', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Expense Calculation', 3, NULL, '18:00:00', '23:50:00', 350, true, '2026-03-25 22:55:53.935', 286, '2026-03-26 03:55:53.935706', '2026-03-26 03:55:53.935706');
INSERT INTO public.task_entries VALUES ('3cef0161-0438-43cf-8398-373e1f7ff183', 'cf3ae147-8282-4915-ae67-cf06f3afa8c0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:50:00', '06:00:00', 370, true, '2026-03-25 22:55:53.947', 287, '2026-03-26 03:55:53.947976', '2026-03-26 03:55:53.947976');
INSERT INTO public.task_entries VALUES ('7e5b1fed-7783-443a-be01-83258a500ab6', 'cf3ae147-8282-4915-ae67-cf06f3afa8c0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '11:00:00', '18:00:00', 420, true, '2026-03-25 22:55:53.952', 288, '2026-03-26 03:55:53.953232', '2026-03-26 03:55:53.953232');
INSERT INTO public.task_entries VALUES ('a27eed83-476f-48b0-823b-a77298904e17', 'cf3ae147-8282-4915-ae67-cf06f3afa8c0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:30:00', '11:00:00', 870, true, '2026-03-25 22:55:53.957', 289, '2026-03-26 03:55:53.957527', '2026-03-26 03:55:53.957527');
INSERT INTO public.task_entries VALUES ('32ccef7f-6715-4581-8210-2eb813413807', '400add5b-a44b-4598-9ce3-421c257bad95', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '11:00:00', '02:00:00', 900, true, '2026-03-25 22:55:53.983', 290, '2026-03-26 03:55:53.9839', '2026-03-26 03:55:53.9839');
INSERT INTO public.task_entries VALUES ('7a5586f3-dddf-4abb-8826-3807116c2633', '400add5b-a44b-4598-9ce3-421c257bad95', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '03:00:00', '06:00:00', 605, true, '2026-03-25 22:55:53.986', 291, '2026-03-26 03:55:53.987205', '2026-03-26 03:55:53.987205');
INSERT INTO public.task_entries VALUES ('c98d1a23-dcfa-4f28-b769-c5abf04b5c25', '400add5b-a44b-4598-9ce3-421c257bad95', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA Preparation', 3, NULL, '03:00:00', '06:00:00', 605, true, '2026-03-25 22:55:53.991', 292, '2026-03-26 03:55:53.991637', '2026-03-26 03:55:53.991637');
INSERT INTO public.task_entries VALUES ('ef7c200e-37aa-4bbb-b255-97c72878f83b', '5b21dca1-9638-4d49-b9f3-4d3b4d84afc0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA Preparation', 3, NULL, '02:00:00', '07:00:00', 300, true, '2026-03-25 22:55:53.998', 293, '2026-03-26 03:55:53.998776', '2026-03-26 03:55:53.998776');
INSERT INTO public.task_entries VALUES ('e40a0cdd-fda2-4dc3-864b-d0030208b4b9', '5b21dca1-9638-4d49-b9f3-4d3b4d84afc0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '07:00:00', '12:00:00', 300, true, '2026-03-25 22:55:54.001', 294, '2026-03-26 03:55:54.002108', '2026-03-26 03:55:54.002108');
INSERT INTO public.task_entries VALUES ('c9501983-df37-4a52-bac3-99576aa5fd3a', '5b21dca1-9638-4d49-b9f3-4d3b4d84afc0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:00:00', '23:05:00', 425, true, '2026-03-25 22:55:54.005', 295, '2026-03-26 03:55:54.005644', '2026-03-26 03:55:54.005644');
INSERT INTO public.task_entries VALUES ('da8beade-b459-4d9c-9081-87edcca9489a', '9457a0cb-c608-42b3-a0c6-b35fb0b6be57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:05:00', '06:00:00', 415, true, '2026-03-25 22:55:54.013', 296, '2026-03-26 03:55:54.014363', '2026-03-26 03:55:54.014363');
INSERT INTO public.task_entries VALUES ('cdb4bf57-5c97-4332-9ebc-37e73860b2ec', '9457a0cb-c608-42b3-a0c6-b35fb0b6be57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '09:00:00', '14:00:00', 300, true, '2026-03-25 22:55:54.018', 297, '2026-03-26 03:55:54.01862', '2026-03-26 03:55:54.01862');
INSERT INTO public.task_entries VALUES ('9965b384-b13c-4c60-b487-fe8e47bf35ed', '9457a0cb-c608-42b3-a0c6-b35fb0b6be57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Misc', 1, NULL, '14:00:00', '17:05:00', 185, true, '2026-03-25 22:55:54.021', 298, '2026-03-26 03:55:54.02214', '2026-03-26 03:55:54.02214');
INSERT INTO public.task_entries VALUES ('1320c4d9-81f6-4ccb-9c26-76b268bde841', 'cfd2e9c9-f8b1-4efa-9425-21df22e696ff', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '22:00:00', 60, true, '2026-03-25 22:55:54.028', 299, '2026-03-26 03:55:54.029137', '2026-03-26 03:55:54.029137');
INSERT INTO public.task_entries VALUES ('b1e22af6-b249-4996-a0d0-3c66ad050c71', 'cfd2e9c9-f8b1-4efa-9425-21df22e696ff', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:00:00', '02:00:00', 240, true, '2026-03-25 22:55:54.032', 300, '2026-03-26 03:55:54.032682', '2026-03-26 03:55:54.032682');
INSERT INTO public.task_entries VALUES ('a02540ca-c26b-4b73-a640-081190ff455d', 'ccb188cf-90bb-46a2-82a8-e7208baede49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '02:00:00', '06:30:00', 270, true, '2026-03-25 22:55:54.04', 301, '2026-03-26 03:55:54.040586', '2026-03-26 03:55:54.040586');
INSERT INTO public.task_entries VALUES ('bc71527c-019d-447d-860c-4475f965e118', 'ccb188cf-90bb-46a2-82a8-e7208baede49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '06:30:00', '12:00:00', 330, true, '2026-03-25 22:55:54.043', 302, '2026-03-26 03:55:54.044105', '2026-03-26 03:55:54.044105');
INSERT INTO public.task_entries VALUES ('34f9c829-db2a-4abc-9602-a67d4b308998', 'ccb188cf-90bb-46a2-82a8-e7208baede49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Project', 3, NULL, '15:00:00', '19:00:00', 240, true, '2026-03-25 22:55:54.047', 303, '2026-03-26 03:55:54.047653', '2026-03-26 03:55:54.047653');
INSERT INTO public.task_entries VALUES ('ed97f34f-9141-4355-9f5d-8ac9cce574e8', '33cf24d0-2e40-4f2b-8887-c7d1983dc27f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '03:00:00', 300, true, '2026-03-25 22:55:54.053', 304, '2026-03-26 03:55:54.054492', '2026-03-26 03:55:54.054492');
INSERT INTO public.task_entries VALUES ('b7004632-0dd6-480f-8e75-16537b3fbb78', '33cf24d0-2e40-4f2b-8887-c7d1983dc27f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA Preparation', 3, NULL, '03:00:00', '06:00:00', 180, true, '2026-03-25 22:55:54.059', 305, '2026-03-26 03:55:54.059766', '2026-03-26 03:55:54.059766');
INSERT INTO public.task_entries VALUES ('29300b75-7660-40fa-b5b5-204bed0c4530', '42158637-e08e-41ef-acf7-236798ff4d08', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA Preparation', 3, NULL, '03:00:00', '06:00:00', 180, true, '2026-03-25 22:55:54.067', 306, '2026-03-26 03:55:54.06804', '2026-03-26 03:55:54.06804');
INSERT INTO public.task_entries VALUES ('068b50cd-a14b-4624-8a41-9e8744214512', '42158637-e08e-41ef-acf7-236798ff4d08', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '06:00:00', '10:00:00', 240, true, '2026-03-25 22:55:54.071', 307, '2026-03-26 03:55:54.071588', '2026-03-26 03:55:54.071588');
INSERT INTO public.task_entries VALUES ('50f858e2-76f4-4467-bbb2-29b09a4d574b', '36772d97-e558-411c-af12-473f39477614', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '02:00:00', 240, true, '2026-03-25 22:55:54.076', 308, '2026-03-26 03:55:54.077364', '2026-03-26 03:55:54.077364');
INSERT INTO public.task_entries VALUES ('097ba33d-9306-499b-95c7-9a864865f978', '36772d97-e558-411c-af12-473f39477614', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA Preparation', 3, NULL, '02:00:00', '06:00:00', 240, true, '2026-03-25 22:55:54.08', 309, '2026-03-26 03:55:54.080862', '2026-03-26 03:55:54.080862');
INSERT INTO public.task_entries VALUES ('f9c22794-3f42-4d7b-b7cf-f138d968e36c', '36772d97-e558-411c-af12-473f39477614', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '08:00:00', '15:00:00', 420, true, '2026-03-25 22:55:54.083', 310, '2026-03-26 03:55:54.084324', '2026-03-26 03:55:54.084324');
INSERT INTO public.task_entries VALUES ('64fd2c5e-f504-4959-ba48-ffab52a3f3dc', '71680dbd-31ba-4547-a5c0-4ca67e0abcdf', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '01:30:00', NULL, NULL, true, '2026-03-25 22:55:54.09', 311, '2026-03-26 03:55:54.091289', '2026-03-26 03:55:54.091289');
INSERT INTO public.task_entries VALUES ('77c99e01-231f-431b-b8ba-a50b6b7e869e', '4b93d9f4-c181-4e74-af01-feecf03d73c6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '05:00:00', '15:30:00', 630, true, '2026-03-25 22:55:54.097', 312, '2026-03-26 03:55:54.098217', '2026-03-26 03:55:54.098217');
INSERT INTO public.task_entries VALUES ('7340244b-ed64-44ae-a9b5-049b9ba3837c', '4b93d9f4-c181-4e74-af01-feecf03d73c6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA Preparation', 3, NULL, '15:30:00', '17:20:00', 110, true, '2026-03-25 22:55:54.101', 313, '2026-03-26 03:55:54.101679', '2026-03-26 03:55:54.101679');
INSERT INTO public.task_entries VALUES ('23002b51-4d6f-4877-82d6-99ce179b7ecd', '4b93d9f4-c181-4e74-af01-feecf03d73c6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Exercise', 3, NULL, '17:20:00', '19:00:00', 100, true, '2026-03-25 22:55:54.106', 314, '2026-03-26 03:55:54.107099', '2026-03-26 03:55:54.107099');
INSERT INTO public.task_entries VALUES ('b559c624-b572-431b-9fde-ac6f7f1b048f', 'e3b08bcb-ad7d-4cde-a65a-f61af4d7e056', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Entertainment', 1, NULL, '05:00:00', '10:00:00', 300, true, '2026-03-25 22:55:54.113', 315, '2026-03-26 03:55:54.114339', '2026-03-26 03:55:54.114339');
INSERT INTO public.task_entries VALUES ('8df28dea-3f68-4fc2-9767-6f26867ebea4', 'e3b08bcb-ad7d-4cde-a65a-f61af4d7e056', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '13:30:00', '14:40:00', 70, true, '2026-03-25 22:55:54.117', 316, '2026-03-26 03:55:54.117759', '2026-03-26 03:55:54.117759');
INSERT INTO public.task_entries VALUES ('18d60d42-cfa1-42a2-ae75-702f892c392a', 'e3b08bcb-ad7d-4cde-a65a-f61af4d7e056', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Book Atomic Habits', 3, NULL, '14:40:00', '20:30:00', 350, true, '2026-03-25 22:55:54.12', 317, '2026-03-26 03:55:54.121238', '2026-03-26 03:55:54.121238');
INSERT INTO public.task_entries VALUES ('cea7091f-5536-466d-b7e6-338ddd2e12a4', 'e3b08bcb-ad7d-4cde-a65a-f61af4d7e056', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DSA Preparation', 3, NULL, '20:30:00', '02:00:00', 330, true, '2026-03-25 22:55:54.123', 318, '2026-03-26 03:55:54.124418', '2026-03-26 03:55:54.124418');
INSERT INTO public.task_entries VALUES ('0ac7f425-9e82-47a0-b0d7-5c4901e85874', 'c110b0c4-4f24-4da9-b9cb-4ab41c23f6f4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Entertainment', 1, NULL, '02:00:00', '05:00:00', 360, true, '2026-03-25 22:55:54.132', 319, '2026-03-26 03:55:54.133213', '2026-03-26 03:55:54.133213');
INSERT INTO public.task_entries VALUES ('f8688ac0-f597-443c-a64e-9f664f462878', 'c110b0c4-4f24-4da9-b9cb-4ab41c23f6f4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '17:00:00', '19:10:00', 130, true, '2026-03-25 22:55:54.136', 320, '2026-03-26 03:55:54.136628', '2026-03-26 03:55:54.136628');
INSERT INTO public.task_entries VALUES ('d7a3890d-f290-4011-b690-4df08f3da5a5', 'c110b0c4-4f24-4da9-b9cb-4ab41c23f6f4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DSA Exam Preparation', 3, NULL, '20:30:00', '02:20:00', 350, true, '2026-03-25 22:55:54.139', 321, '2026-03-26 03:55:54.140335', '2026-03-26 03:55:54.140335');
INSERT INTO public.task_entries VALUES ('4af7db59-e623-4db1-9b0a-ef60c08b5988', '6992799e-5242-4325-84e6-6c0ead3f009a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DSA Exam Preparation', 3, NULL, '02:20:00', '07:00:00', 280, true, '2026-03-25 22:55:54.37', 322, '2026-03-26 03:55:54.370978', '2026-03-26 03:55:54.370978');
INSERT INTO public.task_entries VALUES ('99c931a0-3317-47ad-84ff-5b51924e10f4', '6992799e-5242-4325-84e6-6c0ead3f009a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DSA Exam', 3, NULL, '07:00:00', '14:00:00', 420, true, '2026-03-25 22:55:54.375', 323, '2026-03-26 03:55:54.376218', '2026-03-26 03:55:54.376218');
INSERT INTO public.task_entries VALUES ('a8742c0d-d315-4077-8fe0-694a8ac38256', 'a3f992fc-130c-4e02-b610-21f2fc60c673', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Entertainment', 1, NULL, '04:00:00', '07:00:00', 180, true, '2026-03-25 22:55:54.383', 324, '2026-03-26 03:55:54.384322', '2026-03-26 03:55:54.384322');
INSERT INTO public.task_entries VALUES ('42f926e2-4235-4ae3-93bd-ab134efcd98f', 'a3f992fc-130c-4e02-b610-21f2fc60c673', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'Uni', 3, NULL, '08:00:00', '14:00:00', 360, true, '2026-03-25 22:55:54.387', 325, '2026-03-26 03:55:54.388399', '2026-03-26 03:55:54.388399');
INSERT INTO public.task_entries VALUES ('b2e2dacf-e309-4eca-9bfd-b25e3ab7b5f4', 'a3f992fc-130c-4e02-b610-21f2fc60c673', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:00:00', '15:00:00', 840, true, '2026-03-25 22:55:54.392', 326, '2026-03-26 03:55:54.392723', '2026-03-26 03:55:54.392723');
INSERT INTO public.task_entries VALUES ('24309c68-9964-45ac-b231-413cca476675', 'a3f992fc-130c-4e02-b610-21f2fc60c673', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Plan 20 Days Off', 3, NULL, '15:00:00', '18:00:00', 180, true, '2026-03-25 22:55:54.395', 327, '2026-03-26 03:55:54.396155', '2026-03-26 03:55:54.396155');
INSERT INTO public.task_entries VALUES ('0f74971b-c548-4f7a-a067-e131f352c36c', 'a3f992fc-130c-4e02-b610-21f2fc60c673', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Expense Calculation', 3, NULL, '18:00:00', '19:00:00', 60, true, '2026-03-25 22:55:54.399', 328, '2026-03-26 03:55:54.399749', '2026-03-26 03:55:54.399749');
INSERT INTO public.task_entries VALUES ('bc0df6bb-8282-4ca1-aab1-be7365305d6b', 'a3f992fc-130c-4e02-b610-21f2fc60c673', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '19:00:00', '20:00:00', 150, true, '2026-03-25 22:55:54.404', 329, '2026-03-26 03:55:54.404857', '2026-03-26 03:55:54.404857');
INSERT INTO public.task_entries VALUES ('0fc61f2f-f815-49e2-b993-e42c7cf0b153', 'af683f2f-fbf3-4f60-b27c-e0135cdd2599', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '10:00:00', '11:30:00', 90, true, '2026-03-25 22:55:54.411', 330, '2026-03-26 03:55:54.411991', '2026-03-26 03:55:54.411991');
INSERT INTO public.task_entries VALUES ('ee722f37-8cf6-4127-ac24-b2523cf7607f', 'af683f2f-fbf3-4f60-b27c-e0135cdd2599', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '11:30:00', '13:30:00', 120, true, '2026-03-25 22:55:54.414', 331, '2026-03-26 03:55:54.415484', '2026-03-26 03:55:54.415484');
INSERT INTO public.task_entries VALUES ('00e7fcfe-523a-49f9-b201-e910ee2bf21d', 'af683f2f-fbf3-4f60-b27c-e0135cdd2599', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '13:30:00', '19:20:00', 590, true, '2026-03-25 22:55:54.419', 332, '2026-03-26 03:55:54.419817', '2026-03-26 03:55:54.419817');
INSERT INTO public.task_entries VALUES ('0f819ba1-b13a-47a0-8cb0-9bb204ae4cd5', 'de666590-8ab0-431e-9bc9-3fa96c6def56', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '10:00:00', '13:10:00', 190, true, '2026-03-25 22:55:54.426', 333, '2026-03-26 03:55:54.426844', '2026-03-26 03:55:54.426844');
INSERT INTO public.task_entries VALUES ('21b49e43-1b4e-4791-b173-283e352fd691', 'de666590-8ab0-431e-9bc9-3fa96c6def56', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '13:10:00', '16:30:00', 310, true, '2026-03-25 22:55:54.429', 334, '2026-03-26 03:55:54.430174', '2026-03-26 03:55:54.430174');
INSERT INTO public.task_entries VALUES ('62915c50-7127-4494-b5ac-be0891289b38', 'de666590-8ab0-431e-9bc9-3fa96c6def56', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '16:30:00', '19:50:00', 480, true, '2026-03-25 22:55:54.433', 335, '2026-03-26 03:55:54.433858', '2026-03-26 03:55:54.433858');
INSERT INTO public.task_entries VALUES ('495f9d02-10af-42d9-8c82-29278396c173', 'e08dff51-fdf4-4222-8ad7-8a5d28439bbf', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '13:00:00', '15:00:00', 120, true, '2026-03-25 22:55:54.441', 336, '2026-03-26 03:55:54.441655', '2026-03-26 03:55:54.441655');
INSERT INTO public.task_entries VALUES ('2101a553-99a1-40c5-8ca5-21584e6e62ae', 'e08dff51-fdf4-4222-8ad7-8a5d28439bbf', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '15:10:00', '17:40:00', 150, true, '2026-03-25 22:55:54.444', 337, '2026-03-26 03:55:54.445008', '2026-03-26 03:55:54.445008');
INSERT INTO public.task_entries VALUES ('716c68b3-87f7-4f46-b506-b756749f886b', 'e08dff51-fdf4-4222-8ad7-8a5d28439bbf', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Abbas MVP', 3, NULL, '17:40:00', '18:52:00', 72, true, '2026-03-25 22:55:54.45', 338, '2026-03-26 03:55:54.451367', '2026-03-26 03:55:54.451367');
INSERT INTO public.task_entries VALUES ('d09bba10-3891-48d7-8cb8-39b5cde586ec', 'e08dff51-fdf4-4222-8ad7-8a5d28439bbf', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '18:52:00', '19:45:00', 53, true, '2026-03-25 22:55:54.454', 339, '2026-03-26 03:55:54.454653', '2026-03-26 03:55:54.454653');
INSERT INTO public.task_entries VALUES ('b616ceb9-7c72-4eef-bad4-e16b09498c4a', '9a782f8f-e745-4361-9912-94d410db0c39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '20:50:00', '02:30:00', 340, true, '2026-03-25 22:55:54.461', 340, '2026-03-26 03:55:54.461755', '2026-03-26 03:55:54.461755');
INSERT INTO public.task_entries VALUES ('2792a507-8b6e-4dc7-843c-e18fd789bc83', '9a782f8f-e745-4361-9912-94d410db0c39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'TDL Review', 3, NULL, '03:00:00', '03:30:00', 30, true, '2026-03-25 22:55:54.464', 341, '2026-03-26 03:55:54.465261', '2026-03-26 03:55:54.465261');
INSERT INTO public.task_entries VALUES ('daa7a734-9028-45a8-bab8-778a66806bac', '9a782f8f-e745-4361-9912-94d410db0c39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 2, NULL, '13:00:00', '16:00:00', 180, true, '2026-03-25 22:55:54.468', 342, '2026-03-26 03:55:54.468755', '2026-03-26 03:55:54.468755');
INSERT INTO public.task_entries VALUES ('349c705a-7c34-4f76-896e-f70a946e9377', '9a782f8f-e745-4361-9912-94d410db0c39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:50:00', '18:10:00', 80, true, '2026-03-25 22:55:54.471', 343, '2026-03-26 03:55:54.472012', '2026-03-26 03:55:54.472012');
INSERT INTO public.task_entries VALUES ('7ffb7014-88dd-4a89-81ae-76005f866b49', '9a782f8f-e745-4361-9912-94d410db0c39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '18:10:00', '06:00:00', 710, true, '2026-03-25 22:55:54.474', 344, '2026-03-26 03:55:54.474836', '2026-03-26 03:55:54.474836');
INSERT INTO public.task_entries VALUES ('ec765b81-42c9-4125-9a2f-e99901d5a882', '0b3c7256-fff1-4777-b740-f8b220201f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Exercise', 3, NULL, '06:00:00', '06:40:00', 40, true, '2026-03-25 22:55:54.482', 345, '2026-03-26 03:55:54.482698', '2026-03-26 03:55:54.482698');
INSERT INTO public.task_entries VALUES ('c7e72031-1bc0-46de-bb92-c08ed39944d5', '0b3c7256-fff1-4777-b740-f8b220201f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:00:00', '18:10:00', 130, true, '2026-03-25 22:55:54.485', 346, '2026-03-26 03:55:54.486111', '2026-03-26 03:55:54.486111');
INSERT INTO public.task_entries VALUES ('c7bbe91e-444d-4b01-ad65-8fc94ba94400', '0b3c7256-fff1-4777-b740-f8b220201f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '18:10:00', '19:30:00', 80, true, '2026-03-25 22:55:54.489', 347, '2026-03-26 03:55:54.489747', '2026-03-26 03:55:54.489747');
INSERT INTO public.task_entries VALUES ('26b0915a-939b-4e04-acdb-a5ef97de7acf', '0b3c7256-fff1-4777-b740-f8b220201f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Book Atomic Habits', 3, NULL, '20:55:00', '23:50:00', 175, true, '2026-03-25 22:55:54.494', 348, '2026-03-26 03:55:54.494862', '2026-03-26 03:55:54.494862');
INSERT INTO public.task_entries VALUES ('9982f4e4-4ff7-448d-b0f6-5ccf90cc5cea', '27bf24ed-2d73-445c-9235-a6b02836be8f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '02:10:00', '06:00:00', 230, true, '2026-03-25 22:55:54.501', 349, '2026-03-26 03:55:54.502205', '2026-03-26 03:55:54.502205');
INSERT INTO public.task_entries VALUES ('6d5558fb-2580-4210-bd47-fe8666904109', '27bf24ed-2d73-445c-9235-a6b02836be8f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:00:00', '05:30:00', 900, true, '2026-03-25 22:55:54.504', 350, '2026-03-26 03:55:54.505414', '2026-03-26 03:55:54.505414');
INSERT INTO public.task_entries VALUES ('7c1b3bcb-d8d0-48f9-a02a-dce90a6b8e58', '27bf24ed-2d73-445c-9235-a6b02836be8f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '17:30:00', '19:20:00', 110, true, '2026-03-25 22:55:54.508', 351, '2026-03-26 03:55:54.508884', '2026-03-26 03:55:54.508884');
INSERT INTO public.task_entries VALUES ('665e01c7-e2e7-40bc-ab1c-fb80ba1412da', '27bf24ed-2d73-445c-9235-a6b02836be8f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Book Atomic Habits', 3, NULL, '21:10:00', '00:00:00', 170, true, '2026-03-25 22:55:54.511', 352, '2026-03-26 03:55:54.512315', '2026-03-26 03:55:54.512315');
INSERT INTO public.task_entries VALUES ('4652ce7a-9eec-472f-ba85-4904fe3252d5', '1b82dee9-63b0-4c10-b3ee-4d2b88dd6808', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '01:00:00', '04:00:00', 250, true, '2026-03-25 22:55:54.518', 353, '2026-03-26 03:55:54.519235', '2026-03-26 03:55:54.519235');
INSERT INTO public.task_entries VALUES ('5c442254-ff00-424f-b965-2fe596069ad5', '1b82dee9-63b0-4c10-b3ee-4d2b88dd6808', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '04:00:00', '04:40:00', 40, true, '2026-03-25 22:55:54.522', 354, '2026-03-26 03:55:54.522887', '2026-03-26 03:55:54.522887');
INSERT INTO public.task_entries VALUES ('687a8f7a-6036-4d73-a687-7dbb171d9c50', '1b82dee9-63b0-4c10-b3ee-4d2b88dd6808', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '06:40:00', '19:40:00', 830, true, '2026-03-25 22:55:54.525', 355, '2026-03-26 03:55:54.526344', '2026-03-26 03:55:54.526344');
INSERT INTO public.task_entries VALUES ('1a14c6c4-c721-4141-96b9-1add1c8120de', '1b82dee9-63b0-4c10-b3ee-4d2b88dd6808', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '23:10:00', 130, true, '2026-03-25 22:55:54.529', 356, '2026-03-26 03:55:54.529781', '2026-03-26 03:55:54.529781');
INSERT INTO public.task_entries VALUES ('ca7f3a4b-e583-4bc8-829b-a788d9b1d6ef', '1b82dee9-63b0-4c10-b3ee-4d2b88dd6808', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Book Atomic Habits', 3, NULL, '23:10:00', '01:45:00', 155, true, '2026-03-25 22:55:54.533', 357, '2026-03-26 03:55:54.534245', '2026-03-26 03:55:54.534245');
INSERT INTO public.task_entries VALUES ('3692e7ba-c5dc-4263-bb96-963876476853', 'ab5a8cec-b237-494a-8206-244ed5382597', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '02:30:00', '04:10:00', 235, true, '2026-03-25 22:55:54.542', 358, '2026-03-26 03:55:54.543164', '2026-03-26 03:55:54.543164');
INSERT INTO public.task_entries VALUES ('6c219709-6fa0-4a15-9e03-63eed3644158', 'ab5a8cec-b237-494a-8206-244ed5382597', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '04:10:00', '04:45:00', 35, true, '2026-03-25 22:55:54.545', 359, '2026-03-26 03:55:54.546441', '2026-03-26 03:55:54.546441');
INSERT INTO public.task_entries VALUES ('9483cf5a-30f2-4208-b45e-49e5dd4cc10e', 'ab5a8cec-b237-494a-8206-244ed5382597', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:30:00', '19:20:00', 50, true, '2026-03-25 22:55:54.549', 360, '2026-03-26 03:55:54.550087', '2026-03-26 03:55:54.550087');
INSERT INTO public.task_entries VALUES ('43341f0d-4c8e-42f3-825e-6f36d046d66f', 'ab5a8cec-b237-494a-8206-244ed5382597', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '19:50:00', '21:40:00', 110, true, '2026-03-25 22:55:54.552', 361, '2026-03-26 03:55:54.553435', '2026-03-26 03:55:54.553435');
INSERT INTO public.task_entries VALUES ('940b3853-bb33-4abb-978e-9a514064dccd', 'ab5a8cec-b237-494a-8206-244ed5382597', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '09:40:00', '01:00:00', 920, true, '2026-03-25 22:55:54.557', 362, '2026-03-26 03:55:54.557777', '2026-03-26 03:55:54.557777');
INSERT INTO public.task_entries VALUES ('507330bc-83ee-4755-89d7-53a580dbadc2', '4b2181e9-2c5f-40a3-82a0-48aad5bdab4d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Automations Learning', 3, NULL, '01:00:00', '04:00:00', 180, true, '2026-03-25 22:55:54.563', 363, '2026-03-26 03:55:54.563859', '2026-03-26 03:55:54.563859');
INSERT INTO public.task_entries VALUES ('9cdf9e3a-eca7-46f0-93bb-ab96f33808cd', '4b2181e9-2c5f-40a3-82a0-48aad5bdab4d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'TDL Review', 3, NULL, '04:00:00', '04:30:00', 30, true, '2026-03-25 22:55:54.566', 364, '2026-03-26 03:55:54.567517', '2026-03-26 03:55:54.567517');
INSERT INTO public.task_entries VALUES ('366455ca-444f-4911-a7cf-412fb1a0df10', '4b2181e9-2c5f-40a3-82a0-48aad5bdab4d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Relexation', 3, NULL, '04:30:00', '07:00:00', 150, true, '2026-03-25 22:55:54.57', 365, '2026-03-26 03:55:54.570917', '2026-03-26 03:55:54.570917');
INSERT INTO public.task_entries VALUES ('d3f41c9d-2887-4005-8e4b-3be67c45f757', '4b2181e9-2c5f-40a3-82a0-48aad5bdab4d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:00:00', '21:20:00', 200, true, '2026-03-25 22:55:54.573', 366, '2026-03-26 03:55:54.574437', '2026-03-26 03:55:54.574437');
INSERT INTO public.task_entries VALUES ('8971a887-537f-4471-a2df-aef2f8ca8ea0', 'c18f13f8-6e05-4770-b10b-51f2008c9a55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:30:00', '00:30:00', 330, true, '2026-03-25 22:55:54.581', 367, '2026-03-26 03:55:54.582293', '2026-03-26 03:55:54.582293');
INSERT INTO public.task_entries VALUES ('ee1daf9a-6049-423e-b1e6-9d004e53936b', 'c18f13f8-6e05-4770-b10b-51f2008c9a55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '96645722-545e-46db-860e-8bea0567d90d', NULL, 'How AI Works From Sorcery', 3, NULL, '00:40:00', '04:00:00', 200, true, '2026-03-25 22:55:54.586', 368, '2026-03-26 03:55:54.58693', '2026-03-26 03:55:54.58693');
INSERT INTO public.task_entries VALUES ('1e4d1aa1-20ec-4697-8943-b25a74599965', 'c18f13f8-6e05-4770-b10b-51f2008c9a55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '05:00:00', '07:10:00', 130, true, '2026-03-25 22:55:54.589', 369, '2026-03-26 03:55:54.590249', '2026-03-26 03:55:54.590249');
INSERT INTO public.task_entries VALUES ('25d2b755-7924-487d-9647-5791ce72c515', 'c18f13f8-6e05-4770-b10b-51f2008c9a55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '07:10:00', '08:30:00', 230, true, '2026-03-25 22:55:54.593', 370, '2026-03-26 03:55:54.593732', '2026-03-26 03:55:54.593732');
INSERT INTO public.task_entries VALUES ('5cab1c08-4216-4f2e-a508-5b000c675b39', 'c0e82c80-62b7-4c90-bc29-40a0bf4670cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '12:30:00', 810, true, '2026-03-25 22:55:54.601', 371, '2026-03-26 03:55:54.602486', '2026-03-26 03:55:54.602486');
INSERT INTO public.task_entries VALUES ('beb036e1-9b45-4f63-a762-e611ea9bbb3c', 'c0e82c80-62b7-4c90-bc29-40a0bf4670cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '01:10:00', '05:00:00', 230, true, '2026-03-25 22:55:54.606', 372, '2026-03-26 03:55:54.606792', '2026-03-26 03:55:54.606792');
INSERT INTO public.task_entries VALUES ('f473b200-74b4-4c45-9749-461210bded8f', 'c0e82c80-62b7-4c90-bc29-40a0bf4670cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Markez', 3, NULL, '21:30:00', '23:00:00', 90, true, '2026-03-25 22:55:54.609', 373, '2026-03-26 03:55:54.610307', '2026-03-26 03:55:54.610307');
INSERT INTO public.task_entries VALUES ('79f2e4a6-9ea6-4956-a165-96e9b47328a0', 'c0e82c80-62b7-4c90-bc29-40a0bf4670cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '23:00:00', '23:30:00', 30, true, '2026-03-25 22:55:54.613', 374, '2026-03-26 03:55:54.613754', '2026-03-26 03:55:54.613754');
INSERT INTO public.task_entries VALUES ('cd3d35ce-5a19-4cf4-a57a-8b69de7d194c', 'c0e82c80-62b7-4c90-bc29-40a0bf4670cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '23:30:00', '00:35:00', 65, true, '2026-03-25 22:55:54.616', 375, '2026-03-26 03:55:54.617255', '2026-03-26 03:55:54.617255');
INSERT INTO public.task_entries VALUES ('4355ed67-c596-477c-b926-3b04dfd27397', 'ca72b88c-f211-48cc-b3f9-5c451316bb57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'How AI Works From Sorcery', 3, NULL, '00:40:00', '04:30:00', 230, true, '2026-03-25 22:55:54.622', 376, '2026-03-26 03:55:54.623441', '2026-03-26 03:55:54.623441');
INSERT INTO public.task_entries VALUES ('5e0f11e0-0abd-4788-8841-993146cdac57', 'ca72b88c-f211-48cc-b3f9-5c451316bb57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:30:00', '05:50:00', 800, true, '2026-03-25 22:55:54.628', 377, '2026-03-26 03:55:54.628517', '2026-03-26 03:55:54.628517');
INSERT INTO public.task_entries VALUES ('c3fe6376-5da0-4ddc-ac10-6342222693c6', 'ca72b88c-f211-48cc-b3f9-5c451316bb57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '06:30:00', '10:30:00', 240, true, '2026-03-25 22:55:54.631', 378, '2026-03-26 03:55:54.632011', '2026-03-26 03:55:54.632011');
INSERT INTO public.task_entries VALUES ('4584f4f8-aff6-4333-9875-8dd2888cc82d', 'ea1749ce-86c9-4a9c-af77-3ec0791e275e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '13:45:00', 1215, true, '2026-03-25 22:55:54.638', 379, '2026-03-26 03:55:54.639508', '2026-03-26 03:55:54.639508');
INSERT INTO public.task_entries VALUES ('c6cf0d7f-1f42-45c6-92bb-387f05e382de', 'ea1749ce-86c9-4a9c-af77-3ec0791e275e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Expense Calculation', 3, NULL, '13:45:00', '03:30:00', 825, true, '2026-03-25 22:55:54.643', 380, '2026-03-26 03:55:54.643546', '2026-03-26 03:55:54.643546');
INSERT INTO public.task_entries VALUES ('5e7be0a2-daaa-47f2-93c7-e142ad5cd3c5', 'ea1749ce-86c9-4a9c-af77-3ec0791e275e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Mdeical Checkup', 3, NULL, '13:00:00', '18:00:00', 300, true, '2026-03-25 22:55:54.646', 381, '2026-03-26 03:55:54.64726', '2026-03-26 03:55:54.64726');
INSERT INTO public.task_entries VALUES ('ee365be8-5553-4a28-b6a2-ad828898a1d7', '15e2a6d4-ee90-48a8-89ad-d34bd3fca6db', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '02:10:00', 250, true, '2026-03-25 22:55:54.914', 382, '2026-03-26 03:55:54.915239', '2026-03-26 03:55:54.915239');
INSERT INTO public.task_entries VALUES ('c30479b3-e785-4381-843d-727ea0c07302', '15e2a6d4-ee90-48a8-89ad-d34bd3fca6db', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Slipssy', 3, NULL, '02:10:00', '06:10:00', 240, true, '2026-03-25 22:55:54.92', 383, '2026-03-26 03:55:54.921319', '2026-03-26 03:55:54.921319');
INSERT INTO public.task_entries VALUES ('b954ab52-d9c7-43cb-8c6b-1aef9d567302', '15e2a6d4-ee90-48a8-89ad-d34bd3fca6db', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Hunter', 3, NULL, '08:10:00', '09:30:00', 80, true, '2026-03-25 22:55:54.926', 384, '2026-03-26 03:55:54.92652', '2026-03-26 03:55:54.92652');
INSERT INTO public.task_entries VALUES ('2ee3f957-5b14-4c9e-a599-28db50c36693', '1dad45bb-22e8-4545-a13e-b39faa90191f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '02:10:00', 370, true, '2026-03-25 22:55:54.937', 385, '2026-03-26 03:55:54.938025', '2026-03-26 03:55:54.938025');
INSERT INTO public.task_entries VALUES ('1342cf7b-24ee-4e72-ab37-26b3625f597a', '1dad45bb-22e8-4545-a13e-b39faa90191f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Hunter', 3, NULL, '06:00:00', '07:15:00', 75, true, '2026-03-25 22:55:54.944', 386, '2026-03-26 03:55:54.944916', '2026-03-26 03:55:54.944916');
INSERT INTO public.task_entries VALUES ('77b4635f-947f-47b0-ab4b-b4cb6cb6313d', '1d3b56fe-5747-4dc0-9399-cdb402a652b8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '04:00:00', '09:15:00', 405, true, '2026-03-25 22:55:54.953', 387, '2026-03-26 03:55:54.953968', '2026-03-26 03:55:54.953968');
INSERT INTO public.task_entries VALUES ('e8edb911-a5b7-46c6-806e-f1e1647d8030', '1d3b56fe-5747-4dc0-9399-cdb402a652b8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Slipssy', 3, NULL, '09:15:00', '10:30:00', 75, true, '2026-03-25 22:55:54.958', 388, '2026-03-26 03:55:54.958968', '2026-03-26 03:55:54.958968');
INSERT INTO public.task_entries VALUES ('6ceb47a1-5669-403b-bf42-99a53c584fe4', '1d3b56fe-5747-4dc0-9399-cdb402a652b8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni', 3, NULL, '12:20:00', '18:00:00', 340, true, '2026-03-25 22:55:54.963', 389, '2026-03-26 03:55:54.963999', '2026-03-26 03:55:54.963999');
INSERT INTO public.task_entries VALUES ('a7000289-1b1f-45a7-a765-e26b07716ccb', '72b0e73a-1f86-4162-8420-8d3b7e111830', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '08:00:00', '10:00:00', 120, true, '2026-03-25 22:55:54.97', 390, '2026-03-26 03:55:54.971033', '2026-03-26 03:55:54.971033');
INSERT INTO public.task_entries VALUES ('0287012a-cb78-4b6d-a56c-3c7c8e1ab3eb', '72b0e73a-1f86-4162-8420-8d3b7e111830', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni', 3, NULL, '10:00:00', '18:30:00', 510, true, '2026-03-25 22:55:54.974', 391, '2026-03-26 03:55:54.974735', '2026-03-26 03:55:54.974735');
INSERT INTO public.task_entries VALUES ('85c3275d-9109-4d00-9316-46b162bfb224', '1cae38a1-6df4-4870-a43b-cbb1cc656f13', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '07:00:00', '12:30:00', 330, true, '2026-03-25 22:55:54.981', 392, '2026-03-26 03:55:54.982665', '2026-03-26 03:55:54.982665');
INSERT INTO public.task_entries VALUES ('8d5c686b-971d-4214-8ad0-622ba2b2426f', '1cae38a1-6df4-4870-a43b-cbb1cc656f13', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni Library', 3, NULL, '13:00:00', '15:30:00', 150, true, '2026-03-25 22:55:54.985', 393, '2026-03-26 03:55:54.985944', '2026-03-26 03:55:54.985944');
INSERT INTO public.task_entries VALUES ('8ecbb728-1fc1-42c0-bde8-07a2bb679ba8', '1cae38a1-6df4-4870-a43b-cbb1cc656f13', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:30:00', '16:50:00', 80, true, '2026-03-25 22:55:54.988', 394, '2026-03-26 03:55:54.989507', '2026-03-26 03:55:54.989507');
INSERT INTO public.task_entries VALUES ('2cf3a728-f85c-4443-a296-acbfb76a0ca2', '1cae38a1-6df4-4870-a43b-cbb1cc656f13', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:50:00', '18:10:00', 80, true, '2026-03-25 22:55:54.992', 395, '2026-03-26 03:55:54.993079', '2026-03-26 03:55:54.993079');
INSERT INTO public.task_entries VALUES ('d1ee069d-7b9e-4478-ab78-93a2e8349e36', '1cae38a1-6df4-4870-a43b-cbb1cc656f13', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '19:40:00', '21:30:00', 110, true, '2026-03-25 22:55:54.997', 396, '2026-03-26 03:55:54.998523', '2026-03-26 03:55:54.998523');
INSERT INTO public.task_entries VALUES ('d72f4c6e-1c7f-49da-b76d-7106f31e5a11', 'ff8c7de5-3c57-4457-abba-4213398d0b88', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '08:00:00', '09:00:00', 110, true, '2026-03-25 22:55:55.004', 397, '2026-03-26 03:55:55.005105', '2026-03-26 03:55:55.005105');
INSERT INTO public.task_entries VALUES ('0acde871-f723-4d02-bda5-8c1268c76e0d', 'ff8c7de5-3c57-4457-abba-4213398d0b88', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '09:20:00', '11:50:00', 150, true, '2026-03-25 22:55:55.008', 398, '2026-03-26 03:55:55.008637', '2026-03-26 03:55:55.008637');
INSERT INTO public.task_entries VALUES ('2750a3b6-7b89-4d82-a821-b38bad9eefe9', 'ff8c7de5-3c57-4457-abba-4213398d0b88', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '11:50:00', '14:10:00', 230, true, '2026-03-25 22:55:55.011', 399, '2026-03-26 03:55:55.012229', '2026-03-26 03:55:55.012229');
INSERT INTO public.task_entries VALUES ('d3b79d50-6cda-4a6a-a5bf-a7fd54411eb6', 'ff8c7de5-3c57-4457-abba-4213398d0b88', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '16:30:00', '20:45:00', 255, true, '2026-03-25 22:55:55.015', 400, '2026-03-26 03:55:55.015777', '2026-03-26 03:55:55.015777');
INSERT INTO public.task_entries VALUES ('e0bfde11-ef32-43c7-91e4-94320ab15931', 'ff8c7de5-3c57-4457-abba-4213398d0b88', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '21:30:00', '23:35:00', 125, true, '2026-03-25 22:55:55.018', 401, '2026-03-26 03:55:55.019316', '2026-03-26 03:55:55.019316');
INSERT INTO public.task_entries VALUES ('50364d49-6b22-4e88-b695-d17df1321e57', '84c1b9b8-4014-4cb2-ad6d-017587509624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '07:30:00', '12:00:00', 690, true, '2026-03-25 22:55:55.025', 402, '2026-03-26 03:55:55.026285', '2026-03-26 03:55:55.026285');
INSERT INTO public.task_entries VALUES ('754ce075-8c53-4742-86f8-0357306a67ab', '84c1b9b8-4014-4cb2-ad6d-017587509624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Bike Repair', 3, NULL, '14:00:00', '18:00:00', 240, true, '2026-03-25 22:55:55.029', 403, '2026-03-26 03:55:55.029494', '2026-03-26 03:55:55.029494');
INSERT INTO public.task_entries VALUES ('2819f3e1-100e-4a1c-8906-1045e873cb6b', '84c1b9b8-4014-4cb2-ad6d-017587509624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, NULL, NULL, NULL, true, '2026-03-25 22:55:55.031', 404, '2026-03-26 03:55:55.032363', '2026-03-26 03:55:55.032363');
INSERT INTO public.task_entries VALUES ('5e653075-17ae-495a-9678-ae5b545807f1', '97e4ad78-17a8-4ee1-8231-50a23ea1a75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:30:00', '20:30:00', 200, true, '2026-03-25 22:55:55.04', 405, '2026-03-26 03:55:55.041152', '2026-03-26 03:55:55.041152');
INSERT INTO public.task_entries VALUES ('27bb63fd-bc15-4c57-8c5c-02c821b5ca8e', '97e4ad78-17a8-4ee1-8231-50a23ea1a75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '14:00:00', '17:00:00', 180, true, '2026-03-25 22:55:55.044', 406, '2026-03-26 03:55:55.044675', '2026-03-26 03:55:55.044675');
INSERT INTO public.task_entries VALUES ('80d12699-39e1-4e6f-843f-513110475c1c', '97e4ad78-17a8-4ee1-8231-50a23ea1a75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Hunter', 3, NULL, '17:00:00', '17:30:00', 30, true, '2026-03-25 22:55:55.047', 407, '2026-03-26 03:55:55.048232', '2026-03-26 03:55:55.048232');
INSERT INTO public.task_entries VALUES ('19167108-7f41-4836-bde3-83a2a82e8826', '97e4ad78-17a8-4ee1-8231-50a23ea1a75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '17:30:00', '19:15:00', 105, true, '2026-03-25 22:55:55.051', 408, '2026-03-26 03:55:55.052508', '2026-03-26 03:55:55.052508');
INSERT INTO public.task_entries VALUES ('993d7173-9c2e-4042-aeed-5c5750732b52', '97e4ad78-17a8-4ee1-8231-50a23ea1a75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Framer Film Test Project', 3, NULL, '20:30:00', '22:50:00', 140, true, '2026-03-25 22:55:55.058', 409, '2026-03-26 03:55:55.059318', '2026-03-26 03:55:55.059318');
INSERT INTO public.task_entries VALUES ('0cc2f791-b8e9-4f1b-bf18-181f3bf6afbe', 'e2763731-7b85-4710-a0cc-58ead1bf87d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '13:50:00', '02:30:00', 760, true, '2026-03-25 22:55:55.066', 410, '2026-03-26 03:55:55.067392', '2026-03-26 03:55:55.067392');
INSERT INTO public.task_entries VALUES ('fdeb9de2-a3e6-49bd-8efc-ef403826fc98', 'e2763731-7b85-4710-a0cc-58ead1bf87d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '09:50:00', 970, true, '2026-03-25 22:55:55.071', 411, '2026-03-26 03:55:55.071677', '2026-03-26 03:55:55.071677');
INSERT INTO public.task_entries VALUES ('9b8ae608-2c5f-4182-b1ec-27fc8d40f033', 'e2763731-7b85-4710-a0cc-58ead1bf87d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '09:50:00', '13:30:00', 220, true, '2026-03-25 22:55:55.074', 412, '2026-03-26 03:55:55.075026', '2026-03-26 03:55:55.075026');
INSERT INTO public.task_entries VALUES ('c05ed5c9-754a-4c6c-a861-9528beeafeba', 'e2763731-7b85-4710-a0cc-58ead1bf87d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '15:50:00', '17:10:00', 80, true, '2026-03-25 22:55:55.077', 413, '2026-03-26 03:55:55.078454', '2026-03-26 03:55:55.078454');
INSERT INTO public.task_entries VALUES ('0fc7a406-1933-46ae-a3bc-6b1053e22ebb', 'e2763731-7b85-4710-a0cc-58ead1bf87d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'How AI Works From Sorcery', 3, NULL, '17:30:00', '20:30:00', 245, true, '2026-03-25 22:55:55.081', 414, '2026-03-26 03:55:55.082194', '2026-03-26 03:55:55.082194');
INSERT INTO public.task_entries VALUES ('11898b34-1c89-455c-bb82-a6d87c8c2019', 'e2763731-7b85-4710-a0cc-58ead1bf87d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '22:05:00', '23:15:00', 70, true, '2026-03-25 22:55:55.084', 415, '2026-03-26 03:55:55.085555', '2026-03-26 03:55:55.085555');
INSERT INTO public.task_entries VALUES ('9c2a71ca-43f5-4142-843c-5538a9f4c2fe', '592a6f3d-62cb-4e19-85c4-d60c7c44f859', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '11:30:00', '13:15:00', 165, true, '2026-03-25 22:55:55.091', 416, '2026-03-26 03:55:55.091619', '2026-03-26 03:55:55.091619');
INSERT INTO public.task_entries VALUES ('528244e0-f047-44d7-a349-5c097e0740ff', '592a6f3d-62cb-4e19-85c4-d60c7c44f859', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '13:15:00', '15:50:00', 155, true, '2026-03-25 22:55:55.094', 417, '2026-03-26 03:55:55.095215', '2026-03-26 03:55:55.095215');
INSERT INTO public.task_entries VALUES ('792ac169-d0f3-4ffa-99b2-ea2a94f96c2f', '592a6f3d-62cb-4e19-85c4-d60c7c44f859', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Abbas MVP', 3, NULL, '16:00:00', '19:00:00', 180, true, '2026-03-25 22:55:55.098', 418, '2026-03-26 03:55:55.098761', '2026-03-26 03:55:55.098761');
INSERT INTO public.task_entries VALUES ('aa8d8d10-5c35-4311-b8c6-106830080c78', '592a6f3d-62cb-4e19-85c4-d60c7c44f859', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '23:00:00', '02:00:00', 180, true, '2026-03-25 22:55:55.101', 419, '2026-03-26 03:55:55.102479', '2026-03-26 03:55:55.102479');
INSERT INTO public.task_entries VALUES ('0700d971-1172-456e-b148-86bbc39a393e', 'ca17c7c8-6796-4bb7-8dd4-ca06f796fd50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '02:00:00', '02:40:00', 40, true, '2026-03-25 22:55:55.108', 420, '2026-03-26 03:55:55.109534', '2026-03-26 03:55:55.109534');
INSERT INTO public.task_entries VALUES ('e525888a-28c9-471a-8880-3a70ba79091f', 'ca17c7c8-6796-4bb7-8dd4-ca06f796fd50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni', 3, NULL, '12:30:00', '19:00:00', 390, true, '2026-03-25 22:55:55.112', 421, '2026-03-26 03:55:55.112775', '2026-03-26 03:55:55.112775');
INSERT INTO public.task_entries VALUES ('0af9a54e-2a9a-4dba-aeb4-fc42c21fe651', 'ca17c7c8-6796-4bb7-8dd4-ca06f796fd50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '19:30:00', '22:30:00', 180, true, '2026-03-25 22:55:55.115', 422, '2026-03-26 03:55:55.116148', '2026-03-26 03:55:55.116148');
INSERT INTO public.task_entries VALUES ('8c1885e9-3cff-48cf-9872-76e0a71d6eab', 'd73e1ea2-3157-4b7f-9e6e-e4ffb7985e43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni', 3, NULL, '12:00:00', '18:00:00', 360, true, '2026-03-25 22:55:55.122', 423, '2026-03-26 03:55:55.123159', '2026-03-26 03:55:55.123159');
INSERT INTO public.task_entries VALUES ('1250cd0c-bf16-4399-bf8b-f64938dba8a1', 'd73e1ea2-3157-4b7f-9e6e-e4ffb7985e43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:00:00', '22:40:00', 280, true, '2026-03-25 22:55:55.126', 424, '2026-03-26 03:55:55.126589', '2026-03-26 03:55:55.126589');
INSERT INTO public.task_entries VALUES ('e53c4201-c8cf-4a25-9393-348cd9041cc8', 'd73e1ea2-3157-4b7f-9e6e-e4ffb7985e43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Projects management', 3, NULL, '22:40:00', '23:30:00', 50, true, '2026-03-25 22:55:55.131', 425, '2026-03-26 03:55:55.131977', '2026-03-26 03:55:55.131977');
INSERT INTO public.task_entries VALUES ('dbe054e9-539f-46e9-a150-37d78ef0fcb0', 'd73e1ea2-3157-4b7f-9e6e-e4ffb7985e43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:40:00', '02:05:00', 205, true, '2026-03-25 22:55:55.134', 426, '2026-03-26 03:55:55.135336', '2026-03-26 03:55:55.135336');
INSERT INTO public.task_entries VALUES ('72143351-dbb1-4f12-a9aa-511609bdd7e5', 'd73e1ea2-3157-4b7f-9e6e-e4ffb7985e43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '02:05:00', '03:00:00', 55, true, '2026-03-25 22:55:55.138', 427, '2026-03-26 03:55:55.138813', '2026-03-26 03:55:55.138813');
INSERT INTO public.task_entries VALUES ('57118e1f-b7dc-4e95-be7c-0d8d65b883da', '502e4c0a-83cc-4186-b80e-b908bcbcf0c6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni', 3, NULL, '08:00:00', '17:30:00', 570, true, '2026-03-25 22:55:55.145', 428, '2026-03-26 03:55:55.145707', '2026-03-26 03:55:55.145707');
INSERT INTO public.task_entries VALUES ('fc719efb-d6f0-4c99-a9b2-2b9bc00bfd11', '502e4c0a-83cc-4186-b80e-b908bcbcf0c6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Bazaar', 3, NULL, '17:30:00', '20:00:00', 150, true, '2026-03-25 22:55:55.149', 429, '2026-03-26 03:55:55.150216', '2026-03-26 03:55:55.150216');
INSERT INTO public.task_entries VALUES ('075d549e-5d92-4344-8cc8-aa525de8ebcb', '502e4c0a-83cc-4186-b80e-b908bcbcf0c6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '22:40:00', 160, true, '2026-03-25 22:55:55.153', 430, '2026-03-26 03:55:55.154236', '2026-03-26 03:55:55.154236');
INSERT INTO public.task_entries VALUES ('38dc432a-608a-4bb0-977e-d69993bc1173', 'cd568725-9a09-4948-87e9-ec720b87602b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '12:00:00', '13:00:00', 60, true, '2026-03-25 22:55:55.383', 431, '2026-03-26 03:55:55.384488', '2026-03-26 03:55:55.384488');
INSERT INTO public.task_entries VALUES ('8d6293ef-c12a-4d32-8804-769e356833ed', 'cd568725-9a09-4948-87e9-ec720b87602b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'PC Setup', 3, NULL, '13:00:00', '15:00:00', 120, true, '2026-03-25 22:55:55.387', 432, '2026-03-26 03:55:55.387996', '2026-03-26 03:55:55.387996');
INSERT INTO public.task_entries VALUES ('d086d864-3f53-47af-8719-08787da1e54c', 'cd568725-9a09-4948-87e9-ec720b87602b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '16:00:00', 150, true, '2026-03-25 22:55:55.39', 433, '2026-03-26 03:55:55.39145', '2026-03-26 03:55:55.39145');
INSERT INTO public.task_entries VALUES ('97e3b677-154d-4314-8802-8afc88635169', 'cd568725-9a09-4948-87e9-ec720b87602b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:00:00', '17:40:00', 245, true, '2026-03-25 22:55:55.396', 434, '2026-03-26 03:55:55.397306', '2026-03-26 03:55:55.397306');
INSERT INTO public.task_entries VALUES ('2aab4236-216f-4e12-9f0b-3f95f8c484ae', 'cd568725-9a09-4948-87e9-ec720b87602b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Blue Bill', 3, NULL, '17:40:00', '17:50:00', 10, true, '2026-03-25 22:55:55.399', 435, '2026-03-26 03:55:55.400513', '2026-03-26 03:55:55.400513');
INSERT INTO public.task_entries VALUES ('0b73a0e8-c023-4c2b-b5bd-7f1833cb2e33', 'e42f153f-c5e0-4ec1-95cb-8b35f3df76b6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '00:00:00', '03:00:00', 180, true, '2026-03-25 22:55:55.406', 436, '2026-03-26 03:55:55.407107', '2026-03-26 03:55:55.407107');
INSERT INTO public.task_entries VALUES ('ccc0da53-a57a-4198-8d42-a4ae23d0fa31', 'e42f153f-c5e0-4ec1-95cb-8b35f3df76b6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '03:00:00', '03:30:00', 30, true, '2026-03-25 22:55:55.41', 437, '2026-03-26 03:55:55.41057', '2026-03-26 03:55:55.41057');
INSERT INTO public.task_entries VALUES ('b7ca2f88-b13d-4740-b98b-65c72395c274', 'e42f153f-c5e0-4ec1-95cb-8b35f3df76b6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '12:00:00', '14:00:00', 120, true, '2026-03-25 22:55:55.413', 438, '2026-03-26 03:55:55.414409', '2026-03-26 03:55:55.414409');
INSERT INTO public.task_entries VALUES ('857d0f7a-2953-4bf0-b2b3-45ffb2e68b63', 'e42f153f-c5e0-4ec1-95cb-8b35f3df76b6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '17:30:00', 480, true, '2026-03-25 22:55:55.418', 439, '2026-03-26 03:55:55.418728', '2026-03-26 03:55:55.418728');
INSERT INTO public.task_entries VALUES ('78dec70d-a3b5-4538-bd76-cde3198c98ef', '53e9761f-1604-4446-a550-bf0db17487d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:20:00', '03:00:00', 100, true, '2026-03-25 22:55:55.425', 440, '2026-03-26 03:55:55.426454', '2026-03-26 03:55:55.426454');
INSERT INTO public.task_entries VALUES ('56a46878-8916-4c31-a2f1-d677a3539d72', '53e9761f-1604-4446-a550-bf0db17487d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '03:00:00', '03:30:00', 30, true, '2026-03-25 22:55:55.429', 441, '2026-03-26 03:55:55.429703', '2026-03-26 03:55:55.429703');
INSERT INTO public.task_entries VALUES ('1dccfa21-6fdc-4bb1-9ca7-c3537b05493b', '53e9761f-1604-4446-a550-bf0db17487d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Uni', 3, NULL, '07:00:00', '14:30:00', 450, true, '2026-03-25 22:55:55.432', 442, '2026-03-26 03:55:55.433402', '2026-03-26 03:55:55.433402');
INSERT INTO public.task_entries VALUES ('c7700f6b-3982-435e-b11a-6dd13338c364', '53e9761f-1604-4446-a550-bf0db17487d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc Library', 3, NULL, '15:00:00', '15:30:00', 60, true, '2026-03-25 22:55:55.438', 443, '2026-03-26 03:55:55.43856', '2026-03-26 03:55:55.43856');
INSERT INTO public.task_entries VALUES ('d7476192-61f9-4ac6-8f1b-398c7245f806', '53e9761f-1604-4446-a550-bf0db17487d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '21:35:00', 95, true, '2026-03-25 22:55:55.441', 444, '2026-03-26 03:55:55.44245', '2026-03-26 03:55:55.44245');
INSERT INTO public.task_entries VALUES ('2539e725-e47d-45ec-b027-38c95158374c', '53e9761f-1604-4446-a550-bf0db17487d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '20:00:00', '21:35:00', 95, true, '2026-03-25 22:55:55.445', 445, '2026-03-26 03:55:55.445976', '2026-03-26 03:55:55.445976');
INSERT INTO public.task_entries VALUES ('8252c72a-b014-44fa-ae9b-0372af83bc58', '061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '03:35:00', 650, true, '2026-03-25 22:55:55.452', 446, '2026-03-26 03:55:55.452711', '2026-03-26 03:55:55.452711');
INSERT INTO public.task_entries VALUES ('6781e29e-2ef8-4c06-96b3-f88ba84508c1', '061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'OT', 1, NULL, '10:00:00', '12:00:00', 120, true, '2026-03-25 22:55:55.455', 447, '2026-03-26 03:55:55.455987', '2026-03-26 03:55:55.455987');
INSERT INTO public.task_entries VALUES ('a1d03785-4f59-40a2-85b2-726abe0e6cb6', '061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '12:00:00', '15:00:00', 290, true, '2026-03-25 22:55:55.458', 448, '2026-03-26 03:55:55.459499', '2026-03-26 03:55:55.459499');
INSERT INTO public.task_entries VALUES ('0450d17a-f1aa-47f4-8d3f-0dd73a665f32', '061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '15:00:00', '16:40:00', 100, true, '2026-03-25 22:55:55.462', 449, '2026-03-26 03:55:55.462941', '2026-03-26 03:55:55.462941');
INSERT INTO public.task_entries VALUES ('67899d4e-6da6-4a95-8d79-fda06cdec7b6', '061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Meeting with Peter', 3, NULL, '20:05:00', '20:40:00', 35, true, '2026-03-25 22:55:55.466', 450, '2026-03-26 03:55:55.467507', '2026-03-26 03:55:55.467507');
INSERT INTO public.task_entries VALUES ('d9fe1453-6e87-41b7-954d-3f0ab0a77f48', '061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'How AI Works From Sorcery', 3, NULL, '21:30:00', '12:15:00', 885, true, '2026-03-25 22:55:55.47', 451, '2026-03-26 03:55:55.470758', '2026-03-26 03:55:55.470758');
INSERT INTO public.task_entries VALUES ('f20e6163-cd30-4aed-9b6d-f67eca83ffb9', '061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '01:30:00', '03:30:00', 120, true, '2026-03-25 22:55:55.475', 452, '2026-03-26 03:55:55.476143', '2026-03-26 03:55:55.476143');
INSERT INTO public.task_entries VALUES ('ab4637f6-192d-4b4f-b258-dccc4bfe3ca5', '061641a2-33e7-4bc4-9d4c-4d97b40651e3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '03:30:00', '04:00:00', 30, true, '2026-03-25 22:55:55.479', 453, '2026-03-26 03:55:55.479497', '2026-03-26 03:55:55.479497');
INSERT INTO public.task_entries VALUES ('0f03fcb3-8884-4e24-8720-81153206d918', '6a360cb2-1f2a-4ad0-af29-19643c5abed0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'OT', 1, NULL, '10:30:00', '12:00:00', 90, true, '2026-03-25 22:55:55.485', 454, '2026-03-26 03:55:55.485759', '2026-03-26 03:55:55.485759');
INSERT INTO public.task_entries VALUES ('73230e33-0c62-474d-9853-402dcabd6a08', '6a360cb2-1f2a-4ad0-af29-19643c5abed0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '12:00:00', '18:30:00', 390, true, '2026-03-25 22:55:55.489', 455, '2026-03-26 03:55:55.490166', '2026-03-26 03:55:55.490166');
INSERT INTO public.task_entries VALUES ('5aafa6ff-edd7-40d5-bb85-5f1c74bf5566', '6a360cb2-1f2a-4ad0-af29-19643c5abed0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '22:40:00', 210, true, '2026-03-25 22:55:55.493', 456, '2026-03-26 03:55:55.493739', '2026-03-26 03:55:55.493739');
INSERT INTO public.task_entries VALUES ('e5d54d2e-b929-463a-a895-acc081d24318', '6a360cb2-1f2a-4ad0-af29-19643c5abed0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Meeting with Peter', 3, NULL, '22:40:00', '22:50:00', 10, true, '2026-03-25 22:55:55.496', 457, '2026-03-26 03:55:55.496995', '2026-03-26 03:55:55.496995');
INSERT INTO public.task_entries VALUES ('1dddcc7b-c96e-4449-98a6-efa80e68055c', '6a360cb2-1f2a-4ad0-af29-19643c5abed0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:50:00', '00:30:00', 100, true, '2026-03-25 22:55:55.5', 458, '2026-03-26 03:55:55.500621', '2026-03-26 03:55:55.500621');
INSERT INTO public.task_entries VALUES ('65e42c19-c48b-422c-af15-60b5e878dc2f', '57775460-5746-4937-9314-939477fe1b4e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'RAG assignment', 3, NULL, '00:50:00', '05:30:00', 280, true, '2026-03-25 22:55:55.507', 459, '2026-03-26 03:55:55.507583', '2026-03-26 03:55:55.507583');
INSERT INTO public.task_entries VALUES ('c4a117a9-f76a-4c68-9c99-e1fbe73fb8d9', '57775460-5746-4937-9314-939477fe1b4e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '05:30:00', '06:20:00', 230, true, '2026-03-25 22:55:55.51', 460, '2026-03-26 03:55:55.51102', '2026-03-26 03:55:55.51102');
INSERT INTO public.task_entries VALUES ('2cdf495b-ee50-4597-adb3-cab40ee7d573', '57775460-5746-4937-9314-939477fe1b4e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '07:00:00', '10:00:00', 180, true, '2026-03-25 22:55:55.514', 461, '2026-03-26 03:55:55.514554', '2026-03-26 03:55:55.514554');
INSERT INTO public.task_entries VALUES ('e46276af-b2f7-49b3-8803-0dc2b27848b3', '57775460-5746-4937-9314-939477fe1b4e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'OT', 1, NULL, '16:00:00', '19:30:00', 210, true, '2026-03-25 22:55:55.519', 462, '2026-03-26 03:55:55.519951', '2026-03-26 03:55:55.519951');
INSERT INTO public.task_entries VALUES ('aeac7f4d-6f51-4f00-af7c-87294d0295d0', '57775460-5746-4937-9314-939477fe1b4e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:30:00', '23:10:00', 40, true, '2026-03-25 22:55:55.522', 463, '2026-03-26 03:55:55.523346', '2026-03-26 03:55:55.523346');
INSERT INTO public.task_entries VALUES ('97550d84-64a4-4ae4-91f0-83434c248e87', '1f797a43-523a-4776-a829-6420190ff903', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:10:00', '01:10:00', 240, true, '2026-03-25 22:55:55.53', 464, '2026-03-26 03:55:55.531267', '2026-03-26 03:55:55.531267');
INSERT INTO public.task_entries VALUES ('fd9ba553-f079-4ee1-8905-28268a811212', '1f797a43-523a-4776-a829-6420190ff903', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:40:00', '04:05:00', 1095, true, '2026-03-25 22:55:55.534', 465, '2026-03-26 03:55:55.53471', '2026-03-26 03:55:55.53471');
INSERT INTO public.task_entries VALUES ('e56bea3a-001e-44eb-8d7c-e6e7aa3f639b', '1f797a43-523a-4776-a829-6420190ff903', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '04:20:00', '04:40:00', 20, true, '2026-03-25 22:55:55.537', 466, '2026-03-26 03:55:55.538054', '2026-03-26 03:55:55.538054');
INSERT INTO public.task_entries VALUES ('35699090-56a5-4fb8-a797-fda72752d49b', '539e1876-db5e-4a7c-9ed2-5bbc9b5d1010', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '00:00:00', '06:30:00', 390, true, '2026-03-25 22:55:55.544', 467, '2026-03-26 03:55:55.545282', '2026-03-26 03:55:55.545282');
INSERT INTO public.task_entries VALUES ('2ead7432-0828-41a4-b11a-cfc90fee0098', '539e1876-db5e-4a7c-9ed2-5bbc9b5d1010', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Excercise', 3, NULL, '06:30:00', '07:15:00', 45, true, '2026-03-25 22:55:55.548', 468, '2026-03-26 03:55:55.548649', '2026-03-26 03:55:55.548649');
INSERT INTO public.task_entries VALUES ('050e3531-3e15-45e3-99b2-a90458c4fcae', '539e1876-db5e-4a7c-9ed2-5bbc9b5d1010', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Never split the difference', 3, NULL, '07:15:00', '09:05:00', 110, true, '2026-03-25 22:55:55.551', 469, '2026-03-26 03:55:55.552056', '2026-03-26 03:55:55.552056');
INSERT INTO public.task_entries VALUES ('7bfba8d8-9332-4904-b0cb-5de897993250', '539e1876-db5e-4a7c-9ed2-5bbc9b5d1010', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '00:00:00', 120, true, '2026-03-25 22:55:55.555', 470, '2026-03-26 03:55:55.555601', '2026-03-26 03:55:55.555601');
INSERT INTO public.task_entries VALUES ('9293eed9-1c9a-4c64-abbb-4ce6dfb61465', 'cea0ee2c-a983-417d-92b8-05ceb319e2f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '00:00:00', '02:05:00', 125, true, '2026-03-25 22:55:55.563', 471, '2026-03-26 03:55:55.564464', '2026-03-26 03:55:55.564464');
INSERT INTO public.task_entries VALUES ('446a2407-749f-4b7f-a5c7-e1e77fbb56b0', 'cea0ee2c-a983-417d-92b8-05ceb319e2f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '02:05:00', '07:00:00', 295, true, '2026-03-25 22:55:55.567', 472, '2026-03-26 03:55:55.567821', '2026-03-26 03:55:55.567821');
INSERT INTO public.task_entries VALUES ('be045270-47b5-4d45-a9d0-0be24acf83b7', 'cea0ee2c-a983-417d-92b8-05ceb319e2f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '07:00:00', '12:00:00', 420, true, '2026-03-25 22:55:55.571', 473, '2026-03-26 03:55:55.572089', '2026-03-26 03:55:55.572089');
INSERT INTO public.task_entries VALUES ('9afe95fb-79ed-4976-b10e-6d90f828364c', 'cea0ee2c-a983-417d-92b8-05ceb319e2f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:00:00', '21:00:00', 120, true, '2026-03-25 22:55:55.574', 474, '2026-03-26 03:55:55.574868', '2026-03-26 03:55:55.574868');
INSERT INTO public.task_entries VALUES ('ac538b52-6f5e-4e57-a96d-31f00511319a', 'cea0ee2c-a983-417d-92b8-05ceb319e2f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '21:30:00', '12:40:00', 910, true, '2026-03-25 22:55:55.577', 475, '2026-03-26 03:55:55.578274', '2026-03-26 03:55:55.578274');
INSERT INTO public.task_entries VALUES ('2a5df494-ec4d-4fcb-bb31-5d912eebfd2d', '2e350eef-d7b6-4198-9e24-07fce9ffa1fe', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '00:50:00', '04:00:00', 190, true, '2026-03-25 22:55:55.584', 476, '2026-03-26 03:55:55.585485', '2026-03-26 03:55:55.585485');
INSERT INTO public.task_entries VALUES ('1c7aaab2-dee2-469e-aa85-49a4e7ff1eb6', '2e350eef-d7b6-4198-9e24-07fce9ffa1fe', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '04:00:00', '08:00:00', 390, true, '2026-03-25 22:55:55.588', 477, '2026-03-26 03:55:55.588772', '2026-03-26 03:55:55.588772');
INSERT INTO public.task_entries VALUES ('274e5bdc-59f7-4c13-80bc-c7736847b67b', '2e350eef-d7b6-4198-9e24-07fce9ffa1fe', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '21:00:00', '23:30:00', 150, true, '2026-03-25 22:55:55.591', 478, '2026-03-26 03:55:55.592333', '2026-03-26 03:55:55.592333');
INSERT INTO public.task_entries VALUES ('ba0bc2c3-cf7e-467b-87d5-013dca9e67cc', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'DMS Assignment', 3, NULL, '23:30:00', '00:30:00', 60, true, '2026-03-25 22:55:55.597', 479, '2026-03-26 03:55:55.598435', '2026-03-26 03:55:55.598435');
INSERT INTO public.task_entries VALUES ('1646189c-3006-4d9a-9979-c3e623bb510a', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Python AI Lab Presentation', 3, NULL, '00:30:00', '01:30:00', 60, true, '2026-03-25 22:55:55.601', 480, '2026-03-26 03:55:55.601929', '2026-03-26 03:55:55.601929');
INSERT INTO public.task_entries VALUES ('73825263-d21a-4804-afb7-9b2b612b5935', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:50:00', '05:00:00', 220, true, '2026-03-25 22:55:55.606', 481, '2026-03-26 03:55:55.607319', '2026-03-26 03:55:55.607319');
INSERT INTO public.task_entries VALUES ('61d950a1-0983-47b5-9d54-1dc99a4c6181', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AI Lab Python AI Model', 3, NULL, '05:00:00', '06:00:00', 60, true, '2026-03-25 22:55:55.61', 482, '2026-03-26 03:55:55.610798', '2026-03-26 03:55:55.610798');
INSERT INTO public.task_entries VALUES ('2c14b5d7-c42d-479d-a2bb-113a5bbbfdb4', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni - DBMS LAB', 3, NULL, '07:00:00', '11:00:00', 240, true, '2026-03-25 22:55:55.613', 483, '2026-03-26 03:55:55.614328', '2026-03-26 03:55:55.614328');
INSERT INTO public.task_entries VALUES ('5cfc5600-60fd-4317-89f7-c9b76839d204', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Lib - DBMS Quiz', 3, NULL, '11:30:00', '13:00:00', 90, true, '2026-03-25 22:55:55.617', 484, '2026-03-26 03:55:55.617685', '2026-03-26 03:55:55.617685');
INSERT INTO public.task_entries VALUES ('b3ae402a-1a84-4d07-a826-6d88c1aed3b5', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni - DBMS', 3, NULL, '13:00:00', '15:00:00', 120, true, '2026-03-25 22:55:55.62', 485, '2026-03-26 03:55:55.621075', '2026-03-26 03:55:55.621075');
INSERT INTO public.task_entries VALUES ('5cd59354-e46b-4ab3-91f9-35064f16f292', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni - AI', 3, NULL, '15:00:00', '18:00:00', 180, true, '2026-03-25 22:55:55.624', 486, '2026-03-26 03:55:55.624768', '2026-03-26 03:55:55.624768');
INSERT INTO public.task_entries VALUES ('988b9b19-1d05-4d0b-9902-53abbe1c9955', '8a000021-f431-41fc-b38b-4d25bc4e9b49', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '00:00:00', 120, true, '2026-03-25 22:55:55.628', 487, '2026-03-26 03:55:55.629126', '2026-03-26 03:55:55.629126');
INSERT INTO public.task_entries VALUES ('da4795f8-3f0c-4128-bf64-dd72d182e5e1', '7d6af30b-936f-4073-8fa6-c7bbfef92c31', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '02:00:00', 120, true, '2026-03-25 22:55:55.635', 488, '2026-03-26 03:55:55.63597', '2026-03-26 03:55:55.63597');
INSERT INTO public.task_entries VALUES ('4a0acdb8-525d-47f6-9e7d-c2bd8e1e6d7c', '7d6af30b-936f-4073-8fa6-c7bbfef92c31', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '06:00:00', '12:00:00', 360, true, '2026-03-25 22:55:55.638', 489, '2026-03-26 03:55:55.639491', '2026-03-26 03:55:55.639491');
INSERT INTO public.task_entries VALUES ('aa7f1696-e698-452b-891b-1db6b2813409', '7d6af30b-936f-4073-8fa6-c7bbfef92c31', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '12:00:00', '18:00:00', 360, true, '2026-03-25 22:55:55.642', 490, '2026-03-26 03:55:55.643087', '2026-03-26 03:55:55.643087');
INSERT INTO public.task_entries VALUES ('a984500b-0f84-4c2d-95a9-f4ae700e275d', '6a51ab67-4702-451d-8682-be618c989a05', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '02:40:00', 160, true, '2026-03-25 22:55:55.651', 491, '2026-03-26 03:55:55.651806', '2026-03-26 03:55:55.651806');
INSERT INTO public.task_entries VALUES ('9ecb6838-7d6a-4789-a7e0-1e17a2807102', '6a51ab67-4702-451d-8682-be618c989a05', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '02:40:00', '06:10:00', 210, true, '2026-03-25 22:55:55.654', 492, '2026-03-26 03:55:55.655162', '2026-03-26 03:55:55.655162');
INSERT INTO public.task_entries VALUES ('ac8c8646-a3bb-4a40-9191-544fc0fa39ed', '6a51ab67-4702-451d-8682-be618c989a05', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '07:00:00', '12:00:00', 450, true, '2026-03-25 22:55:55.658', 493, '2026-03-26 03:55:55.658804', '2026-03-26 03:55:55.658804');
INSERT INTO public.task_entries VALUES ('cb9afb06-ca03-421a-b38c-6a8734aef9c4', '6a51ab67-4702-451d-8682-be618c989a05', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Lib - Content Automation Build', 3, NULL, '12:00:00', '16:00:00', 240, true, '2026-03-25 22:55:55.662', 494, '2026-03-26 03:55:55.663136', '2026-03-26 03:55:55.663136');
INSERT INTO public.task_entries VALUES ('50c46e24-e7d8-49d9-98d0-8dbc84a2343f', '5078ef4c-6fb4-4d11-8ebe-4efe180d40e6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '00:00:00', '02:40:00', 250, true, '2026-03-25 22:55:55.893', 495, '2026-03-26 03:55:55.893895', '2026-03-26 03:55:55.893895');
INSERT INTO public.task_entries VALUES ('275043fc-a2f6-444d-bbcc-5e0c8b99bd3f', '5078ef4c-6fb4-4d11-8ebe-4efe180d40e6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '02:40:00', '05:30:00', 170, true, '2026-03-25 22:55:55.897', 496, '2026-03-26 03:55:55.898159', '2026-03-26 03:55:55.898159');
INSERT INTO public.task_entries VALUES ('45199770-9d19-4c83-952b-831a6f199229', '5078ef4c-6fb4-4d11-8ebe-4efe180d40e6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Expense Calculation', 3, NULL, '07:00:00', '08:30:00', 90, true, '2026-03-25 22:55:55.901', 497, '2026-03-26 03:55:55.902316', '2026-03-26 03:55:55.902316');
INSERT INTO public.task_entries VALUES ('c0a10663-5b5f-4a17-8ab8-f17a571b1e90', '3ea35295-c5d0-4bbc-9ebe-3072155cba89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '00:50:00', 470, true, '2026-03-25 22:55:55.91', 498, '2026-03-26 03:55:55.911194', '2026-03-26 03:55:55.911194');
INSERT INTO public.task_entries VALUES ('a238f4ab-5790-4fca-9cf8-48d69f627f63', '3ea35295-c5d0-4bbc-9ebe-3072155cba89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Hassan Project', 3, NULL, '12:20:00', '00:50:00', 810, true, '2026-03-25 22:55:55.914', 499, '2026-03-26 03:55:55.915145', '2026-03-26 03:55:55.915145');
INSERT INTO public.task_entries VALUES ('414f5cea-ddf7-45fc-a270-29fe3b668c3d', '3ea35295-c5d0-4bbc-9ebe-3072155cba89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '00:50:00', '04:00:00', 190, true, '2026-03-25 22:55:55.921', 500, '2026-03-26 03:55:55.922598', '2026-03-26 03:55:55.922598');
INSERT INTO public.task_entries VALUES ('c6a6841b-1f5d-4e0e-a167-36d66526d863', '3ea35295-c5d0-4bbc-9ebe-3072155cba89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Automation System Build', 3, NULL, '06:00:00', '16:00:00', 600, true, '2026-03-25 22:55:55.926', 501, '2026-03-26 03:55:55.927823', '2026-03-26 03:55:55.927823');
INSERT INTO public.task_entries VALUES ('70fbf465-cbcf-4276-9a90-3867cde12c8d', '1e387471-770c-46a0-9ff1-0e913294a420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '03:00:00', '07:00:00', 240, true, '2026-03-25 22:55:55.935', 502, '2026-03-26 03:55:55.93658', '2026-03-26 03:55:55.93658');
INSERT INTO public.task_entries VALUES ('22d05e89-9990-42c3-9683-2d7466df377c', '1e387471-770c-46a0-9ff1-0e913294a420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '07:00:00', '09:00:00', 360, true, '2026-03-25 22:55:55.939', 503, '2026-03-26 03:55:55.940676', '2026-03-26 03:55:55.940676');
INSERT INTO public.task_entries VALUES ('892a7227-e740-4d1f-b5cd-cdfc1d9a3906', '1e387471-770c-46a0-9ff1-0e913294a420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '09:00:00', '11:00:00', 180, true, '2026-03-25 22:55:55.944', 504, '2026-03-26 03:55:55.94499', '2026-03-26 03:55:55.94499');
INSERT INTO public.task_entries VALUES ('d2d2b348-8b72-4558-8495-5d87dd31c2fc', '1e387471-770c-46a0-9ff1-0e913294a420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Automation System Build', 3, NULL, '15:40:00', '19:10:00', 210, true, '2026-03-25 22:55:55.948', 505, '2026-03-26 03:55:55.94935', '2026-03-26 03:55:55.94935');
INSERT INTO public.task_entries VALUES ('b91386a7-a965-46e0-9191-55c5f4189ac0', '1e387471-770c-46a0-9ff1-0e913294a420', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'C & D Assignment', 3, NULL, '21:00:00', '22:30:00', 90, true, '2026-03-25 22:55:55.954', 506, '2026-03-26 03:55:55.955544', '2026-03-26 03:55:55.955544');
INSERT INTO public.task_entries VALUES ('664b4d78-ab12-40b5-b649-39ed128dfd82', '048f9f2a-6ee7-43be-b57a-5687aa4195a1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:00:00', '00:40:00', 190, true, '2026-03-25 22:55:55.963', 507, '2026-03-26 03:55:55.96439', '2026-03-26 03:55:55.96439');
INSERT INTO public.task_entries VALUES ('5acf6b32-11cc-417e-b273-6f319f70494c', '048f9f2a-6ee7-43be-b57a-5687aa4195a1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'C & D', 3, NULL, '09:00:00', '12:40:00', 220, true, '2026-03-25 22:55:55.968', 508, '2026-03-26 03:55:55.968979', '2026-03-26 03:55:55.968979');
INSERT INTO public.task_entries VALUES ('7969e0ec-52c6-4b3a-bdd4-8c60f9777955', '048f9f2a-6ee7-43be-b57a-5687aa4195a1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc - Lib', 3, NULL, '12:40:00', '14:30:00', 170, true, '2026-03-25 22:55:55.972', 509, '2026-03-26 03:55:55.973495', '2026-03-26 03:55:55.973495');
INSERT INTO public.task_entries VALUES ('7a89b6e2-17f0-4514-adf2-09ce11daebd2', '048f9f2a-6ee7-43be-b57a-5687aa4195a1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE', 3, NULL, '16:30:00', '18:30:00', 120, true, '2026-03-25 22:55:55.977', 510, '2026-03-26 03:55:55.978583', '2026-03-26 03:55:55.978583');
INSERT INTO public.task_entries VALUES ('c9e7ee6c-f488-4ca8-bf3a-a18155ec3243', '1544c7f9-004f-4d81-98eb-1d697353976f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '01:30:00', 270, true, '2026-03-25 22:55:55.986', 511, '2026-03-26 03:55:55.986972', '2026-03-26 03:55:55.986972');
INSERT INTO public.task_entries VALUES ('6dc35072-c374-4b74-8144-442a35579cc5', '1544c7f9-004f-4d81-98eb-1d697353976f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:30:00', '02:30:00', 60, true, '2026-03-25 22:55:55.99', 512, '2026-03-26 03:55:55.990896', '2026-03-26 03:55:55.990896');
INSERT INTO public.task_entries VALUES ('c7cbdee9-4b9e-4915-877e-b08cfb8a86a8', '1544c7f9-004f-4d81-98eb-1d697353976f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Automation System Build', 3, NULL, '02:30:00', '05:00:00', 150, true, '2026-03-25 22:55:55.994', 513, '2026-03-26 03:55:55.995045', '2026-03-26 03:55:55.995045');
INSERT INTO public.task_entries VALUES ('9c4d1cb5-9d24-4229-9937-99f25b2a6d09', '1544c7f9-004f-4d81-98eb-1d697353976f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DBMS', 3, NULL, '19:30:00', '11:00:00', 930, true, '2026-03-25 22:55:55.999', 514, '2026-03-26 03:55:56.000542', '2026-03-26 03:55:56.000542');
INSERT INTO public.task_entries VALUES ('d58a9869-75db-4fd0-b365-b7d45430f2f3', '1544c7f9-004f-4d81-98eb-1d697353976f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '11:00:00', '15:00:00', 240, true, '2026-03-25 22:55:56.003', 515, '2026-03-26 03:55:56.004132', '2026-03-26 03:55:56.004132');
INSERT INTO public.task_entries VALUES ('e6aad270-80f4-4233-8ff0-cecfce635b47', '1544c7f9-004f-4d81-98eb-1d697353976f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Foundation', 3, NULL, '15:00:00', '18:00:00', 180, true, '2026-03-25 22:55:56.008', 516, '2026-03-26 03:55:56.009303', '2026-03-26 03:55:56.009303');
INSERT INTO public.task_entries VALUES ('cce586a0-cad6-478a-a1a3-9c72f7727127', '5194463e-aac7-4a5c-8513-6b56a36d708e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '08:00:00', '09:30:00', 390, true, '2026-03-25 22:55:56.016', 517, '2026-03-26 03:55:56.017134', '2026-03-26 03:55:56.017134');
INSERT INTO public.task_entries VALUES ('8e76c2bb-2984-4b31-aea7-c3fe6b2e86f9', '5194463e-aac7-4a5c-8513-6b56a36d708e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '09:30:00', '12:30:00', 180, true, '2026-03-25 22:55:56.02', 518, '2026-03-26 03:55:56.021069', '2026-03-26 03:55:56.021069');
INSERT INTO public.task_entries VALUES ('d4600515-46d8-4820-89db-24a78e6e8a60', '5194463e-aac7-4a5c-8513-6b56a36d708e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '12:30:00', '18:00:00', 330, true, '2026-03-25 22:55:56.024', 519, '2026-03-26 03:55:56.025029', '2026-03-26 03:55:56.025029');
INSERT INTO public.task_entries VALUES ('71fb9c83-2398-4166-9553-0f332eb2e89f', 'bd5a5a61-5b3c-41bf-99bb-ff92d327f6d7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '11:00:00', '19:00:00', 480, true, '2026-03-25 22:55:56.031', 520, '2026-03-26 03:55:56.032133', '2026-03-26 03:55:56.032133');
INSERT INTO public.task_entries VALUES ('2af29e08-5f7a-4ad1-9bd0-b538a0796e73', 'd3f8a53a-6e0b-45db-bd34-0a416065110c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '05:00:00', 300, true, '2026-03-25 22:55:56.038', 521, '2026-03-26 03:55:56.039134', '2026-03-26 03:55:56.039134');
INSERT INTO public.task_entries VALUES ('768341b7-941c-4689-abf4-f8e3816a7bf7', 'd3f8a53a-6e0b-45db-bd34-0a416065110c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'hassan project', 3, NULL, '06:00:00', '10:30:00', 270, true, '2026-03-25 22:55:56.046', 522, '2026-03-26 03:55:56.047218', '2026-03-26 03:55:56.047218');
INSERT INTO public.task_entries VALUES ('b9527a98-89b3-4600-883a-94abf8e1df64', 'd3f8a53a-6e0b-45db-bd34-0a416065110c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '10:30:00', '12:00:00', 90, true, '2026-03-25 22:55:56.05', 523, '2026-03-26 03:55:56.051603', '2026-03-26 03:55:56.051603');
INSERT INTO public.task_entries VALUES ('dad881a5-4357-4fdd-8768-144001904d28', 'd3f8a53a-6e0b-45db-bd34-0a416065110c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '12:00:00', '16:30:00', 345, true, '2026-03-25 22:55:56.055', 524, '2026-03-26 03:55:56.055935', '2026-03-26 03:55:56.055935');
INSERT INTO public.task_entries VALUES ('b7fb4aae-4694-4906-8118-b68225186936', 'd3f8a53a-6e0b-45db-bd34-0a416065110c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'AI Automations Learning', 3, NULL, '16:30:00', '21:30:00', 300, true, '2026-03-25 22:55:56.061', 525, '2026-03-26 03:55:56.061679', '2026-03-26 03:55:56.061679');
INSERT INTO public.task_entries VALUES ('f00324f5-edf3-4cf5-a72a-8ac73ca8d031', '4433106a-6bd3-422f-b851-2caa371f8a43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Traveling', 3, NULL, '19:00:00', '11:00:00', 960, true, '2026-03-25 22:55:56.068', 526, '2026-03-26 03:55:56.068914', '2026-03-26 03:55:56.068914');
INSERT INTO public.task_entries VALUES ('9b1022a7-a79c-4563-811f-f096524696f9', '4433106a-6bd3-422f-b851-2caa371f8a43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:00:00', '16:45:00', 265, true, '2026-03-25 22:55:56.071', 527, '2026-03-26 03:55:56.072367', '2026-03-26 03:55:56.072367');
INSERT INTO public.task_entries VALUES ('251598f3-1bf4-4679-8ff6-5640fb71f230', '4433106a-6bd3-422f-b851-2caa371f8a43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:45:00', '18:30:00', 105, true, '2026-03-25 22:55:56.075', 528, '2026-03-26 03:55:56.076213', '2026-03-26 03:55:56.076213');
INSERT INTO public.task_entries VALUES ('77805709-d8f0-4d92-82cb-cf1d4e893d83', '4433106a-6bd3-422f-b851-2caa371f8a43', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'OWF', 3, NULL, '19:00:00', '02:00:00', 420, true, '2026-03-25 22:55:56.079', 529, '2026-03-26 03:55:56.080207', '2026-03-26 03:55:56.080207');
INSERT INTO public.task_entries VALUES ('b71be34c-ca3d-4e5b-88df-2f9b1b7693a3', 'cbf5a6d2-7eb2-426b-a943-25999fdd22af', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '07:00:00', '16:00:00', 720, true, '2026-03-25 22:55:56.086', 530, '2026-03-26 03:55:56.087371', '2026-03-26 03:55:56.087371');
INSERT INTO public.task_entries VALUES ('ad9cff7e-3a97-41b7-841c-f5a697a2412a', 'cbf5a6d2-7eb2-426b-a943-25999fdd22af', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:45:00', '20:30:00', 225, true, '2026-03-25 22:55:56.089', 531, '2026-03-26 03:55:56.090558', '2026-03-26 03:55:56.090558');
INSERT INTO public.task_entries VALUES ('97175645-5a11-4c6c-80ad-8e84ca12167e', '5ba3fbd1-563c-4305-9d4a-d2f348f97e19', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '07:00:00', '14:00:00', 420, true, '2026-03-25 22:55:56.097', 532, '2026-03-26 03:55:56.098448', '2026-03-26 03:55:56.098448');
INSERT INTO public.task_entries VALUES ('0a27d212-000b-42c7-97c6-9cbebed7a908', '5ba3fbd1-563c-4305-9d4a-d2f348f97e19', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:00:00', '15:00:00', 60, true, '2026-03-25 22:55:56.101', 533, '2026-03-26 03:55:56.102161', '2026-03-26 03:55:56.102161');
INSERT INTO public.task_entries VALUES ('19379a1a-c9c7-4d9a-8bd0-2de7d3cb8ea0', '5ba3fbd1-563c-4305-9d4a-d2f348f97e19', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '15:00:00', '18:00:00', 180, true, '2026-03-25 22:55:56.104', 534, '2026-03-26 03:55:56.105341', '2026-03-26 03:55:56.105341');
INSERT INTO public.task_entries VALUES ('a25b6308-c155-4796-b34c-14608d2ebd80', '5ba3fbd1-563c-4305-9d4a-d2f348f97e19', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'OT', 3, NULL, '20:00:00', '00:00:00', 240, true, '2026-03-25 22:55:56.11', 535, '2026-03-26 03:55:56.110797', '2026-03-26 03:55:56.110797');
INSERT INTO public.task_entries VALUES ('435f3975-5e13-4f99-9893-ea474f642135', 'd442b4c4-3438-4a3d-a3de-58e7a1f926d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '07:00:00', '14:00:00', 420, true, '2026-03-25 22:55:56.117', 536, '2026-03-26 03:55:56.117847', '2026-03-26 03:55:56.117847');
INSERT INTO public.task_entries VALUES ('cd474d97-acb0-489e-b89b-70b821c48b77', 'd442b4c4-3438-4a3d-a3de-58e7a1f926d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '17:00:00', '19:00:00', 120, true, '2026-03-25 22:55:56.12', 537, '2026-03-26 03:55:56.121376', '2026-03-26 03:55:56.121376');
INSERT INTO public.task_entries VALUES ('a98eeacf-6801-4dcf-b4d3-dadd0833a218', 'd442b4c4-3438-4a3d-a3de-58e7a1f926d8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'OT', 3, NULL, '20:00:00', '00:00:00', 240, true, '2026-03-25 22:55:56.124', 538, '2026-03-26 03:55:56.124512', '2026-03-26 03:55:56.124512');
INSERT INTO public.task_entries VALUES ('a9ada2ee-bf79-4b64-a3fc-4b590f4d3353', '6b90125a-0f05-40ca-a47e-db70e85ef1b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '00:00:00', '02:00:00', 120, true, '2026-03-25 22:55:56.131', 539, '2026-03-26 03:55:56.131615', '2026-03-26 03:55:56.131615');
INSERT INTO public.task_entries VALUES ('bae248be-e70d-4f3d-94c8-54ff55e89cbb', '00c8f0b5-6986-445f-a05d-519e1c28a21b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DBMS Lab', 3, NULL, '07:00:00', '11:00:00', 240, true, '2026-03-25 22:55:56.139', 540, '2026-03-26 03:55:56.140192', '2026-03-26 03:55:56.140192');
INSERT INTO public.task_entries VALUES ('161b53db-a7ec-4610-a7ad-0b80aa9cb591', '00c8f0b5-6986-445f-a05d-519e1c28a21b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc - Lib', 3, NULL, '11:00:00', '13:20:00', 140, true, '2026-03-25 22:55:56.143', 541, '2026-03-26 03:55:56.14379', '2026-03-26 03:55:56.14379');
INSERT INTO public.task_entries VALUES ('6ccd3a2d-434d-4a0e-9c28-91fa4e8ad278', '00c8f0b5-6986-445f-a05d-519e1c28a21b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DBMS', 3, NULL, '13:20:00', '14:20:00', 60, true, '2026-03-25 22:55:56.146', 542, '2026-03-26 03:55:56.14759', '2026-03-26 03:55:56.14759');
INSERT INTO public.task_entries VALUES ('d3e26285-5cd1-4736-bc7e-cffe44cceb97', '00c8f0b5-6986-445f-a05d-519e1c28a21b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc - Upwork Bidding', 3, NULL, '14:20:00', '16:10:00', 110, true, '2026-03-25 22:55:56.15', 543, '2026-03-26 03:55:56.151133', '2026-03-26 03:55:56.151133');
INSERT INTO public.task_entries VALUES ('901b7c38-4abc-41bc-8055-23221c374909', '00c8f0b5-6986-445f-a05d-519e1c28a21b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI', 3, NULL, '16:20:00', '18:30:00', 130, true, '2026-03-25 22:55:56.156', 544, '2026-03-26 03:55:56.156808', '2026-03-26 03:55:56.156808');
INSERT INTO public.task_entries VALUES ('ad8b0b14-39fa-4408-9ea7-a79fd2d903e6', '00c8f0b5-6986-445f-a05d-519e1c28a21b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:30:00', '21:00:00', 150, true, '2026-03-25 22:55:56.165', 545, '2026-03-26 03:55:56.165581', '2026-03-26 03:55:56.165581');
INSERT INTO public.task_entries VALUES ('8ee931b0-28d7-453d-965c-d847b05b5c1f', '00c8f0b5-6986-445f-a05d-519e1c28a21b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Min meeting 9pm', 3, NULL, '21:00:00', '21:35:00', 35, true, '2026-03-25 22:55:56.183', 546, '2026-03-26 03:55:56.184332', '2026-03-26 03:55:56.184332');
INSERT INTO public.task_entries VALUES ('ac435f99-d303-497f-bb2a-25be697fd236', '965001c7-78f2-4426-8cab-d1f54a23fb50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:35:00', '01:10:00', 215, true, '2026-03-25 22:55:56.429', 547, '2026-03-26 03:55:56.430044', '2026-03-26 03:55:56.430044');
INSERT INTO public.task_entries VALUES ('6cf21350-56d4-4c67-8b22-8d379d68d230', '965001c7-78f2-4426-8cab-d1f54a23fb50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '12:00:00', '18:00:00', 360, true, '2026-03-25 22:55:56.455', 548, '2026-03-26 03:55:56.456071', '2026-03-26 03:55:56.456071');
INSERT INTO public.task_entries VALUES ('1044d023-47ac-4b8f-bf32-254c0def098f', '965001c7-78f2-4426-8cab-d1f54a23fb50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'BK W', 3, NULL, '18:00:00', '19:10:00', 70, true, '2026-03-25 22:55:56.46', 549, '2026-03-26 03:55:56.461418', '2026-03-26 03:55:56.461418');
INSERT INTO public.task_entries VALUES ('071432ed-076e-4657-9fdc-ba45a622ac55', '965001c7-78f2-4426-8cab-d1f54a23fb50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project foundation', 3, NULL, '20:00:00', '22:30:00', 150, true, '2026-03-25 22:55:56.465', 550, '2026-03-26 03:55:56.466385', '2026-03-26 03:55:56.466385');
INSERT INTO public.task_entries VALUES ('45c4591b-5942-4164-9e5a-eab14b5c7724', '965001c7-78f2-4426-8cab-d1f54a23fb50', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Expense Calc', 3, NULL, '22:30:00', '01:00:00', 150, true, '2026-03-25 22:55:56.471', 551, '2026-03-26 03:55:56.471985', '2026-03-26 03:55:56.471985');
INSERT INTO public.task_entries VALUES ('359d65a0-c83d-4223-a3c1-a12787a559cf', '60233948-d5c6-449e-923e-3a470fc787fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '01:10:00', '02:30:00', 80, true, '2026-03-25 22:55:56.482', 552, '2026-03-26 03:55:56.483147', '2026-03-26 03:55:56.483147');
INSERT INTO public.task_entries VALUES ('57562cd5-ea36-4bbd-b6d0-8d9882b98fbf', '60233948-d5c6-449e-923e-3a470fc787fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Assignments', 3, NULL, '02:30:00', '07:30:00', 300, true, '2026-03-25 22:55:56.487', 553, '2026-03-26 03:55:56.488455', '2026-03-26 03:55:56.488455');
INSERT INTO public.task_entries VALUES ('32215a91-612a-4bf6-91f1-f2a84f1ed827', 'b4244dae-554d-4aca-8b14-238194f11ee4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '02:00:00', '03:00:00', 150, true, '2026-03-25 22:55:56.947', 647, '2026-03-26 03:55:56.94759', '2026-03-26 03:55:56.94759');
INSERT INTO public.task_entries VALUES ('91dff4bd-4f0e-4558-9bcf-53b008c423aa', '60233948-d5c6-449e-923e-3a470fc787fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI - Lab', 3, NULL, '07:30:00', '11:40:00', 250, true, '2026-03-25 22:55:56.493', 554, '2026-03-26 03:55:56.494731', '2026-03-26 03:55:56.494731');
INSERT INTO public.task_entries VALUES ('c16be24a-95c3-4a94-8644-19ff7f6882f6', '60233948-d5c6-449e-923e-3a470fc787fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc - Lib', 3, NULL, '11:40:00', '15:50:00', 250, true, '2026-03-25 22:55:56.498', 555, '2026-03-26 03:55:56.498949', '2026-03-26 03:55:56.498949');
INSERT INTO public.task_entries VALUES ('9bc2602f-d3db-4376-bd93-c9d3abc79b4a', '60233948-d5c6-449e-923e-3a470fc787fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'C&D - Lab', 3, NULL, '16:30:00', '18:30:00', 120, true, '2026-03-25 22:55:56.502', 556, '2026-03-26 03:55:56.503409', '2026-03-26 03:55:56.503409');
INSERT INTO public.task_entries VALUES ('01013dcd-9915-4810-87df-b3dd71abd6a9', '2b12006b-4694-4e28-8f4d-f2f2f0d6d9f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '00:00:00', '05:00:00', 300, true, '2026-03-25 22:55:56.51', 557, '2026-03-26 03:55:56.511133', '2026-03-26 03:55:56.511133');
INSERT INTO public.task_entries VALUES ('12a63a81-0685-44b8-9907-d42a8c5a0e7f', '2b12006b-4694-4e28-8f4d-f2f2f0d6d9f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '11:30:00', '18:30:00', 420, true, '2026-03-25 22:55:56.514', 558, '2026-03-26 03:55:56.515198', '2026-03-26 03:55:56.515198');
INSERT INTO public.task_entries VALUES ('e0966f5e-1d36-4a84-a2b1-7b4bdaceaccf', '2b12006b-4694-4e28-8f4d-f2f2f0d6d9f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:30:00', '19:50:00', 80, true, '2026-03-25 22:55:56.518', 559, '2026-03-26 03:55:56.519181', '2026-03-26 03:55:56.519181');
INSERT INTO public.task_entries VALUES ('32ab58d8-29e8-4fe1-a396-b2ebe0829923', '2b12006b-4694-4e28-8f4d-f2f2f0d6d9f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '20:00:00', '23:10:00', 190, true, '2026-03-25 22:55:56.523', 560, '2026-03-26 03:55:56.524068', '2026-03-26 03:55:56.524068');
INSERT INTO public.task_entries VALUES ('903bb2ff-7673-470c-9e2e-6f3a43f553ff', '2b12006b-4694-4e28-8f4d-f2f2f0d6d9f7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Exam Schedule', 3, NULL, '23:10:00', '00:00:00', 50, true, '2026-03-25 22:55:56.526', 561, '2026-03-26 03:55:56.527648', '2026-03-26 03:55:56.527648');
INSERT INTO public.task_entries VALUES ('73657282-ad8b-4104-84e4-9291e26d488c', '2aacb950-6caa-41ae-b81c-297735aa2c05', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '05:00:00', 660, true, '2026-03-25 22:55:56.534', 562, '2026-03-26 03:55:56.535473', '2026-03-26 03:55:56.535473');
INSERT INTO public.task_entries VALUES ('f88510a8-6c42-41c8-8f1f-4fc2a1458349', '2aacb950-6caa-41ae-b81c-297735aa2c05', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:00:00', '01:00:00', 180, true, '2026-03-25 22:55:56.538', 563, '2026-03-26 03:55:56.539273', '2026-03-26 03:55:56.539273');
INSERT INTO public.task_entries VALUES ('60f3b121-3e83-4f41-b67f-f565a0a24985', '192c685a-eecb-4817-9711-3c775e8f9200', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '01:00:00', '05:00:00', 300, true, '2026-03-25 22:55:56.549', 564, '2026-03-26 03:55:56.550261', '2026-03-26 03:55:56.550261');
INSERT INTO public.task_entries VALUES ('f1bf21c3-f8a8-46c7-b3d1-97305394610c', '192c685a-eecb-4817-9711-3c775e8f9200', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '05:00:00', '07:00:00', 120, true, '2026-03-25 22:55:56.553', 565, '2026-03-26 03:55:56.554209', '2026-03-26 03:55:56.554209');
INSERT INTO public.task_entries VALUES ('4cf203f2-8262-4564-9128-4f075b340c77', '192c685a-eecb-4817-9711-3c775e8f9200', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '19:00:00', '01:00:00', 360, true, '2026-03-25 22:55:56.557', 566, '2026-03-26 03:55:56.558131', '2026-03-26 03:55:56.558131');
INSERT INTO public.task_entries VALUES ('d637ce19-e2e9-49d4-930c-f1ee2567e1d9', '3893cc3c-d9cd-426f-9abc-2a6298924826', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '01:00:00', '03:30:00', 510, true, '2026-03-25 22:55:56.564', 567, '2026-03-26 03:55:56.56523', '2026-03-26 03:55:56.56523');
INSERT INTO public.task_entries VALUES ('fbb1e0e6-db7d-4948-9abb-44b0d7ec9f7c', '3893cc3c-d9cd-426f-9abc-2a6298924826', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '03:30:00', '06:00:00', 150, true, '2026-03-25 22:55:56.568', 568, '2026-03-26 03:55:56.569036', '2026-03-26 03:55:56.569036');
INSERT INTO public.task_entries VALUES ('4b835655-9949-411f-897f-cf8baa6ca879', '3893cc3c-d9cd-426f-9abc-2a6298924826', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '16:00:00', '18:00:00', 120, true, '2026-03-25 22:55:56.572', 569, '2026-03-26 03:55:56.57344', '2026-03-26 03:55:56.57344');
INSERT INTO public.task_entries VALUES ('5999dbed-febd-47b9-ac0b-916f653ed8e1', '3893cc3c-d9cd-426f-9abc-2a6298924826', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'RD', 3, NULL, '18:00:00', '19:30:00', 90, true, '2026-03-25 22:55:56.576', 570, '2026-03-26 03:55:56.577362', '2026-03-26 03:55:56.577362');
INSERT INTO public.task_entries VALUES ('33cc859c-39dc-4606-ae81-84ad9fdd1ed7', '3893cc3c-d9cd-426f-9abc-2a6298924826', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Shekhar Meeting', 3, NULL, '23:30:00', '23:50:00', 20, true, '2026-03-25 22:55:56.58', 571, '2026-03-26 03:55:56.581334', '2026-03-26 03:55:56.581334');
INSERT INTO public.task_entries VALUES ('caae0da0-c710-41ca-9910-e52f4c1c29b3', '3507c784-8d29-48a8-b610-afd5feff9ae4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Inbox', 3, NULL, '00:00:00', '03:00:00', 300, true, '2026-03-25 22:55:56.588', 572, '2026-03-26 03:55:56.589184', '2026-03-26 03:55:56.589184');
INSERT INTO public.task_entries VALUES ('8435d478-4add-4dcf-8314-afc24f8956e2', '3507c784-8d29-48a8-b610-afd5feff9ae4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '03:00:00', '04:00:00', 60, true, '2026-03-25 22:55:56.594', 573, '2026-03-26 03:55:56.595139', '2026-03-26 03:55:56.595139');
INSERT INTO public.task_entries VALUES ('91813a5e-0eaa-4015-a8fc-fba44d5218b1', '3507c784-8d29-48a8-b610-afd5feff9ae4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Shekhar Automation Quote', 3, NULL, '04:00:00', '04:30:00', 30, true, '2026-03-25 22:55:56.599', 574, '2026-03-26 03:55:56.60015', '2026-03-26 03:55:56.60015');
INSERT INTO public.task_entries VALUES ('76eaccc0-92aa-44c7-9a64-d95705a8c2c2', '3507c784-8d29-48a8-b610-afd5feff9ae4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project foundation', 3, NULL, '04:30:00', '05:00:00', 30, true, '2026-03-25 22:55:56.603', 575, '2026-03-26 03:55:56.604005', '2026-03-26 03:55:56.604005');
INSERT INTO public.task_entries VALUES ('3e5a9b45-4c9e-4422-be11-71b2a84eed5a', '3507c784-8d29-48a8-b610-afd5feff9ae4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '07:00:00', '11:00:00', 240, true, '2026-03-25 22:55:56.608', 576, '2026-03-26 03:55:56.608679', '2026-03-26 03:55:56.608679');
INSERT INTO public.task_entries VALUES ('f48a7943-5953-4a48-b1e2-5343ba77f0d9', '3507c784-8d29-48a8-b610-afd5feff9ae4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'OUT', 3, NULL, '18:00:00', '21:30:00', 210, true, '2026-03-25 22:55:56.612', 577, '2026-03-26 03:55:56.613466', '2026-03-26 03:55:56.613466');
INSERT INTO public.task_entries VALUES ('a85a1bde-b732-41de-99cd-1845e113adc6', '287430ca-cb1b-434d-a17e-93bd1fe478e7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'WD', 3, NULL, '18:00:00', '19:30:00', 90, true, '2026-03-25 22:55:56.62', 578, '2026-03-26 03:55:56.620985', '2026-03-26 03:55:56.620985');
INSERT INTO public.task_entries VALUES ('72429eeb-4bfd-45bc-b8a9-acf8186d9052', '5df23281-8c25-4bfe-a010-36294b63e4ac', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '18:00:00', '21:00:00', 180, true, '2026-03-25 22:55:56.627', 579, '2026-03-26 03:55:56.628338', '2026-03-26 03:55:56.628338');
INSERT INTO public.task_entries VALUES ('30e74951-c847-400d-bb7f-2ccfe820439f', '5df23281-8c25-4bfe-a010-36294b63e4ac', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '22:00:00', 360, true, '2026-03-25 22:55:56.631', 580, '2026-03-26 03:55:56.632314', '2026-03-26 03:55:56.632314');
INSERT INTO public.task_entries VALUES ('772913dc-d0e6-4ea6-89eb-d4733bfd08e3', '5df23281-8c25-4bfe-a010-36294b63e4ac', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:00:00', '02:00:00', 240, true, '2026-03-25 22:55:56.635', 581, '2026-03-26 03:55:56.636204', '2026-03-26 03:55:56.636204');
INSERT INTO public.task_entries VALUES ('2c52df4b-b287-4e5d-bf3b-c29f68c26055', '5df23281-8c25-4bfe-a010-36294b63e4ac', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '07:00:00', '11:00:00', 240, true, '2026-03-25 22:55:56.639', 582, '2026-03-26 03:55:56.640483', '2026-03-26 03:55:56.640483');
INSERT INTO public.task_entries VALUES ('d1f5ecfe-bbca-491f-a137-109b0ae5ee84', '5df23281-8c25-4bfe-a010-36294b63e4ac', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Lib - Upwork Bidding', 3, NULL, '11:30:00', '13:30:00', 120, true, '2026-03-25 22:55:56.645', 583, '2026-03-26 03:55:56.646581', '2026-03-26 03:55:56.646581');
INSERT INTO public.task_entries VALUES ('783ef5ad-fc92-465c-8bb7-dae69d35a919', '5df23281-8c25-4bfe-a010-36294b63e4ac', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '11:30:00', '18:30:00', 420, true, '2026-03-25 22:55:56.649', 584, '2026-03-26 03:55:56.649915', '2026-03-26 03:55:56.649915');
INSERT INTO public.task_entries VALUES ('7af4f97a-437b-48f3-9d74-9231475ccc47', '10ad6bff-02e4-4ab6-a0c6-2efb6eaf2f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:00:00', '21:30:00', 1000, true, '2026-03-25 22:55:56.657', 585, '2026-03-26 03:55:56.658831', '2026-03-26 03:55:56.658831');
INSERT INTO public.task_entries VALUES ('20f61057-5033-48e5-870f-214741db6588', '10ad6bff-02e4-4ab6-a0c6-2efb6eaf2f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidder Interview', 3, NULL, '21:30:00', '22:00:00', 30, true, '2026-03-25 22:55:56.661', 586, '2026-03-26 03:55:56.662412', '2026-03-26 03:55:56.662412');
INSERT INTO public.task_entries VALUES ('6ecba63a-f9d9-4fa3-9d14-01b4a16521a3', '10ad6bff-02e4-4ab6-a0c6-2efb6eaf2f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Peter Interview Proposal', 3, NULL, '22:00:00', '22:30:00', 30, true, '2026-03-25 22:55:56.665', 587, '2026-03-26 03:55:56.666323', '2026-03-26 03:55:56.666323');
INSERT INTO public.task_entries VALUES ('d3201a44-ebbc-4a59-84e6-6120801a03c1', '10ad6bff-02e4-4ab6-a0c6-2efb6eaf2f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Agency Profile Update', 3, NULL, '22:30:00', '23:00:00', 30, true, '2026-03-25 22:55:56.669', 588, '2026-03-26 03:55:56.670322', '2026-03-26 03:55:56.670322');
INSERT INTO public.task_entries VALUES ('921976cf-a583-48c7-b59d-03d08e719ba8', '10ad6bff-02e4-4ab6-a0c6-2efb6eaf2f07', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Inbox Review', 3, NULL, '23:00:00', '23:50:00', 50, true, '2026-03-25 22:55:56.673', 589, '2026-03-26 03:55:56.674345', '2026-03-26 03:55:56.674345');
INSERT INTO public.task_entries VALUES ('1756f391-5b55-4061-9df3-ad497ba55542', '7dbcef98-6fd3-4c8f-8a20-8a603c2cc710', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:50:00', '01:00:00', 250, true, '2026-03-25 22:55:56.681', 590, '2026-03-26 03:55:56.682135', '2026-03-26 03:55:56.682135');
INSERT INTO public.task_entries VALUES ('b73651a6-4f76-43fe-9844-1a14530f31cf', '7dbcef98-6fd3-4c8f-8a20-8a603c2cc710', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidder Meeting - Abdul Basit', 3, NULL, '01:40:00', '02:20:00', 40, true, '2026-03-25 22:55:56.685', 591, '2026-03-26 03:55:56.685634', '2026-03-26 03:55:56.685634');
INSERT INTO public.task_entries VALUES ('9fadba31-fb66-4ba3-813f-4e33218e2167', '7dbcef98-6fd3-4c8f-8a20-8a603c2cc710', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '02:40:00', '05:00:00', 140, true, '2026-03-25 22:55:56.688', 592, '2026-03-26 03:55:56.689387', '2026-03-26 03:55:56.689387');
INSERT INTO public.task_entries VALUES ('328e715d-b62b-45a3-8f94-854816f948d7', '7dbcef98-6fd3-4c8f-8a20-8a603c2cc710', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Expense Calc', 3, NULL, '05:00:00', '07:00:00', 120, true, '2026-03-25 22:55:56.694', 593, '2026-03-26 03:55:56.695337', '2026-03-26 03:55:56.695337');
INSERT INTO public.task_entries VALUES ('4bc7c42e-69bf-41ee-9074-9da83b52d81d', '5b7e5767-a02e-4fe8-89f4-c1ed0c371b24', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:30:00', '01:00:00', 150, true, '2026-03-25 22:55:56.702', 594, '2026-03-26 03:55:56.703629', '2026-03-26 03:55:56.703629');
INSERT INTO public.task_entries VALUES ('7f613b0c-0b0f-4520-8093-aceaa763853f', '5b7e5767-a02e-4fe8-89f4-c1ed0c371b24', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:00:00', '02:40:00', 100, true, '2026-03-25 22:55:56.706', 595, '2026-03-26 03:55:56.70745', '2026-03-26 03:55:56.70745');
INSERT INTO public.task_entries VALUES ('955cd8ab-9497-4672-8a7d-234db676b5b2', '5b7e5767-a02e-4fe8-89f4-c1ed0c371b24', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE Exam Preparation', 3, NULL, '02:40:00', '08:00:00', 320, true, '2026-03-25 22:55:56.71', 596, '2026-03-26 03:55:56.710993', '2026-03-26 03:55:56.710993');
INSERT INTO public.task_entries VALUES ('575ad5c0-ca74-4fb4-93c2-ed21d90145b0', '5b7e5767-a02e-4fe8-89f4-c1ed0c371b24', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE Exam', 3, NULL, '09:00:00', '13:00:00', 240, true, '2026-03-25 22:55:56.713', 597, '2026-03-26 03:55:56.714648', '2026-03-26 03:55:56.714648');
INSERT INTO public.task_entries VALUES ('803725e3-5d3d-4864-9378-0cbd9914f578', '5b7e5767-a02e-4fe8-89f4-c1ed0c371b24', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'TE', 1, NULL, '13:00:00', '15:00:00', 120, true, '2026-03-25 22:55:56.717', 598, '2026-03-26 03:55:56.718212', '2026-03-26 03:55:56.718212');
INSERT INTO public.task_entries VALUES ('7bf506da-7588-4a6a-9a03-1fe8ee5276ae', '91285e2e-80ce-414b-9b88-0d57995ae9be', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '02:00:00', '04:00:00', 120, true, '2026-03-25 22:55:56.726', 599, '2026-03-26 03:55:56.727613', '2026-03-26 03:55:56.727613');
INSERT INTO public.task_entries VALUES ('81789f3e-a6d1-40df-aa19-31385a5e846d', '91285e2e-80ce-414b-9b88-0d57995ae9be', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '04:00:00', '05:00:00', 60, true, '2026-03-25 22:55:56.731', 600, '2026-03-26 03:55:56.731937', '2026-03-26 03:55:56.731937');
INSERT INTO public.task_entries VALUES ('727c4410-76ce-411e-b2b3-643a127a04a6', '91285e2e-80ce-414b-9b88-0d57995ae9be', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project propwatchlist', 3, NULL, '05:00:00', '05:40:00', 40, true, '2026-03-25 22:55:56.734', 601, '2026-03-26 03:55:56.735488', '2026-03-26 03:55:56.735488');
INSERT INTO public.task_entries VALUES ('5542020e-b476-4b1c-b5ed-d397ddc55939', '91285e2e-80ce-414b-9b88-0d57995ae9be', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Exam Preparation', 3, NULL, '05:40:00', '08:00:00', 240, true, '2026-03-25 22:55:56.738', 602, '2026-03-26 03:55:56.739452', '2026-03-26 03:55:56.739452');
INSERT INTO public.task_entries VALUES ('5e6291d7-3bd4-4643-93b1-7db3e63f25ea', '91285e2e-80ce-414b-9b88-0d57995ae9be', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Exam', 3, NULL, '11:00:00', '13:00:00', 120, true, '2026-03-25 22:55:56.744', 603, '2026-03-26 03:55:56.745043', '2026-03-26 03:55:56.745043');
INSERT INTO public.task_entries VALUES ('3107373d-9403-4735-94f6-d9a1c81042c7', '91285e2e-80ce-414b-9b88-0d57995ae9be', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '13:00:00', '17:00:00', 240, true, '2026-03-25 22:55:56.747', 604, '2026-03-26 03:55:56.748656', '2026-03-26 03:55:56.748656');
INSERT INTO public.task_entries VALUES ('531a0e30-6702-4b26-99c2-cb8ec305f96f', 'f9c59b9a-0d5a-45e2-a5da-204196a024c2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '01:00:00', '02:00:00', 60, true, '2026-03-25 22:55:56.756', 605, '2026-03-26 03:55:56.756791', '2026-03-26 03:55:56.756791');
INSERT INTO public.task_entries VALUES ('ee7b48da-dcf9-40d2-acf7-900be4cac481', 'f9c59b9a-0d5a-45e2-a5da-204196a024c2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project propwatchlist', 3, NULL, '02:00:00', '04:00:00', 120, true, '2026-03-25 22:55:56.76', 606, '2026-03-26 03:55:56.760997', '2026-03-26 03:55:56.760997');
INSERT INTO public.task_entries VALUES ('d08f24cd-4ebb-47e1-b325-333e5f4978c9', 'f9c59b9a-0d5a-45e2-a5da-204196a024c2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'WL Exam Preparation', 3, NULL, '04:00:00', '07:00:00', 180, true, '2026-03-25 22:55:56.764', 607, '2026-03-26 03:55:56.765123', '2026-03-26 03:55:56.765123');
INSERT INTO public.task_entries VALUES ('7ad08c51-992e-4998-8292-f7fbe9d929f8', 'f9c59b9a-0d5a-45e2-a5da-204196a024c2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Exam', 3, NULL, '11:00:00', '13:00:00', 120, true, '2026-03-25 22:55:56.767', 608, '2026-03-26 03:55:56.768493', '2026-03-26 03:55:56.768493');
INSERT INTO public.task_entries VALUES ('48f322af-b1ae-4548-944f-02a84e450f57', '28b22a9f-f1ad-45a8-b8bf-6ddd488608d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '01:30:00', '05:00:00', 210, true, '2026-03-25 22:55:56.774', 609, '2026-03-26 03:55:56.774742', '2026-03-26 03:55:56.774742');
INSERT INTO public.task_entries VALUES ('b7dd426c-4ce3-4603-918d-7633525ab74a', '28b22a9f-f1ad-45a8-b8bf-6ddd488608d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'DT', 3, NULL, '05:00:00', '07:00:00', 120, true, '2026-03-25 22:55:56.777', 610, '2026-03-26 03:55:56.778506', '2026-03-26 03:55:56.778506');
INSERT INTO public.task_entries VALUES ('74f6e6b8-84cc-4a47-89bb-15264c9e24b6', '28b22a9f-f1ad-45a8-b8bf-6ddd488608d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '07:00:00', '09:00:00', 180, true, '2026-03-25 22:55:56.781', 611, '2026-03-26 03:55:56.78153', '2026-03-26 03:55:56.78153');
INSERT INTO public.task_entries VALUES ('3235900e-af08-4abf-a4c7-02c549f2e05b', '28b22a9f-f1ad-45a8-b8bf-6ddd488608d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '10:00:00', '11:40:00', 100, true, '2026-03-25 22:55:56.784', 612, '2026-03-26 03:55:56.785046', '2026-03-26 03:55:56.785046');
INSERT INTO public.task_entries VALUES ('066c1e99-9c7d-43b2-8f02-a7287d04a85d', '28b22a9f-f1ad-45a8-b8bf-6ddd488608d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Peter Automation Project', 3, NULL, '12:00:00', '12:16:00', 16, true, '2026-03-25 22:55:56.79', 613, '2026-03-26 03:55:56.791246', '2026-03-26 03:55:56.791246');
INSERT INTO public.task_entries VALUES ('94260901-8dae-49c7-a9ba-55d3fd171ba1', '28b22a9f-f1ad-45a8-b8bf-6ddd488608d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Finding Video Editor, Bidder & N8N', 3, NULL, '12:16:00', '13:00:00', 44, true, '2026-03-25 22:55:56.794', 614, '2026-03-26 03:55:56.794685', '2026-03-26 03:55:56.794685');
INSERT INTO public.task_entries VALUES ('b33f47b9-4f34-403c-820a-a938f5ede11f', 'aa0e83ca-fc59-45cf-a695-5e3b25288730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DB Exam Preparation', 3, NULL, '05:00:00', '07:00:00', 120, true, '2026-03-25 22:55:56.802', 615, '2026-03-26 03:55:56.803251', '2026-03-26 03:55:56.803251');
INSERT INTO public.task_entries VALUES ('0e99a685-d3ba-4a06-9765-a280ba8989b4', 'aa0e83ca-fc59-45cf-a695-5e3b25288730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DB Exam', 3, NULL, '08:30:00', '10:00:00', 90, true, '2026-03-25 22:55:56.805', 616, '2026-03-26 03:55:56.805837', '2026-03-26 03:55:56.805837');
INSERT INTO public.task_entries VALUES ('67272262-408d-4d9d-8ea2-4c610a3da5cb', 'aa0e83ca-fc59-45cf-a695-5e3b25288730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'CD Exam Preparation', 3, NULL, '11:00:00', '13:30:00', 150, true, '2026-03-25 22:55:56.808', 617, '2026-03-26 03:55:56.809456', '2026-03-26 03:55:56.809456');
INSERT INTO public.task_entries VALUES ('9c062ffe-a522-45f8-884a-629b19c75e11', 'aa0e83ca-fc59-45cf-a695-5e3b25288730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DB Exam', 3, NULL, '13:30:00', '15:00:00', 90, true, '2026-03-25 22:55:56.812', 618, '2026-03-26 03:55:56.812885', '2026-03-26 03:55:56.812885');
INSERT INTO public.task_entries VALUES ('39856888-d32a-491b-8e1c-23bbf81f4894', 'aa0e83ca-fc59-45cf-a695-5e3b25288730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 3, NULL, '15:00:00', '19:00:00', 390, true, '2026-03-25 22:55:56.815', 619, '2026-03-26 03:55:56.815554', '2026-03-26 03:55:56.815554');
INSERT INTO public.task_entries VALUES ('69ab30fa-d22f-4e1a-8605-650d35edb416', '590dc50a-9c1c-4058-90b4-37865d2fd9b4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '09:30:00', '16:30:00', 420, true, '2026-03-25 22:55:56.822', 620, '2026-03-26 03:55:56.823101', '2026-03-26 03:55:56.823101');
INSERT INTO public.task_entries VALUES ('274ad607-0784-46d6-9686-b0ec2719c15f', '590dc50a-9c1c-4058-90b4-37865d2fd9b4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:30:00', '20:00:00', 210, true, '2026-03-25 22:55:56.825', 621, '2026-03-26 03:55:56.826394', '2026-03-26 03:55:56.826394');
INSERT INTO public.task_entries VALUES ('58119ebf-a3f7-416f-ac45-21c82de499fd', '590dc50a-9c1c-4058-90b4-37865d2fd9b4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Finding Video Editor, Bidder & N8N', 3, NULL, '20:16:00', '23:30:00', 194, true, '2026-03-25 22:55:56.829', 622, '2026-03-26 03:55:56.829709', '2026-03-26 03:55:56.829709');
INSERT INTO public.task_entries VALUES ('3898431c-ccde-4931-9f86-39f366d5211f', '590dc50a-9c1c-4058-90b4-37865d2fd9b4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Inbox', 3, NULL, '23:30:00', '00:00:00', 30, true, '2026-03-25 22:55:56.834', 623, '2026-03-26 03:55:56.83493', '2026-03-26 03:55:56.83493');
INSERT INTO public.task_entries VALUES ('a6e56de3-9d6f-4241-bbe9-447ef5fd7259', 'fee40146-10df-40f1-bc00-1652a21a1a2c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '01:10:00', 150, true, '2026-03-25 22:55:56.841', 624, '2026-03-26 03:55:56.842271', '2026-03-26 03:55:56.842271');
INSERT INTO public.task_entries VALUES ('57565578-5ffb-4da8-865e-02e0bc0ce1e9', 'fee40146-10df-40f1-bc00-1652a21a1a2c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '10:40:00', '16:20:00', 340, true, '2026-03-25 22:55:56.845', 625, '2026-03-26 03:55:56.846091', '2026-03-26 03:55:56.846091');
INSERT INTO public.task_entries VALUES ('7d5aa03b-b0ed-4e28-80ba-592f114f27c6', 'fee40146-10df-40f1-bc00-1652a21a1a2c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Inbox', 3, NULL, '17:30:00', '18:00:00', 30, true, '2026-03-25 22:55:56.849', 626, '2026-03-26 03:55:56.849694', '2026-03-26 03:55:56.849694');
INSERT INTO public.task_entries VALUES ('8c2ba363-f6ae-49be-8ed2-8cfc546b88ad', 'fee40146-10df-40f1-bc00-1652a21a1a2c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding Areeba Training', 3, NULL, '20:30:00', '21:40:00', 70, true, '2026-03-25 22:55:56.852', 627, '2026-03-26 03:55:56.853459', '2026-03-26 03:55:56.853459');
INSERT INTO public.task_entries VALUES ('5573a70e-9575-4e87-872a-2ef288258afe', 'd0c39bbb-71a0-4640-b64d-46d87ec66c57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '10:00:00', '11:50:00', 230, true, '2026-03-25 22:55:56.859', 628, '2026-03-26 03:55:56.860228', '2026-03-26 03:55:56.860228');
INSERT INTO public.task_entries VALUES ('593c036f-336d-4bf1-81f1-71177b1ec39c', 'd0c39bbb-71a0-4640-b64d-46d87ec66c57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Management', 3, NULL, '11:50:00', '14:25:00', 155, true, '2026-03-25 22:55:56.863', 629, '2026-03-26 03:55:56.86383', '2026-03-26 03:55:56.86383');
INSERT INTO public.task_entries VALUES ('e9fe6fcd-8ceb-4f36-af89-9f8fa214c948', 'd0c39bbb-71a0-4640-b64d-46d87ec66c57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mohammad Saad Gohar upwork bidder meeting 02:30 pm', 3, NULL, '14:25:00', '14:40:00', 15, true, '2026-03-25 22:55:56.866', 630, '2026-03-26 03:55:56.867444', '2026-03-26 03:55:56.867444');
INSERT INTO public.task_entries VALUES ('6a84a341-996b-4015-bc57-6696892fd061', 'd0c39bbb-71a0-4640-b64d-46d87ec66c57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Weekly Content Upload', 3, NULL, '14:40:00', '15:30:00', 50, true, '2026-03-25 22:55:56.871', 631, '2026-03-26 03:55:56.871856', '2026-03-26 03:55:56.871856');
INSERT INTO public.task_entries VALUES ('80b9bfa4-c447-43a2-8ff6-d7eef857e8fa', 'd0c39bbb-71a0-4640-b64d-46d87ec66c57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Ade Dar Upwork Automation Meeting 4:15pm - 05:00pm', 3, NULL, '16:15:00', '16:40:00', 25, true, '2026-03-25 22:55:56.876', 632, '2026-03-26 03:55:56.877377', '2026-03-26 03:55:56.877377');
INSERT INTO public.task_entries VALUES ('9943e2bf-260b-4e09-a96a-ccae4f3a393e', 'd0c39bbb-71a0-4640-b64d-46d87ec66c57', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '19:30:00', '20:30:00', 60, true, '2026-03-25 22:55:56.88', 633, '2026-03-26 03:55:56.881442', '2026-03-26 03:55:56.881442');
INSERT INTO public.task_entries VALUES ('dd86af20-1494-4427-a3aa-7b92ade8c368', '0c7d67a1-430f-4a19-bc75-4ba810ed8d11', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '07:00:00', '08:00:00', 60, true, '2026-03-25 22:55:56.888', 634, '2026-03-26 03:55:56.888886', '2026-03-26 03:55:56.888886');
INSERT INTO public.task_entries VALUES ('6e0d94f5-7fc0-4a7f-8c00-6bf9d9144ef2', '0c7d67a1-430f-4a19-bc75-4ba810ed8d11', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DBMS Lab Exam', 3, NULL, '08:00:00', '11:00:00', 180, true, '2026-03-25 22:55:56.892', 635, '2026-03-26 03:55:56.892498', '2026-03-26 03:55:56.892498');
INSERT INTO public.task_entries VALUES ('113a7f27-9cbd-4a62-9da3-7eb6cd0151ac', '0c7d67a1-430f-4a19-bc75-4ba810ed8d11', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'MIcs Lib - Upwork, SM', 3, NULL, '12:00:00', '14:30:00', 150, true, '2026-03-25 22:55:56.895', 636, '2026-03-26 03:55:56.896226', '2026-03-26 03:55:56.896226');
INSERT INTO public.task_entries VALUES ('ba4b64f0-d5ab-4696-86db-d9467e26b6bf', '0c7d67a1-430f-4a19-bc75-4ba810ed8d11', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Upwork Bidding', 3, NULL, '14:30:00', '16:30:00', 120, true, '2026-03-25 22:55:56.898', 637, '2026-03-26 03:55:56.899452', '2026-03-26 03:55:56.899452');
INSERT INTO public.task_entries VALUES ('d2cfe0fb-6a0c-4752-8bb3-1dc7d184bc1f', '0c7d67a1-430f-4a19-bc75-4ba810ed8d11', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI', 3, NULL, '16:30:00', '18:00:00', 90, true, '2026-03-25 22:55:56.904', 638, '2026-03-26 03:55:56.904822', '2026-03-26 03:55:56.904822');
INSERT INTO public.task_entries VALUES ('6ee82e6a-2c4e-4b8e-aa58-03af707a0673', '0c7d67a1-430f-4a19-bc75-4ba810ed8d11', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Scraping', 3, NULL, '19:00:00', '22:00:00', 180, true, '2026-03-25 22:55:56.909', 639, '2026-03-26 03:55:56.90997', '2026-03-26 03:55:56.90997');
INSERT INTO public.task_entries VALUES ('81a337c0-2706-40b3-a0cb-52f2bc92e0c6', 'fd5e19ad-c385-45c2-9f3f-32b5d85e1b65', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '08:00:00', '11:00:00', 180, true, '2026-03-25 22:55:56.919', 640, '2026-03-26 03:55:56.920038', '2026-03-26 03:55:56.920038');
INSERT INTO public.task_entries VALUES ('3ca33161-9803-488e-8fd4-a9994a0db64e', 'fd5e19ad-c385-45c2-9f3f-32b5d85e1b65', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '11:30:00', '12:30:00', 270, true, '2026-03-25 22:55:56.922', 641, '2026-03-26 03:55:56.923544', '2026-03-26 03:55:56.923544');
INSERT INTO public.task_entries VALUES ('98c242fd-7747-4517-b835-32ea9d1cac0d', 'fd5e19ad-c385-45c2-9f3f-32b5d85e1b65', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni WL', 3, NULL, '12:30:00', '14:45:00', 135, true, '2026-03-25 22:55:56.926', 642, '2026-03-26 03:55:56.926497', '2026-03-26 03:55:56.926497');
INSERT INTO public.task_entries VALUES ('ac79cf04-2760-467f-beeb-356838259fe4', 'fd5e19ad-c385-45c2-9f3f-32b5d85e1b65', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Bank', 3, NULL, '14:50:00', '16:10:00', 80, true, '2026-03-25 22:55:56.929', 643, '2026-03-26 03:55:56.929903', '2026-03-26 03:55:56.929903');
INSERT INTO public.task_entries VALUES ('2447845a-d6b1-4c7a-8b61-b25c4237d20b', 'fd5e19ad-c385-45c2-9f3f-32b5d85e1b65', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni DBMS', 3, NULL, '16:30:00', '17:20:00', 50, true, '2026-03-25 22:55:56.932', 644, '2026-03-26 03:55:56.932682', '2026-03-26 03:55:56.932682');
INSERT INTO public.task_entries VALUES ('6e234eac-ba0c-4441-b2c6-06fdbf60d97a', 'fd5e19ad-c385-45c2-9f3f-32b5d85e1b65', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Project Setup', 3, NULL, '21:10:00', '22:20:00', 70, true, '2026-03-25 22:55:56.937', 645, '2026-03-26 03:55:56.93788', '2026-03-26 03:55:56.93788');
INSERT INTO public.task_entries VALUES ('ffae32aa-d482-4f66-a951-934c3d72eed3', 'fd5e19ad-c385-45c2-9f3f-32b5d85e1b65', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '22:20:00', '02:00:00', 220, true, '2026-03-25 22:55:56.94', 646, '2026-03-26 03:55:56.941449', '2026-03-26 03:55:56.941449');
INSERT INTO public.task_entries VALUES ('dc358a74-faf0-43ef-b82f-da8eae68b94b', 'b4244dae-554d-4aca-8b14-238194f11ee4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni AI Lab', 3, NULL, '06:30:00', '11:00:00', 270, true, '2026-03-25 22:55:56.95', 648, '2026-03-26 03:55:56.951243', '2026-03-26 03:55:56.951243');
INSERT INTO public.task_entries VALUES ('1a52bd55-eee8-476c-9906-2cdc6f3d657a', 'b4244dae-554d-4aca-8b14-238194f11ee4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '15:00:00', '18:00:00', 180, true, '2026-03-25 22:55:56.954', 649, '2026-03-26 03:55:56.954637', '2026-03-26 03:55:56.954637');
INSERT INTO public.task_entries VALUES ('2092c53e-eb65-41b1-a78b-6a8f648ac757', 'b4244dae-554d-4aca-8b14-238194f11ee4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Project Succession', 3, NULL, '20:00:00', '21:00:00', 60, true, '2026-03-25 22:55:56.957', 650, '2026-03-26 03:55:56.957908', '2026-03-26 03:55:56.957908');
INSERT INTO public.task_entries VALUES ('328cf90b-2c9a-43d2-abe2-39274d6ba721', '4ba3af4e-8906-4bda-8cee-b5c52d4cc1b1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '01:20:00', 260, true, '2026-03-25 22:55:56.963', 651, '2026-03-26 03:55:56.964444', '2026-03-26 03:55:56.964444');
INSERT INTO public.task_entries VALUES ('cbee74d2-e6ba-422c-b98e-c4b16ecefe24', '4ba3af4e-8906-4bda-8cee-b5c52d4cc1b1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '11:00:00', NULL, NULL, true, '2026-03-25 22:55:56.969', 652, '2026-03-26 03:55:56.970271', '2026-03-26 03:55:56.970271');
INSERT INTO public.task_entries VALUES ('a8037792-e696-43d9-a283-920b224c03aa', '749b8e82-2f50-4dbc-b2d1-f7f0561b3652', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:30:00', '22:00:00', 30, true, '2026-03-25 22:55:56.977', 653, '2026-03-26 03:55:56.977493', '2026-03-26 03:55:56.977493');
INSERT INTO public.task_entries VALUES ('8970cded-10a9-4a8a-ab1c-efd16460f7b9', '749b8e82-2f50-4dbc-b2d1-f7f0561b3652', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Upwork', 3, NULL, '22:00:00', '03:00:00', 300, true, '2026-03-25 22:55:56.98', 654, '2026-03-26 03:55:56.981084', '2026-03-26 03:55:56.981084');
INSERT INTO public.task_entries VALUES ('924aaef0-addc-4115-8f0c-69da95176642', 'ab615ef5-0f66-4530-bc4e-e510dd3ded4f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '08:00:00', '12:00:00', 240, true, '2026-03-25 22:55:56.987', 655, '2026-03-26 03:55:56.988144', '2026-03-26 03:55:56.988144');
INSERT INTO public.task_entries VALUES ('b294919a-2403-43ee-b674-d4ec6c6dfce4', 'ab615ef5-0f66-4530-bc4e-e510dd3ded4f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '12:00:00', '14:00:00', 150, true, '2026-03-25 22:55:56.99', 656, '2026-03-26 03:55:56.991215', '2026-03-26 03:55:56.991215');
INSERT INTO public.task_entries VALUES ('3fb38963-6f5c-4caf-9792-722160d54808', 'ab615ef5-0f66-4530-bc4e-e510dd3ded4f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '14:00:00', '18:30:00', 270, true, '2026-03-25 22:55:56.994', 657, '2026-03-26 03:55:56.994719', '2026-03-26 03:55:56.994719');
INSERT INTO public.task_entries VALUES ('8506be05-e4a8-4f85-a9a3-7e7ff0e1dffc', 'ab615ef5-0f66-4530-bc4e-e510dd3ded4f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Freelancers Payment Cleared', 3, NULL, '18:30:00', '19:05:00', 35, true, '2026-03-25 22:55:56.997', 658, '2026-03-26 03:55:56.998344', '2026-03-26 03:55:56.998344');
INSERT INTO public.task_entries VALUES ('6c8ded84-7835-4905-bd8a-70c1d4977de7', '7af0b30f-43da-4ca4-a01a-45fa5aba419a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc', 3, NULL, '11:00:00', '18:30:00', 450, true, '2026-03-25 22:55:57.005', 659, '2026-03-26 03:55:57.006136', '2026-03-26 03:55:57.006136');
INSERT INTO public.task_entries VALUES ('2820aaa4-cf14-4c14-9104-5dd5546727f0', '7af0b30f-43da-4ca4-a01a-45fa5aba419a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:30:00', '02:00:00', 390, true, '2026-03-25 22:55:57.011', 660, '2026-03-26 03:55:57.011656', '2026-03-26 03:55:57.011656');
INSERT INTO public.task_entries VALUES ('e88f8e3d-348b-48a8-81a0-5b9b63f8fe65', '2f0d7c41-e05d-45b9-944d-417053d8075e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Project Setup', 3, NULL, '02:00:00', '04:30:00', 150, true, '2026-03-25 22:55:57.019', 661, '2026-03-26 03:55:57.020612', '2026-03-26 03:55:57.020612');
INSERT INTO public.task_entries VALUES ('e7d2537f-984a-45da-9c12-e374c4f00cc2', '2f0d7c41-e05d-45b9-944d-417053d8075e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '11:00:00', '12:30:00', 240, true, '2026-03-25 22:55:57.023', 662, '2026-03-26 03:55:57.023617', '2026-03-26 03:55:57.023617');
INSERT INTO public.task_entries VALUES ('f01dfff3-7481-494e-8d6e-739e4b3981d8', '2f0d7c41-e05d-45b9-944d-417053d8075e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DBMS', 3, NULL, '12:30:00', '14:45:00', 135, true, '2026-03-25 22:55:57.026', 663, '2026-03-26 03:55:57.027372', '2026-03-26 03:55:57.027372');
INSERT INTO public.task_entries VALUES ('a19e39f9-e50f-4d45-913f-0e342432408f', '2f0d7c41-e05d-45b9-944d-417053d8075e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Project Setup', 3, NULL, '14:45:00', '16:30:00', 105, true, '2026-03-25 22:55:57.03', 664, '2026-03-26 03:55:57.030697', '2026-03-26 03:55:57.030697');
INSERT INTO public.task_entries VALUES ('32c92a58-46a9-4143-8fe9-05792e0e4dc2', '2f0d7c41-e05d-45b9-944d-417053d8075e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Class', 3, NULL, '16:30:00', '17:40:00', 70, true, '2026-03-25 22:55:57.033', 665, '2026-03-26 03:55:57.0342', '2026-03-26 03:55:57.0342');
INSERT INTO public.task_entries VALUES ('ef1f9a90-3212-4b04-80e0-2fc1690eadf7', '2f0d7c41-e05d-45b9-944d-417053d8075e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork', 3, NULL, '20:10:00', '23:00:00', 170, true, '2026-03-25 22:55:57.037', 666, '2026-03-26 03:55:57.037977', '2026-03-26 03:55:57.037977');
INSERT INTO public.task_entries VALUES ('89cade13-34e2-4d20-87af-c53a005374ec', '9b088830-0951-4cbc-bdf6-9f78f17f98e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '08:00:00', '09:45:00', 285, true, '2026-03-25 22:55:57.044', 667, '2026-03-26 03:55:57.044647', '2026-03-26 03:55:57.044647');
INSERT INTO public.task_entries VALUES ('e3c42ce0-204d-4e47-99ea-8026fa0e528f', '9b088830-0951-4cbc-bdf6-9f78f17f98e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '09:45:00', '10:45:00', 60, true, '2026-03-25 22:55:57.047', 668, '2026-03-26 03:55:57.048118', '2026-03-26 03:55:57.048118');
INSERT INTO public.task_entries VALUES ('14c519a7-0281-4031-9a3e-04e8ff5eabdf', '9b088830-0951-4cbc-bdf6-9f78f17f98e4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Classes', 3, NULL, '16:30:00', '18:30:00', 120, true, '2026-03-25 22:55:57.051', 669, '2026-03-26 03:55:57.051846', '2026-03-26 03:55:57.051846');
INSERT INTO public.task_entries VALUES ('995eab9c-6f59-4502-aef7-2b045d674b7f', '8d843cff-66b5-4309-bd75-b76daa4e786d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Lab', 3, NULL, '07:30:00', '10:50:00', 200, true, '2026-03-25 22:55:57.058', 670, '2026-03-26 03:55:57.058785', '2026-03-26 03:55:57.058785');
INSERT INTO public.task_entries VALUES ('d745a5be-356e-4b2e-8cfe-3856cc4aebe0', '8d843cff-66b5-4309-bd75-b76daa4e786d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '11:00:00', '12:30:00', 90, true, '2026-03-25 22:55:57.063', 671, '2026-03-26 03:55:57.063855', '2026-03-26 03:55:57.063855');
INSERT INTO public.task_entries VALUES ('522c9dd7-0355-4f3a-9a34-48ec3013cf19', '8d843cff-66b5-4309-bd75-b76daa4e786d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '12:30:00', '13:30:00', 60, true, '2026-03-25 22:55:57.066', 672, '2026-03-26 03:55:57.067484', '2026-03-26 03:55:57.067484');
INSERT INTO public.task_entries VALUES ('24996798-3562-4ee6-b19e-44e9a00ab623', '8d843cff-66b5-4309-bd75-b76daa4e786d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project GSA', 3, NULL, '13:30:00', '14:15:00', 45, true, '2026-03-25 22:55:57.07', 673, '2026-03-26 03:55:57.070856', '2026-03-26 03:55:57.070856');
INSERT INTO public.task_entries VALUES ('041b6068-556d-4506-ae02-1950dc49bc5d', '9e616173-818d-460e-9edc-d56a64d557dd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '13:00:00', '15:00:00', 210, true, '2026-03-25 22:55:57.077', 674, '2026-03-26 03:55:57.078324', '2026-03-26 03:55:57.078324');
INSERT INTO public.task_entries VALUES ('a1af1ed8-996d-4527-8410-8068799e61c5', '9e616173-818d-460e-9edc-d56a64d557dd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '15:00:00', '18:00:00', 180, true, '2026-03-25 22:55:57.081', 675, '2026-03-26 03:55:57.082706', '2026-03-26 03:55:57.082706');
INSERT INTO public.task_entries VALUES ('972c8330-6109-4435-beec-21caa17a0a6b', '9e616173-818d-460e-9edc-d56a64d557dd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Fiverr', 3, NULL, '20:00:00', '22:00:00', 120, true, '2026-03-25 22:55:57.086', 676, '2026-03-26 03:55:57.086752', '2026-03-26 03:55:57.086752');
INSERT INTO public.task_entries VALUES ('290d24ec-a9e0-46bd-a2cb-00c62df8c5ad', '9e616173-818d-460e-9edc-d56a64d557dd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Automation Learning', 3, NULL, '23:00:00', '03:00:00', 240, true, '2026-03-25 22:55:57.089', 677, '2026-03-26 03:55:57.090342', '2026-03-26 03:55:57.090342');
INSERT INTO public.task_entries VALUES ('4704dc1e-57d8-439f-b182-f5a51543b59b', '67a6625a-f10c-48ed-a3a2-201807a3d5f8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '13:00:00', '14:30:00', 90, true, '2026-03-25 22:55:57.098', 678, '2026-03-26 03:55:57.099028', '2026-03-26 03:55:57.099028');
INSERT INTO public.task_entries VALUES ('ae44dabc-cc22-42e2-9e08-8d96b78cf631', '67a6625a-f10c-48ed-a3a2-201807a3d5f8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '16:30:00', 150, true, '2026-03-25 22:55:57.102', 679, '2026-03-26 03:55:57.102926', '2026-03-26 03:55:57.102926');
INSERT INTO public.task_entries VALUES ('a2fca3ca-fa7f-436b-af84-6bf1101e3dd7', '67a6625a-f10c-48ed-a3a2-201807a3d5f8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '16:30:00', '19:00:00', 150, true, '2026-03-25 22:55:57.106', 680, '2026-03-26 03:55:57.107175', '2026-03-26 03:55:57.107175');
INSERT INTO public.task_entries VALUES ('ad772cbc-f209-4e64-913a-ebe42a63d916', '67a6625a-f10c-48ed-a3a2-201807a3d5f8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '19:00:00', '20:00:00', 110, true, '2026-03-25 22:55:57.112', 681, '2026-03-26 03:55:57.113382', '2026-03-26 03:55:57.113382');
INSERT INTO public.task_entries VALUES ('d4e6bd4f-974b-4214-9ec3-4d78cfc72f19', '67a6625a-f10c-48ed-a3a2-201807a3d5f8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project GSA', 3, NULL, '20:00:00', '21:20:00', 80, true, '2026-03-25 22:55:57.117', 682, '2026-03-26 03:55:57.118536', '2026-03-26 03:55:57.118536');
INSERT INTO public.task_entries VALUES ('e59dd572-4dac-4b02-9388-ca998a518c0b', 'a36beb9e-9398-4157-889d-40d0c9c48c2b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Finding Fiverr Expert', 3, NULL, '00:00:00', '00:30:00', 30, true, '2026-03-25 22:55:57.126', 683, '2026-03-26 03:55:57.127323', '2026-03-26 03:55:57.127323');
INSERT INTO public.task_entries VALUES ('ddc7152e-cff2-4aa4-b37d-93aa1c32d1f5', 'a36beb9e-9398-4157-889d-40d0c9c48c2b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Automation Learning', 3, NULL, '00:30:00', '03:30:00', 180, true, '2026-03-25 22:55:57.13', 684, '2026-03-26 03:55:57.131716', '2026-03-26 03:55:57.131716');
INSERT INTO public.task_entries VALUES ('94a22a4c-580d-48ee-8bb7-f026defe7af2', 'a36beb9e-9398-4157-889d-40d0c9c48c2b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '12:00:00', '13:30:00', 200, true, '2026-03-25 22:55:57.134', 685, '2026-03-26 03:55:57.135637', '2026-03-26 03:55:57.135637');
INSERT INTO public.task_entries VALUES ('dcb00728-8c6b-46e4-85a0-eb3efd2945e6', 'a36beb9e-9398-4157-889d-40d0c9c48c2b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project Moji', 3, NULL, '15:00:00', '15:30:00', 30, true, '2026-03-25 22:55:57.138', 686, '2026-03-26 03:55:57.139596', '2026-03-26 03:55:57.139596');
INSERT INTO public.task_entries VALUES ('f557095c-c573-4f79-b300-7cb8d8cde0bb', 'a36beb9e-9398-4157-889d-40d0c9c48c2b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '15:30:00', '17:45:00', 135, true, '2026-03-25 22:55:57.143', 687, '2026-03-26 03:55:57.143986', '2026-03-26 03:55:57.143986');
INSERT INTO public.task_entries VALUES ('1ea6f4c4-d482-46f8-aeaa-00fa1dcff1e4', 'a36beb9e-9398-4157-889d-40d0c9c48c2b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Automation Learning', 3, NULL, '18:30:00', '22:30:00', 240, true, '2026-03-25 22:55:57.147', 688, '2026-03-26 03:55:57.148407', '2026-03-26 03:55:57.148407');
INSERT INTO public.task_entries VALUES ('991e5563-bb7c-411b-b11e-8b2672ea078c', 'a36beb9e-9398-4157-889d-40d0c9c48c2b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:30:00', '00:20:00', 110, true, '2026-03-25 22:55:57.151', 689, '2026-03-26 03:55:57.152529', '2026-03-26 03:55:57.152529');
INSERT INTO public.task_entries VALUES ('3696a3b7-5812-4cb6-9402-2f0b5af5eac9', 'b68e09d8-7c84-4ef1-b85b-164cef23e75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'C&D', 3, NULL, '10:00:00', '12:30:00', 150, true, '2026-03-25 22:55:57.16', 690, '2026-03-26 03:55:57.161159', '2026-03-26 03:55:57.161159');
INSERT INTO public.task_entries VALUES ('3a833972-e971-4473-a8e5-73d5e4742a1e', 'b68e09d8-7c84-4ef1-b85b-164cef23e75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'KNCT - Misc', 3, NULL, '12:30:00', '16:30:00', 240, true, '2026-03-25 22:55:57.166', 691, '2026-03-26 03:55:57.167311', '2026-03-26 03:55:57.167311');
INSERT INTO public.task_entries VALUES ('51d05306-1ef3-4fee-b93c-d3e05a8dbcb3', 'b68e09d8-7c84-4ef1-b85b-164cef23e75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE', 3, NULL, '16:30:00', '18:30:00', 120, true, '2026-03-25 22:55:57.169', 692, '2026-03-26 03:55:57.1707', '2026-03-26 03:55:57.1707');
INSERT INTO public.task_entries VALUES ('b7022fb4-e8d6-4d99-be09-bdbdb9d7992e', 'b68e09d8-7c84-4ef1-b85b-164cef23e75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:30:00', '19:30:00', 60, true, '2026-03-25 22:55:57.173', 693, '2026-03-26 03:55:57.174135', '2026-03-26 03:55:57.174135');
INSERT INTO public.task_entries VALUES ('3364dc56-8bbe-41be-a83f-3151527f82ca', 'b68e09d8-7c84-4ef1-b85b-164cef23e75f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Shana Meeting', 3, NULL, '20:00:00', '20:20:00', 20, true, '2026-03-25 22:55:57.177', 694, '2026-03-26 03:55:57.177999', '2026-03-26 03:55:57.177999');
INSERT INTO public.task_entries VALUES ('dc072e99-b7ee-43f2-82e3-a77c5970d93c', '0a026232-e215-43d8-8bda-495dd0bd5e39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '13:00:00', '13:30:00', 30, true, '2026-03-25 22:55:57.184', 695, '2026-03-26 03:55:57.185639', '2026-03-26 03:55:57.185639');
INSERT INTO public.task_entries VALUES ('2b0e8e35-f3e6-42b1-b68d-de3d3b9a7c02', '0a026232-e215-43d8-8bda-495dd0bd5e39', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '13:30:00', '20:40:00', 670, true, '2026-03-25 22:55:57.189', 696, '2026-03-26 03:55:57.189929', '2026-03-26 03:55:57.189929');
INSERT INTO public.task_entries VALUES ('81a3c0cb-ead3-40c3-9601-d90fbc8d789b', '3e254983-36e7-452a-bf98-2bb5905ad08a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project GSA', 3, NULL, '01:10:00', '01:40:00', 30, true, '2026-03-25 22:55:57.197', 697, '2026-03-26 03:55:57.198112', '2026-03-26 03:55:57.198112');
INSERT INTO public.task_entries VALUES ('1d4c4129-d3bb-4fd0-bdfc-4e6a0e8e336d', '3e254983-36e7-452a-bf98-2bb5905ad08a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project halloEnergie', 3, NULL, '01:40:00', '02:00:00', 20, true, '2026-03-25 22:55:57.201', 698, '2026-03-26 03:55:57.202006', '2026-03-26 03:55:57.202006');
INSERT INTO public.task_entries VALUES ('a8a4b2fc-2f45-42ca-8379-04cd17002db4', '3e254983-36e7-452a-bf98-2bb5905ad08a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '02:00:00', '02:50:00', 280, true, '2026-03-25 22:55:57.205', 699, '2026-03-26 03:55:57.205965', '2026-03-26 03:55:57.205965');
INSERT INTO public.task_entries VALUES ('ae9eb20a-5171-4a89-99ba-285de5e5b284', '3e254983-36e7-452a-bf98-2bb5905ad08a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '17:30:00', 150, true, '2026-03-25 22:55:57.21', 700, '2026-03-26 03:55:57.210819', '2026-03-26 03:55:57.210819');
INSERT INTO public.task_entries VALUES ('d4a47fae-b520-47c5-aff5-cc14d313d7a8', '3e254983-36e7-452a-bf98-2bb5905ad08a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Automation Learning', 3, NULL, '22:20:00', '03:40:00', 320, true, '2026-03-25 22:55:57.216', 701, '2026-03-26 03:55:57.21718', '2026-03-26 03:55:57.21718');
INSERT INTO public.task_entries VALUES ('264bb314-8847-440f-be99-a2a02467d336', 'd3c76ea5-56a8-4c6b-a4f5-35d49952c239', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '03:40:00', '04:20:00', 40, true, '2026-03-25 22:55:57.225', 702, '2026-03-26 03:55:57.22661', '2026-03-26 03:55:57.22661');
INSERT INTO public.task_entries VALUES ('a8d3e729-dfd9-4d56-8e30-96049bc459a4', 'd3c76ea5-56a8-4c6b-a4f5-35d49952c239', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '04:20:00', '05:00:00', 140, true, '2026-03-25 22:55:57.23', 703, '2026-03-26 03:55:57.231089', '2026-03-26 03:55:57.231089');
INSERT INTO public.task_entries VALUES ('bddb90b3-6ac4-4ff3-9144-88b0dd216b50', 'd3c76ea5-56a8-4c6b-a4f5-35d49952c239', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '17:40:00', '19:30:00', 110, true, '2026-03-25 22:55:57.234', 704, '2026-03-26 03:55:57.235442', '2026-03-26 03:55:57.235442');
INSERT INTO public.task_entries VALUES ('2f4100e8-006b-4407-9db3-1f40996fb9ec', 'd3c76ea5-56a8-4c6b-a4f5-35d49952c239', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Automation Learning', 3, NULL, '21:00:00', '00:10:00', 190, true, '2026-03-25 22:55:57.238', 705, '2026-03-26 03:55:57.239302', '2026-03-26 03:55:57.239302');
INSERT INTO public.task_entries VALUES ('6df93816-b63b-4beb-bd1d-fe062d4461ed', 'f90eca83-29d5-49bf-9822-d24725613285', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Automation Learning', 3, NULL, '00:55:00', '06:30:00', 335, true, '2026-03-25 22:55:57.247', 706, '2026-03-26 03:55:57.24866', '2026-03-26 03:55:57.24866');
INSERT INTO public.task_entries VALUES ('43febdd2-0b4a-42f1-b1b3-16271f9b561c', 'f90eca83-29d5-49bf-9822-d24725613285', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 1, NULL, '06:30:00', '08:00:00', 90, true, '2026-03-25 22:55:57.252', 707, '2026-03-26 03:55:57.253065', '2026-03-26 03:55:57.253065');
INSERT INTO public.task_entries VALUES ('544d06ce-4191-4022-9b5f-e65734a6aa8b', 'f90eca83-29d5-49bf-9822-d24725613285', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:00:00', '18:00:00', 120, true, '2026-03-25 22:55:57.256', 708, '2026-03-26 03:55:57.257123', '2026-03-26 03:55:57.257123');
INSERT INTO public.task_entries VALUES ('82dc2d69-4c0a-438b-a7c9-edb25864a820', 'f90eca83-29d5-49bf-9822-d24725613285', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Automation Learning', 3, NULL, '21:15:00', '06:00:00', 525, true, '2026-03-25 22:55:57.259', 709, '2026-03-26 03:55:57.260646', '2026-03-26 03:55:57.260646');
INSERT INTO public.task_entries VALUES ('8e03ea77-5ab6-4f84-9ba6-43adb453e51d', 'f1cebc74-53d2-4c98-a4c7-26aa457e378e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Automation Learning', 3, NULL, '20:30:00', '05:30:00', 540, true, '2026-03-25 22:55:57.269', 710, '2026-03-26 03:55:57.270563', '2026-03-26 03:55:57.270563');
INSERT INTO public.task_entries VALUES ('593adc08-9afb-493c-9a89-1f5174a59ffa', '2c4d4ab6-10dd-40a0-92aa-2719b529ba75', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '05:30:00', '07:00:00', 90, true, '2026-03-25 22:55:57.277', 711, '2026-03-26 03:55:57.278539', '2026-03-26 03:55:57.278539');
INSERT INTO public.task_entries VALUES ('22fb8916-c6fb-4630-a9fa-1a9224c4d017', '2c4d4ab6-10dd-40a0-92aa-2719b529ba75', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Automation Learning', 3, NULL, '07:00:00', '11:30:00', 270, true, '2026-03-25 22:55:57.281', 712, '2026-03-26 03:55:57.282485', '2026-03-26 03:55:57.282485');
INSERT INTO public.task_entries VALUES ('ac0d688c-ea90-4359-81af-38cd6f46cfeb', '2c4d4ab6-10dd-40a0-92aa-2719b529ba75', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Laiveai AI Meeting 10PM', 3, NULL, '12:00:00', '12:40:00', 40, true, '2026-03-25 22:55:57.285', 713, '2026-03-26 03:55:57.285961', '2026-03-26 03:55:57.285961');
INSERT INTO public.task_entries VALUES ('ec5f9f1f-d2b7-4fef-83d5-32b056b18164', '2c4d4ab6-10dd-40a0-92aa-2719b529ba75', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'HC', 3, NULL, '19:00:00', '22:00:00', 180, true, '2026-03-25 22:55:57.289', 714, '2026-03-26 03:55:57.289815', '2026-03-26 03:55:57.289815');
INSERT INTO public.task_entries VALUES ('10b8483d-0712-40b1-8c5b-953a5afe5aab', '2c4d4ab6-10dd-40a0-92aa-2719b529ba75', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:30:00', '23:00:00', 30, true, '2026-03-25 22:55:57.293', 715, '2026-03-26 03:55:57.294089', '2026-03-26 03:55:57.294089');
INSERT INTO public.task_entries VALUES ('57e04f5e-a8f0-4132-b362-eb6cf83f81b5', '0edcf39f-8f53-492a-a465-8024ddb9821b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Automation Learning', 3, NULL, '00:00:00', '03:30:00', 210, true, '2026-03-25 22:55:57.303', 716, '2026-03-26 03:55:57.304019', '2026-03-26 03:55:57.304019');
INSERT INTO public.task_entries VALUES ('9e32afb7-fba6-4ab8-a7f1-b57e70ffc12f', '0edcf39f-8f53-492a-a465-8024ddb9821b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:30:00', '04:40:00', 790, true, '2026-03-25 22:55:57.307', 717, '2026-03-26 03:55:57.307829', '2026-03-26 03:55:57.307829');
INSERT INTO public.task_entries VALUES ('00dc7eb9-ad36-4daa-981a-99ee254b197c', '0edcf39f-8f53-492a-a465-8024ddb9821b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic Workflow', 3, NULL, '05:30:00', '08:00:00', 150, true, '2026-03-25 22:55:57.31', 718, '2026-03-26 03:55:57.311643', '2026-03-26 03:55:57.311643');
INSERT INTO public.task_entries VALUES ('9649e39a-90d5-43a3-9c61-ce7917398c2e', '0edcf39f-8f53-492a-a465-8024ddb9821b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:30:00', '22:30:00', 240, true, '2026-03-25 22:55:57.315', 719, '2026-03-26 03:55:57.315969', '2026-03-26 03:55:57.315969');
INSERT INTO public.task_entries VALUES ('acb50ae2-f41e-4c26-8c5f-fd52049bf381', '0edcf39f-8f53-492a-a465-8024ddb9821b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:30:00', '23:40:00', 70, true, '2026-03-25 22:55:57.321', 720, '2026-03-26 03:55:57.321473', '2026-03-26 03:55:57.321473');
INSERT INTO public.task_entries VALUES ('7825c7b8-f0d4-4ece-a044-31d591dbd1b6', '6208b703-af25-4a96-a7bf-ff319b9bd14a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:40:00', '00:25:00', 75, true, '2026-03-25 22:55:57.328', 721, '2026-03-26 03:55:57.32914', '2026-03-26 03:55:57.32914');
INSERT INTO public.task_entries VALUES ('b2bfe2d1-5526-41e4-9dae-9d5e14514110', '6208b703-af25-4a96-a7bf-ff319b9bd14a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'PR Productivity MVP', 3, NULL, '03:00:00', '05:00:00', 120, true, '2026-03-25 22:55:57.331', 722, '2026-03-26 03:55:57.331927', '2026-03-26 03:55:57.331927');
INSERT INTO public.task_entries VALUES ('1abf9d73-7e82-47c7-9d31-40af64bf0a72', '6208b703-af25-4a96-a7bf-ff319b9bd14a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '05:30:00', '06:00:00', 30, true, '2026-03-25 22:55:57.334', 723, '2026-03-26 03:55:57.335451', '2026-03-26 03:55:57.335451');
INSERT INTO public.task_entries VALUES ('376114b8-472f-44fc-9721-dcd297bd0b74', '6208b703-af25-4a96-a7bf-ff319b9bd14a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DBMS Lab', 3, NULL, '07:30:00', '11:00:00', 210, true, '2026-03-25 22:55:57.338', 724, '2026-03-26 03:55:57.338981', '2026-03-26 03:55:57.338981');
INSERT INTO public.task_entries VALUES ('4e650a17-2bce-4a02-83f3-d6b4e2c2ea76', '6208b703-af25-4a96-a7bf-ff319b9bd14a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Agency Website Setup', 3, NULL, '11:20:00', '12:20:00', 60, true, '2026-03-25 22:55:57.342', 725, '2026-03-26 03:55:57.342723', '2026-03-26 03:55:57.342723');
INSERT INTO public.task_entries VALUES ('5f97ff1d-98ec-4be8-82d0-f88f180e6aae', '46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '02:05:00', 285, true, '2026-03-25 22:55:57.349', 726, '2026-03-26 03:55:57.349463', '2026-03-26 03:55:57.349463');
INSERT INTO public.task_entries VALUES ('1151a839-8e9c-4cf0-baef-ba9e20f5010e', '46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Expense Calculation', 3, NULL, '02:05:00', '05:40:00', 215, true, '2026-03-25 22:55:57.352', 727, '2026-03-26 03:55:57.353205', '2026-03-26 03:55:57.353205');
INSERT INTO public.task_entries VALUES ('62959211-280f-4467-8c57-0005735a391e', '46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Management', 3, NULL, '05:40:00', '07:00:00', 80, true, '2026-03-25 22:55:57.356', 728, '2026-03-26 03:55:57.356612', '2026-03-26 03:55:57.356612');
INSERT INTO public.task_entries VALUES ('e5ffac4b-b6ae-42eb-9905-690434985aa0', '46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '07:00:00', '08:00:00', 60, true, '2026-03-25 22:55:57.359', 729, '2026-03-26 03:55:57.360363', '2026-03-26 03:55:57.360363');
INSERT INTO public.task_entries VALUES ('a2a96004-607f-4f41-96fc-1af984ed6d17', '46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '20:00:00', '21:00:00', 60, true, '2026-03-25 22:55:57.365', 730, '2026-03-26 03:55:57.365993', '2026-03-26 03:55:57.365993');
INSERT INTO public.task_entries VALUES ('5205c39b-326e-4618-aa1e-d46b1aa1b426', '46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '21:30:00', '22:30:00', 60, true, '2026-03-25 22:55:57.369', 731, '2026-03-26 03:55:57.369907', '2026-03-26 03:55:57.369907');
INSERT INTO public.task_entries VALUES ('b0ac3967-47e5-4aa9-a3e9-c82af02b325a', '46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project GSA', 3, NULL, '22:30:00', '23:30:00', 60, true, '2026-03-25 22:55:57.372', 732, '2026-03-26 03:55:57.373166', '2026-03-26 03:55:57.373166');
INSERT INTO public.task_entries VALUES ('340158ea-0ee8-40e0-8c3d-86cda6be92de', '46f9caf7-25ab-4920-8140-670003901b38', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project halloEnergie', 3, NULL, '23:30:00', '00:00:00', 30, true, '2026-03-25 22:55:57.378', 733, '2026-03-26 03:55:57.378563', '2026-03-26 03:55:57.378563');
INSERT INTO public.task_entries VALUES ('1e28a3d2-59c4-4a3e-b4dc-6fd087d50d88', '2049cb7f-852e-4305-b45d-2314ecb852d4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '00:00:00', '02:00:00', 120, true, '2026-03-25 22:55:57.384', 734, '2026-03-26 03:55:57.385251', '2026-03-26 03:55:57.385251');
INSERT INTO public.task_entries VALUES ('1826697e-4c4e-41f5-845f-58e997e649a1', '2049cb7f-852e-4305-b45d-2314ecb852d4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '02:00:00', '07:05:00', 305, true, '2026-03-25 22:55:57.388', 735, '2026-03-26 03:55:57.388676', '2026-03-26 03:55:57.388676');
INSERT INTO public.task_entries VALUES ('298a9666-521c-4ab8-ba3f-5e65b6a28aee', '2049cb7f-852e-4305-b45d-2314ecb852d4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Lab', 3, NULL, '07:05:00', '11:00:00', 235, true, '2026-03-25 22:55:57.391', 736, '2026-03-26 03:55:57.39235', '2026-03-26 03:55:57.39235');
INSERT INTO public.task_entries VALUES ('25f2f32e-ca7c-4d85-b2a0-0f09b77de2cf', '2049cb7f-852e-4305-b45d-2314ecb852d4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '01:00:00', 180, true, '2026-03-25 22:55:57.395', 737, '2026-03-26 03:55:57.395881', '2026-03-26 03:55:57.395881');
INSERT INTO public.task_entries VALUES ('30804796-5bdf-47da-b4c4-45daa92bbfee', 'c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Agency Setup', 3, NULL, '01:00:00', '03:00:00', 120, true, '2026-03-25 22:55:57.402', 738, '2026-03-26 03:55:57.402677', '2026-03-26 03:55:57.402677');
INSERT INTO public.task_entries VALUES ('0cdf8f32-3dec-4f73-913e-26f4e9ed3870', 'c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Agency Website and Email Setup', 3, NULL, '03:00:00', '04:00:00', 60, true, '2026-03-25 22:55:57.405', 739, '2026-03-26 03:55:57.4064', '2026-03-26 03:55:57.4064');
INSERT INTO public.task_entries VALUES ('f99ba6c2-2e23-435a-a5a4-2851078fe253', 'c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Automation Case Studies', 3, NULL, '04:30:00', '07:30:00', 180, true, '2026-03-25 22:55:57.411', 740, '2026-03-26 03:55:57.411668', '2026-03-26 03:55:57.411668');
INSERT INTO public.task_entries VALUES ('61d98b4b-9de0-4db6-b3dd-e4c8c8777ccd', 'c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Mics', 3, NULL, '07:30:00', '08:30:00', 60, true, '2026-03-25 22:55:57.415', 741, '2026-03-26 03:55:57.415871', '2026-03-26 03:55:57.415871');
INSERT INTO public.task_entries VALUES ('4658b007-7545-44bc-a5f5-3b5763d75abd', 'c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'C&D Lab', 3, NULL, '08:30:00', '11:00:00', 150, true, '2026-03-25 22:55:57.419', 742, '2026-03-26 03:55:57.419659', '2026-03-26 03:55:57.419659');
INSERT INTO public.task_entries VALUES ('5093e06f-d954-41ff-8d1a-c3190d18375c', 'c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'WL', 3, NULL, '13:30:00', '15:00:00', 90, true, '2026-03-25 22:55:57.422', 743, '2026-03-26 03:55:57.423029', '2026-03-26 03:55:57.423029');
INSERT INTO public.task_entries VALUES ('c1b9c30b-488b-478b-a168-e25f7b0ba6af', 'c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Lib - Misc', 3, NULL, '15:00:00', '16:25:00', 85, true, '2026-03-25 22:55:57.428', 744, '2026-03-26 03:55:57.428533', '2026-03-26 03:55:57.428533');
INSERT INTO public.task_entries VALUES ('19542a82-44c3-49a4-b734-a16534953274', 'c0bdaa2b-def2-4dda-997d-5ac699748265', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE', 3, NULL, '16:30:00', '18:00:00', 90, true, '2026-03-25 22:55:57.431', 745, '2026-03-26 03:55:57.431654', '2026-03-26 03:55:57.431654');
INSERT INTO public.task_entries VALUES ('4e69b84a-5be9-417a-9eed-d04e56c14c77', 'abedbe81-44fb-4e76-ae00-6e7d0b94af55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '04:00:00', '05:30:00', 90, true, '2026-03-25 22:55:57.439', 746, '2026-03-26 03:55:57.439638', '2026-03-26 03:55:57.439638');
INSERT INTO public.task_entries VALUES ('fae33605-b08d-4861-a437-09ea950e970b', 'abedbe81-44fb-4e76-ae00-6e7d0b94af55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Project GSA', 3, NULL, '05:30:00', '08:20:00', 170, true, '2026-03-25 22:55:57.442', 747, '2026-03-26 03:55:57.44325', '2026-03-26 03:55:57.44325');
INSERT INTO public.task_entries VALUES ('38005124-e423-4b0c-af78-4eef953fca48', 'abedbe81-44fb-4e76-ae00-6e7d0b94af55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'PG', 3, NULL, '09:00:00', '10:00:00', 60, true, '2026-03-25 22:55:57.446', 748, '2026-03-26 03:55:57.446675', '2026-03-26 03:55:57.446675');
INSERT INTO public.task_entries VALUES ('6f4f3ba6-423c-4f01-8187-e1ac8941d1ff', 'abedbe81-44fb-4e76-ae00-6e7d0b94af55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '11:00:00', '13:00:00', 120, true, '2026-03-25 22:55:57.449', 749, '2026-03-26 03:55:57.449992', '2026-03-26 03:55:57.449992');
INSERT INTO public.task_entries VALUES ('9cff33f5-6d7d-41dd-847e-8c2cd5a551c1', 'abedbe81-44fb-4e76-ae00-6e7d0b94af55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '13:30:00', '17:40:00', 250, true, '2026-03-25 22:55:57.452', 750, '2026-03-26 03:55:57.453414', '2026-03-26 03:55:57.453414');
INSERT INTO public.task_entries VALUES ('4dfce436-1639-4f49-a3f9-05895249ea60', 'abedbe81-44fb-4e76-ae00-6e7d0b94af55', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic Workflow', 3, NULL, '17:40:00', '20:00:00', 270, true, '2026-03-25 22:55:57.458', 751, '2026-03-26 03:55:57.458824', '2026-03-26 03:55:57.458824');
INSERT INTO public.task_entries VALUES ('0064b617-6670-4f50-821e-64f86205a27e', '2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'PG', 3, NULL, '04:30:00', '05:30:00', 60, true, '2026-03-25 22:55:57.464', 752, '2026-03-26 03:55:57.464978', '2026-03-26 03:55:57.464978');
INSERT INTO public.task_entries VALUES ('a054f6c9-af90-4310-8e31-8ede51da8c62', '2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '07:30:00', '08:00:00', 30, true, '2026-03-25 22:55:57.467', 753, '2026-03-26 03:55:57.468286', '2026-03-26 03:55:57.468286');
INSERT INTO public.task_entries VALUES ('50c53901-1c28-4104-a614-c655c1ff5788', '2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '08:00:00', '10:00:00', 120, true, '2026-03-25 22:55:57.471', 754, '2026-03-26 03:55:57.472016', '2026-03-26 03:55:57.472016');
INSERT INTO public.task_entries VALUES ('6c33a649-7904-40c7-b340-5811bf2f07cb', '2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '10:00:00', '11:30:00', 90, true, '2026-03-25 22:55:57.474', 755, '2026-03-26 03:55:57.475257', '2026-03-26 03:55:57.475257');
INSERT INTO public.task_entries VALUES ('5316c651-0fc8-4c27-b622-c7c443af85e3', '2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Hunter Trading invoice', 3, NULL, '11:30:00', '11:40:00', 10, true, '2026-03-25 22:55:57.478', 756, '2026-03-26 03:55:57.478907', '2026-03-26 03:55:57.478907');
INSERT INTO public.task_entries VALUES ('16470c29-3bbc-4d16-8b39-64555dd083e5', '2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Automation Offer to Pitch Upwork Clients', 3, NULL, '11:40:00', '14:00:00', 140, true, '2026-03-25 22:55:57.481', 757, '2026-03-26 03:55:57.482316', '2026-03-26 03:55:57.482316');
INSERT INTO public.task_entries VALUES ('b9d064f5-40de-4880-87c0-4564213a31c9', '2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Agency Website and Email Setup', 3, NULL, '15:00:00', '16:00:00', 60, true, '2026-03-25 22:55:57.485', 758, '2026-03-26 03:55:57.486142', '2026-03-26 03:55:57.486142');
INSERT INTO public.task_entries VALUES ('e038938e-7bb4-458e-a7a1-d734bca538ff', '2f240ae1-fa11-4d6c-bd09-a7a69e012bc1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Never split the difference', 3, NULL, '17:00:00', '17:50:00', 50, true, '2026-03-25 22:55:57.489', 759, '2026-03-26 03:55:57.489857', '2026-03-26 03:55:57.489857');
INSERT INTO public.task_entries VALUES ('5fbc5c44-b2e1-43ef-a76f-2303d2d42ba2', 'e1ee0731-071f-464f-97f0-03b71ffc2076', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '04:40:00', '07:30:00', 230, true, '2026-03-25 22:55:57.497', 760, '2026-03-26 03:55:57.498421', '2026-03-26 03:55:57.498421');
INSERT INTO public.task_entries VALUES ('a01552b6-a8a7-47a8-bd91-67097d39e4a6', 'e1ee0731-071f-464f-97f0-03b71ffc2076', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Agency Website and Email Setup', 3, NULL, '04:40:00', '07:30:00', 440, true, '2026-03-25 22:55:57.503', 761, '2026-03-26 03:55:57.503543', '2026-03-26 03:55:57.503543');
INSERT INTO public.task_entries VALUES ('d3e4494c-a44f-4e9d-a537-553496462f3f', 'e1ee0731-071f-464f-97f0-03b71ffc2076', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE', 3, NULL, '15:30:00', '18:00:00', 150, true, '2026-03-25 22:55:57.506', 762, '2026-03-26 03:55:57.506826', '2026-03-26 03:55:57.506826');
INSERT INTO public.task_entries VALUES ('059a2b3a-451e-422b-a152-60eb71f0234e', '6013c019-5106-4d41-ae51-fc31fc43692e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '06:30:00', '09:00:00', 150, true, '2026-03-25 22:55:57.513', 763, '2026-03-26 03:55:57.514229', '2026-03-26 03:55:57.514229');
INSERT INTO public.task_entries VALUES ('e0898d90-9bfd-4e04-833c-87c33b47cc44', '6013c019-5106-4d41-ae51-fc31fc43692e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '09:00:00', '11:00:00', 120, true, '2026-03-25 22:55:57.53', 764, '2026-03-26 03:55:57.531239', '2026-03-26 03:55:57.531239');
INSERT INTO public.task_entries VALUES ('dad5fa0a-8d72-4715-934e-f9e9606c688c', '6013c019-5106-4d41-ae51-fc31fc43692e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DBMS', 3, NULL, '12:00:00', '15:00:00', 180, true, '2026-03-25 22:55:57.538', 765, '2026-03-26 03:55:57.539088', '2026-03-26 03:55:57.539088');
INSERT INTO public.task_entries VALUES ('986432c8-6712-40a8-99fe-803b72bb2c99', '6013c019-5106-4d41-ae51-fc31fc43692e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Lib Misc', 3, NULL, '15:00:00', '16:30:00', 90, true, '2026-03-25 22:55:57.542', 766, '2026-03-26 03:55:57.543406', '2026-03-26 03:55:57.543406');
INSERT INTO public.task_entries VALUES ('306d1671-816f-4882-996e-6cc73e24887f', '6013c019-5106-4d41-ae51-fc31fc43692e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI', 3, NULL, '16:30:00', '18:00:00', 90, true, '2026-03-25 22:55:57.547', 767, '2026-03-26 03:55:57.547728', '2026-03-26 03:55:57.547728');
INSERT INTO public.task_entries VALUES ('db6c2c48-d263-4324-ac08-141f4646a706', '6013c019-5106-4d41-ae51-fc31fc43692e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Agency Website', 3, NULL, '19:00:00', '22:00:00', 180, true, '2026-03-25 22:55:57.551', 768, '2026-03-26 03:55:57.552084', '2026-03-26 03:55:57.552084');
INSERT INTO public.task_entries VALUES ('0e08c180-d22e-425d-af16-efd42faf009e', '98b155a1-5f8e-41a9-84fa-6f6af4f97723', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '08:00:00', '11:00:00', 180, true, '2026-03-25 22:55:57.56', 769, '2026-03-26 03:55:57.560928', '2026-03-26 03:55:57.560928');
INSERT INTO public.task_entries VALUES ('d171fe76-2e78-4ff0-a1e4-0a10cd5f9c66', '98b155a1-5f8e-41a9-84fa-6f6af4f97723', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '09:00:00', '11:00:00', 120, true, '2026-03-25 22:55:57.566', 770, '2026-03-26 03:55:57.566988', '2026-03-26 03:55:57.566988');
INSERT INTO public.task_entries VALUES ('8710d39e-2133-4a3c-a2ee-a12a01bf48de', '3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '08:00:00', '10:00:00', 120, true, '2026-03-25 22:55:57.572', 771, '2026-03-26 03:55:57.573062', '2026-03-26 03:55:57.573062');
INSERT INTO public.task_entries VALUES ('4d921148-5307-44cf-be77-fa99b09c7f59', '3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SE Assignment', 3, NULL, '10:00:00', '10:20:00', 20, true, '2026-03-25 22:55:57.577', 772, '2026-03-26 03:55:57.57835', '2026-03-26 03:55:57.57835');
INSERT INTO public.task_entries VALUES ('330f4811-2b54-4294-9fdf-36a299e2e3d8', '3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '11:00:00', '12:20:00', 900, true, '2026-03-25 22:55:57.581', 773, '2026-03-26 03:55:57.581814', '2026-03-26 03:55:57.581814');
INSERT INTO public.task_entries VALUES ('76e805fc-a57e-4671-ac5d-b578518e0c41', '3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'WL', 3, NULL, '13:20:00', '15:00:00', 100, true, '2026-03-25 22:55:57.584', 774, '2026-03-26 03:55:57.585291', '2026-03-26 03:55:57.585291');
INSERT INTO public.task_entries VALUES ('4369c757-fdb9-44cf-b280-60a9a139699a', '3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE', 3, NULL, '16:25:00', '18:00:00', 95, true, '2026-03-25 22:55:57.588', 775, '2026-03-26 03:55:57.5887', '2026-03-26 03:55:57.5887');
INSERT INTO public.task_entries VALUES ('a6cf8473-a585-4cfd-b4b2-42093093b004', '3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:30:00', '19:20:00', 50, true, '2026-03-25 22:55:57.59', 776, '2026-03-26 03:55:57.591454', '2026-03-26 03:55:57.591454');
INSERT INTO public.task_entries VALUES ('7715e399-ce72-4ea2-a9d8-291bca0cb841', '3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting', 3, NULL, '19:25:00', '20:00:00', 35, true, '2026-03-25 22:55:57.594', 777, '2026-03-26 03:55:57.594811', '2026-03-26 03:55:57.594811');
INSERT INTO public.task_entries VALUES ('f2546616-f5b3-48cf-a99e-66c286da525e', '3e4b8ea0-2bef-4aa8-bafc-08c3671e9209', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Agency Website', 3, NULL, '20:00:00', '22:30:00', 150, true, '2026-03-25 22:55:57.598', 778, '2026-03-26 03:55:57.599374', '2026-03-26 03:55:57.599374');
INSERT INTO public.task_entries VALUES ('9d2ec00b-c1eb-4578-92e1-5ff9dfa890d9', 'f4524712-ef44-4c14-948f-b79067bb3449', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '18:30:00', 210, true, '2026-03-25 22:55:57.604', 779, '2026-03-26 03:55:57.605359', '2026-03-26 03:55:57.605359');
INSERT INTO public.task_entries VALUES ('9fe345dc-28f2-4cc5-a5f5-e744cbe1fde9', 'f4524712-ef44-4c14-948f-b79067bb3449', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '18:30:00', '19:00:00', 30, true, '2026-03-25 22:55:57.61', 780, '2026-03-26 03:55:57.610666', '2026-03-26 03:55:57.610666');
INSERT INTO public.task_entries VALUES ('b9f138d3-b62c-46c1-91f9-6b0fc9b970df', '1ae2ae88-30d7-4973-8e6c-f5a9496c2b09', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '08:00:00', '14:30:00', 780, true, '2026-03-25 22:55:57.617', 781, '2026-03-26 03:55:57.617667', '2026-03-26 03:55:57.617667');
INSERT INTO public.task_entries VALUES ('a39c7ae1-5b0a-491f-b5f8-e1082902991f', '1ae2ae88-30d7-4973-8e6c-f5a9496c2b09', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '14:30:00', '15:30:00', 60, true, '2026-03-25 22:55:57.62', 782, '2026-03-26 03:55:57.620958', '2026-03-26 03:55:57.620958');
INSERT INTO public.task_entries VALUES ('aa50fdd8-55d4-4284-ac26-66252e933945', '1ae2ae88-30d7-4973-8e6c-f5a9496c2b09', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '15:30:00', '19:30:00', 240, true, '2026-03-25 22:55:57.623', 783, '2026-03-26 03:55:57.623781', '2026-03-26 03:55:57.623781');
INSERT INTO public.task_entries VALUES ('4af45328-29a8-4be3-9e01-a825fc90a5a9', 'b29a9ee8-8fdb-4b66-b78c-9920668fd7c7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'C&D', 3, NULL, '11:00:00', '13:30:00', 150, true, '2026-03-25 22:55:57.629', 784, '2026-03-26 03:55:57.62972', '2026-03-26 03:55:57.62972');
INSERT INTO public.task_entries VALUES ('79e17e24-b272-4c91-b66d-03cc69211c66', 'b29a9ee8-8fdb-4b66-b78c-9920668fd7c7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE', 3, NULL, '16:30:00', '18:00:00', 90, true, '2026-03-25 22:55:57.632', 785, '2026-03-26 03:55:57.632537', '2026-03-26 03:55:57.632537');
INSERT INTO public.task_entries VALUES ('28d222d7-9327-4cda-94af-9ff3d9324edb', 'b29a9ee8-8fdb-4b66-b78c-9920668fd7c7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:00:00', '19:30:00', 90, true, '2026-03-25 22:55:57.635', 786, '2026-03-26 03:55:57.635886', '2026-03-26 03:55:57.635886');
INSERT INTO public.task_entries VALUES ('e918d0e9-cca6-4689-baf1-f43d0c23ae5f', 'b29a9ee8-8fdb-4b66-b78c-9920668fd7c7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DBMS Project', 3, NULL, '20:00:00', '03:00:00', 420, true, '2026-03-25 22:55:57.638', 787, '2026-03-26 03:55:57.638761', '2026-03-26 03:55:57.638761');
INSERT INTO public.task_entries VALUES ('b26baa41-40a0-49f7-9889-1333a2beae51', '86675f2f-0b83-4503-b383-f0abf8240594', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'C&D', 3, NULL, '11:00:00', '15:00:00', 240, true, '2026-03-25 22:55:57.645', 788, '2026-03-26 03:55:57.645777', '2026-03-26 03:55:57.645777');
INSERT INTO public.task_entries VALUES ('d839d708-e3f7-433a-b868-9ed99de81ca5', '86675f2f-0b83-4503-b383-f0abf8240594', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '16:30:00', '19:00:00', 150, true, '2026-03-25 22:55:57.648', 789, '2026-03-26 03:55:57.649116', '2026-03-26 03:55:57.649116');
INSERT INTO public.task_entries VALUES ('d74541f2-8dd4-4c58-be38-872db0e08730', '86675f2f-0b83-4503-b383-f0abf8240594', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:30:00', '21:00:00', 90, true, '2026-03-25 22:55:57.653', 790, '2026-03-26 03:55:57.654434', '2026-03-26 03:55:57.654434');
INSERT INTO public.task_entries VALUES ('da5ebef7-535f-4815-bb16-bef4ecf03a0a', '86675f2f-0b83-4503-b383-f0abf8240594', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Exam Scheduling', 3, NULL, '21:30:00', '22:00:00', 30, true, '2026-03-25 22:55:57.657', 791, '2026-03-26 03:55:57.657875', '2026-03-26 03:55:57.657875');
INSERT INTO public.task_entries VALUES ('889e1ca4-0d39-4d08-8da1-04d5ecf95784', '86675f2f-0b83-4503-b383-f0abf8240594', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Assignment Management', 3, NULL, '22:00:00', '22:45:00', 45, true, '2026-03-25 22:55:57.661', 792, '2026-03-26 03:55:57.662346', '2026-03-26 03:55:57.662346');
INSERT INTO public.task_entries VALUES ('fbf6ae1f-ed83-4ade-8a54-366b970ccae8', '86675f2f-0b83-4503-b383-f0abf8240594', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Pres', 3, NULL, '22:45:00', '00:00:00', 75, true, '2026-03-25 22:55:57.665', 793, '2026-03-26 03:55:57.665715', '2026-03-26 03:55:57.665715');
INSERT INTO public.task_entries VALUES ('6586b1d2-d41b-4d23-a22f-7ae4ba92f56f', '48d1821e-71ff-4889-93d3-ccf916eeb963', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '00:00:00', '01:00:00', 60, true, '2026-03-25 22:55:57.672', 794, '2026-03-26 03:55:57.672933', '2026-03-26 03:55:57.672933');
INSERT INTO public.task_entries VALUES ('f895c6cf-2faa-4e6b-83ad-6d89ad0bd5f3', '48d1821e-71ff-4889-93d3-ccf916eeb963', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:00:00', '02:45:00', 105, true, '2026-03-25 22:55:57.676', 795, '2026-03-26 03:55:57.677192', '2026-03-26 03:55:57.677192');
INSERT INTO public.task_entries VALUES ('ffeb4772-396f-4ebe-8d9b-2a8aa482296b', 'c4017946-ab89-421d-9c58-efbd8ddcf3ef', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'ET', 3, NULL, '07:00:00', '10:00:00', 180, true, '2026-03-25 22:55:57.683', 796, '2026-03-26 03:55:57.684337', '2026-03-26 03:55:57.684337');
INSERT INTO public.task_entries VALUES ('a39a07e9-9c2c-4b1e-92f0-26f9e2b06f25', 'c4017946-ab89-421d-9c58-efbd8ddcf3ef', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Shifting', 3, NULL, '11:00:00', '20:00:00', 540, true, '2026-03-25 22:55:57.687', 797, '2026-03-26 03:55:57.687834', '2026-03-26 03:55:57.687834');
INSERT INTO public.task_entries VALUES ('6ff22f4f-de01-4c3c-a6a3-6b13a2158054', 'c4017946-ab89-421d-9c58-efbd8ddcf3ef', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '00:00:00', 180, true, '2026-03-25 22:55:57.691', 798, '2026-03-26 03:55:57.692406', '2026-03-26 03:55:57.692406');
INSERT INTO public.task_entries VALUES ('e485fc94-d8bc-4e07-af4c-cff4f16d51e4', 'f0324932-4e1e-4255-994a-248785644839', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '00:00:00', '01:10:00', 70, true, '2026-03-25 22:55:57.7', 799, '2026-03-26 03:55:57.700787', '2026-03-26 03:55:57.700787');
INSERT INTO public.task_entries VALUES ('a7c68fd6-7689-4a4a-8756-d14a2ba8c103', 'f0324932-4e1e-4255-994a-248785644839', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '13:00:00', '15:20:00', 140, true, '2026-03-25 22:55:57.703', 800, '2026-03-26 03:55:57.704475', '2026-03-26 03:55:57.704475');
INSERT INTO public.task_entries VALUES ('0b754fb0-4064-43ae-8645-17b3704a8aad', 'f0324932-4e1e-4255-994a-248785644839', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '15:20:00', '16:30:00', 70, true, '2026-03-25 22:55:57.707', 801, '2026-03-26 03:55:57.707761', '2026-03-26 03:55:57.707761');
INSERT INTO public.task_entries VALUES ('92746cf2-929d-479c-98f1-e4d5e2413860', '4db2e8b7-0f38-4804-9e88-e49b9b36a7b9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '04:30:00', 510, true, '2026-03-25 22:55:57.714', 802, '2026-03-26 03:55:57.714854', '2026-03-26 03:55:57.714854');
INSERT INTO public.task_entries VALUES ('97f12150-1909-4ecf-8f61-678f245063e3', '0e63aa02-498b-4a4c-a78e-50cf13db586d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '08:00:00', '16:00:00', 480, true, '2026-03-25 22:55:57.721', 803, '2026-03-26 03:55:57.721959', '2026-03-26 03:55:57.721959');
INSERT INTO public.task_entries VALUES ('c72190c0-68bf-4d1e-95ff-643b90dbfcc0', '0e63aa02-498b-4a4c-a78e-50cf13db586d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'WL Assignment', 3, NULL, '16:00:00', '20:00:00', 240, true, '2026-03-25 22:55:57.724', 804, '2026-03-26 03:55:57.725431', '2026-03-26 03:55:57.725431');
INSERT INTO public.task_entries VALUES ('1834e4b7-b00f-4060-a755-df851c1314a0', '0e63aa02-498b-4a4c-a78e-50cf13db586d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '20:00:00', '21:00:00', 60, true, '2026-03-25 22:55:57.728', 805, '2026-03-26 03:55:57.728885', '2026-03-26 03:55:57.728885');
INSERT INTO public.task_entries VALUES ('cfc67d88-d36a-4c90-95fb-cb94806e2027', '0e63aa02-498b-4a4c-a78e-50cf13db586d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Hassan Automation Meeting', 3, NULL, '21:00:00', '22:10:00', 70, true, '2026-03-25 22:55:57.731', 806, '2026-03-26 03:55:57.732132', '2026-03-26 03:55:57.732132');
INSERT INTO public.task_entries VALUES ('c3421bd0-a1ac-4a96-9a69-f1e9ba49de00', '0e63aa02-498b-4a4c-a78e-50cf13db586d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:10:00', '01:00:00', 170, true, '2026-03-25 22:55:57.735', 807, '2026-03-26 03:55:57.735609', '2026-03-26 03:55:57.735609');
INSERT INTO public.task_entries VALUES ('bf3beb1c-d365-4473-99bb-96297647064a', 'e9a649ce-6c2f-4aaa-b090-0df0a6207330', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'WL', 3, NULL, '12:00:00', '14:00:00', 120, true, '2026-03-25 22:55:57.745', 808, '2026-03-26 03:55:57.745721', '2026-03-26 03:55:57.745721');
INSERT INTO public.task_entries VALUES ('705c5e95-61d6-41d5-a464-dfa6ab438dd2', 'e9a649ce-6c2f-4aaa-b090-0df0a6207330', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI', 3, NULL, '14:00:00', '16:25:00', 145, true, '2026-03-25 22:55:57.748', 809, '2026-03-26 03:55:57.74885', '2026-03-26 03:55:57.74885');
INSERT INTO public.task_entries VALUES ('ae55cda5-6312-43e9-b32c-9b60403c3eeb', 'e9a649ce-6c2f-4aaa-b090-0df0a6207330', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'TW', 1, NULL, '16:25:00', '18:00:00', 95, true, '2026-03-25 22:55:57.752', 810, '2026-03-26 03:55:57.752515', '2026-03-26 03:55:57.752515');
INSERT INTO public.task_entries VALUES ('28580400-e329-46bb-a922-fc28977daff0', 'e9a649ce-6c2f-4aaa-b090-0df0a6207330', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '18:00:00', '20:00:00', 120, true, '2026-03-25 22:55:57.755', 811, '2026-03-26 03:55:57.755979', '2026-03-26 03:55:57.755979');
INSERT INTO public.task_entries VALUES ('371810f4-54fb-4514-baaa-c94d79637c01', 'e9a649ce-6c2f-4aaa-b090-0df0a6207330', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:10:00', '12:00:00', 950, true, '2026-03-25 22:55:57.759', 812, '2026-03-26 03:55:57.759556', '2026-03-26 03:55:57.759556');
INSERT INTO public.task_entries VALUES ('88e4e67c-a911-47e7-9742-3982b7b5a5f6', '8ced5300-2b2f-4945-9a61-8795ee5b5f7f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '00:00:00', '02:00:00', 120, true, '2026-03-25 22:55:57.767', 813, '2026-03-26 03:55:57.76805', '2026-03-26 03:55:57.76805');
INSERT INTO public.task_entries VALUES ('bbcb05f3-0367-4b5c-a115-514f8934c453', '8ced5300-2b2f-4945-9a61-8795ee5b5f7f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Lab Exam', 3, NULL, '06:00:00', '11:00:00', 300, true, '2026-03-25 22:55:57.77', 814, '2026-03-26 03:55:57.771262', '2026-03-26 03:55:57.771262');
INSERT INTO public.task_entries VALUES ('9c13389c-6928-496b-8e66-6f7536355fbc', '8ced5300-2b2f-4945-9a61-8795ee5b5f7f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'TW', 1, NULL, '18:00:00', '20:00:00', 120, true, '2026-03-25 22:55:57.773', 815, '2026-03-26 03:55:57.774096', '2026-03-26 03:55:57.774096');
INSERT INTO public.task_entries VALUES ('1923d22c-4346-4282-b497-4c5b0f1a5887', '8ced5300-2b2f-4945-9a61-8795ee5b5f7f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '23:00:00', 180, true, '2026-03-25 22:55:57.777', 816, '2026-03-26 03:55:57.777884', '2026-03-26 03:55:57.777884');
INSERT INTO public.task_entries VALUES ('f6e06377-e63f-4078-ae26-58203bfbb6a7', '22a6f19a-789d-4e42-b5ca-9dcd3de9338c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '23:10:00', '00:40:00', 90, true, '2026-03-25 22:55:57.784', 817, '2026-03-26 03:55:57.784759', '2026-03-26 03:55:57.784759');
INSERT INTO public.task_entries VALUES ('35756ea0-9ab2-4d05-a35c-6d530dbad3d0', '22a6f19a-789d-4e42-b5ca-9dcd3de9338c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:40:00', '02:35:00', 115, true, '2026-03-25 22:55:57.789', 818, '2026-03-26 03:55:57.789898', '2026-03-26 03:55:57.789898');
INSERT INTO public.task_entries VALUES ('4cc1d00d-c2db-4a9b-9176-cec4f180ea35', '22a6f19a-789d-4e42-b5ca-9dcd3de9338c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'C&D Lab Exam', 3, NULL, '06:00:00', '11:00:00', 300, true, '2026-03-25 22:55:57.793', 819, '2026-03-26 03:55:57.793896', '2026-03-26 03:55:57.793896');
INSERT INTO public.task_entries VALUES ('b9ca3daf-1025-4763-a9d5-625e4080091c', '93e519fd-f642-4f58-b0f7-540c5c225704', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:00:00', '17:30:00', 210, true, '2026-03-25 22:55:57.8', 820, '2026-03-26 03:55:57.80056', '2026-03-26 03:55:57.80056');
INSERT INTO public.task_entries VALUES ('64f039b4-f20e-4dc9-99b6-a83300b51c6d', '93e519fd-f642-4f58-b0f7-540c5c225704', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE Exam', 3, NULL, '17:30:00', '22:30:00', 300, true, '2026-03-25 22:55:57.803', 821, '2026-03-26 03:55:57.80422', '2026-03-26 03:55:57.80422');
INSERT INTO public.task_entries VALUES ('bbe6fd29-4483-4162-9491-2e39bf452c67', '65fe41ae-3cbe-4c9e-8312-ca36e4870551', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE Exam Prep', 3, NULL, '23:30:00', '03:10:00', 220, true, '2026-03-25 22:55:57.811', 822, '2026-03-26 03:55:57.811841', '2026-03-26 03:55:57.811841');
INSERT INTO public.task_entries VALUES ('aece72e5-63f1-4a8b-a3bd-b70d8667ee3e', '6132f9ec-19db-49da-8236-c91b6770d1d7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'SE Exam', 3, NULL, '11:30:00', '14:00:00', 150, true, '2026-03-25 22:55:57.819', 823, '2026-03-26 03:55:57.820877', '2026-03-26 03:55:57.820877');
INSERT INTO public.task_entries VALUES ('aae5532e-cd54-46c0-976c-4bc297736998', '6132f9ec-19db-49da-8236-c91b6770d1d7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '23:00:00', 120, true, '2026-03-25 22:55:57.822', 824, '2026-03-26 03:55:57.823869', '2026-03-26 03:55:57.823869');
INSERT INTO public.task_entries VALUES ('6f169fb5-0684-4b59-bde7-938d48aa6bd8', 'f92560ee-2a4c-431a-a9c4-76a22ae81a47', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Exam Prep', 3, NULL, '00:30:00', '07:00:00', 390, true, '2026-03-25 22:55:57.829', 825, '2026-03-26 03:55:57.831001', '2026-03-26 03:55:57.831001');
INSERT INTO public.task_entries VALUES ('9c9b7150-3f8b-43b3-a55f-4422d8ec7e0f', '1bc8d6de-975f-4c49-a0bf-b65e08f93978', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Exam', 3, NULL, NULL, NULL, NULL, true, '2026-03-25 22:55:57.836', 826, '2026-03-26 03:55:57.837796', '2026-03-26 03:55:57.837796');
INSERT INTO public.task_entries VALUES ('51a80bba-0ace-42a1-aad3-63b8bc767a7e', '73962dea-abfa-405c-8c46-ab4f32b7eea6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, NULL, NULL, NULL, true, '2026-03-25 22:55:57.844', 827, '2026-03-26 03:55:57.846092', '2026-03-26 03:55:57.846092');
INSERT INTO public.task_entries VALUES ('ccd7e6a1-ae06-4ae6-93b2-bc435b2e3ab0', '73962dea-abfa-405c-8c46-ab4f32b7eea6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '8308ab8c-f4e2-43a5-8d0e-92dd04499d5d', NULL, 'Exams', 1, NULL, NULL, NULL, NULL, true, '2026-03-25 22:55:57.847', 828, '2026-03-26 03:55:57.849208', '2026-03-26 03:55:57.849208');
INSERT INTO public.task_entries VALUES ('f7ad1c9b-5400-4106-a22b-ea7d9ab8678f', 'cd1b2c4c-5c7f-4862-94f6-cb09a474758d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:30:00', '17:00:00', 90, true, '2026-03-25 22:55:57.855', 829, '2026-03-26 03:55:57.856408', '2026-03-26 03:55:57.856408');
INSERT INTO public.task_entries VALUES ('96324f04-c837-4297-950b-0ea76c580c42', 'cd1b2c4c-5c7f-4862-94f6-cb09a474758d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Expense Calc', 3, NULL, '15:30:00', '19:00:00', 210, true, '2026-03-25 22:55:57.858', 830, '2026-03-26 03:55:57.859649', '2026-03-26 03:55:57.859649');
INSERT INTO public.task_entries VALUES ('1d30293d-40e8-477a-99ee-3003750ab85e', 'cd1b2c4c-5c7f-4862-94f6-cb09a474758d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '20:10:00', '22:30:00', 140, true, '2026-03-25 22:55:57.862', 831, '2026-03-26 03:55:57.863502', '2026-03-26 03:55:57.863502');
INSERT INTO public.task_entries VALUES ('861e8f0f-3c26-440f-b8ff-a0ec728f106b', 'cd1b2c4c-5c7f-4862-94f6-cb09a474758d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting', 3, NULL, '22:30:00', '00:00:00', 90, true, '2026-03-25 22:55:57.865', 832, '2026-03-26 03:55:57.86701', '2026-03-26 03:55:57.86701');
INSERT INTO public.task_entries VALUES ('ca73cadf-1aca-4fb6-a210-cd9d40cbe1bb', 'd6b46188-2ba7-44d6-bd02-dc8a6b39cdd3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Python Data Science Libraries', 3, NULL, '00:10:00', '08:10:00', 480, true, '2026-03-25 22:55:57.874', 833, '2026-03-26 03:55:57.875817', '2026-03-26 03:55:57.875817');
INSERT INTO public.task_entries VALUES ('f0feb3cb-2f9d-4655-bc62-6ceaef221d66', 'd6b46188-2ba7-44d6-bd02-dc8a6b39cdd3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Excercise', 3, NULL, '08:10:00', '08:35:00', 25, true, '2026-03-25 22:55:57.88', 834, '2026-03-26 03:55:57.881635', '2026-03-26 03:55:57.881635');
INSERT INTO public.task_entries VALUES ('e74817c8-024f-4f61-a3ac-746d77192e9b', 'd6b46188-2ba7-44d6-bd02-dc8a6b39cdd3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:00:00', '21:00:00', 120, true, '2026-03-25 22:55:57.886', 835, '2026-03-26 03:55:57.888125', '2026-03-26 03:55:57.888125');
INSERT INTO public.task_entries VALUES ('0aba3ca7-55c9-46e0-9283-027b14d2d5b5', 'd6b46188-2ba7-44d6-bd02-dc8a6b39cdd3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '21:00:00', '00:15:00', 195, true, '2026-03-25 22:55:57.889', 836, '2026-03-26 03:55:57.891235', '2026-03-26 03:55:57.891235');
INSERT INTO public.task_entries VALUES ('75db3467-1adb-464c-98a2-961d8db611ba', 'cea2e110-588d-4fd0-947e-dad89ea0fab3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Management', 3, NULL, '21:00:00', '05:00:00', 480, true, '2026-03-25 22:55:57.897', 837, '2026-03-26 03:55:57.89916', '2026-03-26 03:55:57.89916');
INSERT INTO public.task_entries VALUES ('fe25345d-b226-4c5b-9f57-82c619f4053f', 'cea2e110-588d-4fd0-947e-dad89ea0fab3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '05:00:00', '05:40:00', 40, true, '2026-03-25 22:55:57.901', 838, '2026-03-26 03:55:57.902471', '2026-03-26 03:55:57.902471');
INSERT INTO public.task_entries VALUES ('ad981e85-86d5-4b4e-bada-135af5f472fe', 'cea2e110-588d-4fd0-947e-dad89ea0fab3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Python Data Science Libraries', 3, NULL, '05:40:00', '07:00:00', 80, true, '2026-03-25 22:55:57.904', 839, '2026-03-26 03:55:57.905984', '2026-03-26 03:55:57.905984');
INSERT INTO public.task_entries VALUES ('5954ccea-b6b1-4f8b-9308-bec6fddcee38', 'cea2e110-588d-4fd0-947e-dad89ea0fab3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Data Science Course', 3, NULL, '07:00:00', '09:30:00', 150, true, '2026-03-25 22:55:57.908', 840, '2026-03-26 03:55:57.909522', '2026-03-26 03:55:57.909522');
INSERT INTO public.task_entries VALUES ('d0cd61f4-13b9-4bc8-8b00-951f73b1eb0d', 'cea2e110-588d-4fd0-947e-dad89ea0fab3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '18:00:00', '19:00:00', 60, true, '2026-03-25 22:55:57.911', 841, '2026-03-26 03:55:57.912967', '2026-03-26 03:55:57.912967');
INSERT INTO public.task_entries VALUES ('70296219-d007-4ffc-b02c-57ae72002854', 'cea2e110-588d-4fd0-947e-dad89ea0fab3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:00:00', '20:00:00', 60, true, '2026-03-25 22:55:57.915', 842, '2026-03-26 03:55:57.916544', '2026-03-26 03:55:57.916544');
INSERT INTO public.task_entries VALUES ('0b5bf599-3abc-40cf-954a-c068cbd3c6c2', 'cea2e110-588d-4fd0-947e-dad89ea0fab3', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '20:00:00', '23:00:00', 180, true, '2026-03-25 22:55:57.918', 843, '2026-03-26 03:55:57.919922', '2026-03-26 03:55:57.919922');
INSERT INTO public.task_entries VALUES ('dcfe4b04-6601-4b63-b75a-f02f83ee943d', 'e57dc2c0-f1be-4f99-b976-360593570609', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting', 3, NULL, '23:00:00', '00:30:00', 90, true, '2026-03-25 22:55:57.926', 844, '2026-03-26 03:55:57.92785', '2026-03-26 03:55:57.92785');
INSERT INTO public.task_entries VALUES ('6e71ca30-7cd2-44c9-a9a5-f72949733a3a', 'e57dc2c0-f1be-4f99-b976-360593570609', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Cold Email Setup', 3, NULL, '00:30:00', '03:00:00', 270, true, '2026-03-25 22:55:57.931', 845, '2026-03-26 03:55:57.933169', '2026-03-26 03:55:57.933169');
INSERT INTO public.task_entries VALUES ('d75f1e93-b739-4221-9fa0-b33228782a04', 'e57dc2c0-f1be-4f99-b976-360593570609', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '03:00:00', '04:40:00', 160, true, '2026-03-25 22:55:57.937', 846, '2026-03-26 03:55:57.939243', '2026-03-26 03:55:57.939243');
INSERT INTO public.task_entries VALUES ('164e8515-c5d5-4964-a1f6-92f3d93cf123', 'e57dc2c0-f1be-4f99-b976-360593570609', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '04:40:00', '05:00:00', 50, true, '2026-03-25 22:55:57.941', 847, '2026-03-26 03:55:57.942704', '2026-03-26 03:55:57.942704');
INSERT INTO public.task_entries VALUES ('3b0e9784-65e7-47ea-9175-31fe8cd88af4', 'e57dc2c0-f1be-4f99-b976-360593570609', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Data Science Course', 3, NULL, '07:10:00', '09:30:00', 140, true, '2026-03-25 22:55:57.944', 848, '2026-03-26 03:55:57.946151', '2026-03-26 03:55:57.946151');
INSERT INTO public.task_entries VALUES ('2d6fa0a9-9eab-43e3-ad37-abf055086622', 'e57dc2c0-f1be-4f99-b976-360593570609', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Management', 3, NULL, '10:00:00', '11:20:00', 80, true, '2026-03-25 22:55:57.948', 849, '2026-03-26 03:55:57.949883', '2026-03-26 03:55:57.949883');
INSERT INTO public.task_entries VALUES ('908ec492-06a3-4358-887c-b356518555e8', 'd01320da-34f3-4b3b-9b7c-fb11d2b3ea89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '12:30:00', '14:20:00', 875, true, '2026-03-25 22:55:57.955', 850, '2026-03-26 03:55:57.956752', '2026-03-26 03:55:57.956752');
INSERT INTO public.task_entries VALUES ('a629e8d7-d403-463c-8a05-3e7f623d14f6', 'd01320da-34f3-4b3b-9b7c-fb11d2b3ea89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '14:20:00', '16:45:00', 145, true, '2026-03-25 22:55:57.958', 851, '2026-03-26 03:55:57.960152', '2026-03-26 03:55:57.960152');
INSERT INTO public.task_entries VALUES ('062566c3-bd70-4f5c-bb20-396336484a66', 'd01320da-34f3-4b3b-9b7c-fb11d2b3ea89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Cold Email Setup', 3, NULL, '17:30:00', '21:00:00', 210, true, '2026-03-25 22:55:57.962', 852, '2026-03-26 03:55:57.963597', '2026-03-26 03:55:57.963597');
INSERT INTO public.task_entries VALUES ('e64a6976-2892-4d91-9dce-b35ec76b31ce', 'd01320da-34f3-4b3b-9b7c-fb11d2b3ea89', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Data Science Course', 3, NULL, '22:10:00', '01:10:00', 180, true, '2026-03-25 22:55:57.965', 853, '2026-03-26 03:55:57.967182', '2026-03-26 03:55:57.967182');
INSERT INTO public.task_entries VALUES ('520b4a00-541b-445b-b474-dfaf6c5e664e', '149b65f2-c1f8-47b0-a0b5-030bea48a2d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '21:00:00', '22:30:00', 90, true, '2026-03-25 22:55:57.972', 854, '2026-03-26 03:55:57.974291', '2026-03-26 03:55:57.974291');
INSERT INTO public.task_entries VALUES ('87fcadaa-ab9c-410a-b0c8-3f74e77162b3', '149b65f2-c1f8-47b0-a0b5-030bea48a2d6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '22:30:00', '01:20:00', 170, true, '2026-03-25 22:55:57.978', 855, '2026-03-26 03:55:57.979399', '2026-03-26 03:55:57.979399');
INSERT INTO public.task_entries VALUES ('4b038a03-f8c4-4945-b42d-c734f1be4285', '3c8101b0-138e-4e8a-ad4f-7905cda0f5a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:30:00', '05:15:00', 225, true, '2026-03-25 22:55:57.985', 856, '2026-03-26 03:55:57.98639', '2026-03-26 03:55:57.98639');
INSERT INTO public.task_entries VALUES ('2cbdc327-b915-4fea-b5e8-74f66b32e96b', '3c8101b0-138e-4e8a-ad4f-7905cda0f5a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Cold Email Setup', 3, NULL, '05:45:00', '08:15:00', 150, true, '2026-03-25 22:55:57.988', 857, '2026-03-26 03:55:57.989949', '2026-03-26 03:55:57.989949');
INSERT INTO public.task_entries VALUES ('5c85428c-e588-4a60-9332-5941f47baccf', '3c8101b0-138e-4e8a-ad4f-7905cda0f5a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '08:10:00', '09:15:00', 65, true, '2026-03-25 22:55:57.992', 858, '2026-03-26 03:55:57.993287', '2026-03-26 03:55:57.993287');
INSERT INTO public.task_entries VALUES ('a19a5e8a-eb3c-42d3-bbf1-4087a25abe46', '3c8101b0-138e-4e8a-ad4f-7905cda0f5a6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Data Science Course', 3, NULL, '22:10:00', '13:10:00', 900, true, '2026-03-25 22:55:57.995', 859, '2026-03-26 03:55:57.996854', '2026-03-26 03:55:57.996854');
INSERT INTO public.task_entries VALUES ('907dc7ad-d5e8-4528-9da1-4a15afb7c9da', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 2, NULL, '00:00:00', '05:00:00', 300, true, '2026-03-25 22:55:58.002', 860, '2026-03-26 03:55:58.003806', '2026-03-26 03:55:58.003806');
INSERT INTO public.task_entries VALUES ('d77dc844-ec59-4a7a-8fff-9ff423c1972d', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '07:00:00', '09:30:00', 150, true, '2026-03-25 22:55:58.006', 861, '2026-03-26 03:55:58.007335', '2026-03-26 03:55:58.007335');
INSERT INTO public.task_entries VALUES ('b24cd165-55a2-40e7-aaeb-63fb367325cf', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '09:30:00', '11:00:00', 90, true, '2026-03-25 22:55:58.009', 862, '2026-03-26 03:55:58.010827', '2026-03-26 03:55:58.010827');
INSERT INTO public.task_entries VALUES ('25640940-376b-4397-85e0-562874cd1e09', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '11:00:00', '13:00:00', 120, true, '2026-03-25 22:55:58.014', 863, '2026-03-26 03:55:58.015457', '2026-03-26 03:55:58.015457');
INSERT INTO public.task_entries VALUES ('a26af2a6-75f6-4db7-9b1d-e9aed2694df4', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:00:00', '15:00:00', 60, true, '2026-03-25 22:55:58.017', 864, '2026-03-26 03:55:58.018663', '2026-03-26 03:55:58.018663');
INSERT INTO public.task_entries VALUES ('15a1a1cf-9709-4784-a48e-cc7695fbab54', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'DT', 3, NULL, '15:00:00', '17:00:00', 120, true, '2026-03-25 22:55:58.022', 865, '2026-03-26 03:55:58.024117', '2026-03-26 03:55:58.024117');
INSERT INTO public.task_entries VALUES ('6dc9d124-9970-4620-8a76-bbb54e67b9f1', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Cold Email Setup', 3, NULL, '17:00:00', '18:00:00', 60, true, '2026-03-25 22:55:58.027', 866, '2026-03-26 03:55:58.028346', '2026-03-26 03:55:58.028346');
INSERT INTO public.task_entries VALUES ('be173b75-23b1-45bd-af2d-0a86e448e276', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'LinkedIn Outreach', 3, NULL, '18:00:00', '20:20:00', 140, true, '2026-03-25 22:55:58.03', 867, '2026-03-26 03:55:58.031878', '2026-03-26 03:55:58.031878');
INSERT INTO public.task_entries VALUES ('8b092372-fbcb-4733-8bc2-98f81310e1e8', '586738d4-383d-4d65-9018-197e1246d93c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Data Science Course', 3, NULL, '20:30:00', '00:20:00', 230, true, '2026-03-25 22:55:58.034', 868, '2026-03-26 03:55:58.035281', '2026-03-26 03:55:58.035281');
INSERT INTO public.task_entries VALUES ('1cc2429e-aedc-4e97-b17a-1dd42e8de75e', '1fa4903e-b497-4532-bb62-c1c4ebef0a1f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '04:00:00', '08:00:00', 240, true, '2026-03-25 22:55:58.041', 869, '2026-03-26 03:55:58.04235', '2026-03-26 03:55:58.04235');
INSERT INTO public.task_entries VALUES ('caa02404-579f-40a5-bb2f-2e7017f78aa5', '1fa4903e-b497-4532-bb62-c1c4ebef0a1f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '11:00:00', '17:30:00', 390, true, '2026-03-25 22:55:58.044', 870, '2026-03-26 03:55:58.045783', '2026-03-26 03:55:58.045783');
INSERT INTO public.task_entries VALUES ('cb85dbc7-8fcf-4ef2-9448-04d3110f1f9d', '1fa4903e-b497-4532-bb62-c1c4ebef0a1f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '17:30:00', '19:10:00', 100, true, '2026-03-25 22:55:58.048', 871, '2026-03-26 03:55:58.049421', '2026-03-26 03:55:58.049421');
INSERT INTO public.task_entries VALUES ('df5e3d4b-8a5e-4486-94b7-8c58b5bedca4', '1fa4903e-b497-4532-bb62-c1c4ebef0a1f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting', 3, NULL, '19:10:00', '21:00:00', 110, true, '2026-03-25 22:55:58.051', 872, '2026-03-26 03:55:58.052662', '2026-03-26 03:55:58.052662');
INSERT INTO public.task_entries VALUES ('68a53239-bac3-4c05-8c8c-463d59fb9b67', '1fa4903e-b497-4532-bb62-c1c4ebef0a1f', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Data Science Course', 3, NULL, '21:00:00', '22:00:00', 60, true, '2026-03-25 22:55:58.055', 873, '2026-03-26 03:55:58.056293', '2026-03-26 03:55:58.056293');
INSERT INTO public.task_entries VALUES ('f1c1fedd-19a6-4c3c-a320-0b2ed51804ed', '2def90ed-9bce-4a66-bf1d-1b24ba0f3cc9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '04:00:00', '09:00:00', 300, true, '2026-03-25 22:55:58.063', 874, '2026-03-26 03:55:58.065302', '2026-03-26 03:55:58.065302');
INSERT INTO public.task_entries VALUES ('3ac3b2c9-7a19-411f-b756-30a992fd2354', '2def90ed-9bce-4a66-bf1d-1b24ba0f3cc9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '09:00:00', '10:30:00', 90, true, '2026-03-25 22:55:58.067', 875, '2026-03-26 03:55:58.068484', '2026-03-26 03:55:58.068484');
INSERT INTO public.task_entries VALUES ('ce1a152f-8132-419e-a74a-3c17c253702d', '2def90ed-9bce-4a66-bf1d-1b24ba0f3cc9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting', 3, NULL, '10:30:00', '11:30:00', 60, true, '2026-03-25 22:55:58.07', 876, '2026-03-26 03:55:58.071964', '2026-03-26 03:55:58.071964');
INSERT INTO public.task_entries VALUES ('eddd4348-ab81-44e7-a8f3-ca37937ce181', '2def90ed-9bce-4a66-bf1d-1b24ba0f3cc9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '11:30:00', '13:30:00', 120, true, '2026-03-25 22:55:58.074', 877, '2026-03-26 03:55:58.075542', '2026-03-26 03:55:58.075542');
INSERT INTO public.task_entries VALUES ('bfdea9bd-24be-432e-a6dc-1710e9bd3264', '2def90ed-9bce-4a66-bf1d-1b24ba0f3cc9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Cold Email Setup', 3, NULL, '13:30:00', '14:30:00', 60, true, '2026-03-25 22:55:58.077', 878, '2026-03-26 03:55:58.079033', '2026-03-26 03:55:58.079033');
INSERT INTO public.task_entries VALUES ('16a330e6-62d6-4407-8a71-ccd7b35ca157', '2def90ed-9bce-4a66-bf1d-1b24ba0f3cc9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Data Science Course', 3, NULL, '14:30:00', '20:10:00', 340, true, '2026-03-25 22:55:58.081', 879, '2026-03-26 03:55:58.08251', '2026-03-26 03:55:58.08251');
INSERT INTO public.task_entries VALUES ('c934ae95-f07c-484d-b3c9-d11d777de5d5', '2def90ed-9bce-4a66-bf1d-1b24ba0f3cc9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, '09:00PM Meeting Husna', 3, NULL, '21:10:00', '21:40:00', 30, true, '2026-03-25 22:55:58.084', 880, '2026-03-26 03:55:58.085856', '2026-03-26 03:55:58.085856');
INSERT INTO public.task_entries VALUES ('399d483b-37c0-4f41-a623-6051d173f95b', '044c8471-4e44-4b50-b96b-780502dbbfbc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 2, NULL, '04:00:00', '09:00:00', 300, true, '2026-03-25 22:55:58.089', 881, '2026-03-26 03:55:58.091243', '2026-03-26 03:55:58.091243');
INSERT INTO public.task_entries VALUES ('3768d720-d7f8-4ea4-a921-3a2fb57bc9db', '044c8471-4e44-4b50-b96b-780502dbbfbc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '10:00:00', '12:00:00', 240, true, '2026-03-25 22:55:58.093', 882, '2026-03-26 03:55:58.094858', '2026-03-26 03:55:58.094858');
INSERT INTO public.task_entries VALUES ('9ce9bf49-d1a7-42e8-882a-9e2c9260dbba', '044c8471-4e44-4b50-b96b-780502dbbfbc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '12:00:00', '14:00:00', 120, true, '2026-03-25 22:55:58.096', 883, '2026-03-26 03:55:58.098154', '2026-03-26 03:55:58.098154');
INSERT INTO public.task_entries VALUES ('6467d4d7-9d1e-49dc-aa48-a1d12b5f8a5a', '044c8471-4e44-4b50-b96b-780502dbbfbc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Data Science Course', 3, NULL, '16:00:00', '19:30:00', 210, true, '2026-03-25 22:55:58.1', 884, '2026-03-26 03:55:58.101567', '2026-03-26 03:55:58.101567');
INSERT INTO public.task_entries VALUES ('a1e69a2a-03e3-4ce2-8ab6-4c3f13fcbc14', '48ca45e5-2be3-4580-af5a-c75109698ff8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '05:00:00', '08:00:00', 180, true, '2026-03-25 22:55:58.109', 885, '2026-03-26 03:55:58.110498', '2026-03-26 03:55:58.110498');
INSERT INTO public.task_entries VALUES ('9d579f3d-3977-4c93-bf17-a3fe4cd230cc', '48ca45e5-2be3-4580-af5a-c75109698ff8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Out', 3, NULL, '12:00:00', '22:00:00', 600, true, '2026-03-25 22:55:58.112', 886, '2026-03-26 03:55:58.113925', '2026-03-26 03:55:58.113925');
INSERT INTO public.task_entries VALUES ('447300d3-bacb-4432-848c-5bd73837a8be', '48ca45e5-2be3-4580-af5a-c75109698ff8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '22:00:00', '22:30:00', 30, true, '2026-03-25 22:55:58.116', 887, '2026-03-26 03:55:58.117465', '2026-03-26 03:55:58.117465');
INSERT INTO public.task_entries VALUES ('8be43092-2d18-4b3d-a98a-17a8b64a04b5', '48ca45e5-2be3-4580-af5a-c75109698ff8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '22:30:00', '00:20:00', 110, true, '2026-03-25 22:55:58.119', 888, '2026-03-26 03:55:58.120863', '2026-03-26 03:55:58.120863');
INSERT INTO public.task_entries VALUES ('fba14ede-b2ff-4c5a-b046-704785022c64', '066038d6-975d-4263-b4e6-a4061f26e5fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Hassan''s Contract', 3, NULL, '00:20:00', '00:40:00', 20, true, '2026-03-25 22:55:58.129', 889, '2026-03-26 03:55:58.130619', '2026-03-26 03:55:58.130619');
INSERT INTO public.task_entries VALUES ('07b2d268-c994-4f1c-b539-9558a3060fe8', '066038d6-975d-4263-b4e6-a4061f26e5fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting', 3, NULL, '00:40:00', '01:10:00', 30, true, '2026-03-25 22:55:58.132', 890, '2026-03-26 03:55:58.134032', '2026-03-26 03:55:58.134032');
INSERT INTO public.task_entries VALUES ('bcea9136-ce23-47ab-8458-232b7c7f674d', '066038d6-975d-4263-b4e6-a4061f26e5fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Data Science Course', 3, NULL, '01:10:00', '05:30:00', 260, true, '2026-03-25 22:55:58.136', 891, '2026-03-26 03:55:58.137333', '2026-03-26 03:55:58.137333');
INSERT INTO public.task_entries VALUES ('a5963923-2590-4711-9f22-f4ab8ab88c92', '066038d6-975d-4263-b4e6-a4061f26e5fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '05:30:00', '05:50:00', 190, true, '2026-03-25 22:55:58.138', 892, '2026-03-26 03:55:58.140107', '2026-03-26 03:55:58.140107');
INSERT INTO public.task_entries VALUES ('fd04fc91-bee6-4f75-9aa3-d19715e7ea8a', '066038d6-975d-4263-b4e6-a4061f26e5fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '15:00:00', '18:10:00', 190, true, '2026-03-25 22:55:58.142', 893, '2026-03-26 03:55:58.143515', '2026-03-26 03:55:58.143515');
INSERT INTO public.task_entries VALUES ('4c6a35ef-06de-4a46-af20-e7e63e8645a8', '066038d6-975d-4263-b4e6-a4061f26e5fa', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Openclaw', 3, NULL, '21:00:00', '00:30:00', 210, true, '2026-03-25 22:55:58.144', 894, '2026-03-26 03:55:58.146079', '2026-03-26 03:55:58.146079');
INSERT INTO public.task_entries VALUES ('489e6f6d-e7b6-4503-b7ec-f75918f146d0', '15e99cc0-54e4-4017-9471-afaafae19d1a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '00:30:00', '01:30:00', 60, true, '2026-03-25 22:55:58.152', 895, '2026-03-26 03:55:58.154109', '2026-03-26 03:55:58.154109');
INSERT INTO public.task_entries VALUES ('a4aa063f-1574-483d-898f-3690d5bffdfa', '15e99cc0-54e4-4017-9471-afaafae19d1a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Vibe Coding', 3, NULL, '01:30:00', '02:50:00', 80, true, '2026-03-25 22:55:58.156', 896, '2026-03-26 03:55:58.157807', '2026-03-26 03:55:58.157807');
INSERT INTO public.task_entries VALUES ('02292de4-b220-447b-82ff-5a7428f2cf32', '15e99cc0-54e4-4017-9471-afaafae19d1a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '09:30:00', '12:00:00', 340, true, '2026-03-25 22:55:58.159', 897, '2026-03-26 03:55:58.161073', '2026-03-26 03:55:58.161073');
INSERT INTO public.task_entries VALUES ('b5a0cf39-5106-4470-9cb8-7caf2329a262', '15e99cc0-54e4-4017-9471-afaafae19d1a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Management', 3, NULL, '12:00:00', '17:00:00', 300, true, '2026-03-25 22:55:58.162', 898, '2026-03-26 03:55:58.163739', '2026-03-26 03:55:58.163739');
INSERT INTO public.task_entries VALUES ('ce08e698-5cd8-451d-9827-67dfdbaad414', '15e99cc0-54e4-4017-9471-afaafae19d1a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Hunter Trading', 3, NULL, '17:00:00', '17:30:00', 30, true, '2026-03-25 22:55:58.165', 899, '2026-03-26 03:55:58.167296', '2026-03-26 03:55:58.167296');
INSERT INTO public.task_entries VALUES ('e115c9a9-708d-4db3-ab5a-c5ff3765681a', '15e99cc0-54e4-4017-9471-afaafae19d1a', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'Upwork Bidding', 3, NULL, '17:30:00', '19:10:00', 100, true, '2026-03-25 22:55:58.169', 900, '2026-03-26 03:55:58.170951', '2026-03-26 03:55:58.170951');
INSERT INTO public.task_entries VALUES ('15132fe7-296b-4bf8-9b57-1e069fbfd3d4', '322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'LinkedIn Outreach', 3, NULL, '23:00:00', '01:30:00', 150, true, '2026-03-25 22:55:58.176', 901, '2026-03-26 03:55:58.17791', '2026-03-26 03:55:58.17791');
INSERT INTO public.task_entries VALUES ('5261be6d-2569-4644-9281-4da312c41ecf', '322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 2, NULL, '07:00:00', '12:00:00', 300, true, '2026-03-25 22:55:58.179', 902, '2026-03-26 03:55:58.181384', '2026-03-26 03:55:58.181384');
INSERT INTO public.task_entries VALUES ('3a517dba-a9d3-48f4-9b0b-27895d4a914b', '322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '12:30:00', '13:20:00', 50, true, '2026-03-25 22:55:58.183', 903, '2026-03-26 03:55:58.184698', '2026-03-26 03:55:58.184698');
INSERT INTO public.task_entries VALUES ('86314ee6-8b54-4940-b727-6ff150e5fc83', '322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Certificate Addition', 3, NULL, '13:40:00', '13:50:00', 10, true, '2026-03-25 22:55:58.187', 904, '2026-03-26 03:55:58.188285', '2026-03-26 03:55:58.188285');
INSERT INTO public.task_entries VALUES ('4b9818cb-7b79-442d-9a09-9c732dc1767c', '322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Management', 3, NULL, '13:50:00', '15:00:00', 70, true, '2026-03-25 22:55:58.192', 905, '2026-03-26 03:55:58.193448', '2026-03-26 03:55:58.193448');
INSERT INTO public.task_entries VALUES ('8c59b50f-f115-417f-adc3-79d291e882b0', '322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'LinkedIn Outreach', 3, NULL, '15:00:00', '16:30:00', 90, true, '2026-03-25 22:55:58.195', 906, '2026-03-26 03:55:58.196951', '2026-03-26 03:55:58.196951');
INSERT INTO public.task_entries VALUES ('72cf82d5-433d-4336-8b75-19de775e1dc4', '322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'Instagram Outreach', 3, NULL, '17:00:00', '19:30:00', 150, true, '2026-03-25 22:55:58.199', 907, '2026-03-26 03:55:58.200482', '2026-03-26 03:55:58.200482');
INSERT INTO public.task_entries VALUES ('17bf5ef6-d38b-48d3-8e28-fac9f308f8a8', '322128ed-2256-4ecb-9b7d-c371003d4ef1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Never split the difference', 3, NULL, '19:30:00', '23:30:00', 240, true, '2026-03-25 22:55:58.202', 908, '2026-03-26 03:55:58.203947', '2026-03-26 03:55:58.203947');
INSERT INTO public.task_entries VALUES ('4fe36d2a-05a6-4241-96a7-750b29183727', '23c6f1f8-6cee-448e-9f97-4e91ed0f1260', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '10:30:00', '13:30:00', 180, true, '2026-03-25 22:55:58.209', 909, '2026-03-26 03:55:58.21081', '2026-03-26 03:55:58.21081');
INSERT INTO public.task_entries VALUES ('66426541-edfb-468b-9caf-b208f1f03816', '23c6f1f8-6cee-448e-9f97-4e91ed0f1260', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '13:30:00', '15:00:00', 90, true, '2026-03-25 22:55:58.212', 910, '2026-03-26 03:55:58.213393', '2026-03-26 03:55:58.213393');
INSERT INTO public.task_entries VALUES ('59d85d24-9d4b-4665-a413-40c4be80af77', '23c6f1f8-6cee-448e-9f97-4e91ed0f1260', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '15:00:00', '17:00:00', 120, true, '2026-03-25 22:55:58.215', 911, '2026-03-26 03:55:58.217037', '2026-03-26 03:55:58.217037');
INSERT INTO public.task_entries VALUES ('d2c7aa32-73c3-4407-8099-5a24cc0753e9', '23c6f1f8-6cee-448e-9f97-4e91ed0f1260', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Never split the difference', 3, NULL, '17:10:00', '20:10:00', 1150, true, '2026-03-25 22:55:58.22', 912, '2026-03-26 03:55:58.221301', '2026-03-26 03:55:58.221301');
INSERT INTO public.task_entries VALUES ('ee755750-2065-4854-ad4f-ac46826688a9', '56e42524-ed3d-4f99-be08-3d57ab445818', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '07:00:00', '22:30:00', 930, true, '2026-03-25 22:55:58.227', 913, '2026-03-26 03:55:58.228339', '2026-03-26 03:55:58.228339');
INSERT INTO public.task_entries VALUES ('3f41f307-c378-486c-b730-52b157fc5291', '56e42524-ed3d-4f99-be08-3d57ab445818', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:00:00', '17:10:00', 70, true, '2026-03-25 22:55:58.232', 914, '2026-03-26 03:55:58.233704', '2026-03-26 03:55:58.233704');
INSERT INTO public.task_entries VALUES ('a5314eee-9069-4bd0-803b-26f5eed1d82d', '56e42524-ed3d-4f99-be08-3d57ab445818', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '16:00:00', '17:10:00', 70, true, '2026-03-25 22:55:58.235', 915, '2026-03-26 03:55:58.237107', '2026-03-26 03:55:58.237107');
INSERT INTO public.task_entries VALUES ('0f39bb01-e963-4e61-9f46-87423eca101e', '56e42524-ed3d-4f99-be08-3d57ab445818', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '17:10:00', '20:30:00', 200, true, '2026-03-25 22:55:58.239', 916, '2026-03-26 03:55:58.240674', '2026-03-26 03:55:58.240674');
INSERT INTO public.task_entries VALUES ('fc091ebf-155f-4626-96a2-6f327e6a6c71', '56e42524-ed3d-4f99-be08-3d57ab445818', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '17:10:00', '20:30:00', 200, true, '2026-03-25 22:55:58.242', 917, '2026-03-26 03:55:58.244069', '2026-03-26 03:55:58.244069');
INSERT INTO public.task_entries VALUES ('b28ab2a8-cb72-41ea-8f5c-3b2e1cb93595', '56e42524-ed3d-4f99-be08-3d57ab445818', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '20:30:00', '22:05:00', 95, true, '2026-03-25 22:55:58.246', 918, '2026-03-26 03:55:58.247694', '2026-03-26 03:55:58.247694');
INSERT INTO public.task_entries VALUES ('244d01bb-6539-4887-a367-5958cdbb2a82', '56e42524-ed3d-4f99-be08-3d57ab445818', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'Insta & LinkedIn Outreach', 3, NULL, '22:05:00', '12:00:00', 835, true, '2026-03-25 22:55:58.249', 919, '2026-03-26 03:55:58.251224', '2026-03-26 03:55:58.251224');
INSERT INTO public.task_entries VALUES ('b22472a0-e5fd-406f-87a5-c9c813bdcf00', 'df96e1a1-baef-4cd9-84bb-449a51a946f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Never split the difference', 3, NULL, '00:00:00', '03:30:00', 210, true, '2026-03-25 22:55:58.256', 920, '2026-03-26 03:55:58.258185', '2026-03-26 03:55:58.258185');
INSERT INTO public.task_entries VALUES ('cd989fc9-0a2b-4d5e-940c-69599879017b', 'df96e1a1-baef-4cd9-84bb-449a51a946f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'ML', 3, NULL, '12:00:00', '15:00:00', 180, true, '2026-03-25 22:55:58.26', 921, '2026-03-26 03:55:58.261507', '2026-03-26 03:55:58.261507');
INSERT INTO public.task_entries VALUES ('a6d1e951-5284-4522-b6c5-b254839bd944', 'df96e1a1-baef-4cd9-84bb-449a51a946f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Stamp', 3, NULL, '15:00:00', '17:30:00', 150, true, '2026-03-25 22:55:58.263', 922, '2026-03-26 03:55:58.265094', '2026-03-26 03:55:58.265094');
INSERT INTO public.task_entries VALUES ('7dcac59f-ece9-4390-80ca-45666c5ac402', 'df96e1a1-baef-4cd9-84bb-449a51a946f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '17:30:00', '18:30:00', 60, true, '2026-03-25 22:55:58.267', 923, '2026-03-26 03:55:58.268554', '2026-03-26 03:55:58.268554');
INSERT INTO public.task_entries VALUES ('57a4d97c-f892-4390-85c0-0c58089b5874', 'df96e1a1-baef-4cd9-84bb-449a51a946f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting & Outreach', 3, NULL, '18:30:00', '21:20:00', 170, true, '2026-03-25 22:55:58.271', 924, '2026-03-26 03:55:58.27305', '2026-03-26 03:55:58.27305');
INSERT INTO public.task_entries VALUES ('1c0caf3c-e360-4b01-a484-99ffa3b1bd0e', 'df96e1a1-baef-4cd9-84bb-449a51a946f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '21:20:00', '01:30:00', 250, true, '2026-03-25 22:55:58.276', 925, '2026-03-26 03:55:58.278232', '2026-03-26 03:55:58.278232');
INSERT INTO public.task_entries VALUES ('13206748-8422-4fb4-9020-c56e8a025733', '1b75ad4a-307d-419e-b534-fd3eb84c1679', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 2, NULL, '12:00:00', '15:00:00', 180, true, '2026-03-25 22:55:58.283', 926, '2026-03-26 03:55:58.285169', '2026-03-26 03:55:58.285169');
INSERT INTO public.task_entries VALUES ('ed55c99b-d8b0-4f74-a23e-8998aa96d8e4', '1b75ad4a-307d-419e-b534-fd3eb84c1679', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '16:30:00', 90, true, '2026-03-25 22:55:58.287', 927, '2026-03-26 03:55:58.288543', '2026-03-26 03:55:58.288543');
INSERT INTO public.task_entries VALUES ('4f9fc8d4-b851-4b23-aa86-902213201d3b', '1b75ad4a-307d-419e-b534-fd3eb84c1679', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:30:00', '18:45:00', 135, true, '2026-03-25 22:55:58.29', 928, '2026-03-26 03:55:58.291324', '2026-03-26 03:55:58.291324');
INSERT INTO public.task_entries VALUES ('6a5315ed-adf2-418d-90b7-a0d7c46dc1e1', '1b75ad4a-307d-419e-b534-fd3eb84c1679', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting', 3, NULL, '19:10:00', '21:00:00', 110, true, '2026-03-25 22:55:58.293', 929, '2026-03-26 03:55:58.29477', '2026-03-26 03:55:58.29477');
INSERT INTO public.task_entries VALUES ('32ec71a1-86f7-408a-bf77-d44dfc75486a', '1b75ad4a-307d-419e-b534-fd3eb84c1679', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'LinkedIn & Insta Outreach', 3, NULL, '21:00:00', '21:30:00', 30, true, '2026-03-25 22:55:58.297', 930, '2026-03-26 03:55:58.298379', '2026-03-26 03:55:58.298379');
INSERT INTO public.task_entries VALUES ('7cd3144f-fd56-4c1b-ad3c-efa0bd134f27', '1b75ad4a-307d-419e-b534-fd3eb84c1679', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '21:30:00', '01:20:00', 230, true, '2026-03-25 22:55:58.3', 931, '2026-03-26 03:55:58.301737', '2026-03-26 03:55:58.301737');
INSERT INTO public.task_entries VALUES ('3e1fc848-fde6-4248-8300-4d37dc6deda1', 'abb2f2db-1de6-46cc-896f-3dedf346df8b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:00:00', '17:35:00', 95, true, '2026-03-25 22:55:58.307', 932, '2026-03-26 03:55:58.308873', '2026-03-26 03:55:58.308873');
INSERT INTO public.task_entries VALUES ('b783664a-f2e1-48ae-b01d-0745bbf061b1', 'abb2f2db-1de6-46cc-896f-3dedf346df8b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '17:35:00', '19:30:00', 115, true, '2026-03-25 22:55:58.31', 933, '2026-03-26 03:55:58.312121', '2026-03-26 03:55:58.312121');
INSERT INTO public.task_entries VALUES ('f4586b3a-7a76-4c15-bdc8-9554b9d15656', 'abb2f2db-1de6-46cc-896f-3dedf346df8b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '19:30:00', '20:00:00', 30, true, '2026-03-25 22:55:58.315', 934, '2026-03-26 03:55:58.316633', '2026-03-26 03:55:58.316633');
INSERT INTO public.task_entries VALUES ('f8a94dbf-97a2-4f04-ae5d-4fa27904f16f', 'abb2f2db-1de6-46cc-896f-3dedf346df8b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:30:00', '22:00:00', 90, true, '2026-03-25 22:55:58.318', 935, '2026-03-26 03:55:58.319967', '2026-03-26 03:55:58.319967');
INSERT INTO public.task_entries VALUES ('eef63300-5320-45f4-b8f1-560ff2498645', 'abb2f2db-1de6-46cc-896f-3dedf346df8b', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'LinkedIn & Insta Outreach', 3, NULL, '22:00:00', '00:30:00', 150, true, '2026-03-25 22:55:58.321', 936, '2026-03-26 03:55:58.322733', '2026-03-26 03:55:58.322733');
INSERT INTO public.task_entries VALUES ('59191adc-004e-4a8b-a93c-c177845be1c2', '2a4a390b-2844-4d36-aaf6-b7c162391dd2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '12:30:00', '05:00:00', 990, true, '2026-03-25 22:55:58.328', 937, '2026-03-26 03:55:58.329625', '2026-03-26 03:55:58.329625');
INSERT INTO public.task_entries VALUES ('e3fb2397-9fc1-4e48-8b31-174fbd4cb947', '2a4a390b-2844-4d36-aaf6-b7c162391dd2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '16:00:00', '18:00:00', 120, true, '2026-03-25 22:55:58.331', 938, '2026-03-26 03:55:58.333239', '2026-03-26 03:55:58.333239');
INSERT INTO public.task_entries VALUES ('464a301d-7652-4834-9706-0778a0adf63b', '2a4a390b-2844-4d36-aaf6-b7c162391dd2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '18:00:00', '20:00:00', 120, true, '2026-03-25 22:55:58.366', 939, '2026-03-26 03:55:58.368219', '2026-03-26 03:55:58.368219');
INSERT INTO public.task_entries VALUES ('4a00009d-826d-47bd-9bbe-45f0cc5ffefc', '2a4a390b-2844-4d36-aaf6-b7c162391dd2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Meeting Fabrizio', 3, NULL, '19:10:00', '19:35:00', 25, true, '2026-03-25 22:55:58.37', 940, '2026-03-26 03:55:58.371547', '2026-03-26 03:55:58.371547');
INSERT INTO public.task_entries VALUES ('0ac5bd2d-2dd8-4574-920f-8d177f618a5d', '2a4a390b-2844-4d36-aaf6-b7c162391dd2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '21:00:00', '00:30:00', 210, true, '2026-03-25 22:55:58.373', 941, '2026-03-26 03:55:58.375263', '2026-03-26 03:55:58.375263');
INSERT INTO public.task_entries VALUES ('2c88bfc9-8d86-4e0d-982c-8e0cd7bee257', '86770511-173f-475d-a14e-c7f2c81e3805', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'LinkedIn & Insta Outreach', 3, NULL, '00:30:00', '01:20:00', 50, true, '2026-03-25 22:55:58.381', 942, '2026-03-26 03:55:58.383111', '2026-03-26 03:55:58.383111');
INSERT INTO public.task_entries VALUES ('a25eb99a-889d-4697-ae06-619c7776c2f1', '86770511-173f-475d-a14e-c7f2c81e3805', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '01:30:00', '06:05:00', 275, true, '2026-03-25 22:55:58.385', 943, '2026-03-26 03:55:58.386414', '2026-03-26 03:55:58.386414');
INSERT INTO public.task_entries VALUES ('44abf5a2-b119-4db2-9805-c9e4fd757945', '86770511-173f-475d-a14e-c7f2c81e3805', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '12:00:00', '17:00:00', 300, true, '2026-03-25 22:55:58.39', 944, '2026-03-26 03:55:58.391783', '2026-03-26 03:55:58.391783');
INSERT INTO public.task_entries VALUES ('b727ab8c-9355-4751-91de-c6ed15c9bb95', '86770511-173f-475d-a14e-c7f2c81e3805', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '22:15:00', 135, true, '2026-03-25 22:55:58.393', 945, '2026-03-26 03:55:58.395234', '2026-03-26 03:55:58.395234');
INSERT INTO public.task_entries VALUES ('2616c6d6-9a68-4224-b812-22a46b3297d0', '86770511-173f-475d-a14e-c7f2c81e3805', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '22:30:00', '01:00:00', 150, true, '2026-03-25 22:55:58.397', 946, '2026-03-26 03:55:58.398827', '2026-03-26 03:55:58.398827');
INSERT INTO public.task_entries VALUES ('fb27664c-1b17-45c2-a009-e4985ecf04df', '8f5fa31d-d1fb-496a-bbdc-b8002520bd28', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '01:00:00', '01:40:00', 70, true, '2026-03-25 22:55:58.404', 947, '2026-03-26 03:55:58.405774', '2026-03-26 03:55:58.405774');
INSERT INTO public.task_entries VALUES ('fa02a866-cf41-4582-946b-c3cca415782c', '8f5fa31d-d1fb-496a-bbdc-b8002520bd28', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'OpenClaw Setup', 3, NULL, '01:40:00', '02:30:00', 50, true, '2026-03-25 22:55:58.41', 948, '2026-03-26 03:55:58.412131', '2026-03-26 03:55:58.412131');
INSERT INTO public.task_entries VALUES ('a3f9ab2e-7cb7-4462-abd9-f7436c0b60bf', '8f5fa31d-d1fb-496a-bbdc-b8002520bd28', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '03:00:00', '08:30:00', 330, true, '2026-03-25 22:55:58.414', 949, '2026-03-26 03:55:58.415611', '2026-03-26 03:55:58.415611');
INSERT INTO public.task_entries VALUES ('ffbaad31-e86c-4d2d-ae6b-bc7a46765f8d', '8f5fa31d-d1fb-496a-bbdc-b8002520bd28', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '22:10:00', 130, true, '2026-03-25 22:55:58.417', 950, '2026-03-26 03:55:58.418915', '2026-03-26 03:55:58.418915');
INSERT INTO public.task_entries VALUES ('9f503d16-0abb-49ab-ac81-ab069a004383', '3007c545-c471-4a96-b89c-988d739918f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'DT', 3, NULL, '22:10:00', '05:50:00', 460, true, '2026-03-25 22:55:58.425', 951, '2026-03-26 03:55:58.426965', '2026-03-26 03:55:58.426965');
INSERT INTO public.task_entries VALUES ('fa37d740-ff22-4c6e-acdb-a3e453c1d855', '3007c545-c471-4a96-b89c-988d739918f5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AD', 3, NULL, '07:00:00', '08:30:00', 90, true, '2026-03-25 22:55:58.428', 952, '2026-03-26 03:55:58.430371', '2026-03-26 03:55:58.430371');
INSERT INTO public.task_entries VALUES ('d28e3864-cc88-455c-9084-1b8b2b3b864c', '67841421-e143-4129-bee9-521be576dec2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '20:00:00', '00:10:00', 250, true, '2026-03-25 22:55:58.435', 953, '2026-03-26 03:55:58.437546', '2026-03-26 03:55:58.437546');
INSERT INTO public.task_entries VALUES ('71ec1b0b-7756-4017-9680-fa5b931d6dc9', 'f2e5d960-780e-46ba-8bef-749193538756', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '00:10:00', '02:00:00', 110, true, '2026-03-25 22:55:58.443', 954, '2026-03-26 03:55:58.444463', '2026-03-26 03:55:58.444463');
INSERT INTO public.task_entries VALUES ('09b4b506-91f5-4c02-9566-d1d4005548ee', 'f2e5d960-780e-46ba-8bef-749193538756', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '09:00:00', '15:00:00', 360, true, '2026-03-25 22:55:58.446', 955, '2026-03-26 03:55:58.447898', '2026-03-26 03:55:58.447898');
INSERT INTO public.task_entries VALUES ('864e6dc0-f264-4d7e-800a-1dfb836aaf72', 'eb8f709f-583d-49f8-9c4c-0dffaa1bb2d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '05:00:00', '07:30:00', 150, true, '2026-03-25 22:55:58.457', 956, '2026-03-26 03:55:58.459224', '2026-03-26 03:55:58.459224');
INSERT INTO public.task_entries VALUES ('60ab01fe-84a2-4e9a-b1e0-d8b0a9392afe', 'eb8f709f-583d-49f8-9c4c-0dffaa1bb2d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '07:30:00', '08:20:00', 50, true, '2026-03-25 22:55:58.461', 957, '2026-03-26 03:55:58.462674', '2026-03-26 03:55:58.462674');
INSERT INTO public.task_entries VALUES ('0223dd55-e771-4fa3-937f-04efe6669056', 'eb8f709f-583d-49f8-9c4c-0dffaa1bb2d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Management & Outreach', 3, NULL, '08:20:00', '09:30:00', 70, true, '2026-03-25 22:55:58.464', 958, '2026-03-26 03:55:58.466255', '2026-03-26 03:55:58.466255');
INSERT INTO public.task_entries VALUES ('a5d0d2e4-9fdb-4784-800f-8be844216376', 'eb8f709f-583d-49f8-9c4c-0dffaa1bb2d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Trend Finder n8n Automation', 3, NULL, '09:30:00', '10:30:00', 60, true, '2026-03-25 22:55:58.468', 959, '2026-03-26 03:55:58.469663', '2026-03-26 03:55:58.469663');
INSERT INTO public.task_entries VALUES ('5d8cfdda-8f14-497f-a0a3-7b063d6423b7', 'eb8f709f-583d-49f8-9c4c-0dffaa1bb2d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '10:30:00', '13:40:00', 190, true, '2026-03-25 22:55:58.471', 960, '2026-03-26 03:55:58.473251', '2026-03-26 03:55:58.473251');
INSERT INTO public.task_entries VALUES ('f15bf820-2b44-4a98-9c8b-2f072a9df6a9', 'eb8f709f-583d-49f8-9c4c-0dffaa1bb2d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '15:00:00', '15:40:00', 40, true, '2026-03-25 22:55:58.476', 961, '2026-03-26 03:55:58.477522', '2026-03-26 03:55:58.477522');
INSERT INTO public.task_entries VALUES ('7c63daf7-5bce-4a6a-8498-f2951c33f3f3', 'eb8f709f-583d-49f8-9c4c-0dffaa1bb2d0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '15:40:00', '18:00:00', 140, true, '2026-03-25 22:55:58.479', 962, '2026-03-26 03:55:58.481171', '2026-03-26 03:55:58.481171');
INSERT INTO public.task_entries VALUES ('1d6bc333-d24b-4653-aad5-05b71c714c86', '784fb2d0-98f2-4b25-9ac5-24f3ba05e730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '03:00:00', 180, true, '2026-03-25 22:55:58.486', 963, '2026-03-26 03:55:58.488062', '2026-03-26 03:55:58.488062');
INSERT INTO public.task_entries VALUES ('a93245d0-4b95-4879-8238-5fe28507f3ba', '784fb2d0-98f2-4b25-9ac5-24f3ba05e730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting', 3, NULL, '03:00:00', '04:10:00', 70, true, '2026-03-25 22:55:58.49', 964, '2026-03-26 03:55:58.491512', '2026-03-26 03:55:58.491512');
INSERT INTO public.task_entries VALUES ('d1fd4759-c40a-498c-ba35-7e01e6a82921', '784fb2d0-98f2-4b25-9ac5-24f3ba05e730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Robotics Task', 3, NULL, '03:00:00', '05:10:00', 130, true, '2026-03-25 22:55:58.493', 965, '2026-03-26 03:55:58.49493', '2026-03-26 03:55:58.49493');
INSERT INTO public.task_entries VALUES ('209046b0-6713-4fe8-a115-5249d45d12b8', '784fb2d0-98f2-4b25-9ac5-24f3ba05e730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '05:10:00', '06:05:00', 55, true, '2026-03-25 22:55:58.497', 966, '2026-03-26 03:55:58.498461', '2026-03-26 03:55:58.498461');
INSERT INTO public.task_entries VALUES ('363c961f-ab0e-4709-a269-d8331aeb8ee5', '784fb2d0-98f2-4b25-9ac5-24f3ba05e730', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Uni', 3, NULL, '10:30:00', '14:30:00', 240, true, '2026-03-25 22:55:58.502', 967, '2026-03-26 03:55:58.503649', '2026-03-26 03:55:58.503649');
INSERT INTO public.task_entries VALUES ('1ebb0fc4-9ed4-42f2-9870-7c4c2f5d4417', 'cecc9260-ed1c-48cf-b0d9-000660e0af0c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Management & Outreach', 3, NULL, '08:00:00', '10:20:00', 140, true, '2026-03-25 22:55:58.509', 968, '2026-03-26 03:55:58.510626', '2026-03-26 03:55:58.510626');
INSERT INTO public.task_entries VALUES ('a1c3fec8-c5d6-494c-a06b-4515c4c15512', 'cecc9260-ed1c-48cf-b0d9-000660e0af0c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '10:20:00', '12:20:00', 120, true, '2026-03-25 22:55:58.512', 969, '2026-03-26 03:55:58.514323', '2026-03-26 03:55:58.514323');
INSERT INTO public.task_entries VALUES ('5808d1e4-d15d-42b7-955d-03cb18cf9f56', 'cecc9260-ed1c-48cf-b0d9-000660e0af0c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Expense Calc', 3, NULL, '12:30:00', '14:10:00', 100, true, '2026-03-25 22:55:58.516', 970, '2026-03-26 03:55:58.517698', '2026-03-26 03:55:58.517698');
INSERT INTO public.task_entries VALUES ('9600faba-4d5a-4b3a-bf78-d07666b30831', 'cecc9260-ed1c-48cf-b0d9-000660e0af0c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'Case Study Posting', 3, NULL, '14:10:00', '15:00:00', 50, true, '2026-03-25 22:55:58.519', 971, '2026-03-26 03:55:58.520902', '2026-03-26 03:55:58.520902');
INSERT INTO public.task_entries VALUES ('1cee37d6-1cd5-47f3-82e6-8d1824c1488b', 'cecc9260-ed1c-48cf-b0d9-000660e0af0c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'Misc', 3, NULL, '15:00:00', '16:00:00', 60, true, '2026-03-25 22:55:58.522', 972, '2026-03-26 03:55:58.523765', '2026-03-26 03:55:58.523765');
INSERT INTO public.task_entries VALUES ('0f0fcd5b-160a-4bdd-a871-ccb4f094a8a6', 'cecc9260-ed1c-48cf-b0d9-000660e0af0c', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '16:00:00', '19:00:00', 300, true, '2026-03-25 22:55:58.525', 973, '2026-03-26 03:55:58.527332', '2026-03-26 03:55:58.527332');
INSERT INTO public.task_entries VALUES ('69101feb-3994-4aeb-ab53-5d556dbc4ec5', '28c03cb0-024e-440f-9d84-840b271e9ba6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 2, NULL, '03:00:00', '12:20:00', 560, true, '2026-03-25 22:55:58.533', 974, '2026-03-26 03:55:58.535151', '2026-03-26 03:55:58.535151');
INSERT INTO public.task_entries VALUES ('260e1dcf-d985-4a0d-97ce-960fc83c00c3', '28c03cb0-024e-440f-9d84-840b271e9ba6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '17:00:00', 120, true, '2026-03-25 22:55:58.608', 975, '2026-03-26 03:55:58.609793', '2026-03-26 03:55:58.609793');
INSERT INTO public.task_entries VALUES ('0cf5863f-8cd1-4704-8172-e98b8eef7fdc', '28c03cb0-024e-440f-9d84-840b271e9ba6', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '17:00:00', '19:00:00', 120, true, '2026-03-25 22:55:58.625', 976, '2026-03-26 03:55:58.627312', '2026-03-26 03:55:58.627312');
INSERT INTO public.task_entries VALUES ('a457e242-8323-4a30-bb60-edf16374e827', 'bd86d308-a807-4fb7-8d72-4e8952d0e9ce', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '10:00:00', '11:20:00', 210, true, '2026-03-25 22:55:58.635', 977, '2026-03-26 03:55:58.636753', '2026-03-26 03:55:58.636753');
INSERT INTO public.task_entries VALUES ('369f0617-dc02-4e79-a4e1-e4c822f01ea7', 'bd86d308-a807-4fb7-8d72-4e8952d0e9ce', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '23:20:00', '13:30:00', 850, true, '2026-03-25 22:55:58.65', 978, '2026-03-26 03:55:58.651943', '2026-03-26 03:55:58.651943');
INSERT INTO public.task_entries VALUES ('f328941c-1180-44f4-bb88-0d630fa432f4', 'bd86d308-a807-4fb7-8d72-4e8952d0e9ce', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Management & Outreach', 3, NULL, '13:30:00', '15:30:00', 120, true, '2026-03-25 22:55:58.655', 979, '2026-03-26 03:55:58.656974', '2026-03-26 03:55:58.656974');
INSERT INTO public.task_entries VALUES ('0d64b893-91d8-4c2c-b357-442e7900a79e', 'bd86d308-a807-4fb7-8d72-4e8952d0e9ce', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Machine Learning Course', 3, NULL, '15:30:00', '20:20:00', 290, true, '2026-03-25 22:55:58.658', 980, '2026-03-26 03:55:58.66026', '2026-03-26 03:55:58.66026');
INSERT INTO public.task_entries VALUES ('6161fbef-c053-4f89-94a9-462b9e3b345b', '430ecfda-9d06-4790-9332-a5922dc4d4cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'ML', 3, NULL, '10:30:00', '13:00:00', 150, true, '2026-03-25 22:55:58.666', 981, '2026-03-26 03:55:58.668348', '2026-03-26 03:55:58.668348');
INSERT INTO public.task_entries VALUES ('af192f58-78b6-4e5f-ba85-3ebc86e27e94', '430ecfda-9d06-4790-9332-a5922dc4d4cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '13:00:00', '14:00:00', 60, true, '2026-03-25 22:55:58.671', 982, '2026-03-26 03:55:58.673432', '2026-03-26 03:55:58.673432');
INSERT INTO public.task_entries VALUES ('03bd6d96-dc39-4486-9c58-1bfd3e9f5ec0', '430ecfda-9d06-4790-9332-a5922dc4d4cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '20:00:00', '22:00:00', 120, true, '2026-03-25 22:55:58.675', 983, '2026-03-26 03:55:58.676785', '2026-03-26 03:55:58.676785');
INSERT INTO public.task_entries VALUES ('8897f725-2945-4ab0-8c14-e348bd6b003a', '430ecfda-9d06-4790-9332-a5922dc4d4cc', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Management & Outreach', 3, NULL, '22:00:00', '00:30:00', 150, true, '2026-03-25 22:55:58.678', 984, '2026-03-26 03:55:58.68018', '2026-03-26 03:55:58.68018');
INSERT INTO public.task_entries VALUES ('e9b92f4b-1625-493a-b862-34e85afa048d', '5e761d3f-9960-4e97-bec1-115cd0d1b208', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'AL/ML Projects Case Studies & Portfolio Update', 3, NULL, '00:30:00', '05:00:00', 270, true, '2026-03-25 22:55:58.685', 985, '2026-03-26 03:55:58.6871', '2026-03-26 03:55:58.6871');
INSERT INTO public.task_entries VALUES ('915fb46d-023e-4098-8a70-072962b37ec3', '5e761d3f-9960-4e97-bec1-115cd0d1b208', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DOA', 3, NULL, '07:30:00', '10:00:00', 150, true, '2026-03-25 22:55:58.691', 986, '2026-03-26 03:55:58.692467', '2026-03-26 03:55:58.692467');
INSERT INTO public.task_entries VALUES ('a4be8cc7-05dd-4bc7-ad0e-a1aa9cfcb8e1', '5e761d3f-9960-4e97-bec1-115cd0d1b208', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Misc - Lib', 3, NULL, '10:30:00', '13:20:00', 170, true, '2026-03-25 22:55:58.695', 987, '2026-03-26 03:55:58.696697', '2026-03-26 03:55:58.696697');
INSERT INTO public.task_entries VALUES ('a112cc00-0774-4d8d-9c27-e999f0a23e23', '5e761d3f-9960-4e97-bec1-115cd0d1b208', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'RB', 3, NULL, '13:20:00', '15:00:00', 100, true, '2026-03-25 22:55:58.698', 988, '2026-03-26 03:55:58.700344', '2026-03-26 03:55:58.700344');
INSERT INTO public.task_entries VALUES ('bccbe12f-9046-40cd-8bf5-e3d663c5f44e', '5e761d3f-9960-4e97-bec1-115cd0d1b208', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '18:00:00', '18:40:00', 40, true, '2026-03-25 22:55:58.702', 989, '2026-03-26 03:55:58.703613', '2026-03-26 03:55:58.703613');
INSERT INTO public.task_entries VALUES ('882b1e60-69a7-4112-abc8-b038d463cee1', '5e761d3f-9960-4e97-bec1-115cd0d1b208', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Offer', 3, NULL, '18:40:00', '23:20:00', 280, true, '2026-03-25 22:55:58.705', 990, '2026-03-26 03:55:58.706437', '2026-03-26 03:55:58.706437');
INSERT INTO public.task_entries VALUES ('d8ab7c5b-c472-4691-aa58-5858ab8163d0', '7691ba85-74b8-4c26-b284-8308f6dce6b1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DOA & DV', 3, NULL, '10:00:00', '14:30:00', 270, true, '2026-03-25 22:55:58.713', 991, '2026-03-26 03:55:58.715439', '2026-03-26 03:55:58.715439');
INSERT INTO public.task_entries VALUES ('e31d3d79-150e-4f02-9976-3d19cc01d9ce', '7691ba85-74b8-4c26-b284-8308f6dce6b1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:30:00', '15:30:00', 125, true, '2026-03-25 22:55:58.717', 992, '2026-03-26 03:55:58.718651', '2026-03-26 03:55:58.718651');
INSERT INTO public.task_entries VALUES ('f86f9083-f099-470b-87d8-88791c957b28', '7691ba85-74b8-4c26-b284-8308f6dce6b1', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting & Outreach', 3, NULL, '15:30:00', '17:00:00', 90, true, '2026-03-25 22:55:58.72', 993, '2026-03-26 03:55:58.722404', '2026-03-26 03:55:58.722404');
INSERT INTO public.task_entries VALUES ('6d20fc36-d721-4cbb-902f-f2f3d9d024b7', 'b69e1fe3-d701-4149-aed5-fecd059124f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '03:00:00', '06:30:00', 210, true, '2026-03-25 22:55:58.729', 994, '2026-03-26 03:55:58.731124', '2026-03-26 03:55:58.731124');
INSERT INTO public.task_entries VALUES ('b8b14008-c4a6-49ad-8bca-081c3782cd92', 'b69e1fe3-d701-4149-aed5-fecd059124f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'ML', 3, NULL, '10:30:00', '14:30:00', 240, true, '2026-03-25 22:55:58.733', 995, '2026-03-26 03:55:58.734459', '2026-03-26 03:55:58.734459');
INSERT INTO public.task_entries VALUES ('18368052-8aad-4d85-a795-2b61572b8149', 'b69e1fe3-d701-4149-aed5-fecd059124f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '14:30:00', '17:10:00', 160, true, '2026-03-25 22:55:58.739', 996, '2026-03-26 03:55:58.740568', '2026-03-26 03:55:58.740568');
INSERT INTO public.task_entries VALUES ('3f9e4aa0-8ceb-42f8-928f-6407766e27fe', 'b69e1fe3-d701-4149-aed5-fecd059124f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting & Outreach', 3, NULL, '17:00:00', '19:15:00', 135, true, '2026-03-25 22:55:58.742', 997, '2026-03-26 03:55:58.744225', '2026-03-26 03:55:58.744225');
INSERT INTO public.task_entries VALUES ('1fb2dce8-fa3f-466f-9ef3-ffb9368987d8', 'b69e1fe3-d701-4149-aed5-fecd059124f0', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Offer', 3, NULL, '19:15:00', '23:50:00', 275, true, '2026-03-25 22:55:58.746', 998, '2026-03-26 03:55:58.747614', '2026-03-26 03:55:58.747614');
INSERT INTO public.task_entries VALUES ('b29653b6-f056-4416-90f2-9dffa30c1b8c', 'dc93b185-ac4b-4a93-90ff-51d4e061c578', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'Misc', 1, NULL, '04:00:00', '07:30:00', 390, true, '2026-03-25 22:55:58.753', 999, '2026-03-26 03:55:58.754721', '2026-03-26 03:55:58.754721');
INSERT INTO public.task_entries VALUES ('0fa848d3-4cb7-419e-854e-4636c229b796', 'dc93b185-ac4b-4a93-90ff-51d4e061c578', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:00:00', '16:15:00', 75, true, '2026-03-25 22:55:58.756', 1000, '2026-03-26 03:55:58.758004', '2026-03-26 03:55:58.758004');
INSERT INTO public.task_entries VALUES ('2e84c8f4-7bc2-4b80-951a-ac70029121e8', 'dc93b185-ac4b-4a93-90ff-51d4e061c578', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '16:15:00', '17:50:00', 95, true, '2026-03-25 22:55:58.76', 1001, '2026-03-26 03:55:58.761665', '2026-03-26 03:55:58.761665');
INSERT INTO public.task_entries VALUES ('dbbec0c3-b4b6-4959-a321-8cfbd6aaf546', 'dc93b185-ac4b-4a93-90ff-51d4e061c578', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'WF', 3, NULL, '17:50:00', '19:00:00', 70, true, '2026-03-25 22:55:58.766', 1002, '2026-03-26 03:55:58.767748', '2026-03-26 03:55:58.767748');
INSERT INTO public.task_entries VALUES ('a6afa2fc-b016-4445-9cb7-23f9d3c03179', 'dc93b185-ac4b-4a93-90ff-51d4e061c578', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting & Outreach', 3, NULL, '19:15:00', '00:10:00', 295, true, '2026-03-25 22:55:58.77', 1003, '2026-03-26 03:55:58.772207', '2026-03-26 03:55:58.772207');
INSERT INTO public.task_entries VALUES ('75a09b7b-2b08-4c09-b843-70146465b56e', '9d2dc3a8-d7ad-4c44-89e8-3e7eb4939bdd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Offer', 3, NULL, '00:20:00', '04:50:00', 270, true, '2026-03-25 22:55:58.779', 1004, '2026-03-26 03:55:58.78106', '2026-03-26 03:55:58.78106');
INSERT INTO public.task_entries VALUES ('8876823f-f0cc-4db2-8f7a-fdf2fc9189bd', '9d2dc3a8-d7ad-4c44-89e8-3e7eb4939bdd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:30:00', '16:50:00', 80, true, '2026-03-25 22:55:58.783', 1005, '2026-03-26 03:55:58.785084', '2026-03-26 03:55:58.785084');
INSERT INTO public.task_entries VALUES ('a415dcac-5f32-41af-bcf6-1dd57d7ca231', '9d2dc3a8-d7ad-4c44-89e8-3e7eb4939bdd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting & Outreach', 3, NULL, '17:50:00', '19:30:00', 100, true, '2026-03-25 22:55:58.789', 1006, '2026-03-26 03:55:58.790532', '2026-03-26 03:55:58.790532');
INSERT INTO public.task_entries VALUES ('73d26aac-d65a-46ac-aa7f-9460897b6dd6', '9d2dc3a8-d7ad-4c44-89e8-3e7eb4939bdd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '19:30:00', '21:10:00', 100, true, '2026-03-25 22:55:58.792', 1007, '2026-03-26 03:55:58.793869', '2026-03-26 03:55:58.793869');
INSERT INTO public.task_entries VALUES ('59172799-9543-4d34-bf50-36a9b1c758a9', '9d2dc3a8-d7ad-4c44-89e8-3e7eb4939bdd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Offer', 3, NULL, '22:10:00', '02:10:00', 240, true, '2026-03-25 22:55:58.795', 1008, '2026-03-26 03:55:58.797499', '2026-03-26 03:55:58.797499');
INSERT INTO public.task_entries VALUES ('1102fb2f-1fc2-4a66-9a77-d05eec9bf446', '230e91ae-d297-4304-899f-d7a527773b02', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Offer', 3, NULL, '02:30:00', '04:00:00', 90, true, '2026-03-25 22:55:58.803', 1009, '2026-03-26 03:55:58.804321', '2026-03-26 03:55:58.804321');
INSERT INTO public.task_entries VALUES ('594d2f92-6a95-48d1-99b3-2a6f3843bf48', '230e91ae-d297-4304-899f-d7a527773b02', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic Workflows', 3, NULL, '04:00:00', '06:10:00', 130, true, '2026-03-25 22:55:58.806', 1010, '2026-03-26 03:55:58.807958', '2026-03-26 03:55:58.807958');
INSERT INTO public.task_entries VALUES ('074713c8-951f-4625-82cd-ecf7cfa91229', '230e91ae-d297-4304-899f-d7a527773b02', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:50:00', '18:10:00', 80, true, '2026-03-25 22:55:59.033', 1011, '2026-03-26 03:55:59.03487', '2026-03-26 03:55:59.03487');
INSERT INTO public.task_entries VALUES ('13bc009f-4a95-4f84-9f9b-2619eede1a70', '230e91ae-d297-4304-899f-d7a527773b02', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '18:10:00', '20:00:00', 110, true, '2026-03-25 22:55:59.185', 1012, '2026-03-26 03:55:59.18637', '2026-03-26 03:55:59.18637');
INSERT INTO public.task_entries VALUES ('75b6179c-9936-4ca8-89aa-9e9258941740', '230e91ae-d297-4304-899f-d7a527773b02', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting & Outreach', 3, NULL, '20:00:00', '22:00:00', 120, true, '2026-03-25 22:55:59.288', 1013, '2026-03-26 03:55:59.290137', '2026-03-26 03:55:59.290137');
INSERT INTO public.task_entries VALUES ('76a2f8ed-7126-4578-8d1a-3228811dea62', '5c3d6ec4-83d8-4212-b5e3-223b8a953416', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Offer', 3, NULL, '00:00:00', '06:00:00', 360, true, '2026-03-25 22:55:59.376', 1014, '2026-03-26 03:55:59.377855', '2026-03-26 03:55:59.377855');
INSERT INTO public.task_entries VALUES ('c43ee846-735d-4ae1-87ac-c054d3d40ffc', '5c3d6ec4-83d8-4212-b5e3-223b8a953416', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Creating Grand Slam Offer for agency', 3, NULL, '06:00:00', '07:50:00', 110, true, '2026-03-25 22:55:59.382', 1015, '2026-03-26 03:55:59.383512', '2026-03-26 03:55:59.383512');
INSERT INTO public.task_entries VALUES ('dbd3d565-bc15-45bd-bfca-5652df8933b2', '5c3d6ec4-83d8-4212-b5e3-223b8a953416', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '07:50:00', '08:40:00', 50, true, '2026-03-25 22:55:59.389', 1016, '2026-03-26 03:55:59.390497', '2026-03-26 03:55:59.390497');
INSERT INTO public.task_entries VALUES ('f745cb49-b2f8-4500-9b63-c8328c3dd533', '5c3d6ec4-83d8-4212-b5e3-223b8a953416', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '08:40:00', '09:20:00', 100, true, '2026-03-25 22:55:59.399', 1017, '2026-03-26 03:55:59.401059', '2026-03-26 03:55:59.401059');
INSERT INTO public.task_entries VALUES ('ee3d3d6a-5f49-4109-85fe-8df057fd0210', '5c3d6ec4-83d8-4212-b5e3-223b8a953416', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Offer Crafting and Strategy Adjustment', 3, NULL, '18:00:00', '21:50:00', 230, true, '2026-03-25 22:55:59.405', 1018, '2026-03-26 03:55:59.406664', '2026-03-26 03:55:59.406664');
INSERT INTO public.task_entries VALUES ('f355a9f6-9d68-465f-9d6b-bb3fb0cbc6d3', 'a184a27b-0de7-45f9-b4a7-f966fd310e31', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:40:00', '18:20:00', 100, true, '2026-03-25 22:55:59.448', 1019, '2026-03-26 03:55:59.450194', '2026-03-26 03:55:59.450194');
INSERT INTO public.task_entries VALUES ('b5734882-18da-49e3-a1b3-c3243af0097a', 'a184a27b-0de7-45f9-b4a7-f966fd310e31', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'SM Content Posting & Outreach, Portfolio Update', 3, NULL, '18:20:00', '22:20:00', 1040, true, '2026-03-25 22:55:59.452', 1020, '2026-03-26 03:55:59.453768', '2026-03-26 03:55:59.453768');
INSERT INTO public.task_entries VALUES ('ba3fb05c-a93f-4c16-8bd0-730dee18f412', 'a184a27b-0de7-45f9-b4a7-f966fd310e31', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, '12 Thu Roy Meeting 10:30PM', 3, NULL, '22:20:00', '22:40:00', 20, true, '2026-03-25 22:55:59.455', 1021, '2026-03-26 03:55:59.45716', '2026-03-26 03:55:59.45716');
INSERT INTO public.task_entries VALUES ('e0db0e2a-00aa-4c93-9ec3-6b16f0a80116', '9bee413a-661c-4b3c-a938-9d82fa247dc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'LinkedIn & Insta Outreach', 3, NULL, '00:00:00', '01:00:00', 60, true, '2026-03-25 22:55:59.462', 1022, '2026-03-26 03:55:59.464241', '2026-03-26 03:55:59.464241');
INSERT INTO public.task_entries VALUES ('9a0dd87f-b953-4216-acb4-6a8ea36ad038', '9bee413a-661c-4b3c-a938-9d82fa247dc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding & Consulation', 3, NULL, '01:00:00', '03:20:00', 140, true, '2026-03-25 22:55:59.466', 1023, '2026-03-26 03:55:59.467478', '2026-03-26 03:55:59.467478');
INSERT INTO public.task_entries VALUES ('0ff20e54-9cc9-49b8-a4af-2b07f196392b', '9bee413a-661c-4b3c-a938-9d82fa247dc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '03:20:00', '07:50:00', 270, true, '2026-03-25 22:55:59.469', 1024, '2026-03-26 03:55:59.470822', '2026-03-26 03:55:59.470822');
INSERT INTO public.task_entries VALUES ('d442e5df-c83c-4c95-87a1-bbfa88c382f1', '9bee413a-661c-4b3c-a938-9d82fa247dc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 2, NULL, '23:40:00', '20:20:00', 1240, true, '2026-03-25 22:55:59.475', 1025, '2026-03-26 03:55:59.476988', '2026-03-26 03:55:59.476988');
INSERT INTO public.task_entries VALUES ('0c442016-0e21-4e76-bef5-27fc8a138201', '9bee413a-661c-4b3c-a938-9d82fa247dc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '20:30:00', '02:30:00', 360, true, '2026-03-25 22:55:59.479', 1026, '2026-03-26 03:55:59.480673', '2026-03-26 03:55:59.480673');
INSERT INTO public.task_entries VALUES ('f3aad009-ce8a-4a04-ac66-b4911a35b5d2', '39299f98-4ee5-4fcb-b4e2-a59dd1542c51', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '02:30:00', '03:40:00', 70, true, '2026-03-25 22:55:59.486', 1027, '2026-03-26 03:55:59.487677', '2026-03-26 03:55:59.487677');
INSERT INTO public.task_entries VALUES ('67bbfef3-a1eb-4e3b-b5f3-435be7befaae', '39299f98-4ee5-4fcb-b4e2-a59dd1542c51', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '03:50:00', '07:00:00', 190, true, '2026-03-25 22:55:59.489', 1028, '2026-03-26 03:55:59.491027', '2026-03-26 03:55:59.491027');
INSERT INTO public.task_entries VALUES ('746dedfb-7da4-4aff-9cf1-b85944234191', '39299f98-4ee5-4fcb-b4e2-a59dd1542c51', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '12:00:00', '14:00:00', 120, true, '2026-03-25 22:55:59.493', 1029, '2026-03-26 03:55:59.494439', '2026-03-26 03:55:59.494439');
INSERT INTO public.task_entries VALUES ('02ec5f9f-286e-4c47-ba6a-654c192d73c3', '39299f98-4ee5-4fcb-b4e2-a59dd1542c51', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Gaming', 2, NULL, '23:00:00', '01:30:00', 150, true, '2026-03-25 22:55:59.496', 1030, '2026-03-26 03:55:59.498038', '2026-03-26 03:55:59.498038');
INSERT INTO public.task_entries VALUES ('f5e4c674-a108-43b5-8baf-551981a4f1be', '14e32472-4188-4e2f-a416-2171bc1d8624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '01:30:00', '05:20:00', 230, true, '2026-03-25 22:55:59.502', 1031, '2026-03-26 03:55:59.504218', '2026-03-26 03:55:59.504218');
INSERT INTO public.task_entries VALUES ('60661905-0280-4434-8aa4-51dd5b2d7a65', '14e32472-4188-4e2f-a416-2171bc1d8624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '15:00:00', '17:20:00', 140, true, '2026-03-25 22:55:59.506', 1032, '2026-03-26 03:55:59.507773', '2026-03-26 03:55:59.507773');
INSERT INTO public.task_entries VALUES ('7efe62a9-c532-48a3-8d7a-9d345e4abd0e', '14e32472-4188-4e2f-a416-2171bc1d8624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'RB & DV Assignments', 3, NULL, '17:40:00', '18:30:00', 50, true, '2026-03-25 22:55:59.509', 1033, '2026-03-26 03:55:59.511074', '2026-03-26 03:55:59.511074');
INSERT INTO public.task_entries VALUES ('8e2eced5-669c-4170-a0ce-32c79ab6f8ef', '14e32472-4188-4e2f-a416-2171bc1d8624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Daily News Workflow', 3, NULL, '18:30:00', '21:40:00', 190, true, '2026-03-25 22:55:59.513', 1034, '2026-03-26 03:55:59.514721', '2026-03-26 03:55:59.514721');
INSERT INTO public.task_entries VALUES ('db1b46c4-65f2-4f2a-b919-7c2581da3f54', '14e32472-4188-4e2f-a416-2171bc1d8624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting', 3, NULL, '21:40:00', '22:10:00', 30, true, '2026-03-25 22:55:59.518', 1035, '2026-03-26 03:55:59.519775', '2026-03-26 03:55:59.519775');
INSERT INTO public.task_entries VALUES ('09418c1b-3c12-4d52-bcdd-0c338098d7a3', '14e32472-4188-4e2f-a416-2171bc1d8624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Youtube Daily Workflow', 3, NULL, '22:10:00', '23:40:00', 90, true, '2026-03-25 22:55:59.522', 1036, '2026-03-26 03:55:59.52421', '2026-03-26 03:55:59.52421');
INSERT INTO public.task_entries VALUES ('f0b5ba2f-3d86-4ec6-ae73-82396c6d52ce', '14e32472-4188-4e2f-a416-2171bc1d8624', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '23:40:00', '01:00:00', 80, true, '2026-03-25 22:55:59.526', 1037, '2026-03-26 03:55:59.527671', '2026-03-26 03:55:59.527671');
INSERT INTO public.task_entries VALUES ('23277969-730a-4929-a77f-62f9f173addd', 'ba0301c0-7170-4364-8d27-4714caebe2f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Files Organization', 3, NULL, '01:30:00', '03:50:00', 140, true, '2026-03-25 22:55:59.534', 1038, '2026-03-26 03:55:59.535723', '2026-03-26 03:55:59.535723');
INSERT INTO public.task_entries VALUES ('4d87a2da-dfcf-4093-ae80-1dde4c160f7d', 'ba0301c0-7170-4364-8d27-4714caebe2f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '05:20:00', '06:10:00', 50, true, '2026-03-25 22:55:59.537', 1039, '2026-03-26 03:55:59.538975', '2026-03-26 03:55:59.538975');
INSERT INTO public.task_entries VALUES ('c72a8002-3c25-4e60-8335-30caa3b48551', 'ba0301c0-7170-4364-8d27-4714caebe2f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '12:00:00', '14:00:00', 120, true, '2026-03-25 22:55:59.541', 1040, '2026-03-26 03:55:59.542493', '2026-03-26 03:55:59.542493');
INSERT INTO public.task_entries VALUES ('2009a44c-ac2f-4153-aa0d-fe6415934e96', 'ba0301c0-7170-4364-8d27-4714caebe2f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '14:00:00', '15:00:00', 60, true, '2026-03-25 22:55:59.544', 1041, '2026-03-26 03:55:59.545917', '2026-03-26 03:55:59.545917');
INSERT INTO public.task_entries VALUES ('d5505479-fb2b-4985-af7f-fe03baade2ce', 'ba0301c0-7170-4364-8d27-4714caebe2f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'n8n workflow to claude workflow', 3, NULL, '15:00:00', '17:20:00', 140, true, '2026-03-25 22:55:59.547', 1042, '2026-03-26 03:55:59.548623', '2026-03-26 03:55:59.548623');
INSERT INTO public.task_entries VALUES ('8e3a36dd-b33f-4565-83ae-5027126ccdd1', 'ba0301c0-7170-4364-8d27-4714caebe2f2', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '17:20:00', '18:10:00', 50, true, '2026-03-25 22:55:59.55', 1043, '2026-03-26 03:55:59.552249', '2026-03-26 03:55:59.552249');
INSERT INTO public.task_entries VALUES ('d0e880cf-7b84-4683-95c2-b0a2e993be5d', '9fd52797-2317-467a-81ba-c26aaf7ad7d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '23:30:00', '01:30:00', 120, true, '2026-03-25 22:55:59.559', 1044, '2026-03-26 03:55:59.560872', '2026-03-26 03:55:59.560872');
INSERT INTO public.task_entries VALUES ('c07942f9-5bfc-483d-ab28-41360e0c0b84', '9fd52797-2317-467a-81ba-c26aaf7ad7d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'n8n workflow to claude workflow', 3, NULL, '01:30:00', '02:20:00', 50, true, '2026-03-25 22:55:59.563', 1045, '2026-03-26 03:55:59.564573', '2026-03-26 03:55:59.564573');
INSERT INTO public.task_entries VALUES ('936a65c8-e366-41c6-92a2-b5bbba2069a7', '9fd52797-2317-467a-81ba-c26aaf7ad7d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '02:20:00', '06:10:00', 230, true, '2026-03-25 22:55:59.566', 1046, '2026-03-26 03:55:59.567878', '2026-03-26 03:55:59.567878');
INSERT INTO public.task_entries VALUES ('9fef3a46-8dbc-40e7-9248-c2f2eda12e5a', '9fd52797-2317-467a-81ba-c26aaf7ad7d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '14:00:00', '16:05:00', 125, true, '2026-03-25 22:55:59.57', 1047, '2026-03-26 03:55:59.572218', '2026-03-26 03:55:59.572218');
INSERT INTO public.task_entries VALUES ('f95889d2-0da2-4d22-8091-ca06aa82c821', '9fd52797-2317-467a-81ba-c26aaf7ad7d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c5cb9969-0e49-4081-ac53-6cca8d0fba97', NULL, 'SM Content Posting & Outreach', 3, NULL, '16:05:00', '17:15:00', 70, true, '2026-03-25 22:55:59.574', 1048, '2026-03-26 03:55:59.575723', '2026-03-26 03:55:59.575723');
INSERT INTO public.task_entries VALUES ('7a46d88b-f3d8-432c-8454-ccac11af0521', '9fd52797-2317-467a-81ba-c26aaf7ad7d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '17:15:00', '03:05:00', 590, true, '2026-03-25 22:55:59.577', 1049, '2026-03-26 03:55:59.579126', '2026-03-26 03:55:59.579126');
INSERT INTO public.task_entries VALUES ('74178ba6-c89c-4146-9b04-b201b83ee262', '4c367d5e-3bf2-423c-9274-01a110cca9bd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '03:05:00', '07:30:00', 265, true, '2026-03-25 22:55:59.584', 1050, '2026-03-26 03:55:59.586248', '2026-03-26 03:55:59.586248');
INSERT INTO public.task_entries VALUES ('14a1c292-5700-43db-a039-2ae9b60bea76', '4c367d5e-3bf2-423c-9274-01a110cca9bd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:05:00', '17:00:00', 235, true, '2026-03-25 22:55:59.588', 1051, '2026-03-26 03:55:59.58977', '2026-03-26 03:55:59.58977');
INSERT INTO public.task_entries VALUES ('e831f823-3781-4c93-aca0-4f719d6c75f2', '4c367d5e-3bf2-423c-9274-01a110cca9bd', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Client Job Description to Structured Scope Requirements', 3, NULL, '15:05:00', '19:30:00', 265, true, '2026-03-25 22:55:59.591', 1052, '2026-03-26 03:55:59.59339', '2026-03-26 03:55:59.59339');
INSERT INTO public.task_entries VALUES ('75c4852a-5557-420f-b1e7-d2752f59c2f0', 'f85a544d-b5fa-4d7e-9048-cbe9c4db4d90', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '23:00:00', '07:40:00', 520, true, '2026-03-25 22:55:59.599', 1053, '2026-03-26 03:55:59.600286', '2026-03-26 03:55:59.600286');
INSERT INTO public.task_entries VALUES ('9f37cefb-16d7-4348-af82-86be6b47ec22', 'f85a544d-b5fa-4d7e-9048-cbe9c4db4d90', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '15:05:00', '18:30:00', 355, true, '2026-03-25 22:55:59.604', 1054, '2026-03-26 03:55:59.605589', '2026-03-26 03:55:59.605589');
INSERT INTO public.task_entries VALUES ('33e12c25-66ea-4d72-a9b6-a330ef4ff3d8', 'f85a544d-b5fa-4d7e-9048-cbe9c4db4d90', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Gaming', 2, NULL, '22:00:00', '12:00:00', 840, true, '2026-03-25 22:55:59.607', 1055, '2026-03-26 03:55:59.609086', '2026-03-26 03:55:59.609086');
INSERT INTO public.task_entries VALUES ('974745fc-4722-4c86-bfe7-d7e7415c8e84', 'f85a544d-b5fa-4d7e-9048-cbe9c4db4d90', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '12:15:00', '04:05:00', 950, true, '2026-03-25 22:55:59.611', 1056, '2026-03-26 03:55:59.612457', '2026-03-26 03:55:59.612457');
INSERT INTO public.task_entries VALUES ('71098f2e-b02a-438b-b2d4-e33e10cac58b', '520e08ab-bde0-4de9-92d5-2b8f4a2f01da', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '16:05:00', '18:00:00', 115, true, '2026-03-25 22:55:59.619', 1057, '2026-03-26 03:55:59.620298', '2026-03-26 03:55:59.620298');
INSERT INTO public.task_entries VALUES ('1a935e70-5ef5-4eca-bf18-0cf41f89ac82', '520e08ab-bde0-4de9-92d5-2b8f4a2f01da', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Out', 3, NULL, '18:15:00', '21:10:00', 175, true, '2026-03-25 22:55:59.622', 1058, '2026-03-26 03:55:59.623881', '2026-03-26 03:55:59.623881');
INSERT INTO public.task_entries VALUES ('0b2c9ecb-d254-4f8c-8c6d-3bb12d2499fc', '520e08ab-bde0-4de9-92d5-2b8f4a2f01da', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Gaming', 2, NULL, '21:10:00', '23:10:00', 120, true, '2026-03-25 22:55:59.626', 1059, '2026-03-26 03:55:59.627288', '2026-03-26 03:55:59.627288');
INSERT INTO public.task_entries VALUES ('092ba279-7ee6-4c99-bea5-abb9b9f71959', '9c482643-90e6-4822-a581-e2b4b935e4de', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, 'Agentic AI', 3, NULL, '23:10:00', '08:20:00', 550, true, '2026-03-25 22:55:59.633', 1060, '2026-03-26 03:55:59.634401', '2026-03-26 03:55:59.634401');
INSERT INTO public.task_entries VALUES ('605618d5-34bf-41ef-ad37-877329fc4ede', '9c482643-90e6-4822-a581-e2b4b935e4de', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '16:05:00', '17:00:00', 55, true, '2026-03-25 22:55:59.636', 1061, '2026-03-26 03:55:59.637774', '2026-03-26 03:55:59.637774');
INSERT INTO public.task_entries VALUES ('cbc0eff1-c175-4494-bec4-5da5fa2249cd', '9c482643-90e6-4822-a581-e2b4b935e4de', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Agentic AI, SM Content Management', 3, NULL, '17:00:00', '22:30:00', 330, true, '2026-03-25 22:55:59.64', 1062, '2026-03-26 03:55:59.64129', '2026-03-26 03:55:59.64129');
INSERT INTO public.task_entries VALUES ('d92131af-ddfc-48ae-9f66-b1f5a9fe9d50', '70b328fa-e10c-4554-bbf2-3e078343891d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:30:00', '21:30:00', 120, true, '2026-03-25 22:55:59.648', 1063, '2026-03-26 03:55:59.65009', '2026-03-26 03:55:59.65009');
INSERT INTO public.task_entries VALUES ('7560cd5d-77f7-42e2-8967-79b7cf81e6d7', '70b328fa-e10c-4554-bbf2-3e078343891d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'WF', 3, NULL, '21:30:00', '00:00:00', 150, true, '2026-03-25 22:55:59.653', 1064, '2026-03-26 03:55:59.654347', '2026-03-26 03:55:59.654347');
INSERT INTO public.task_entries VALUES ('dd767464-97b1-4d1c-ae72-a5a2506ca8b8', '9119fb7e-c437-4eae-9bbd-32f5f1a5a36d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '00:00:00', '01:30:00', 90, true, '2026-03-25 22:55:59.66', 1065, '2026-03-26 03:55:59.661278', '2026-03-26 03:55:59.661278');
INSERT INTO public.task_entries VALUES ('916f6064-e95c-4a7f-aa9b-51b8fe8e1c7f', '9119fb7e-c437-4eae-9bbd-32f5f1a5a36d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '01:50:00', '09:30:00', 460, true, '2026-03-25 22:55:59.662', 1066, '2026-03-26 03:55:59.663873', '2026-03-26 03:55:59.663873');
INSERT INTO public.task_entries VALUES ('2f245a41-5fa2-4f29-be2f-2253a1342fcc', '9119fb7e-c437-4eae-9bbd-32f5f1a5a36d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '16:00:00', '17:20:00', 80, true, '2026-03-25 22:55:59.666', 1067, '2026-03-26 03:55:59.667445', '2026-03-26 03:55:59.667445');
INSERT INTO public.task_entries VALUES ('3a813118-15eb-42dd-b15e-97c02b8d3073', '9119fb7e-c437-4eae-9bbd-32f5f1a5a36d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Bidding', 3, NULL, '17:20:00', '18:30:00', 70, true, '2026-03-25 22:55:59.67', 1068, '2026-03-26 03:55:59.671717', '2026-03-26 03:55:59.671717');
INSERT INTO public.task_entries VALUES ('5601143d-7b9b-4e16-852f-d2ceb76804d7', '9119fb7e-c437-4eae-9bbd-32f5f1a5a36d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Upwork Job Postings At', 3, NULL, '18:30:00', '20:40:00', 130, true, '2026-03-25 22:55:59.673', 1069, '2026-03-26 03:55:59.674536', '2026-03-26 03:55:59.674536');
INSERT INTO public.task_entries VALUES ('eded67cd-ec39-4396-a8b3-401ed94beecf', '9119fb7e-c437-4eae-9bbd-32f5f1a5a36d', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '20:50:00', '22:30:00', 100, true, '2026-03-25 22:55:59.676', 1070, '2026-03-26 03:55:59.677985', '2026-03-26 03:55:59.677985');
INSERT INTO public.task_entries VALUES ('09a64562-6ee8-4a8e-b5da-68931f2b7ab2', '2e08f5f3-68cf-482d-8be4-cd60840d5528', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'SH', 3, NULL, '17:00:00', '23:30:00', 390, true, '2026-03-25 22:55:59.687', 1072, '2026-03-26 03:55:59.688384', '2026-03-26 03:55:59.688384');
INSERT INTO public.task_entries VALUES ('f5e19baf-a8a9-43a6-b755-55d3b3a260de', '3a0bb8a9-3377-465e-bfa5-fca3501d27ed', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', NULL, 'Upwork bidding training usman', 3, NULL, '00:30:00', '01:00:00', 30, true, '2026-03-28 20:08:34.072', 1, '2026-03-29 01:08:32.214286', '2026-03-28 20:08:50.416');
INSERT INTO public.task_entries VALUES ('7c45fccf-42c4-4d64-bf80-db0fbe8e33eb', '26b39b4f-aa3b-4979-a3b0-3f3e944e6bb8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '00:00:00', '05:10:00', 310, true, '2026-03-28 00:28:43.115', 0, '2026-03-28 05:28:39.993119', '2026-03-28 00:28:43.115');
INSERT INTO public.task_entries VALUES ('7c1c31ce-1fa7-4874-bf41-7a20a60245e6', '26b39b4f-aa3b-4979-a3b0-3f3e944e6bb8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '05:30:00', '07:10:00', 100, true, '2026-03-28 02:07:45.402', 1, '2026-03-28 07:07:40.729543', '2026-03-28 02:07:45.402');
INSERT INTO public.task_entries VALUES ('0e2985c1-b320-4351-a38c-f834ed7aff86', '26b39b4f-aa3b-4979-a3b0-3f3e944e6bb8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '$100M Money Models', 3, NULL, '07:10:00', '08:10:00', 60, true, '2026-03-28 03:14:52.032', 2, '2026-03-28 08:14:48.666361', '2026-03-28 03:14:52.032');
INSERT INTO public.task_entries VALUES ('47a32e55-c78d-4b3b-be58-f55a51c422ba', '2e08f5f3-68cf-482d-8be4-cd60840d5528', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '23:00:00', '02:15:00', 195, true, '2026-03-25 22:55:59.683', 1071, '2026-03-26 03:55:59.685005', '2026-03-26 03:59:29.694');
INSERT INTO public.task_entries VALUES ('267d7277-9359-4127-8b41-fc5a3c6cee95', '26b39b4f-aa3b-4979-a3b0-3f3e944e6bb8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 2, NULL, '08:10:00', '11:30:00', 200, true, '2026-03-28 17:52:57.324', 3, '2026-03-28 22:52:53.037745', '2026-03-28 17:52:57.324');
INSERT INTO public.task_entries VALUES ('04404be2-0333-4be2-bdd6-432513ea5acb', '26b39b4f-aa3b-4979-a3b0-3f3e944e6bb8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 2, NULL, '19:30:00', '23:00:00', 210, true, '2026-03-28 17:54:02.262', 4, '2026-03-28 22:53:58.616194', '2026-03-28 17:54:02.262');
INSERT INTO public.task_entries VALUES ('e7f00dc2-c851-498c-9b25-e7b62e36cf49', 'be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '00:00:00', '00:30:00', 30, true, '2026-03-26 20:17:17.897', 0, '2026-03-27 01:17:14.146821', '2026-03-26 20:17:17.897');
INSERT INTO public.task_entries VALUES ('2c06409b-444a-4342-af4d-b30bba33d785', 'be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', NULL, 'Upwork Explainer', 3, NULL, '00:30:00', '01:20:00', 50, true, '2026-03-26 20:18:05.177', 1, '2026-03-27 01:18:02.967175', '2026-03-26 20:18:05.177');
INSERT INTO public.task_entries VALUES ('fa2deab2-4820-4deb-88b3-62b6630bd583', 'be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '01:20:00', '03:40:00', 140, true, '2026-03-26 22:43:31.569', 2, '2026-03-27 03:43:02.220878', '2026-03-26 22:43:31.569');
INSERT INTO public.task_entries VALUES ('e1d73ed6-882f-420a-a97b-0ddcbfea3091', 'be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Gaming', 1, NULL, '03:40:00', '05:50:00', 130, true, '2026-03-27 17:47:49.933', 3, '2026-03-27 22:47:34.580478', '2026-03-27 17:48:04.291');
INSERT INTO public.task_entries VALUES ('91af7c2f-c43b-4b6f-910e-4f3e1559d508', 'be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '05:50:00', '07:00:00', 70, true, '2026-03-27 17:48:46.436', 4, '2026-03-27 22:48:44.166351', '2026-03-27 17:49:06.481');
INSERT INTO public.task_entries VALUES ('d0b0a7e1-54bb-4bd4-9d69-3870312c9d35', 'be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc - Office', 3, NULL, '17:00:00', '20:00:00', 180, true, '2026-03-27 17:51:12.581', 5, '2026-03-27 22:51:10.193773', '2026-03-27 17:51:12.581');
INSERT INTO public.task_entries VALUES ('c38596f0-2924-4061-944f-7566af28716d', '3a0bb8a9-3377-465e-bfa5-fca3501d27ed', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', NULL, 'Upwork Proposals Adjustments', 3, NULL, '01:00:00', '02:40:00', 100, true, '2026-03-28 21:59:31.424', 2, '2026-03-29 02:59:26.56649', '2026-03-28 22:00:07.698');
INSERT INTO public.task_entries VALUES ('9519a390-325f-48a8-870c-a7a0fe9cc6f0', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '23:30:00', '02:00:00', 150, true, '2026-03-25 22:55:59.692', 0, '2026-03-26 03:55:59.693764', '2026-03-26 03:55:59.693764');
INSERT INTO public.task_entries VALUES ('def5d19e-7b77-4ec0-ba5d-30c8833b8e2e', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '05:50:00', '09:00:00', 190, true, '2026-03-26 03:56:20.87', 3, '2026-03-26 06:04:22.746546', '2026-03-26 03:56:20.87');
INSERT INTO public.task_entries VALUES ('0afd8ee8-7ca2-4897-9bf6-c5b8802a6d8b', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '14:05:00', '16:30:00', 145, true, '2026-03-26 13:05:47.285', 5, '2026-03-26 18:05:43.122341', '2026-03-26 13:05:47.285');
INSERT INTO public.task_entries VALUES ('4be7485d-0b7d-46ac-b28e-3339dda74d1b', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics', 2, NULL, '18:00:00', '22:00:00', 240, true, '2026-03-26 18:24:38.906', 7, '2026-03-26 23:24:25.89651', '2026-03-26 18:24:38.906');
INSERT INTO public.task_entries VALUES ('fbac48a6-3485-4ba7-8fe3-b295223014dd', '3a0bb8a9-3377-465e-bfa5-fca3501d27ed', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'Marketing Expert Advisor', 3, NULL, '02:40:00', '03:30:00', 50, true, '2026-03-28 22:30:09.733', 3, '2026-03-29 03:30:04.272111', '2026-03-28 22:30:09.733');
INSERT INTO public.task_entries VALUES ('7c7c1cc0-ce38-4975-91fd-630e0fdd1d35', 'a32df42d-eafc-4ad0-aa25-de8cb0e10ff4', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '22:00:00', '23:59:00', 119, true, '2026-03-26 18:25:41.513', 8, '2026-03-26 23:25:39.033685', '2026-03-26 19:13:11.043');
INSERT INTO public.task_entries VALUES ('4d36dd78-4d3b-4d5e-bc2c-33ad75b0ffbe', 'be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics - Work', 3, NULL, '20:00:00', '23:50:00', 230, true, '2026-03-27 17:52:24.68', 6, '2026-03-27 22:52:03.908739', '2026-03-27 18:52:43.948');
INSERT INTO public.task_entries VALUES ('f9b3da0d-1ad7-4934-ba1e-5d41755dd7e1', '0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Mics', 2, NULL, '14:30:00', '17:00:00', 150, true, '2026-03-31 22:22:05.233', 7, '2026-04-01 03:21:59.462727', '2026-03-31 22:22:05.233');
INSERT INTO public.task_entries VALUES ('6a0fbe33-7bcc-4406-ac0e-4999abbbeff4', '23988d37-e233-4b4e-ba4f-6e29961c4aba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 3, NULL, '19:00:00', '21:00:00', 120, true, '2026-03-30 22:04:36.099', 0, '2026-03-31 03:04:33.834804', '2026-03-30 22:04:36.099');
INSERT INTO public.task_entries VALUES ('7cc9912f-bf9e-440a-a298-0bc2978bb729', 'be32fcc3-f364-4851-bff7-739bc7951f2e', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'a721d8d8-8024-4917-9e16-3a0a8842dc62', NULL, '100M Leads', 3, NULL, '23:50:00', '23:59:00', 9, true, '2026-03-28 00:26:47.352', 7, '2026-03-27 22:58:54.959842', '2026-03-28 00:26:47.352');
INSERT INTO public.task_entries VALUES ('b33a64f9-2d01-458c-a01d-f5b4b12dfb8f', '23988d37-e233-4b4e-ba4f-6e29961c4aba', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', NULL, 'Expense Calculation', 3, NULL, '21:00:00', '23:59:00', 179, true, '2026-03-30 22:03:48.94', 1, '2026-03-31 03:03:46.72914', '2026-03-30 22:03:48.94');
INSERT INTO public.task_entries VALUES ('fb532ac3-69c0-4e45-9691-812f1800e8e9', '26b39b4f-aa3b-4979-a3b0-3f3e944e6bb8', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', NULL, 'Upwork bidding training usman', 3, NULL, '23:00:00', '23:59:00', 59, true, '2026-03-28 18:51:23.097', 5, '2026-03-28 23:51:20.680699', '2026-03-28 20:08:59.935');
INSERT INTO public.task_entries VALUES ('c738401a-c79e-4314-b691-2e93201f075e', '0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', NULL, 'Team Discord Server', 2, NULL, NULL, NULL, NULL, true, '2026-03-31 09:31:15.338', 1, '2026-03-31 14:31:11.75196', '2026-03-31 09:31:15.338');
INSERT INTO public.task_entries VALUES ('8e100cdb-5c0c-40e8-a200-4a975a0fe52d', '3a0bb8a9-3377-465e-bfa5-fca3501d27ed', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'Marketing Expert Advisor', 3, NULL, '00:00:00', '00:30:00', 30, true, '2026-03-28 20:07:24.57', 0, '2026-03-29 01:07:20.852365', '2026-03-28 20:07:24.57');
INSERT INTO public.task_entries VALUES ('4e0cbd33-810b-4fbd-a63e-f7a2cd54b1b1', '0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'Cold Email Automations', 3, NULL, '02:00:00', '08:20:00', 380, true, '2026-03-31 03:18:01.247', 3, '2026-03-31 03:06:37.670349', '2026-03-31 03:18:01.247');
INSERT INTO public.task_entries VALUES ('3cb6c248-6c44-46ac-bcd7-3f7ee2b62c2c', '0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'LinkedIn Outreach Automation', 3, NULL, '10:20:00', '13:20:00', 180, true, '2026-03-31 08:42:18.163', 5, '2026-03-31 11:12:30.220164', '2026-03-31 08:42:18.163');
INSERT INTO public.task_entries VALUES ('fc53efec-cac0-441f-ad8f-5313d13482c1', '0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'ffd015aa-a1b4-44f2-b0fa-3caabdc2cbde', NULL, 'Expense Calculation', 3, NULL, '00:00:00', '02:00:00', 120, true, '2026-03-30 21:59:16.724', 0, '2026-03-31 02:59:12.996364', '2026-03-30 22:06:01.826');
INSERT INTO public.task_entries VALUES ('55180ab5-6a6b-4733-9daf-a6f4d958d865', '0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Aca Quiz', 3, NULL, '09:40:00', '10:20:00', 40, true, '2026-03-31 06:11:43.719', 4, '2026-03-31 10:15:31.441531', '2026-03-31 06:11:43.719');
INSERT INTO public.task_entries VALUES ('6e60a477-d43d-4d87-a9bf-cf91e5775573', '0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'ML Assignment', 3, NULL, '13:20:00', '14:30:00', 70, true, '2026-03-31 08:44:29.562', 6, '2026-03-31 13:44:27.496421', '2026-03-31 09:27:52.968');
INSERT INTO public.task_entries VALUES ('9bc7c411-46c8-49d4-bf60-8be47e1527be', '0891add7-4ae7-40b3-a60b-61fce4c779c5', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '69405924-8f59-4aa6-a293-8fa29748301f', NULL, 'Team Task Management Dashboard', 2, NULL, NULL, NULL, NULL, true, '2026-03-31 09:32:21.389', 2, '2026-03-31 14:32:19.321333', '2026-03-31 09:32:21.389');
INSERT INTO public.task_entries VALUES ('bedfcb19-d383-46d6-ac6d-f0a926292f51', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Gaming', 2, NULL, '15:30:00', '18:00:00', 150, true, '2026-04-02 01:00:33.367', 8, '2026-04-02 06:00:30.237869', '2026-04-02 01:00:33.367');
INSERT INTO public.task_entries VALUES ('437f10ed-4406-4c35-963b-a8be09a6c2b6', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DV Class', 3, NULL, '14:00:00', '15:10:00', 70, true, '2026-04-01 10:10:11.414', 7, '2026-04-01 15:10:09.560948', '2026-04-01 10:10:11.414');
INSERT INTO public.task_entries VALUES ('80ef1f3d-08aa-4cab-93d2-179eb2470021', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DOA', 3, NULL, '10:00:00', '11:00:00', 60, true, '2026-04-01 06:04:23.417', 5, '2026-04-01 11:04:20.616427', '2026-04-01 06:04:23.417');
INSERT INTO public.task_entries VALUES ('1289e4bb-c27a-4dc4-9a96-a03252fcb019', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Break', 3, NULL, '07:00:00', '07:30:00', 30, true, '2026-04-01 02:34:46.86', 3, '2026-04-01 07:34:42.859333', '2026-04-01 02:35:13.263');
INSERT INTO public.task_entries VALUES ('174b8f20-c898-43c9-90e0-95a678884755', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 2, NULL, '02:30:00', '03:00:00', 30, true, '2026-03-31 22:24:00.71', 0, '2026-04-01 03:23:57.835985', '2026-03-31 22:24:00.71');
INSERT INTO public.task_entries VALUES ('e8aefdb2-4157-4ce1-87e0-9e4fb4ee0bc9', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'Instagram Outreach Automation', 3, NULL, '03:00:00', '04:00:00', 60, true, '2026-03-31 22:24:52.221', 1, '2026-04-01 03:24:50.202281', '2026-04-01 01:55:53.223');
INSERT INTO public.task_entries VALUES ('71f8ceb1-4e46-41d0-bee8-d5973e8623b7', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'Content Engine At', 3, NULL, '07:30:00', '10:00:00', 150, true, '2026-04-01 05:01:37.89', 4, '2026-04-01 10:01:34.698833', '2026-04-01 05:01:37.89');
INSERT INTO public.task_entries VALUES ('2cfc12f3-8035-473a-917e-e9b6dc529e5b', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', NULL, 'Upwork Bidding', 3, NULL, '23:00:00', '02:00:00', 180, true, '2026-04-01 10:08:37.772', 6, '2026-04-01 15:08:27.752724', '2026-04-01 10:08:37.772');
INSERT INTO public.task_entries VALUES ('92d89676-7d6a-496f-8268-8c648ca30cb2', 'b606646a-8a23-4843-bc8a-7f1f69b17fc7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'NexusPoint Outreach Strategy', 3, NULL, '04:00:00', '07:00:00', 180, true, '2026-04-01 01:56:40.364', 2, '2026-04-01 06:56:33.872291', '2026-04-01 01:56:40.364');
INSERT INTO public.task_entries VALUES ('3e9958f7-3de6-49c6-bca9-c4b56a496dc0', '8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'ML Lab', 3, NULL, '13:30:00', '16:20:00', 170, true, '2026-04-04 09:25:08.1', 5, '2026-04-03 14:08:36.309146', '2026-04-04 09:25:08.1');
INSERT INTO public.task_entries VALUES ('8393a0d9-6c1d-498e-a75a-add72a8206ad', '8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'ML', 3, NULL, '16:25:00', '17:25:00', 60, true, '2026-04-04 09:26:01.201', 6, '2026-04-04 14:25:59.324646', '2026-04-04 09:26:01.201');
INSERT INTO public.task_entries VALUES ('f271c135-9f8f-4f6f-b87f-999ffa9f951a', '8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Fire Emblem Engage', 2, NULL, NULL, NULL, NULL, true, '2026-04-04 09:32:43.064', 7, '2026-04-04 14:32:41.675141', '2026-04-04 09:32:43.064');
INSERT INTO public.task_entries VALUES ('20882e5a-6769-4e6b-a284-dd834b6b173b', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 2, NULL, '04:00:00', '05:00:00', 60, true, '2026-04-02 01:05:57.317', 0, '2026-04-02 06:05:53.127088', '2026-04-02 01:05:57.317');
INSERT INTO public.task_entries VALUES ('472626b1-982e-45c4-ae27-c4b16bb6ebb0', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '05:00:00', '07:21:00', 141, true, '2026-04-02 01:06:35.139', 1, '2026-04-02 06:06:21.067889', '2026-04-02 02:44:18.428');
INSERT INTO public.task_entries VALUES ('a491919a-18cf-4f96-8dd1-9f43fb08bcf0', '7f4d95bd-e182-41d3-b2c9-d2e2cf9d3b68', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c9ebe29d-e9b1-4c85-84de-21d2765711c0', NULL, 'Mics', 2, NULL, '06:00:00', '12:00:00', 360, true, '2026-04-04 09:37:47.306', 0, '2026-04-04 14:37:41.903492', '2026-04-04 09:37:47.306');
INSERT INTO public.task_entries VALUES ('3ee31533-da96-45c8-b85d-da0dbea1a8b0', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'Working on quality leads', 3, NULL, '07:40:00', '12:00:00', 260, true, '2026-04-02 07:35:08.639', 2, '2026-04-02 07:44:59.461229', '2026-04-02 07:35:08.639');
INSERT INTO public.task_entries VALUES ('fe79e55e-6042-4dc9-98fe-b808e81f08a8', '7f4d95bd-e182-41d3-b2c9-d2e2cf9d3b68', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'c6b1bb53-c5e9-44dc-bef3-ed4f00d8035d', NULL, 'Misc', 2, NULL, '12:00:00', '14:00:00', 120, true, '2026-04-04 09:38:40.31', 1, '2026-04-04 14:38:38.646766', '2026-04-04 11:13:07.268');
INSERT INTO public.task_entries VALUES ('95d5f326-e5f7-4e45-8ce5-6eb609171d0c', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', NULL, 'Upwork Bidding', 3, NULL, '12:00:00', '13:35:00', 95, true, '2026-04-02 07:37:12.846', 3, '2026-04-02 12:37:10.971502', '2026-04-02 08:35:55.803');
INSERT INTO public.task_entries VALUES ('9cc5f2a2-e19a-4e32-8f3a-bb076cc31069', '7f4d95bd-e182-41d3-b2c9-d2e2cf9d3b68', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Mics', 3, NULL, '14:00:00', '15:00:00', 60, true, '2026-04-04 11:13:50.763', 2, '2026-04-04 16:13:48.28289', '2026-04-04 11:37:17.609');
INSERT INTO public.task_entries VALUES ('99f0542c-19ec-4538-afe0-6abc5c3eedb6', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DOA - 01:15PM - 02:45PM', 3, NULL, '13:15:00', '14:45:00', 90, true, '2026-04-02 08:36:02.631', 4, '2026-04-02 12:01:31.109215', '2026-04-02 13:05:11.428');
INSERT INTO public.task_entries VALUES ('0ccfec16-2d7b-41dc-af47-a9c75642e2ab', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'DV - 02:50PM - 04:25PM', 3, NULL, '14:50:00', '16:25:00', 95, true, '2026-04-02 13:05:26.82', 5, '2026-04-02 12:02:40.830251', '2026-04-02 13:05:40.868');
INSERT INTO public.task_entries VALUES ('50991fe6-b1f8-4106-9a35-b01a8763ddc9', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3c786214-76c5-4c7d-988e-5f1e71ae4c15', NULL, 'Working on quality leads', 3, NULL, '17:05:00', '18:30:00', 85, true, '2026-04-02 13:43:02.942', 6, '2026-04-02 18:06:07.489297', '2026-04-02 13:43:02.942');
INSERT INTO public.task_entries VALUES ('b790bd5c-5a06-43c7-8753-ad08b3035aaf', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Robotics Quiz 2', 3, NULL, '19:00:00', '19:10:00', 10, true, '2026-04-02 14:13:48.535', 7, '2026-04-02 12:00:40.939247', '2026-04-02 14:15:16.882');
INSERT INTO public.task_entries VALUES ('991908e5-7f4c-4749-94b8-09ccb015f73f', '398d3004-9af8-44f3-b03a-d1bdbe17e4b7', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '19:30:00', '23:10:00', 220, true, '2026-04-03 01:45:36.559', 8, '2026-04-03 06:45:32.929122', '2026-04-03 01:45:36.559');
INSERT INTO public.task_entries VALUES ('edbdd2f0-b46b-4ea4-8d72-89f9bdda9f95', '7f4d95bd-e182-41d3-b2c9-d2e2cf9d3b68', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'AI Robotics Lab', 3, NULL, '15:00:00', '16:00:00', 60, true, '2026-04-04 11:36:34.623', 3, '2026-04-04 16:15:16.73058', '2026-04-04 11:37:27.796');
INSERT INTO public.task_entries VALUES ('a88e2782-e558-4ee0-ab28-cee9b5a99811', '8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'd8a81c72-e8e2-4a05-8ea7-62eab47c9eea', NULL, 'TT', 1, NULL, '04:30:00', '06:00:00', 90, true, '2026-04-03 01:47:33.036', 0, '2026-04-03 06:47:27.167949', '2026-04-03 01:47:33.036');
INSERT INTO public.task_entries VALUES ('6751cb64-cf14-4056-89d0-6fed87c0216b', '8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '6003c93e-fc70-4d70-86e5-39c7f700b329', NULL, 'Misc', 3, NULL, '06:00:00', '09:00:00', 180, true, '2026-04-03 04:52:06.624', 1, '2026-04-03 09:52:04.751704', '2026-04-03 04:52:06.624');
INSERT INTO public.task_entries VALUES ('6910eced-72ca-4bc8-b760-96e1808552b5', '8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '3ebea0b0-9e1d-4f52-bcfd-90e7037f539a', NULL, 'Robotics - Class', 3, NULL, '09:00:00', '10:20:00', 80, true, '2026-04-03 04:53:14.238', 2, '2026-04-03 09:53:12.15566', '2026-04-03 05:21:41.331');
INSERT INTO public.task_entries VALUES ('19b2fbbc-696f-44ba-80f3-b0b148be4487', '8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', 'e4a1d9d3-48d9-423b-a6db-3e65424161df', NULL, 'Upwork Bidding', 3, NULL, '10:20:00', '11:40:00', 80, true, '2026-04-03 06:42:26.478', 3, '2026-04-03 11:42:22.051021', '2026-04-03 06:42:26.478');
INSERT INTO public.task_entries VALUES ('22339408-c6db-4a73-a4d7-3b738acf3f9f', '8ff72d69-ac35-4186-b678-fcc1cc4070d9', 'f98b96f2-3dac-4112-bdc2-3c57002d452c', '76f79a24-39c1-44ba-8148-81f44fe680a2', NULL, 'Polar-Trend Project & Stitch Tutorial', 3, NULL, '11:40:00', '13:30:00', 110, true, '2026-04-03 09:07:56.825', 4, '2026-04-03 14:07:52.400985', '2026-04-03 09:08:03.528');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES ('f98b96f2-3dac-4112-bdc2-3c57002d452c', 'hassanaleem86@gmail.com', '$2b$12$Z39whcWPh.J9EkTI7gnUkOQd/E8I..0F8CbRkMrxEq406qEAw/W2W', 'Aleem', '2026-03-26 02:47:57.131671', '2026-03-26 02:47:57.131671');


--
-- Data for Name: weekly_goals; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: backlog_items backlog_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backlog_items
    ADD CONSTRAINT backlog_items_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: daily_logs daily_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_logs
    ADD CONSTRAINT daily_logs_pkey PRIMARY KEY (id);


--
-- Name: imports imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT imports_pkey PRIMARY KEY (id);


--
-- Name: task_entries task_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_entries
    ADD CONSTRAINT task_entries_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weekly_goals weekly_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weekly_goals
    ADD CONSTRAINT weekly_goals_pkey PRIMARY KEY (id);


--
-- Name: backlog_items_user_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX backlog_items_user_category_idx ON public.backlog_items USING btree (user_id, category_id);


--
-- Name: categories_user_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX categories_user_code_idx ON public.categories USING btree (user_id, code);


--
-- Name: daily_logs_user_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX daily_logs_user_date_idx ON public.daily_logs USING btree (user_id, log_date);


--
-- Name: task_entries_user_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX task_entries_user_category_idx ON public.task_entries USING btree (user_id, category_id);


--
-- Name: task_entries_user_created_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX task_entries_user_created_idx ON public.task_entries USING btree (user_id, created_at);


--
-- Name: task_entries_user_daily_log_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX task_entries_user_daily_log_idx ON public.task_entries USING btree (user_id, daily_log_id);


--
-- Name: weekly_goals_user_category_week_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX weekly_goals_user_category_week_idx ON public.weekly_goals USING btree (user_id, category_id, week_start);


--
-- Name: backlog_items backlog_items_category_id_categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backlog_items
    ADD CONSTRAINT backlog_items_category_id_categories_id_fk FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: backlog_items backlog_items_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backlog_items
    ADD CONSTRAINT backlog_items_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: categories categories_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: daily_logs daily_logs_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_logs
    ADD CONSTRAINT daily_logs_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: imports imports_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT imports_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: task_entries task_entries_backlog_item_id_backlog_items_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_entries
    ADD CONSTRAINT task_entries_backlog_item_id_backlog_items_id_fk FOREIGN KEY (backlog_item_id) REFERENCES public.backlog_items(id);


--
-- Name: task_entries task_entries_category_id_categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_entries
    ADD CONSTRAINT task_entries_category_id_categories_id_fk FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: task_entries task_entries_daily_log_id_daily_logs_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_entries
    ADD CONSTRAINT task_entries_daily_log_id_daily_logs_id_fk FOREIGN KEY (daily_log_id) REFERENCES public.daily_logs(id);


--
-- Name: task_entries task_entries_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_entries
    ADD CONSTRAINT task_entries_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: weekly_goals weekly_goals_category_id_categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weekly_goals
    ADD CONSTRAINT weekly_goals_category_id_categories_id_fk FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: weekly_goals weekly_goals_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weekly_goals
    ADD CONSTRAINT weekly_goals_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict pMayKJKdwhrkIFeyI4C5R0c3znznaa0d9BvEKDjaUGJOAr01YXYVRfz9qGNbmK7

