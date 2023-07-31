--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

-- Started on 2023-07-28 10:47:40

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16465)
-- Name: dlcs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dlcs (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.dlcs OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16447)
-- Name: passiveitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passiveitems (
    id integer NOT NULL,
    name text,
    description text,
    unlockrequirements text,
    dlc text,
    maxlevel integer,
    rarity integer
);


ALTER TABLE public.passiveitems OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16440)
-- Name: weapons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weapons (
    id integer NOT NULL,
    name text,
    description text,
    unlockrequirements text,
    dlc text,
    basedamage numeric,
    maxlevel integer,
    rarity integer,
    evolution text,
    evolvedwith text[]
);


ALTER TABLE public.weapons OWNER TO postgres;

--
-- TOC entry 3330 (class 0 OID 16465)
-- Dependencies: 216
-- Data for Name: dlcs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dlcs (id, name) FROM stdin;
0	Base
1	Tides of the Foscari
2	Legacy of the Moonspell
\.


--
-- TOC entry 3329 (class 0 OID 16447)
-- Dependencies: 215
-- Data for Name: passiveitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passiveitems (id, name, description, unlockrequirements, dlc, maxlevel, rarity) FROM stdin;
0	Spinach	Raises inflicted damage by 10%	Unlocked by default	Base	5	100
1	Armor	Reduces incoming damage by 1. Increases retaliatory damage by 10%	Unlocked by default	Base	5	100
2	Hollow Heart	Augments max health by 20%	Survive for 1 minute as any character	Base	5	90
3	Pummarola	Character recovers 0.2 HP per second	Survive for 5 minutes as Gennaro Belpaese	Base	5	90
4	Empty Tome	Reduces weapons cooldown by 8%	Have 6 different weapons simultaneously	Base	5	50
5	Candelabrador	Augments area of attacks by 10%	Level up the Santa Water to level 4	Base	5	100
6	Bracer	Increases projectile speed by 10%	Level up the King Bible to level 4	Base	5	100
7	Spellbinder	Increases duration of weapon effects by 10%	Level up the Runetracer to level 7	Base	5	100
8	Duplicator	Weapons fire more projectiles	Level up the Magic Wand to level 7	Base	2	50
9	Wings	Character moves 10% faster	Reach level 5 as any character	Base	5	50
10	Attractorb	Character picks up items from further away	Pick up a Vacuum	Base	5	100
11	Clover	Character gets 10% luckier	Pick up a Little Clover	Base	5	100
12	Crown	Character gains 8% more experience	Reach level 10 as any character	Base	5	80
13	Stone Mask	Character earns 10% more coins	Pick up in Inlaid Library	Base	5	80
14	Tiragisú	Character revives once with 50% health	Survive for 20 minutes with Krochi	Base	2	40
15	Skull O'Maniac	Increases enemy speed, health, quantity, and frequency by 10%	Survive for 30 minutes with Lama	Base	5	40
16	Silver Ring	Wear ... Clock ...	Obtain Yellow Sign	Base	9	10
17	Gold Ring	... With ... Lancet	Obtain Yellow Sign	Base	9	10
18	Metaglio Left	Channels dark powers to protect the bearer	Obtain Yellow Sign	Base	9	10
19	Metaglio Right	Channels dark powers to curse the bearer	Obtain Yellow Sign	Base	9	10
20	Torrona's Box	Cursed item, but increases Might, Projectile Speed, Duration, and Area by 4%	Have 6 different evolved weapons simultaneously	Base	9	40
21	Academy Badge	Will provide bonus Amount and Revivals in exchange for Growth	Reach level 30 as Eleanor, Maruto, or Keitha	Tides of the Foscari	6	10
\.


