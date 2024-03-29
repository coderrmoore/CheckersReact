PGDMP             
            {           db    12.14    12.14     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16396    db    DATABASE     t   CREATE DATABASE db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE db;
                doadmin    false                        3079    16427    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2            �           1247    16593    enum_reports_report_reason    TYPE     t   CREATE TYPE public.enum_reports_report_reason AS ENUM (
    'Hateful Speech',
    'Cheating',
    'Bad Behavior'
);
 -   DROP TYPE public.enum_reports_report_reason;
       public          db    false            �           1247    16536    report_reason_enum    TYPE     l   CREATE TYPE public.report_reason_enum AS ENUM (
    'Hateful Speech',
    'Cheating',
    'Bad Behavior'
);
 %   DROP TYPE public.report_reason_enum;
       public          db    false            �            1259    16548    chats    TABLE     �   CREATE TABLE public.chats (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    game_id uuid NOT NULL,
    chat_text character varying NOT NULL,
    "time" timestamp with time zone NOT NULL,
    player uuid NOT NULL
);
    DROP TABLE public.chats;
       public         heap    db    false    2            �            1259    16561    games    TABLE     9  CREATE TABLE public.games (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    player1 uuid,
    player2 uuid,
    gamestate character varying NOT NULL,
    recording character varying NOT NULL,
    "time" timestamp with time zone NOT NULL,
    winner uuid,
    "finishedTime" timestamp with time zone
);
    DROP TABLE public.games;
       public         heap    db    false    2            �            1259    16525    reports    TABLE       CREATE TABLE public.reports (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    reported_user uuid NOT NULL,
    report_notes character varying DEFAULT 'No notes provided.'::character varying NOT NULL,
    report_reason public.report_reason_enum NOT NULL
);
    DROP TABLE public.reports;
       public         heap    db    false    2    670            �            1259    16635    roles    TABLE     X   CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255)
);
    DROP TABLE public.roles;
       public         heap    db    false            �            1259    16640 
   user_roles    TABLE     \   CREATE TABLE public.user_roles (
    role_id integer NOT NULL,
    user_id uuid NOT NULL
);
    DROP TABLE public.user_roles;
       public         heap    db    false            �            1259    16475    users    TABLE     ,  CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(255) NOT NULL,
    wins integer DEFAULT 0 NOT NULL,
    losses integer DEFAULT 0 NOT NULL,
    mmr integer DEFAULT 1000 NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    lightswitch boolean DEFAULT false NOT NULL,
    theme smallint DEFAULT 0 NOT NULL,
    banned boolean DEFAULT false NOT NULL,
    hideschat boolean DEFAULT false NOT NULL,
    priority boolean DEFAULT false NOT NULL
);
    DROP TABLE public.users;
       public         heap    db    false    2            O           2606    16555    chats chats_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.chats DROP CONSTRAINT chats_pkey;
       public            db    false    205            Q           2606    16568    games games_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.games DROP CONSTRAINT games_pkey;
       public            db    false    206            M           2606    16534    reports reports_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.reports DROP CONSTRAINT reports_pkey;
       public            db    false    204            S           2606    16639    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            db    false    207            U           2606    16644    user_roles user_roles_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (role_id, user_id);
 D   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
       public            db    false    208    208            G           2606    16500    users users_id 
   CONSTRAINT     G   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id UNIQUE (id);
 8   ALTER TABLE ONLY public.users DROP CONSTRAINT users_id;
       public            db    false    203            I           2606    16485    users users_id_unique 
   CONSTRAINT     ]   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_unique PRIMARY KEY (id, username);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_id_unique;
       public            db    false    203    203            K           2606    16515    users users_username 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username UNIQUE (username);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username;
       public            db    false    203            W           2606    16579    chats fk_game_id    FK CONSTRAINT     y   ALTER TABLE ONLY public.chats
    ADD CONSTRAINT fk_game_id FOREIGN KEY (game_id) REFERENCES public.games(id) NOT VALID;
 :   ALTER TABLE ONLY public.chats DROP CONSTRAINT fk_game_id;
       public          db    false    3921    206    205            Y           2606    16569    games fk_player1    FK CONSTRAINT     o   ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_player1 FOREIGN KEY (player1) REFERENCES public.users(id);
 :   ALTER TABLE ONLY public.games DROP CONSTRAINT fk_player1;
       public          db    false    206    3911    203            Z           2606    16574    games fk_player2    FK CONSTRAINT     o   ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_player2 FOREIGN KEY (player2) REFERENCES public.users(id);
 :   ALTER TABLE ONLY public.games DROP CONSTRAINT fk_player2;
       public          db    false    3911    206    203            X           2606    16587    chats fk_player_id    FK CONSTRAINT     z   ALTER TABLE ONLY public.chats
    ADD CONSTRAINT fk_player_id FOREIGN KEY (player) REFERENCES public.users(id) NOT VALID;
 <   ALTER TABLE ONLY public.chats DROP CONSTRAINT fk_player_id;
       public          db    false    203    205    3911            V           2606    16543    reports fk_reported_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_reported_user FOREIGN KEY (reported_user) REFERENCES public.users(id) NOT VALID;
 B   ALTER TABLE ONLY public.reports DROP CONSTRAINT fk_reported_user;
       public          db    false    3911    204    203            [           2606    16645 "   user_roles user_roles_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_role_id_fkey;
       public          db    false    3923    207    208            \           2606    16650 "   user_roles user_roles_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_user_id_fkey;
       public          db    false    203    208    3911           