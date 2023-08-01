--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

-- Started on 2023-08-01 10:21:24

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
-- TOC entry 214 (class 1259 OID 24657)
-- Name: dlcs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dlcs (
    name text,
    uuid uuid NOT NULL
);


ALTER TABLE public.dlcs OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24662)
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
-- TOC entry 216 (class 1259 OID 24667)
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
-- TOC entry 3328 (class 0 OID 24657)
-- Dependencies: 214
-- Data for Name: dlcs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dlcs (name, uuid) FROM stdin;
Test Name	9ab09ce8-831a-4f6c-b98c-8d7a7bbd6f4a
Base	176e7f1f-565d-4802-87a9-13ef19c43af3
Tides of the Foscari	c0084574-43bd-4941-84a7-1d5939fe7247
Legacy of the Moonspell	edb616ec-a522-4e23-b041-940f58745eef
Test Name	ecb613c3-b766-46ac-bdb6-5e92d2e5d145
Test Name	2f246c7b-7ab7-430f-a6cc-084b4b44c0af
\.


--
-- TOC entry 3329 (class 0 OID 24662)
-- Dependencies: 215
-- Data for Name: passiveitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passiveitems (name, description, unlockrequirements, dlc, maxlevel, rarity, uuid) FROM stdin;
Spinach	Raises inflicted damage by 10%	Unlocked by default	Base	5	100	74c3281b-f3e8-43aa-8ce0-70b7445424e2
Armor	Reduces incoming damage by 1. Increases retaliatory damage by 10%	Unlocked by default	Base	5	100	965ae094-4193-4336-8e2e-81df639c8734
Hollow Heart	Augments max health by 20%	Survive for 1 minute as any character	Base	5	90	1cd5d5e1-d870-458b-a77b-9adb8a31140f
Pummarola	Character recovers 0.2 HP per second	Survive for 5 minutes as Gennaro Belpaese	Base	5	90	18647d9b-90d8-4dd0-99cd-0f0b019d5235
Empty Tome	Reduces weapons cooldown by 8%	Have 6 different weapons simultaneously	Base	5	50	ad0d14af-a370-4993-8d52-6d5d8a6539f1
Candelabrador	Augments area of attacks by 10%	Level up the Santa Water to level 4	Base	5	100	81949f9e-cc88-4e13-9361-d95e6509ac85
Bracer	Increases projectile speed by 10%	Level up the King Bible to level 4	Base	5	100	e0274f62-30ab-48b7-821f-97603b13d046
Spellbinder	Increases duration of weapon effects by 10%	Level up the Runetracer to level 7	Base	5	100	15fa1183-9588-4087-a9f4-8134b09c0f36
Duplicator	Weapons fire more projectiles	Level up the Magic Wand to level 7	Base	2	50	5c7de627-ce47-417b-854d-8e19d6d0f601
Wings	Character moves 10% faster	Reach level 5 as any character	Base	5	50	574a1f70-d6dc-4a80-b0a4-d5715648ef1c
Attractorb	Character picks up items from further away	Pick up a Vacuum	Base	5	100	3dee2c74-1e4f-409d-8a1f-60283a154c1f
Clover	Character gets 10% luckier	Pick up a Little Clover	Base	5	100	d4b3f075-b763-414c-9586-0fb2c0bf9f79
Crown	Character gains 8% more experience	Reach level 10 as any character	Base	5	80	6d77d7f1-12eb-40ef-ae9b-fa859c91ead9
Stone Mask	Character earns 10% more coins	Pick up in Inlaid Library	Base	5	80	9fe66eb6-bfc8-40d1-a358-31c8c39cc577
Tiragisú	Character revives once with 50% health	Survive for 20 minutes with Krochi	Base	2	40	3ba554d0-c980-4449-bdda-2219ff284c0b
Skull O'Maniac	Increases enemy speed, health, quantity, and frequency by 10%	Survive for 30 minutes with Lama	Base	5	40	993d1df4-6a16-4ef9-8ef4-b0d67a84cf97
Silver Ring	Wear ... Clock ...	Obtain Yellow Sign	Base	9	10	fe22c678-af8d-4d44-9ab8-a612cae61f76
Gold Ring	... With ... Lancet	Obtain Yellow Sign	Base	9	10	599a2adf-e4b6-45b8-85fe-856b45dd45b0
Metaglio Left	Channels dark powers to protect the bearer	Obtain Yellow Sign	Base	9	10	96050d78-20ea-414a-9817-921f62a0e00c
Metaglio Right	Channels dark powers to curse the bearer	Obtain Yellow Sign	Base	9	10	3d0e2219-a879-4011-b652-916452d51d56
Torrona's Box	Cursed item, but increases Might, Projectile Speed, Duration, and Area by 4%	Have 6 different evolved weapons simultaneously	Base	9	40	8714fc28-4fa7-4005-b4b0-b1d9df7b15b9
Academy Badge	Will provide bonus Amount and Revivals in exchange for Growth	Reach level 30 as Eleanor, Maruto, or Keitha	Tides of the Foscari	6	10	359a5b53-d4ab-45f9-b204-2f40cffef87a
Test Name	Test Description	Test Unlock Requirements	Base	5	50	2185601b-e9b4-4313-b1c6-77400eed8294
Test Name	Test Description	Test Unlock Requirements	Base	5	50	9d1f8642-ffbe-4076-b4fa-a5c772e385a1
Test Name	Test Description	Test Unlock Requirements	Base	5	50	867aeecc-bf74-417f-a154-89c94f15cdc0
\.