--
-- TOC entry 3328 (class 0 OID 16440)
-- Dependencies: 214
-- Data for Name: weapons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weapons (id, name, description, unlockrequirements, dlc, basedamage, maxlevel, rarity, evolution, evolvedwith) FROM stdin;
0	Whip	Attacks horizontally, passes through enemies	Unlocked by default	Base	10	8	100	Bloody Tear	{"Hollow Heart"}
1	Magic Wand	Fires at the nearest enemy	Unlocked by default	Base	10	8	100	Holy Wand	{"Empty Tome"}
2	Knife	Fires quickly in the faced direction	Unlocked by default	Base	6.5	8	100	Thousand Edge	{Bracer}
3	Axe	High damage, high area scaling	Unlocked by default	Base	20	8	100	Death Spiral	{Candelabrador}
4	Cross	Aims at the nearest enemy, has a boomerang effect	Find a Rosary	Base	5	8	80	Heaven Sword	{Clover}
5	King Bible	Orbits around the character	Unlocked by default	Base	10	8	80	Unholy Vespers	{Spellbinder}
6	Fire Wand	Fires at a random enemy, deals heavy damage	Destroy 20 light sources	Base	20	8	80	Hellfire	{Spinach}
7	Garlic	Damages nearby enemies. Reduces resistance to knockback and freeze	Consume 5 Floor Chickens	Base	5	8	70	Soul Eater	{Pummarola}
8	Santa Water	Generates damaging zones	Unlocked by default	Base	10	8	100	La Borra	{Attractorb}
9	Runetracer	Passes through enemies, bounces around	Survive for 5 minutes with Pasqualina	Base	10	8	80	NO FUTURE	{Armor}
10	Lightning Ring	Strikes at random enemies	Defeat a total of 5000 enemies	Base	15	8	80	Thunder Loop	{Duplicator}
11	Pentagram	Erases everything in sight	Survive for 20 minutes with any character	Base	0	8	60	Gorgeous Moon	{Crown}
12	Peachone	Bombards in a circular area	Survive for 10 minutes with any character	Base	10	8	50	Vandalier	{"Ebony Wings"}
13	Ebony Wings	Bombards in a circular area	Get the Peachone to level 7	Base	10	8	50	Vandalier	{Peachone}
14	Phiera Der Tuphello	Fires quickly in four fixed directions	Survive for 10 minutes with Pugnala	Base	5	8	50	Phieraggi	{"Eight the Sparrow",Tiragisú}
15	Eight The Sparrow	Fires quickly in four fixed directions	Survive for 15 minutes with Pugnala	Base	5	8	50	Phieraggi	{"Phiera Der Tuphello",Tiragisú}
16	Gatti Amari	Summons capricious projectiles. Might interact with pickups	Survive for 15 minutes with Giovanna	Base	10	8	50	Vicious Hunger	{"Stone Mask"}
17	Song of Mana	Attacks vertically, passes through enemies	Survive for 15 minutes with Poppea	Base	10	8	50	Mannajja	{"Skull O'Maniac"}
18	Shadow Pinion	Generates damaging zones when moving, strikes when stopping	Survive for 15 minutes with Concetta	Base	10	8	50	Valkyrie Turner	{Wings}
19	Clock Lancet	Chance to freeze enemies in time	Find an Orologion	Base	0	7	70	Infinite Corridor	{"Silver Ring","Gold Ring"}
20	Laurel	Shields from damage while active	Unlocked by default	Base	0	7	60	Crimson Shroud	{"Metaglio Left","Metaglio Right"}
21	Vento Sacro	Stronger with continuous movement. Can deal critical damage	Survive for 15 minutes with Zi'Assunta	Base	2	8	50	Fuwalafuwaloo	{"Bloody Tear"}
22	Bone	Throws a bouncing projectile	Unlock Mortaccio	Base	5	8	1		\N
23	Cherry Bomb	Throws a bouncing projectile that explodes after some time	Unlock Cavallo	Base	10	8	1		\N
24	Carréllo	Throws a bouncing projectile. Number of bounces affected by Amount	Unlock Bianca Ramba	Base	10	8	1		\N
25	Celestial Dusting	Throws a bouncing projectile. Cooldown reduces when moving	Unlock O'Sole	Base	5	8	1		\N
26	La Robba	Generates bouncing projectiles	Unlock Ambrohoe	Base	10	8	1		\N
27	Great Jubilee	Has a chance to summon light sources	Complete Eudaimonia Machine after having started and exited a run in Endless mode, and a run in Inverse mode	Base	10	9	20		\N
28	Bracelet	Fires three projectiles at a random enemy	Survive 30 minutes with either Gallo or Divano	Base	10	6	40		\N
29	Candybox	Allows you to choose any unlocked base weapon	Discover every standard evolution and union	Base	10	1	2	Super Candybox II Turbo	\N
30	Victory Sword	Strikes with a combo attack at the nearest enemy. Retaliates	Defeat 100,000 enemies in a single run with Queen Sigma	Base	5	12	30	Sole Solution	{"Torrona's Box"}
31	Flames of Misspell	Emits cones of flames	Unlock Avatar	Base	10	8	30	Ashes of Muspell	{"Torrona's Box"}
32	Silver Wind	Defeated enemies might drop hearts	Survive for 15 minutes with Miang	Legacy of the Moonspell	10	8	50	Festive Winds	{Pummarola}
33	Four Seasons	Generates 4 explosions. Amount and Duration affect damage instead	Survive for 15 minutes with Menya	Legacy of the Moonspell	5	8	50	Godai Shuffle	{Spinach,Candelabrador}
34	Summon Night	Generates damaging zones above the character	Survive for 15 minutes with Syuuto	Legacy of the Moonspell	10	8	50	Echo Night	{Duplicator}
35	Mirage Robe	Generates freezing mines with a chance to explode	Survive for 15 minutes with Babi-Onna	Legacy of the Moonspell	10	8	50	J'Odore	{Attractorb}
36	Mille Bolle Blu	Fires lingering projectiles	Unlock Gav'Et Oni	Legacy of the Moonspell	5	8	1	Boo Roo Boolle	{Spellbinder}
37	Night Sword	Dangerous, cursed weapon. Retaliates. Might steal hearts	Pick it up on Mt.Moonspell	Legacy of the Moonspell	5	8	30	Muramasa	{"Stone Mask"}
38	108 Bocce	Actually it's just 8. Damages nearby enemies	Survive for 15 minutes with McCoy-Oni	Legacy of the Moonspell	12	8	10		\N
39	SpellString	Strikes at nearby enemies. Damage multiplied by Speed	Survive 15 minutes with Eleanor Uziron	Tides of the Foscari	5	6	70	SpellStrom	{SpellStream,SpellStrike}
40	SpellStream	Generates an expanding damaging zone. Damage multiplied by Area	Get SpellStream to Level 6	Tides of the Foscari	5	6	70	SpellStrom	{SpellString,SpellStrike}
41	SpellStrike	Strikes at the nearest enemy. Damage further multiplied by Might	Get SpellStrike to Level 6	Tides of the Foscari	20	6	70	SpellStrom	{SpellString,SpellStream}
42	Eskizzibur	Attacks nearby enemies. Retaliates	Survive 15 minutes with Maruto Cuts	Tides of the Foscari	10	8	70	Legionnaire	{Armor}
43	Flash Arrow	Can deal critical damage. Amount affects damage instead	Survive 15 minutes with Keitha Muort	Tides of the Foscari	10	8	70	Millionaire	{Bracer,Clover}
44	Prismatic Missile	Generates explosions around the character. Affected by the first chosen Arcana between II, XIV, or XIX	Survive 15 minutes with Luminaire Foscari	Tides of the Foscari	10	8	70	Luminaire	{Crown}
45	Shadow Servant	Has a chance to slow enemies down	Survive 15 minutes with Genevieve Gruyère	Tides of the Foscari	10	8	70	Ophion	{"Skull O'Maniac"}
46	Party Popper	Throws bouncing projectiles	Unlocking Rottin'Ghoul	Tides of the Foscari	5	8	1		\N
\.


--
-- TOC entry 3185 (class 2606 OID 16471)
-- Name: dlcs dlcs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dlcs
    ADD CONSTRAINT dlcs_pkey PRIMARY KEY (id);


--
-- TOC entry 3183 (class 2606 OID 16453)
-- Name: passiveitems passiveItems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passiveitems
    ADD CONSTRAINT "passiveItems_pkey" PRIMARY KEY (id);


--
-- TOC entry 3181 (class 2606 OID 16446)
-- Name: weapons weapons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapons
    ADD CONSTRAINT weapons_pkey PRIMARY KEY (id);


-- Completed on 2023-07-28 10:47:40

--
-- PostgreSQL database dump complete
--