--
-- TOC entry 3330 (class 0 OID 24667)
-- Dependencies: 216
-- Data for Name: weapons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weapons (name, description, unlockrequirements, dlc, basedamage, maxlevel, rarity, evolution, evolvedwith, uuid) FROM stdin;
Whip	Attacks horizontally, passes through enemies	Unlocked by default	Base	10	8	100	Bloody Tear	{"Hollow Heart"}	758278ab-28ce-405e-82c3-5599d9280f6d
Magic Wand	Fires at the nearest enemy	Unlocked by default	Base	10	8	100	Holy Wand	{"Empty Tome"}	6bbd6c46-4b2c-43c2-8422-1b9d72acadc8
Knife	Fires quickly in the faced direction	Unlocked by default	Base	6.5	8	100	Thousand Edge	{Bracer}	cd187293-b889-4ea5-b831-3e43d2eb6d85
Axe	High damage, high area scaling	Unlocked by default	Base	20	8	100	Death Spiral	{Candelabrador}	83f3bb77-f1f6-4a50-8cc0-dbce37e03e97
Cross	Aims at the nearest enemy, has a boomerang effect	Find a Rosary	Base	5	8	80	Heaven Sword	{Clover}	b29877fb-41eb-4ae6-b9c4-ac07c44ed7c8
King Bible	Orbits around the character	Unlocked by default	Base	10	8	80	Unholy Vespers	{Spellbinder}	cf1455ef-cb00-40a9-a31b-7b40104c92c0
Fire Wand	Fires at a random enemy, deals heavy damage	Destroy 20 light sources	Base	20	8	80	Hellfire	{Spinach}	5067de30-4ace-4dcb-8189-c4f21e9f0c43
Garlic	Damages nearby enemies. Reduces resistance to knockback and freeze	Consume 5 Floor Chickens	Base	5	8	70	Soul Eater	{Pummarola}	5a7c59e4-45da-438d-b119-134f80901bcf
Santa Water	Generates damaging zones	Unlocked by default	Base	10	8	100	La Borra	{Attractorb}	da47acb0-4d52-4e09-8eaa-4b19fb224124
Runetracer	Passes through enemies, bounces around	Survive for 5 minutes with Pasqualina	Base	10	8	80	NO FUTURE	{Armor}	500e3f98-1023-4fec-ac7f-b366d9db2b61
Lightning Ring	Strikes at random enemies	Defeat a total of 5000 enemies	Base	15	8	80	Thunder Loop	{Duplicator}	67f19262-5f9e-45f2-a86a-582bb01ecf24
Pentagram	Erases everything in sight	Survive for 20 minutes with any character	Base	0	8	60	Gorgeous Moon	{Crown}	d6a0f1bb-a8ca-4387-801c-4d90ca8bc8e6
Peachone	Bombards in a circular area	Survive for 10 minutes with any character	Base	10	8	50	Vandalier	{"Ebony Wings"}	47abcd58-582e-480c-bc63-f61f094afe80
Ebony Wings	Bombards in a circular area	Get the Peachone to level 7	Base	10	8	50	Vandalier	{Peachone}	fd390c37-404b-4193-8d9b-bc2694c088cd
Phiera Der Tuphello	Fires quickly in four fixed directions	Survive for 10 minutes with Pugnala	Base	5	8	50	Phieraggi	{"Eight the Sparrow",Tiragisú}	41dc273a-65ec-49df-89f8-d7e49ec738aa
Eight The Sparrow	Fires quickly in four fixed directions	Survive for 15 minutes with Pugnala	Base	5	8	50	Phieraggi	{"Phiera Der Tuphello",Tiragisú}	550fcc7f-f6c7-4ce6-b11c-66fdcbcb2a61
Gatti Amari	Summons capricious projectiles. Might interact with pickups	Survive for 15 minutes with Giovanna	Base	10	8	50	Vicious Hunger	{"Stone Mask"}	7186297d-50e7-46b3-b9a2-bcc1a01bee60
Song of Mana	Attacks vertically, passes through enemies	Survive for 15 minutes with Poppea	Base	10	8	50	Mannajja	{"Skull O'Maniac"}	06259c44-a7b7-4a3c-a6e1-7ba99942f742
Shadow Pinion	Generates damaging zones when moving, strikes when stopping	Survive for 15 minutes with Concetta	Base	10	8	50	Valkyrie Turner	{Wings}	4a6ff09b-1d8a-4124-a48d-2c452ea1e215
Clock Lancet	Chance to freeze enemies in time	Find an Orologion	Base	0	7	70	Infinite Corridor	{"Silver Ring","Gold Ring"}	1aee3bd0-cf7a-49b1-ad2e-12324553617e
Laurel	Shields from damage while active	Unlocked by default	Base	0	7	60	Crimson Shroud	{"Metaglio Left","Metaglio Right"}	577358e9-5db7-4fd7-b799-2ae3025a75b7
Vento Sacro	Stronger with continuous movement. Can deal critical damage	Survive for 15 minutes with Zi'Assunta	Base	2	8	50	Fuwalafuwaloo	{"Bloody Tear"}	3fa6079c-7f7e-4ba7-ae8f-3878c4ae0018
Bone	Throws a bouncing projectile	Unlock Mortaccio	Base	5	8	1		\N	9323d485-8895-40e1-b702-280abe95a648
Cherry Bomb	Throws a bouncing projectile that explodes after some time	Unlock Cavallo	Base	10	8	1		\N	99fc3435-7671-4e8a-938e-80fe393d79fa
Carréllo	Throws a bouncing projectile. Number of bounces affected by Amount	Unlock Bianca Ramba	Base	10	8	1		\N	8f171fae-6d67-4cc9-929f-900c4753f42c
Celestial Dusting	Throws a bouncing projectile. Cooldown reduces when moving	Unlock O'Sole	Base	5	8	1		\N	5ddfa071-0950-4e53-b1b2-22ef976dbcbb
La Robba	Generates bouncing projectiles	Unlock Ambrohoe	Base	10	8	1		\N	20082e48-751a-4a70-a27d-5576ba2b9529
Great Jubilee	Has a chance to summon light sources	Complete Eudaimonia Machine after having started and exited a run in Endless mode, and a run in Inverse mode	Base	10	9	20		\N	9f1f5534-95cd-498f-891e-7a1728e7e059
Bracelet	Fires three projectiles at a random enemy	Survive 30 minutes with either Gallo or Divano	Base	10	6	40		\N	ea4dd059-d6ad-4812-8c1a-50cd4687e7ec
Candybox	Allows you to choose any unlocked base weapon	Discover every standard evolution and union	Base	10	1	2	Super Candybox II Turbo	\N	c10acbd0-44ec-4a8f-a58f-08eb13c184e4
Victory Sword	Strikes with a combo attack at the nearest enemy. Retaliates	Defeat 100,000 enemies in a single run with Queen Sigma	Base	5	12	30	Sole Solution	{"Torrona's Box"}	3d961ae3-ab51-4895-83c2-8e186c32a4ec
Flames of Misspell	Emits cones of flames	Unlock Avatar	Base	10	8	30	Ashes of Muspell	{"Torrona's Box"}	fe004d65-fd36-4f45-8b5e-7306d04d945f
Silver Wind	Defeated enemies might drop hearts	Survive for 15 minutes with Miang	Legacy of the Moonspell	10	8	50	Festive Winds	{Pummarola}	ac3d97dc-9a55-4b3c-8090-08428eb9f48a
Four Seasons	Generates 4 explosions. Amount and Duration affect damage instead	Survive for 15 minutes with Menya	Legacy of the Moonspell	5	8	50	Godai Shuffle	{Spinach,Candelabrador}	9bf04b81-9023-46f8-83cb-08105647933f
Summon Night	Generates damaging zones above the character	Survive for 15 minutes with Syuuto	Legacy of the Moonspell	10	8	50	Echo Night	{Duplicator}	fd04c9af-a56f-413d-aac1-f3e4a263782a
Mirage Robe	Generates freezing mines with a chance to explode	Survive for 15 minutes with Babi-Onna	Legacy of the Moonspell	10	8	50	J'Odore	{Attractorb}	09b7b751-4d60-4e03-8345-21f005d12b5e
Mille Bolle Blu	Fires lingering projectiles	Unlock Gav'Et Oni	Legacy of the Moonspell	5	8	1	Boo Roo Boolle	{Spellbinder}	90a9c8fc-e5f0-4837-8ee9-c427d723fdeb
Night Sword	Dangerous, cursed weapon. Retaliates. Might steal hearts	Pick it up on Mt.Moonspell	Legacy of the Moonspell	5	8	30	Muramasa	{"Stone Mask"}	1b83a6a7-7485-4f23-b06e-8aab33c66290
108 Bocce	Actually it's just 8. Damages nearby enemies	Survive for 15 minutes with McCoy-Oni	Legacy of the Moonspell	12	8	10		\N	31dfdbb1-2089-48e0-b452-0ad9a8fd6d2b
SpellString	Strikes at nearby enemies. Damage multiplied by Speed	Survive 15 minutes with Eleanor Uziron	Tides of the Foscari	5	6	70	SpellStrom	{SpellStream,SpellStrike}	58c385ab-07e4-45e9-8de7-cc9b6742edd9
SpellStream	Generates an expanding damaging zone. Damage multiplied by Area	Get SpellStream to Level 6	Tides of the Foscari	5	6	70	SpellStrom	{SpellString,SpellStrike}	c33a061f-3d93-4eac-9ee3-50cee52235bf
SpellStrike	Strikes at the nearest enemy. Damage further multiplied by Might	Get SpellStrike to Level 6	Tides of the Foscari	20	6	70	SpellStrom	{SpellString,SpellStream}	c9d57da9-dc8b-483a-938f-c1aee4eb796b
Eskizzibur	Attacks nearby enemies. Retaliates	Survive 15 minutes with Maruto Cuts	Tides of the Foscari	10	8	70	Legionnaire	{Armor}	d1fe1741-112d-424e-a3a2-628f0dbd73b6
Flash Arrow	Can deal critical damage. Amount affects damage instead	Survive 15 minutes with Keitha Muort	Tides of the Foscari	10	8	70	Millionaire	{Bracer,Clover}	ea985a36-afee-4e1c-99c0-4d29bcdc32bf
Prismatic Missile	Generates explosions around the character. Affected by the first chosen Arcana between II, XIV, or XIX	Survive 15 minutes with Luminaire Foscari	Tides of the Foscari	10	8	70	Luminaire	{Crown}	d854dd73-64ee-4d3e-92e8-a62828fc5873
Shadow Servant	Has a chance to slow enemies down	Survive 15 minutes with Genevieve Gruyère	Tides of the Foscari	10	8	70	Ophion	{"Skull O'Maniac"}	76f9fedd-dd9e-4ad8-9e87-7853ebe95f19
Party Popper	Throws bouncing projectiles	Unlocking Rottin'Ghoul	Tides of the Foscari	5	8	1		\N	75f77367-79da-4f1b-b2b5-c86e65527e4e
Test Name	Test Description	Test Unlock Requirements	Base	10.5	5	50	Test Evolution	{"Test Evolved With"}	7847ef25-04a6-4741-be10-a98fabc69357
Test Name	Test Description	Test Unlock Requirements	Base	10.5	5	50	Test Evolution	{"Test Evolved With"}	5e83af7b-6861-41b4-a58f-75a761898efc
\.


--
-- TOC entry 3181 (class 2606 OID 24683)
-- Name: dlcs dlcs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dlcs
    ADD CONSTRAINT dlcs_pkey PRIMARY KEY (uuid);


--
-- TOC entry 3183 (class 2606 OID 24681)
-- Name: passiveitems passiveitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passiveitems
    ADD CONSTRAINT passiveitems_pkey PRIMARY KEY (uuid);


--
-- TOC entry 3185 (class 2606 OID 24679)
-- Name: weapons weapons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapons
    ADD CONSTRAINT weapons_pkey PRIMARY KEY (uuid);


-- Completed on 2023-08-01 10:21:24

--
-- PostgreSQL database dump complete
--

