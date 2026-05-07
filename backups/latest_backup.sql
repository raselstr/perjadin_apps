--
-- PostgreSQL database dump
--

\restrict bGfDnaiugPbkQOWbE1pNjkE5E1FhwtUcVETLDBYJ3OxGHGNBy8yxizyngHcYLO4

-- Dumped from database version 14.22 (Debian 14.22-1.pgdg13+1)
-- Dumped by pg_dump version 14.22 (Debian 14.22-1.pgdg13+1)

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
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: raselstr
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.auth_group DISABLE TRIGGER ALL;



ALTER TABLE public.auth_group ENABLE TRIGGER ALL;

--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.django_content_type DISABLE TRIGGER ALL;

INSERT INTO public.django_content_type (id, app_label, model) VALUES (1, 'admin', 'logentry');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (2, 'auth', 'permission');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (3, 'auth', 'group');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (4, 'auth', 'user');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (6, 'sessions', 'session');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (7, 'profiles', 'opd');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (8, 'profiles', 'role');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (9, 'profiles', 'userprofile');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (10, 'menus', 'menu');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (11, 'menus', 'submenu');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (12, 'menus', 'rolepermission');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (13, 'umum', 'jenisjabatan');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (14, 'umum', 'pangkat');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (15, 'umum', 'statusasn');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (16, 'umum', 'penandatangan');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (17, 'umum', 'pegawai');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (18, 'umum', 'tingkat');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (19, 'umum', 'eselon');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (20, 'umum', 'pemda');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (21, 'umum', 'kopsurat');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (22, 'spd', 'dasarperaturan');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (23, 'spd', 'jeniskegiatan');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (24, 'spd', 'jenisspd');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (25, 'spd', 'jenistransportasi');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (26, 'spd', 'lokasi');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (27, 'spd', 'standardpenginapan');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (28, 'spd', 'standardpesawat');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (29, 'spd', 'standardrepresentasi');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (30, 'spd', 'standardtransportasi');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (31, 'spd', 'standarduangharian');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (32, 'perintah', 'spt');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (33, 'perintah', 'pelaksana');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (34, 'perintah', 'pemberitugas');


ALTER TABLE public.django_content_type ENABLE TRIGGER ALL;

--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.auth_permission DISABLE TRIGGER ALL;

INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (25, 'Can add opd', 7, 'add_opd');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (26, 'Can change opd', 7, 'change_opd');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (27, 'Can delete opd', 7, 'delete_opd');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (28, 'Can view opd', 7, 'view_opd');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (29, 'Can add role', 8, 'add_role');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (30, 'Can change role', 8, 'change_role');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (31, 'Can delete role', 8, 'delete_role');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (32, 'Can view role', 8, 'view_role');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (33, 'Can add user profile', 9, 'add_userprofile');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (34, 'Can change user profile', 9, 'change_userprofile');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (35, 'Can delete user profile', 9, 'delete_userprofile');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (36, 'Can view user profile', 9, 'view_userprofile');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (37, 'Can add menu', 10, 'add_menu');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (38, 'Can change menu', 10, 'change_menu');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (39, 'Can delete menu', 10, 'delete_menu');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (40, 'Can view menu', 10, 'view_menu');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (41, 'Can add sub menu', 11, 'add_submenu');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (42, 'Can change sub menu', 11, 'change_submenu');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (43, 'Can delete sub menu', 11, 'delete_submenu');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (44, 'Can view sub menu', 11, 'view_submenu');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (45, 'Can add role permission', 12, 'add_rolepermission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (46, 'Can change role permission', 12, 'change_rolepermission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (47, 'Can delete role permission', 12, 'delete_rolepermission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (48, 'Can view role permission', 12, 'view_rolepermission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (49, 'Can add jenis jabatan', 13, 'add_jenisjabatan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (50, 'Can change jenis jabatan', 13, 'change_jenisjabatan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (51, 'Can delete jenis jabatan', 13, 'delete_jenisjabatan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (52, 'Can view jenis jabatan', 13, 'view_jenisjabatan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (53, 'Can add pangkat', 14, 'add_pangkat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (54, 'Can change pangkat', 14, 'change_pangkat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (55, 'Can delete pangkat', 14, 'delete_pangkat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (56, 'Can view pangkat', 14, 'view_pangkat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (57, 'Can add status asn', 15, 'add_statusasn');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (58, 'Can change status asn', 15, 'change_statusasn');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (59, 'Can delete status asn', 15, 'delete_statusasn');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (60, 'Can view status asn', 15, 'view_statusasn');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (61, 'Can add penandatangan', 16, 'add_penandatangan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (62, 'Can change penandatangan', 16, 'change_penandatangan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (63, 'Can delete penandatangan', 16, 'delete_penandatangan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (64, 'Can view penandatangan', 16, 'view_penandatangan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (65, 'Can add pegawai', 17, 'add_pegawai');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (66, 'Can change pegawai', 17, 'change_pegawai');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (67, 'Can delete pegawai', 17, 'delete_pegawai');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (68, 'Can view pegawai', 17, 'view_pegawai');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (69, 'Can add tingkat', 18, 'add_tingkat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (70, 'Can change tingkat', 18, 'change_tingkat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (71, 'Can delete tingkat', 18, 'delete_tingkat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (72, 'Can view tingkat', 18, 'view_tingkat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (73, 'Can add eselon', 19, 'add_eselon');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (74, 'Can change eselon', 19, 'change_eselon');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (75, 'Can delete eselon', 19, 'delete_eselon');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (76, 'Can view eselon', 19, 'view_eselon');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (77, 'Can add Pemda', 20, 'add_pemda');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (78, 'Can change Pemda', 20, 'change_pemda');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (79, 'Can delete Pemda', 20, 'delete_pemda');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (80, 'Can view Pemda', 20, 'view_pemda');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (81, 'Can add Kop Surat', 21, 'add_kopsurat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (82, 'Can change Kop Surat', 21, 'change_kopsurat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (83, 'Can delete Kop Surat', 21, 'delete_kopsurat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (84, 'Can view Kop Surat', 21, 'view_kopsurat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (85, 'Can add Dasar Peraturan', 22, 'add_dasarperaturan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (86, 'Can change Dasar Peraturan', 22, 'change_dasarperaturan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (87, 'Can delete Dasar Peraturan', 22, 'delete_dasarperaturan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (88, 'Can view Dasar Peraturan', 22, 'view_dasarperaturan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (89, 'Can add Jenis Kegiatan', 23, 'add_jeniskegiatan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (90, 'Can change Jenis Kegiatan', 23, 'change_jeniskegiatan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (91, 'Can delete Jenis Kegiatan', 23, 'delete_jeniskegiatan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (92, 'Can view Jenis Kegiatan', 23, 'view_jeniskegiatan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (93, 'Can add Jenis SPD', 24, 'add_jenisspd');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (94, 'Can change Jenis SPD', 24, 'change_jenisspd');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (95, 'Can delete Jenis SPD', 24, 'delete_jenisspd');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (96, 'Can view Jenis SPD', 24, 'view_jenisspd');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (97, 'Can add Jenis Transportasi', 25, 'add_jenistransportasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (98, 'Can change Jenis Transportasi', 25, 'change_jenistransportasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (99, 'Can delete Jenis Transportasi', 25, 'delete_jenistransportasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (100, 'Can view Jenis Transportasi', 25, 'view_jenistransportasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (101, 'Can add Lokasi', 26, 'add_lokasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (102, 'Can change Lokasi', 26, 'change_lokasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (103, 'Can delete Lokasi', 26, 'delete_lokasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (104, 'Can view Lokasi', 26, 'view_lokasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (105, 'Can add Standar Penginapan', 27, 'add_standardpenginapan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (106, 'Can change Standar Penginapan', 27, 'change_standardpenginapan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (107, 'Can delete Standar Penginapan', 27, 'delete_standardpenginapan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (108, 'Can view Standar Penginapan', 27, 'view_standardpenginapan');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (109, 'Can add Standar Tiket Pesawat', 28, 'add_standardpesawat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (110, 'Can change Standar Tiket Pesawat', 28, 'change_standardpesawat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (111, 'Can delete Standar Tiket Pesawat', 28, 'delete_standardpesawat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (112, 'Can view Standar Tiket Pesawat', 28, 'view_standardpesawat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (113, 'Can add Standar Representasi', 29, 'add_standardrepresentasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (114, 'Can change Standar Representasi', 29, 'change_standardrepresentasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (115, 'Can delete Standar Representasi', 29, 'delete_standardrepresentasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (116, 'Can view Standar Representasi', 29, 'view_standardrepresentasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (117, 'Can add Standar Transportasi', 30, 'add_standardtransportasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (118, 'Can change Standar Transportasi', 30, 'change_standardtransportasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (119, 'Can delete Standar Transportasi', 30, 'delete_standardtransportasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (120, 'Can view Standar Transportasi', 30, 'view_standardtransportasi');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (121, 'Can add Standar Uang Harian', 31, 'add_standarduangharian');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (122, 'Can change Standar Uang Harian', 31, 'change_standarduangharian');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (123, 'Can delete Standar Uang Harian', 31, 'delete_standarduangharian');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (124, 'Can view Standar Uang Harian', 31, 'view_standarduangharian');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (125, 'Can add SPT', 32, 'add_spt');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (126, 'Can change SPT', 32, 'change_spt');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (127, 'Can delete SPT', 32, 'delete_spt');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (128, 'Can view SPT', 32, 'view_spt');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (129, 'Can add Pelaksana', 33, 'add_pelaksana');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (130, 'Can change Pelaksana', 33, 'change_pelaksana');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (131, 'Can delete Pelaksana', 33, 'delete_pelaksana');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (132, 'Can view Pelaksana', 33, 'view_pelaksana');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (133, 'Can add Pemberi Tugas', 34, 'add_pemberitugas');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (134, 'Can change Pemberi Tugas', 34, 'change_pemberitugas');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (135, 'Can delete Pemberi Tugas', 34, 'delete_pemberitugas');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (136, 'Can view Pemberi Tugas', 34, 'view_pemberitugas');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (139, 'Can add eselon', 52, 'add_eselon');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (140, 'Can change eselon', 52, 'change_eselon');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (141, 'Can delete eselon', 52, 'delete_eselon');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (142, 'Can view eselon', 52, 'view_eselon');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (143, 'Can add SPT', 53, 'add_spt');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (144, 'Can change SPT', 53, 'change_spt');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (145, 'Can delete SPT', 53, 'delete_spt');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (146, 'Can view SPT', 53, 'view_spt');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (147, 'Can add Pelaksana', 54, 'add_pelaksana');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (148, 'Can change Pelaksana', 54, 'change_pelaksana');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (149, 'Can delete Pelaksana', 54, 'delete_pelaksana');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (150, 'Can view Pelaksana', 54, 'view_pelaksana');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (151, 'Can add pemda', 55, 'add_pemda');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (152, 'Can change pemda', 55, 'change_pemda');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (153, 'Can delete pemda', 55, 'delete_pemda');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (154, 'Can view pemda', 55, 'view_pemda');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (155, 'Can add Pemberi Tugas', 56, 'add_pemberitugas');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (156, 'Can change Pemberi Tugas', 56, 'change_pemberitugas');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (157, 'Can delete Pemberi Tugas', 56, 'delete_pemberitugas');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (158, 'Can view Pemberi Tugas', 56, 'view_pemberitugas');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (159, 'Can add Kop Surat', 57, 'add_kopsurat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (160, 'Can change Kop Surat', 57, 'change_kopsurat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (161, 'Can delete Kop Surat', 57, 'delete_kopsurat');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (162, 'Can view Kop Surat', 57, 'view_kopsurat');


ALTER TABLE public.auth_permission ENABLE TRIGGER ALL;

--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.auth_group_permissions DISABLE TRIGGER ALL;



ALTER TABLE public.auth_group_permissions ENABLE TRIGGER ALL;

--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.auth_user DISABLE TRIGGER ALL;

INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (9, 'pbkdf2_sha256$1000000$y0brC0d6vhB1BPA5K3kduY$S+FCNYmmT8OdReEmDNMpXROBqD6uxu63mgyA3pOLssY=', '2026-05-07 12:48:51.360417+00', false, 'saleh', '', '', 'asahanbkad@gmail.com', false, true, '2026-05-04 10:58:52.337548+00');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (1, 'pbkdf2_sha256$1000000$YjpAletTzOCcfOcwBIRKVV$MKlTJnH71Qd1E5Q+EkrxYxvTyhtD4KtAiktRiIlZPjg=', '2026-05-07 12:50:19.392242+00', true, 'admin', '', '', '', true, true, '2026-04-14 12:08:07.49271+00');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (8, 'pbkdf2_sha256$1000000$YvNcyfgbNksfvaBBumED6j$XNUw9EHib0+HoMBqN59PlZaQfNywex+wwyZFhkic4tE=', '2026-05-06 01:36:00.480062+00', false, 'rahmad', '', '', 'rahmad@gmail.com', false, true, '2026-05-04 06:38:25.087502+00');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (10, 'pbkdf2_sha256$1000000$3495YkQAHchPouU8zsZ2qe$4MuVQAaIFjTxBq89bfdYxH15sWDn2NTVTKKMojItXfg=', '2026-05-06 11:49:13.761238+00', false, 'Kantor', '', '', 'bkadasahan@gmail.com', false, true, '2026-05-06 11:20:05.684517+00');


ALTER TABLE public.auth_user ENABLE TRIGGER ALL;

--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.auth_user_groups DISABLE TRIGGER ALL;



ALTER TABLE public.auth_user_groups ENABLE TRIGGER ALL;

--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.auth_user_user_permissions DISABLE TRIGGER ALL;



ALTER TABLE public.auth_user_user_permissions ENABLE TRIGGER ALL;

--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.django_admin_log DISABLE TRIGGER ALL;

INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (1, '2026-04-16 04:21:39.634136+00', '1', 'Umum', 1, '[{"added": {}}, {"added": {"name": "sub menu", "object": "Pegawai"}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (2, '2026-04-16 04:27:10.90715+00', '1', 'Badan Keuangan dan Aset Daerah', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (3, '2026-04-16 04:27:36.988674+00', '1', 'Kepala', 1, '[{"added": {}}]', 13, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (4, '2026-04-16 04:27:44.043248+00', '2', 'Plt.', 1, '[{"added": {}}]', 13, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (5, '2026-04-16 04:27:47.988727+00', '3', 'Plh.', 1, '[{"added": {}}]', 13, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (6, '2026-04-16 04:28:16.097475+00', '4', 'Sekretaris', 1, '[{"added": {}}]', 13, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (7, '2026-04-16 04:28:23.469872+00', '5', 'Kepala Bidang', 1, '[{"added": {}}]', 13, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (8, '2026-04-16 04:28:58.054012+00', '1', 'Pengatur Muda (III/a)', 1, '[{"added": {}}]', 14, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (9, '2026-04-16 04:29:08.991483+00', '1', 'PNS', 1, '[{"added": {}}]', 15, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (10, '2026-04-16 09:14:35.030647+00', '1', 'Umum', 2, '[{"added": {"name": "sub menu", "object": "Pejabat"}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (11, '2026-04-16 09:26:11.852836+00', '2', 'rahmad', 1, '[{"added": {}}]', 4, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (12, '2026-04-16 09:26:22.085533+00', '2', 'rahmad', 2, '[{"changed": {"fields": ["First name", "Last name"]}}]', 4, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (13, '2026-04-16 09:27:43.175323+00', '1', 'Administrator', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (14, '2026-04-16 09:27:56.330575+00', '2', 'rahmad', 2, '[{"changed": {"fields": ["Opd", "Role"]}}]', 9, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (15, '2026-04-16 09:28:12.392039+00', '1', 'Administrator - Pegawai', 1, '[{"added": {}}]', 12, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (16, '2026-04-16 10:14:54.48089+00', '1', 'Administrator - Pegawai', 2, '[{"changed": {"fields": ["Can add"]}}]', 12, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (17, '2026-04-16 10:20:08.118657+00', '1', 'Administrator - Pegawai', 2, '[{"changed": {"fields": ["Can edit", "Can delete"]}}]', 12, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (18, '2026-04-16 10:21:17.900442+00', '1', 'Administrator - Pegawai', 2, '[{"changed": {"fields": ["Can add", "Can edit"]}}]', 12, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (19, '2026-04-16 10:42:43.322845+00', '1', 'Administrator - Pegawai', 2, '[{"changed": {"fields": ["Can add"]}}]', 12, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (20, '2026-04-16 12:40:49.126548+00', '1', 'Administrator - Pegawai', 2, '[{"changed": {"fields": ["Can add"]}}]', 12, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (21, '2026-04-16 12:48:04.415778+00', '1', 'Administrator - Pegawai', 2, '[]', 12, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (22, '2026-04-16 12:48:15.576049+00', '2', 'Administrator - Pejabat', 1, '[{"added": {}}]', 12, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (23, '2026-04-16 13:11:45.133691+00', '1', 'Umum', 2, '[{"added": {"name": "sub menu", "object": "Role"}}, {"changed": {"name": "sub menu", "object": "Pejabat", "fields": ["Urutan"]}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (24, '2026-04-16 13:27:11.722798+00', '2', 'Pengguna', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (25, '2026-04-16 13:54:57.176435+00', '3', 'Role', 2, '[]', 11, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (26, '2026-04-17 02:34:28.536319+00', '2', 'Admin', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (27, '2026-04-17 02:34:56.144858+00', '3', 'Role', 2, '[{"changed": {"fields": ["Menu"]}}]', 11, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (28, '2026-04-17 02:35:06.891248+00', '2', 'Admin', 2, '[{"changed": {"fields": ["Urutan"]}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (29, '2026-04-17 05:07:27.044499+00', '2', 'Admin', 2, '[{"changed": {"fields": ["Icon"]}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (30, '2026-04-17 05:09:40.835967+00', '2', 'Admin', 2, '[{"changed": {"fields": ["Icon"]}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (31, '2026-04-17 05:10:51.341004+00', '2', 'Admin', 2, '[{"changed": {"fields": ["Icon"]}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (32, '2026-04-17 05:11:16.716516+00', '1', 'Umum', 2, '[{"changed": {"fields": ["Icon"]}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (33, '2026-04-17 05:11:42.078456+00', '2', 'Admin', 2, '[{"changed": {"fields": ["Icon"]}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (34, '2026-04-17 07:07:00.111969+00', '2', 'Admin', 2, '[{"added": {"name": "sub menu", "object": "Menu"}}, {"changed": {"name": "sub menu", "object": "Role", "fields": ["Urutan"]}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (35, '2026-04-17 07:07:32.883372+00', '2', 'Admin', 2, '[{"added": {"name": "sub menu", "object": "Sub Menu"}}]', 10, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (36, '2026-04-23 09:39:46.939253+00', '1', 'Peraturan Bupati Asahan (4 Tahun 2026)', 1, '[{"added": {}}]', 24, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (37, '2026-04-23 09:40:50.429203+00', '1', 'Peraturan Bupati Asahan (4 Tahun 2026)', 2, '[{"changed": {"fields": ["Keterangan"]}}]', 24, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (38, '2026-05-04 01:43:38.540755+00', '1', 'PEMERINTAH KABUPATEN ASAHAN', 2, '[{"changed": {"fields": ["Nama kabupaten"]}}]', 55, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (39, '2026-05-04 06:37:50.973011+00', '2', 'rahmad', 3, '', 4, 1);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (40, '2026-05-04 06:37:58.345089+00', '7', 'saleh', 3, '', 4, 1);


ALTER TABLE public.django_admin_log ENABLE TRIGGER ALL;

--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.django_migrations DISABLE TRIGGER ALL;

INSERT INTO public.django_migrations (id, app, name, applied) VALUES (1, 'contenttypes', '0001_initial', '2026-05-04 13:14:31.282502+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (2, 'auth', '0001_initial', '2026-05-04 13:14:32.632348+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (3, 'admin', '0001_initial', '2026-05-04 13:14:33.101246+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2026-05-04 13:14:33.125013+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2026-05-04 13:14:33.153924+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2026-05-04 13:14:33.203201+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2026-05-04 13:14:33.235956+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (8, 'auth', '0003_alter_user_email_max_length', '2026-05-04 13:14:33.25492+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (9, 'auth', '0004_alter_user_username_opts', '2026-05-04 13:14:33.288683+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (10, 'auth', '0005_alter_user_last_login_null', '2026-05-04 13:14:33.313363+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (11, 'auth', '0006_require_contenttypes_0002', '2026-05-04 13:14:33.318231+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2026-05-04 13:14:33.343732+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (13, 'auth', '0008_alter_user_username_max_length', '2026-05-04 13:14:33.406821+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2026-05-04 13:14:33.44743+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (15, 'auth', '0010_alter_group_name_max_length', '2026-05-04 13:14:33.504699+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (16, 'auth', '0011_update_proxy_permissions', '2026-05-04 13:14:33.547184+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2026-05-04 13:14:33.580145+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (18, 'profiles', '0001_initial', '2026-05-04 13:14:34.278957+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (19, 'menus', '0001_initial', '2026-05-04 13:14:34.710845+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (20, 'umum', '0001_initial', '2026-05-04 13:14:36.086593+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (21, 'umum', '0002_alter_penandatangan_nip', '2026-05-04 13:14:36.139562+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (22, 'umum', '0003_alter_pegawai_options', '2026-05-04 13:14:36.184172+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (23, 'umum', '0004_alter_penandatangan_options', '2026-05-04 13:14:36.224315+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (24, 'umum', '0005_alter_jenisjabatan_nama_alter_pangkat_pangkat_and_more', '2026-05-04 13:14:36.79619+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (25, 'umum', '0006_penandatangan_unique_nama_jenis_jabatan', '2026-05-04 13:14:36.929854+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (26, 'umum', '0007_tingkat', '2026-05-04 13:14:37.320173+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (27, 'umum', '0008_alter_tingkat_ket', '2026-05-04 13:14:37.378404+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (28, 'umum', '0009_pegawai_tingkat', '2026-05-04 13:14:37.570968+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (29, 'umum', '0010_tingkat_kapal_tingkat_keteraapian_tingkat_lainnya_and_more', '2026-05-04 13:14:37.752024+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (30, 'umum', '0011_rename_keteraapian_tingkat_keretaapian', '2026-05-04 13:14:37.783259+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (31, 'umum', '0012_alter_pangkat_pangkat_alter_pangkat_ruang_and_more', '2026-05-04 13:14:37.907399+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (32, 'umum', '0013_jenisjabatan_fungsi_jenisjabatan_keterangan', '2026-05-04 13:14:38.033196+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (33, 'umum', '0014_eselon', '2026-05-04 13:14:38.230361+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (34, 'umum', '0015_pegawai_eselon', '2026-05-04 13:14:38.39538+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (35, 'umum', '0016_pegawai_unique_pegawai_nip_eselon_jenis_jabatan', '2026-05-04 13:14:38.484903+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (36, 'umum', '0017_alter_pegawai_eselon_alter_pegawai_jenis_jabatan_and_more', '2026-05-04 13:14:38.859551+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (37, 'umum', '0018_alter_pegawai_eselon_alter_pegawai_jenis_jabatan_and_more', '2026-05-04 13:14:39.269227+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (38, 'umum', '0019_alter_pegawai_eselon_alter_pegawai_jenis_jabatan', '2026-05-04 13:14:39.492472+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (39, 'umum', '0020_alter_pegawai_nip', '2026-05-04 13:14:39.549142+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (40, 'umum', '0021_pemda', '2026-05-04 13:14:39.888421+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (41, 'umum', '0022_alter_pemda_options', '2026-05-04 13:14:39.926008+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (42, 'umum', '0023_remove_pemda_jenis_kop_pemda_website_and_more', '2026-05-04 13:14:40.55996+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (43, 'umum', '0024_pemda_ibukota', '2026-05-04 13:14:40.631605+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (44, 'umum', '0025_alter_penandatangan_tugas', '2026-05-04 13:14:40.668869+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (45, 'umum', '0026_remove_penandatangan_uniq_penandatangan_nama_jenis_jabatan_and_more', '2026-05-04 13:14:40.848848+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (46, 'umum', '0027_remove_penandatangan_uniq_penandatangan_nama_tugas_jenis_jabatan_opd_and_more', '2026-05-04 13:14:40.958189+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (47, 'umum', '0028_remove_penandatangan_uniq_penandatangan_nip_nama_tugas_jenis_jabatan_opd_and_more', '2026-05-04 13:14:41.091701+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (48, 'umum', '0029_remove_penandatangan_uniq_penandatangan_nama_tugas_jenis_jabatan_and_more', '2026-05-04 13:14:41.222216+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (49, 'spd', '0001_initial', '2026-05-04 13:14:44.27237+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (50, 'spd', '0002_alter_lokasi_options', '2026-05-04 13:14:44.297721+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (51, 'spd', '0003_remove_standardpenginapan_aktif_and_more', '2026-05-04 13:14:44.418203+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (52, 'spd', '0004_lokasi_kota', '2026-05-04 13:14:44.454874+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (53, 'spd', '0005_alter_lokasi_options', '2026-05-04 13:14:44.49757+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (54, 'spd', '0006_standardpenginapan_satuan', '2026-05-04 13:14:44.559987+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (55, 'perintah', '0001_initial', '2026-05-04 13:14:45.455821+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (56, 'perintah', '0002_spt_tempat_tujuan', '2026-05-04 13:14:45.532758+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (57, 'perintah', '0003_alter_spt_tempat_tujuan', '2026-05-04 13:14:45.603153+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (58, 'perintah', '0004_pemberitugas', '2026-05-04 13:14:46.089374+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (59, 'perintah', '0005_alter_spt_options_remove_spt_nomor_spt_and_more', '2026-05-04 13:14:46.237885+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (60, 'perintah', '0006_pemberitugas_unique_pemberi_tugas_spt_penandatangan', '2026-05-04 13:14:46.337991+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (61, 'perintah', '0007_pemberitugas_nomor_spd', '2026-05-04 13:14:46.39375+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (62, 'perintah', '0008_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_and_more', '2026-05-04 13:14:46.69273+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (63, 'perintah', '0009_alter_pemberitugas_nip_alter_pemberitugas_pangkat', '2026-05-04 13:14:46.79826+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (64, 'perintah', '0010_pemberitugas_nomor_urut', '2026-05-04 13:14:46.831976+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (65, 'perintah', '0011_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_nomor_spt_nomor_spd_and_more', '2026-05-04 13:14:46.963953+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (66, 'sessions', '0001_initial', '2026-05-04 13:14:47.231067+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (67, 'umum', '0030_alter_pemda_nama_dinas', '2026-05-04 13:14:47.335735+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (68, 'umum', '0031_kopsurat', '2026-05-04 13:14:47.664732+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (69, 'umum', '0032_kopsurat_default_spd_number_format_and_more', '2026-05-04 13:14:47.912181+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (70, 'umum', '0033_remove_kopsurat_footer_alignment_and_more', '2026-05-04 13:14:48.130778+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (71, 'umum', '0034_alter_kopsurat_default_spt_number_format_and_more', '2026-05-04 13:14:48.196956+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (72, 'umum', '0014_eselon', '2026-04-27 04:37:30.435294+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (73, 'umum', '0015_pegawai_eselon', '2026-04-27 04:38:28.293529+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (74, 'umum', '0016_pegawai_unique_pegawai_nip_eselon_jenis_jabatan', '2026-04-27 07:03:26.082337+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (75, 'umum', '0017_alter_pegawai_eselon_alter_pegawai_jenis_jabatan_and_more', '2026-04-27 07:09:33.783868+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (76, 'umum', '0018_alter_pegawai_eselon_alter_pegawai_jenis_jabatan_and_more', '2026-04-27 07:17:47.241321+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (77, 'umum', '0019_alter_pegawai_eselon_alter_pegawai_jenis_jabatan', '2026-04-27 07:29:56.501009+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (78, 'umum', '0020_alter_pegawai_nip', '2026-04-27 07:33:39.147647+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (79, 'perintah', '0001_initial', '2026-04-27 09:51:47.697958+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (80, 'perintah', '0002_spt_tempat_tujuan', '2026-04-28 11:03:33.065026+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (81, 'perintah', '0003_alter_spt_tempat_tujuan', '2026-04-28 11:06:34.589497+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (82, 'umum', '0021_pemda', '2026-04-30 04:22:58.600147+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (83, 'perintah', '0004_pemberitugas', '2026-04-30 04:22:59.350877+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (84, 'perintah', '0005_alter_spt_options_remove_spt_nomor_spt_and_more', '2026-04-30 04:30:55.047621+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (85, 'umum', '0022_alter_pemda_options', '2026-04-30 09:28:13.677508+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (86, 'umum', '0023_remove_pemda_jenis_kop_pemda_website_and_more', '2026-04-30 09:37:11.476717+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (87, 'perintah', '0006_pemberitugas_unique_pemberi_tugas_spt_penandatangan', '2026-04-30 09:40:31.064114+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (88, 'umum', '0024_pemda_ibukota', '2026-04-30 10:33:49.306107+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (89, 'umum', '0025_alter_penandatangan_tugas', '2026-04-30 10:54:29.707145+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (90, 'umum', '0026_remove_penandatangan_uniq_penandatangan_nama_jenis_jabatan_and_more', '2026-04-30 11:21:55.342022+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (91, 'umum', '0027_remove_penandatangan_uniq_penandatangan_nama_tugas_jenis_jabatan_opd_and_more', '2026-04-30 11:24:41.912176+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (92, 'umum', '0028_remove_penandatangan_uniq_penandatangan_nip_nama_tugas_jenis_jabatan_opd_and_more', '2026-04-30 12:59:47.184746+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (93, 'umum', '0029_remove_penandatangan_uniq_penandatangan_nama_tugas_jenis_jabatan_and_more', '2026-04-30 13:44:35.64216+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (94, 'perintah', '0007_pemberitugas_nomor_spd', '2026-04-30 13:44:35.682472+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (95, 'perintah', '0008_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_and_more', '2026-04-30 13:44:35.77591+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (96, 'umum', '0030_alter_pemda_nama_dinas', '2026-04-30 13:47:08.04122+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (97, 'perintah', '0009_alter_pemberitugas_nip_alter_pemberitugas_pangkat', '2026-04-30 14:11:37.466152+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (98, 'perintah', '0010_pemberitugas_nomor_urut', '2026-05-04 00:55:04.09774+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (99, 'umum', '0031_kopsurat', '2026-05-04 00:55:05.377202+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (100, 'umum', '0032_kopsurat_default_spd_number_format_and_more', '2026-05-04 00:55:05.615905+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (101, 'umum', '0033_remove_kopsurat_footer_alignment_and_more', '2026-05-04 00:55:05.746864+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (102, 'perintah', '0011_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_nomor_spt_nomor_spd_and_more', '2026-05-04 03:07:14.531831+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (103, 'umum', '0034_alter_kopsurat_default_spt_number_format_and_more', '2026-05-04 06:09:08.80437+00');


ALTER TABLE public.django_migrations ENABLE TRIGGER ALL;

--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.django_session DISABLE TRIGGER ALL;

INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('5sk22cga97ptcoidlochvibu64am0oy6', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS0VmbVK5c_v5SLXuE:1wFQYX:9qeu6TBRE_WjmYq8bLut4Rg21QFcBYwp_eOmg7WTkYo', '2026-04-22 06:00:25.651315+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('302fns8dnckt7oetu3pzflowm68f39yn', '.eJxVj8sOwiAQRX_FsDYNRYqtO92b-AdkYMCidTA8VsZ_F40L3Z5778nMg2moZdY1u6QDsh3r2fqXGbBXR-8AL0Dn2NlIJQXTvSvdN83dMaJbDt_un2CGPLf1pCZnQU5e8gk3ho_YC6W8RNgOaPrR8EGOIFAhVzgMQvGt86Py3NpNL51v0gJzJd2OOEMCak7BhWo8u5xDJB3v-HmB6rL8U4IbtP4eb4FCLglKTKtTzVDY8wX2A1am:1wCcvP:kiRvj7RHZug_eWl2GPU1SJLgj0LiqkK1f0OcezERFeQ', '2026-04-28 12:31:27.911404+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('2m7csykvshhe7911cu5zz3iwjlq6fpue', '.eJxVj8sOwiAQRX_FsDYNRYqtO92b-AdkYMCidTA8VsZ_F40L3Z5778nMg2moZdY1u6QDsh3r2fqXGbBXR-8AL0Dn2NlIJQXTvSvdN83dMaJbDt_un2CGPLf1pCZnQU5e8gk3ho_YC6W8RNgOaPrR8EGOIFAhVzgMQvGt86Py3NpNL51v0gJzJd2OOEMCak7BhWo8u5xDJB3v-HmB6rL8U4IbtP4eb4FCLglKTKtTzVDY8wX2A1am:1wHCcC:_2PhuIR3dv7Nnz3bvy6o4_mejdTl67nsmW2WvcBzQKs', '2026-04-27 03:31:32.046112+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('95bewzflk5fu3t0j0jbzx3fmd806zbtq', '.eJxVj0tuAyEQRK8SsY5GMGZ6wLtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkgj3_Zxbdh0-3gN4xnfPkcmol2ulWme5pnd4y-f313n0QbFi3sdagvUOpg-SaDpYrEjNAkITrQlYoyxepcCYgDrQsM_DVBwWBO3cQ0ochbbj1ZMYRZyyYhnPmMwxefa0xJ5M_6e-F1Pf9kSa84Oi_0CWmWFvBlsvTqVdsY75jbQZdi9fYvthRrCsoqQXIn1-UnV7l:1wFTdU:3OkEtVoeaQMdHVA6calSZoQde-TGJVFxHW_YKfCJVSM', '2026-04-22 09:17:44.923415+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('51octxwoxu2n84oxb5aypad4mzhf98mr', 'e30:1wIN1c:5dyAcAtSSEk5WfHZx9Qucuu6eNXcTarqARNOS339olI', '2026-04-30 08:50:36.182089+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ep4dk2cgevhzpv1hzonw0pt0lzyqhqgq', '.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKSX1rJRQ1xuUpV7p:1wFQfM:JpZZOaHenWGAI4nysBkDCuwnHSwYT6sOnagCFHk5oKQ', '2026-04-22 06:07:28.021175+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('370lzm1576r0eetab0171x6w7ibn127x', 'e30:1wINYX:nixGud1Ev-ua3kP--F8eQxu1RKv8BlAxyed2_cCjKmo', '2026-04-30 09:24:37.768568+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('msfd2ysz5iujqraozv57b5kn505zm1ss', '.eJxVj8tqAyEYhV-luC6DGked7Np9IW8gv_6asZ1o8RIoJe8eE7JItt-5cM4_MdDbanr1xUQke8LI-zOz4H58ugn4DemYJ5dTK9FON8v0UOv0ldFvnw_vS8EKdR3pRS7egViCoAvuLNXIuJRBIKgZLdOWzkIDR4lU4jxzSZUPWgbq3I4JH0Zpg7UnM0YcoUAanZxyOXj1tcacTP7F-4XUt-2VJjjB8H_gKaZYW4GWy9uhV2gjvkFtBlyL59j-yJ4pJfUYwNXlCpSNXuI:1wFVDH:eTV8QrYBJjvsr6BlqyZM--fKYRQ8jwLd8AmVvWMEbAE', '2026-04-22 10:58:47.867269+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('xorscfe9l3c5eylwlmsk6vz7j95svxnk', '.eJxVj8sOwiAQRX_FsDYNRYqtO92b-AdkYMCidTA8VsZ_F40L3Z5778nMg2moZdY1u6QDsh3r2fqXGbBXR-8AL0Dn2NlIJQXTvSvdN83dMaJbDt_un2CGPLf1pCZnQU5e8gk3ho_YC6W8RNgOaPrR8EGOIFAhVzgMQvGt86Py3NpNL51v0gJzJd2OOEMCak7BhWo8u5xDJB3v-HmB6rL8U4IbtP4eb4FCLglKTKtTzVDY8wX2A1am:1wFpRC:j4Po_yX5SXdTqxYDufGOMSpUrI_FqUeB3YRw6Tqzna4', '2026-04-23 08:34:30.421262+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('iozp3vu5a0n73zvs31lrij33rqa211n1', '.eJxVj0tuAyEQRK8SsY5G_IYZvLP3kXID1NDgIRlDxCdSFPnuxpEX8fZV1VP3LzHQ22Z69cVEJAfCyOt_ZsF9-nQP8APSOU8up1aine6V6ZHW6S2j30-P7pNgg7qNtVbaO5A6SKpRWLoi40oFibDMaNlq6SxX4KiQKpxnrujiw6oCdU4w6cOQNth6MuOIMxRIw8kpV4NXX2vMyeQv_Hsh9X1_pgkuMPpHvMQUayvQcnl57xXamO9QmwHX4ndsP-TAlkVpISgV1xuUaF7X:1wFpRj:KCMDxfduFLleZo3PyBMBWa3jsdikcesLUnZQbvtui4I', '2026-04-23 08:35:03.635219+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('i86xbol9k9r7r9x813kuw7bu5xw8m5qh', '.eJxVj0tuAyEQRK8SsY5GwADDeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wt3oFYg6ArzpZqZFypIBAWiZZpS6XQwFEhVSglV3TxQatAnZuZ8GFIG2w9mXHEGQqk4eSUq8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jgy6L0LMXMrzeUgl7e:1wFQ40:1RqvCISG75Jxp54GNBNBOyDI7LTDok2VZEzkUDrIV9M', '2026-04-22 05:28:52.082163+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('k91q3ontk1bgi0wmgp5lwe2wznakwpmo', '.eJxVj8tOBCEQRX_FsDYdoIGG2enexD8gBQXTaA8YHibG-O8yZhbO9tx7T6q-iYXRdztaqDYhORFGHv8zB_495GuAb5DPZfEl95rccq0st7QtLwXD8Xzr3gl2aPtcG2WCB2GioAZXRzUyrlQUCJtEx7SjUmjgqJAqlJIruoWoVaTer0yEOKUd9pHtPOIMFfJ0csrV5C20lkq25QP_XsjjOO5phgvM_hNeUk6tV-ilPryOBn3OD2jdgu_pM_UvcmLbpswquaY_v5SMXuA:1wFq2S:8ocd9bf6AA6AKB-JtEvZxHRg9uMiqx3Pm020pwah0GY', '2026-04-23 09:13:00.963581+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('abkqwzvi0ahhgxsy503fmsfxreuilngs', '.eJxVj8tOBCEQRX_FsDYdmuY5O92b-AekoGAa7QHDw8QY_13GzMLZnnvvSdU3sTD6bkcL1SYkJ7KSx__MgX8P-RrgG-RzWXzJvSa3XCvLLW3LS8FwPN-6d4Id2j7XRprggZvIqcHNUY0rkzJyBCXQrdpRwTUwlEglCsEkVSFqGan328pDnNIO-8h2HnGGCnk6GWVy8hZaSyXb8oF_L-RxHPc0wwVm_wkvKafWK_RSH15Hgz7nB7Ruwff0mfoXOa1KSbMJpeXPL5SsXus:1wFqAc:mNDWxfhXczPae9emPzLXBegZvyUiQY5XEQm720KUT5Y', '2026-04-23 09:21:26.473709+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('0dcutqnzh3dllrph7gbrmkn5zhkg9gbt', '.eJxVj8sOwiAQRX_FsDYNRYqtO92b-AdkYMCidTA8VsZ_F40L3Z5778nMg2moZdY1u6QDsh3r2fqXGbBXR-8AL0Dn2NlIJQXTvSvdN83dMaJbDt_un2CGPLf1pCZnQU5e8gk3ho_YC6W8RNgOaPrR8EGOIFAhVzgMQvGt86Py3NpNL51v0gJzJd2OOEMCak7BhWo8u5xDJB3v-HmB6rL8U4IbtP4eb4FCLglKTKtTzVDY8wX2A1am:1wEjab:_NtO7P1NjJuAbkSvMv2fH6sthOqPJliOuPstKJNSQ18', '2026-05-04 08:02:41.592315+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('kgm3pdv7mybsxbd20a9rwnltlq6n4qea', '.eJxVj0tuAyEQRK8SsY5GDGZ6wLtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkM3v-zyy6D59uAb1jOufJ5dRKtNOtMt3TOr1l8vvrvfsg2LBuY61Be4dSB8k1HSxXNAuAIAnXheysLF-kQkFAHGhZBPDVBwWBO3eYpQ9D2nDryYwjzlgwDafgAgavvtaYk8mf9PdC6vv-SBNecPRf6BJTrK1gy-Xp1Cu2Md-xNoOuxWtsX-w4rysoCVrBzy-UuF7u:1wFT4M:F4heCDuM3usdneg1irtX6m3pxVmraLpBNOsG_gfbDbI', '2026-04-22 08:41:26.747006+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('9nmvdhc9ja1945eww6z78pk376eb0nd9', '.eJxVj8tOBCEQRX_FsDYdmuY5O92b-AekoGAa7QHDw8QY_13GzMLZnnvvSdU3sTD6bkcL1SYkJ7KSx__MgX8P-RrgG-RzWXzJvSa3XCvLLW3LS8FwPN-6d4Id2j7XRprggZvIqcHNUY0rkzJyBCXQrdpRwTUwlEglCsEkVSFqGan328pDnNIO-8h2HnGGCnk6GWVy8hZaSyXb8oF_L-RxHPc0wwVm_wkvKafWK_RSH15Hgz7nB7Ruwff0mfoXOa1KSb0xJczPL5STXuc:1wFPMt:IhAvVR2rqTbuM5uBpam043y5_lXsyk1x9kqYuVSZsKM', '2026-04-22 04:44:19.683517+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('itcyy6cxx2bdvsqs84uodeaea5aes02p', '.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSurVKLr-_AKUm17j:1wFRAt:r5STu2mnD00vVfUx8pFfgIwJWv2v4Z2mj_ZUDijNTPw', '2026-04-22 06:40:03.385997+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('boon14eblz0f6ul5k5hhex2ntghrdgjf', '.eJxVj8tOBCEQRX_FsDYdmuY5O92b-AekoGAa7QHDw8QY_13GzMLZnnvvSdU3sTD6bkcL1SYkJ7KSx__MgX8P-RrgG-RzWXzJvSa3XCvLLW3LS8FwPN-6d4Id2j7XRprggZvIqcHNUY0rkzJyBCXQrdpRwTUwlEglCsEkVSFqGan328pDnNIO-8h2HnGGCnk6GWVy8hZaSyXb8oF_L-RxHPc0wwVm_wkvKafWK_RSH15Hgz7nB7Ruwff0mfoXOa1KSbMppsXPL5SgXuc:1wFqYn:JwPY4fSrY3s460QbBduVOR9gYJ-q0FZ2k7I7K8lI2Xk', '2026-04-23 09:46:25.607735+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('1jd0ylrdkfkfj5mewopuixyeqjqb27fi', '.eJxVj0tuAyEQRK8SsY5GwADDeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wt3oFYg6ArzpZqZFypIBAWiZZpS6XQwFEhVSglV3TxQatAnZuZ8GFIG2w9mXHEGQqk4eSUq8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jgy6L0zLUU1xuUjV7j:1wFPOQ:gAY4xhZ82j5wduhcwbHNx3mVR2aMM9Cp3vOL7uiJN7M', '2026-04-22 04:45:54.142124+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('8j56cnkuaoz6vi97icd9hdoxogjyogpn', '.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKSW1oLPi1xuUd17d:1wFRLg:K2YWkyOU9GZcZP3raH3jpdcVjroXp0JXR9BcQYt-JZM', '2026-04-22 06:51:12.938293+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('1wqzmmsrra6g776zt4oivcy3fhrt76bx', '.eJxVj8tOBCEQRX_FsDYdoOlqena6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5MsMf_zKJ79-ka0Bumc55cTq1EO10r0y2t00smfzzfuneCHes-1hts3qHaguIbzZZrEhIgKMJ1ISu05YvSKAmIAy2LBL76oCFw52ahfBjShntPZhxxxoJpOCWXMHj1tcacTP6gvxdSP457mvCCo_9El5hibQVbLg-vvWIb8wNrM-ha_Izti53EuoKeFXDx8wuUel7b:1wFPqb:PCJ1dM4MaoixBeGgladgXHl7EZIOrz5BAB-7GZlm1xM', '2026-04-22 05:15:01.661856+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('roi6ynkf4zjw2awy7joqexy965i58l7q', 'e30:1wIQOa:RZLQhC30Zi8EIhcbshWLeBM2Si04-_eVG9BBVRd64gU', '2026-04-30 12:26:32.679861+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('iz3p07j1jx36p2l28bi230ymuyijq5kl', 'e30:1wIOKl:eaEf0O05r1jOw5WWCFk7OCV7iXJqW_nSIh69CVMEZCI', '2026-04-30 10:14:27.786945+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('8tbyhke2slhssvtyw9o52n3tgvjnoznm', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtabMCMl_fgGUW17a:1wGBfw:FU_H4xMX5gghPnU0z2p7Q3qmjdPkmxmwLkopquyeMbU', '2026-04-24 08:19:12.817616+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('7ulqe6ber61xeiiq39kfzxu48rczoqe7', '.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFKUaS3Y5QqUZl7c:1wGBmD:en6EG_cLedDpNauEhGURQmPaxSA85pv99kY3c14Aby8', '2026-04-24 08:25:41.212512+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('os41vfmq43as9vtdio9qowzgrbrsl6ks', '.eJxVj81OQyEQhV_FsDY3QIEL3enepG9ABgZ60Vsw_DQxxneXmi7s9jvnfJn5JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zbZQJHoSJgho8OKqRcaWiQFglOqYdlUIDR4VUoZRc0TVErSL1_sBEiFPaYRvZziPOUCFPJ6dcTd5Ca6lkWz7x74U89v2RZrjA7L_gJeXUeoVe6tNpNOhzvkPrFnxP19S_yJGtqzJGM7n-_AKUwF7s:1wG6Ob:N2daZfr0YnRbV9NwLFpzIkJNjLlIK2vhYdRlUUSw0BY', '2026-04-24 02:40:57.412578+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('er1rkvps4wylqv8fija3ouzbejrttt23', '.eJxVj8tOBCEQRX_FsDYdoGnonp3uTfwDUlAwjfYUhoeJMf67jJmFsz333pOqb2aht932GopNyE5MsMf_zIF_D3QN8A3onCefqZXkpmtluqV1eskYjudb906wQ93HetNb8KC2qPiGs-MrCql1VAhmQSdWxxe1gkSNXOOySM1NiKuO3PtZqBCHtMHeyY4jzlCAhlNyqQevodaUyeYP_HuB-nHcU4ILjP4TXhKl2gq0XB5ee4U25gfUZsG39JnaFzsJY8xslOLq5xeUdV7c:1wHgH6:IDnRr7ey38dEFEdNyJnlmOrOmdt-V6zpnOz34987WTs', '2026-04-28 11:11:44.621348+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ifltd8pya844twv9rj7bds0cwbo1w14y', '.eJxVj8tOBCEQRX_FsDYdoOnqZna6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5MsMf_zKJ79-ka0Bumc55cTq1EO10r0y2t00smfzzfuneCHes-1hq0d6h0UFzTbPlGQgIERbguZMVm-aI2lATEgZZFAl992CBw52ahfBjShntPZhxxxoJpOCWXMHj1tcacTP6gvxdSP457mvCCo_9El5hibQVbLg-vvWIb8wNrM-ha_Izti53EuoKeteTi5xeUil7d:1wFr3h:cSMFzy9KCk3bZAhFFteHN6AO82zCdWgzBuZhjJYUpcw', '2026-04-23 10:18:21.183245+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('6glhq7395kzqzmy9pnmowqmm3lovpkar', '.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSlEqVqN_fgGUVV7e:1wG81G:fyhS-uhAr9zBbVAKTqHNAxEDIMMgGEbaMLMXfQjjklg', '2026-04-24 04:24:58.638349+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ytmxlqr5sgl6e5toq5ucf9f6ka4pvv10', '.eJxVj0tuAyEQRK8SsY5GgIEZvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtVbaOxA6CKpxZ-mCjCsVBMIs0bLFUikW4KiQKpSSKzr7sKhAndsx4cOQNlh7MuOIIxRIw8kpV4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzeVZaa8nl5QqUyF7s:1wG6kf:cjKYIl-HG97BIct0Co0omZwysC-kc7bwCPj-3mXnHjI', '2026-04-24 03:03:45.451381+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('h45axjy74zapc9zd5ur5zrnq5gz3untc', '.eJxVj0tOAzEQRK-CvEajHsefmexgj5QbWG23nTFMbORPJIS4Ow7KgmxfVT11fzODvW2mV19MJHZkM3v-zyy6D59uAb1jOufJ5dRKtNOtMt3TOr1l8vvrvfsg2LBuY72q1TsUaxCw0sHCQjNXKghCLcnOiwUpFuSkCBRJyRVoHxYVwLnDLHwY0oZbT2YcccaCaTg5cDV49bXGnEz-pL8XUt_3R5rwgqP_QpeYYm0FWy5Pp16xjfmOtRl0LV5j-2LHWWsNIEHpn1-UQ17Y:1wG8C3:iwoJQT8n1iHA3FVi4P7_i13_ZP6qqYVuylm6Q5Q3HBo', '2026-04-24 04:36:07.797074+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('cdd59cw7vidi6hlc322tbyca3hrtpvwp', '.eJxVj8tOBCEQRX_FsDYdoGnonp3uTfwDUlAwjfYUhoeJMf67jJmFsz333pOqb2aht932GopNyE5MsMf_zIF_D3QN8A3onCefqZXkpmtluqV1eskYjudb906wQ93HetNb8KC2qPiGs-MrCql1VAhmQSdWxxe1gkSNXOOySM1NiKuO3PtZqBCHtMHeyY4jzlCAhlNyqQevodaUyeYP_HuB-nHcU4ILjP4TXhKl2gq0XB5ee4U25gfUZsG39JnaFzsJYwwXs5Ti5xeUL17P:1wGAJZ:hweoDaRUWXLF46KbiNDE0yR0JSbXDNUarmOy3CV8z60', '2026-04-24 06:52:01.824094+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('at67vxvpa03gvxqcm2gjt8hjdvazg8iz', '.eJxVj0tuAyEQRK8SsY5GDGZ6wLtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkM3v-zyy6D59uAb1jOufJ5dRKtNOtMt3TOr1l8vvrvfsg2LBuY61Be4dSB8k1HSxXNAuAIAnXheysLF-kQkFAHGhZBPDVBwWBO3eYpQ9D2nDryYwjzlgwDafgAgavvtaYk8mf9PdC6vv-SBNecPRf6BJTrK1gy-Xp1Cu2Md-xNoOuxWtsX-w4rytoDVKpn1-UzV7x:1wG5xg:X_bAov0Nu7ISpDYcqnBVRGUmLEgR7rct4wshCBCU2n0', '2026-04-24 02:13:08.894734+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('q1vlpznaqpjflfzhxt1ptzvzzktegv50', '.eJxVj0tuAyEQRK8SsY5GwDAweGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUbay21dyB0EFTjbOmKjEsZBIJa0LLV0kWswFEilbgsXFLlwyoDdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaUom6XW1xuUZF7i:1wGARI:Uj7wqKcH04BcpD1cp6vXwoTGiBTfAxxHub5qtF3WC94', '2026-04-24 07:00:00.042269+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('fd4vtymi10zgciahe5au7ccee1ptkfsa', '.eJxVj0FuwyAQRa9Ssa4sIBib7Np9pdwADQzEtA5UMESqqt69pMqi2b7__9PMN7PQabO9hWoTsiMT7Pk_c-A_Qr4F-A75XCZfMtXkpltluqdteisY9td790GwQdvG2mgTPCgTFTd4cHxFIbWOCmGZ0YnV8VmtIFEj1zjPUvMlxFVH7v1BqBCHlGDr2Y4jzlAhD6fkUg_eQmupZFs-8e-F3Pf9kWa4wOi_4CXl1KgClfp06g1ozHdoZMFTuib6YkexLNoYZaT4-QWUt17n:1wG5YP:n-W8KH_lPpfhmbEmKP7gxPZI3oL7En1_25vZbBBzviE', '2026-04-24 01:47:01.582488+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ire9l3cqx67r00d4vehgchtbdnhrwqk3', '.eJxVj8tuwyAQRX-lYl1ZQPBgZ9fuK-UP0MBATOtAxSNSVfXfS6osmlme-9Dcb2awt8306ouJxI5MsOf_zKL78Okm0Dumc55cTq1EO90s012t01smv7_evQ8FG9ZtpFdYvUO1BsVXOli-kJAAQRHqmaxYLJ_VgpKAONA8S-DahwUCd-4glA-jtOHWkxlPnLFgGp2SSxi8-lpjTiZ_0t-E1Pf9kSa84PC_0CWmWFvBlsvTqVdsI75jbQZdi9fYvthRaK35OICfX5QoXtI:1wG6tO:giAQiqn9KpBVuVOamPm7nrT8SGxuRp3MR3FveSMlIr4', '2026-04-24 03:12:46.058164+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('xsybn0k4j0vmudi6keix35zyslgu7s0d', '.eJxVj81OAyEUhV_FsDYToAwzdKd7k74BuXChg04vhp8mxvjuUtOF3X7nJ-d8Mwu9bbbXUGxCdmSCPf9nDvxHoJuA70DnPPlMrSQ33SzTXa3TW8awv969DwUb1G2kjTbBgzJRcYMHx1cUUuuoEJYZnVgdn9UKEjVyjfMsNV9CXHXk3h-ECnGUNtg62THiDAVodEou9eA11Joy2fyJfxeo7_sjJbjA8L_gJVGqrUDL5enUK7QR36E2C76la2pf7CiWRRslxoKfX5SEXuA:1wFrfC:QrZ64i7rHML5vG5aKdjCpvi6ggmR9vMtaKL4md3WDnk', '2026-04-23 10:57:06.142176+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('e3b8txjo714pdk78hc3r7n2kx6gosnrf', '.eJxVj0FOBCEQRa9iWJsO0DTdzE73Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sjTbBgzJRcYOz4xsKqXVUCOuCTmyOL2oDiRq5xmWRmq8hbjpy72ehQhzSBnvPdhxxhgp5OCWXenAKRKlkWz7w74Xcj-OeZrjA6D_hJeVErUIr9eG1E7QxP4CaBd_SZ2pf7CTWVRslZ8N_fgGUil7g:1wFrt8:_Gvf5EaGvmQ6lR6jwfCpNJ9ptPcWWZDiMQuyeqJqVIs', '2026-04-23 11:11:30.236769+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('mld45zs0asd8vma0dnw9jzbfz6ww98zb', '.eJxVj0tuAyEQRK8SsY5GgPkM3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtVEmeBAmCmrw4OiKjCsVBYKW6NjqqBQrcFRIFUrJFdUhripS7w9MhDilHbaR7TziDBXydHLK1eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZ1soYqbT--QWUy17w:1wG5kb:8mo0_ZZZqdrWFHQINVUaF3vm10u0H66Xw3zzI_f2-Gc', '2026-04-24 01:59:37.160323+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('jiv1jzpck336rk4daux0awgm6kn4gxdg', '.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa0pU1KIyxWUVl7a:1wGBBB:jWL2cBGVULVeWfzpmEqnICPwIInJrkMUDiEslFNMo2U', '2026-04-24 07:47:25.033522+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('9bxw8zjtza3qmg5n94va3e0ejm9iy3jv', '.eJxVj0FuwyAQRa9Ssa4sIBjs7Np9pdwADQzEtA5UDESqqt69pMqi2b7__9PMN7PQ22Y7hWoTsiMT7Pk_c-A_Qr4F-A75XCZfcqvJTbfKdE9peisY9td790GwAW1jveo1eFBrVHzFg-MLCql1VAhmRicWx2e1gESNXOM8S81NiIuO3PuDUCEOaYOtZzuOOEOFPJySSz04BaJUsi2f-PdC7vv-SDNcYPRf8JJyolahlfp06gRtzHegZsG3dE3tix2FMYYLo436-QWUaF7f:1wGBTO:Onbc_n8C34yEbzK1XZFfqYJh442fYDsUjP6uvK3EgLw', '2026-04-24 08:06:14.854106+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('a1r718qnt0iq9cn4cr6bk5x1sxnhwacg', '.eJxVj0tuAyEQRK8SsY5GDQZmxrtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZknD3_Zxbdh0-3gN4xnfPkcmol2ulWme5pnd4y-f313n0QbFi3sV716h3KNUhY6WBhIS60DpJwVmT5YkHJBQVpAk1KCQ2zD4sO4NyBSx-GtOHWkxlHnLFgGk4BQg9efa0xJ5M_6e-F1Pf9kSa84Oi_0CWmWFvBlsvTqVdsY75jbQZdi9fYvtiRz_MMAErwn1-UJl7O:1wG70j:RZ_aLNdO2gWv5PMH7lAXfI8saWwBaLGfifrATdHP37A', '2026-04-24 03:20:21.819865+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('wmo5bpzfvme48emdmb5egasg17nr7900', 'e30:1wJhyt:vqrIod9CI0m1fbk2mfM8-Bq1ebjPQoEOEmQf5WxUWyw', '2026-05-04 01:25:19.077669+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('7kh8olohe20u7doo7by9wbzi4szlkwt7', 'e30:1wK6OJ:yQ-zyve7B_eJ5OxfonrP43ak7ISkARuY3djljIq_Wcg', '2026-05-05 03:29:11.947257+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('df7yd575wi7y5977harwzw2hmahxxrdv', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01lyqVZifX5R8XuI:1wHBYy:qhNFt0D4QmqWCPuKyd4PeUaNA-5JxNVQU7lwi0VWaQ8', '2026-04-27 02:24:08.153897+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('eyv3zuhdxpta53md3m0qjs0ngoiveo9h', '.eJxVj0tuAyEQRK8SsY5GgJlmxrtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkgj3_Zxbdh0-3gN4xnfPkcmol2ulWme5pnd4y-f313n0QbFi3sV5h9Q7VGhRf6WD5QkICBEWoZ7JisXxWC0oC4kDzLIFrHxYI3LmDUD4MacOtJzOOOGPBNJySSxi8-lpjTiZ_0t8Lqe_7I014wdF_oUtMsbaCLZenU6_YxnzH2gy6Fq-xfbGj0FpzKQDEzy-UR17W:1wGCVh:X4ZiC4XIAp_vbtuQvrjxHkfS0So3OwY_J_a0uto-4C4', '2026-04-24 09:12:41.611433+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('h88ozbh1owmx794zctep280et6fwonkl', 'e30:1wIR8M:ISdUed5aEy2XCbnW8XEIJZO8wphbIw5uceJk9lMuc3A', '2026-04-30 13:13:50.507631+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('l1o9ddzifb6083esziavdsvqcq91ci7m', '.eJxVj0luAyEQRa8SsY5agBm6vUv2kXwDVFDgJmlDxGApinx3Y8sLe_v-UPX_iYHeVtOrLyYi2RNG3p-ZBffj003Ab0jHPLmcWol2ulmmh1qnr4x--3x4XwpWqOtIL2rxDsQSBF1wZ-mMjCsVBIKWaNlsqRQzcFRIFUrJFdU-zCpQ53ZM-DBKG6w9mfHEEQqk0ckpV4NXX2vMyeRfvE9IfdteaYITDP8HnmKKtRVoubwdeoU24hvUZsC1eI7tj-yZ1npcF1RerpRWXtc:1wHCcP:ZFIqpSm-hSHbM_IYlOylT0IB7ouBlI_ex5OzvjJvxIc', '2026-04-27 03:31:45.544598+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('btk8a77gmjggdhozq9bevonvmioe23s4', '.eJxVj8tuwyAQRX-lYl1ZQDDg7JJ9pf4BGhiIaR2oeFSqqvx7cJVFsz33MXN_iYHeVtOrLyYiORJGXv8zC-7Tp13AD0iXPLmcWol22i3TQ63TW0a_nR_ep4IV6jrSi1y8A7EEQRc8WKqRcSmDQFAzWqYtnYUGjhKpxHnmkioftAzUuQMTPozSBmtPZjxxgQJpdHLK5eDV1xpzMvkL_yakvm3PNMEVhv-E15hibQVaLi_vvUIb8Q1qM-Ba_I7thxyZUmq_ruXtDpR8XuM:1wHCiY:srX_VLSILyhWcEsw2Rjpk-eJgUSFadWPtu3PGFP813o', '2026-04-27 03:38:06.986659+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('mnb9133804jx36pc5128l75q46l01dk3', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtaacayN_fgGUXl7e:1wGCnp:ITvPDcd9YZ0PfhzJFqZyRZ-myQ4-u9fOlihRKkKbfN8', '2026-04-24 09:31:25.136169+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('nhx0ay13741fr4v1r9yvme0e7xb64eoj', '.eJxVj0tuAyEQRK8SsY5GgBmY8S7ZR_INUEODh2TcRHwsRVHuHhx5EW9fVT11fzMLvW2211BsQnZkgj3_Zw78R6BbgO9A5zz5TK0kN90q0z2t01vGsL_euw-CDeo21qtegwe1RsVXPDi-oJBaR4VgZnRicXxWC0jUyDXOs9TchLjoyL0_CBXikDbYOtlxxBkK0HBKLvXgNdSaMtn8iX8vUN_3R0pwgdF_wUuiVFuBlsvTqVdoY75DbRZ8S9fUvthRGGO4VIqrn1-UQl7U:1wGDDw:bbmmta1gV9s7tl_ZjbRPUGkoZQAroE8qL2v9iN7lHro', '2026-04-24 09:58:24.806208+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('nqhdemhxz86sgxe1cob1avxnioo7lc40', '.eJxVj0tuAyEQRK8SsY5GDIZmxrtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkM3v-zyy6D59uAb1jOufJ5dRKtNOtMt3TOr1l8vvrvfsg2LBuY73C6h3KNUi-0sHyhWYBECShVmTnxXIlFxQExIGUEsC1DwsE7txhlj4MacOtJzOOOGPBNJyCCxi8-lpjTiZ_0t8Lqe_7I014wdF_oUtMsbaCLZenU6_YxnzH2gy6Fq-xfbHjrLUWSgOHn1-UfV7g:1wHBtG:zXAwuVsvrcMIEkNv___ojUIS2IZ-AsUMHUtrGEHRXgo', '2026-04-27 02:45:06.510077+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('a50sp9k5a82v8u0ts6m8k5rvs9f8jl23', '.eJxVj8tqAyEYhV-luC6DOo6O2SX7Qt9Afv01YzvR4qVQSt49pmTRbL9z4ZxfYqC3zfTqi4lIDoSR1__Mgvv06S7gB6RznlxOrUQ73S3TQ63TW0a_nx7ep4IN6jbSWmrvQOggqMbZ0hUZlzIIBLWgZauli1iBo0QqcVm4pMqHVQbq3MyED6O0wdaTGSPOUCCNTk65HLz6WmNOJn_h34XU9_2ZJrjA8B_xElOsrUDL5eW9V2gjvkNtBlyL37H9kANTSo1ldNbXG5R1XuA:1wHE5H:JYuQuAUCU7Qjg62ARnqkVlpboHBfPeb1x1qw-qz33a4', '2026-04-27 05:05:39.210169+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('2dk3s95hzh7rk0vbhg2lgzdxcw2kxtrv', '.eJxVj0tuAyEQRK8SsY5GwDAweGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUbay21dyB0EFTjbOmKjEsZBIJa0LLV0kWswFEilbgsXFLlwyoDdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaUo00rO1xuUcV7g:1wGC15:mY6EG_pM_FEdIqiZfdelWNJO4FftJmgftVWgQjeWyHc', '2026-04-24 08:41:03.523149+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('s6glrobu7qoc3xyb5bwmmdwp4km44gm7', '.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa25YpzJyxWUVl7X:1wHCpU:wuNqg-IUSWndvZcyDIFfzJNX3PjaxF7a0cubxCDvfhU', '2026-04-27 03:45:16.01139+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('9sxzxzddcv68lse3k7x26alqq8zuhtbz', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemteZKCyN_fgGUkV7m:1wHESc:f69TDPQsXIGIz_JqBkqI8yRWE3iOA2gShFekUsRYQEc', '2026-04-27 05:29:46.076687+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('p3a4gap66kw8hpffvvus7tg1a9j1t1ce', '.eJxVj0tuAyEQRK8SsY5GgBkYvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtZbaOxA6CKpxZ-mCjEsZBIKa0bLF0lkswFEilTjPXFLlwyIDdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJcci3Y5QqUeF7e:1wHDHJ:iEj9eANZncQW-XwU6PqlHEwFovUBJlC5eg2v6AGxDz0', '2026-04-27 04:14:01.763218+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('m4aqxiiiketist31sr1wgflfrakkuzu8', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01lyaVdCfX5R2Xtw:1wHC56:zxqK1ytUcXzbnaowaHIlYV_NYwu0YdUeifcSobb4GhA', '2026-04-27 02:57:20.788807+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('7135ppr0xr0r64e5awubdzm2fukuxr4g', '.eJxVj0FOBCEQRa9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sN70FD2qLim84O76ikFpHhWAWdGJ1fFErSNTINS6L1NyEuOrIvZ-FCnFIG-w923HEGSrk4ZRc6sEpEKWSbfnAvxdyP457muECo_-El5QTtQqt1IfXTtDG_ABqFnxLn6l9sZMwxgzvrOafX5RSXtg:1wGDjD:nhn3uSWUfsZ68Na0LxIPOJWpDRWiqRR3-iQQIdFeGy4', '2026-04-24 10:30:43.786428+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('3142ldbde32pv1w9oqy7q1bptuautszx', '.eJxVj8tOBCEQRX_FsDYdmqYLena6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5sZo__mUX37tM1oDdM5zy5nFqJdrpWpltap5dM_ni-de8EO9Z9rDfYvEO5Bck3WizXNAuAIAnVSnbWlq9SoyAgDrSuArjyQUPgzi2z9GFIG-49mXHEGQum4RRcwODV1xpzMvmD_l5I_TjuacILjv4TXWKKtRVsuTy89optzA-szaBr8TO2L3aalVIC5KLh5xeUgF7j:1wHDec:WIg_mQroya3OxnwrRLHmqpWD9YubieKA1NPWeP7GwX0', '2026-04-27 04:38:06.8559+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('sa0z5orl3aa7jqfq4wxrbryf7z8sczng', '.eJxVj0tuAyEQRK8SsY5GwDAweGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUbay21dyB0EFTjbOmKjEsZBIJa0LLV0kWswFEilbgsXFLlwyoDdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaW41DNn1xuUfV7d:1wHEwE:sXIrkju3GyWfloKePA_2D54ETR_pXA1Z1zWrYNtPHl0', '2026-04-27 06:00:22.158225+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ykj4x8kc2iz32e6exjiktkbnajcqx6vm', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtebSaKl_fgGUl17o:1wHCBp:A2gbIkKQvt7YCGnS74PDlU0EytHA7ljTq4fM7rauElc', '2026-04-27 03:04:17.322522+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('7ssgkwesh6tkgjgvdlt14xbipirjag07', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemteaaSWl-fgGUel7i:1wHFWJ:HdSZ57nHZivDE2ibjRSVFOJyzr5lLeuVVVIznjRpKZo', '2026-04-27 06:37:39.097162+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ii0hj6x53kxngjx43mrf7fugkgui1bbq', '.eJxVj0tuAyEQRK8SsY5GgBk-3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtZEmeBAmCmrw4KhGxqWMAkGt6Jh2dBUaOEqkEteVS6pC1DJS7w9MhDilHbaR7TziDBXydHLK5eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZUoorpo36-QWUkF7o:1wHFbl:aZOYrzWD6jFUHllFeKTXGtiIIW9GbiwQoa5pEVILzPA', '2026-04-27 06:43:17.977801+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('c2whbx49bck0h4nm1o1019proaqe4akm', 'e30:1wJia0:ooFLAx766wReWTqNzsf8ZPXOK8V-CWEWh1bu4fQwkTw', '2026-05-04 02:03:40.152569+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('gv9v8ienyucryca55tz6ji2fd0mycvzn', 'e30:1wKS6n:HtsXkKvVNn9vIRPsbBoTNJnZeh4IOGczHxeIrormIXw', '2026-05-06 02:40:33.914701+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('c79hlkuo0w16f5tswooeyfd9tm07c7f9', '.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa25lkLLyxWUil7k:1wHGXT:jcnwCAjIK1aoqEsvRIUYZGvMckvumtRNf5S1qpQGqaY', '2026-04-27 07:42:55.864555+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('xxr6ip2d5pa9yfy7bm86gm0keu2rtk9v', 'e30:1wJikM:RCRcV3AsXZoDl-TZhZw1OL1XhXuT9ijKuHAx7OVW-p4', '2026-05-04 02:14:22.177115+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('fsfdcvmilpuob701jf3bm8ioo3jxokga', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01lxLw9efX5SHXuE:1wHGd5:QTh3W_NsM9kz2Z8gqjkhL7-umxCpdQq6XP2AirMjBqc', '2026-04-27 07:48:43.849013+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('22zb4iqleaqej7042o3xo0wjyc1tgxmh', 'e30:1wJj1C:0RxAoadKPeQHgcfC-GODs7nN612EeH8-F3NDrnZI6Ss', '2026-05-04 02:31:46.051181+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('uslcgw551qrfrbmdb5zvja0qwdcc3vu1', '.eJxVj0FOBCEQRa9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sN70FD2qLim84O76ikFpHhWAWdGJ1fFErSNTINS6L1NyEuOrIvZ-FCnFIG-w923HEGSrk4ZRc6sEpEKWSbfnAvxdyP457muECo_-El5QTtQqt1IfXTtDG_ABqFnxLn6l9sZMwxsyGc2F-fgGUWl7Y:1wHf8L:IXu46R_PVm44u1HMx4T2i8s0bN9b1RfvtPobjONwfY8', '2026-04-28 09:58:37.185802+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('00xdgmndehf00ikucozziu4b40635fjl', '.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa25VlyKyxWUf17g:1wHGk2:gbeaWBv4m8islN5xurczcsovnb6N5NPWhlb4eTiWAbY', '2026-04-27 07:55:54.447604+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('yixjlxabzto10h3ya1tqz5kwd1v9h8ow', 'e30:1wJjkw:PbLkUM9kMJ1vdvkVUb8QR-7JRfnOLSiyJvszFwsoO44', '2026-05-04 03:19:02.056261+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('u34i14c75sg7wye0k4oa979fxx3vt0bh', 'e30:1wJlgA:pGCCiKOKD7ZNUnuX4C6DekdZhDmNTGZbTj7ZKNByem8', '2026-05-04 05:22:14.078342+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('cj2ytd52vfb77cely0nar62jna2iytrd', '.eJxVj0tuAyEQRK8SsY5GgBkYvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtZbaOxA6CKpxZ-mCjEsZBIKa0bLF0lkswFEilTjPXFLlwyIDdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJcSSX05QqUml7p:1wHGs1:koIaELNCb2jorB2llwqNOLnfjcubZxtkZSLjvqZeKiM', '2026-04-27 08:04:09.655811+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('imfvyrjllztenobur1u045g9kxeliwxl', '.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJcaUrZ5QqUbF7Y:1wHHCD:Kr0kYPw7MTPMlEKVSZZOnFGU9xvo3l7fQ4OcgPYBvyA', '2026-04-27 08:25:01.079694+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('1naydlhs7gstlm0f4pqdqksckv1z4dex', '.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSq1i1dr8_AKUkF7p:1wHYKv:hElrl1JraISls-OYVtpco_CjzCaAKO-FmFgRmYtw5q8', '2026-04-28 02:43:09.873291+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('0b2usa644vzwtdvpghnucq2s1yev659s', '.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSnG1aml-fgGUlV7p:1wHG7Z:8KPDgMhmvinUz8RsflhJtxk4Ci8NsbBtlrWqYkOOTBo', '2026-04-27 07:16:09.400398+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('34j2tvpsor2248crfh36e545e96thqvr', '.eJxVj0FOBCEQRa9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sN70FD2qLim84O76ikFpHhWAWdGJ1fFErSNTINS6L1NyEuOrIvZ-FCnFIG-w923HEGSrk4ZRc6sEpEKWSbfnAvxdyP457muECo_-El5QTtQqt1IfXTtDG_ABqFnxLn6l9sZMwxsxKzZr__AKUaV7a:1wHYSW:lMlvu5RUqDs5fXJEq8vzXfaoAccpbJreqpajYaC64eo', '2026-04-28 02:51:00.717278+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('tfldrsl7rze1iw6d4474rjsihez3cqmr', '.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaW4ZmwW1xuUYl7Z:1wHI0k:pjBiXkPmNB67iXUPlNTiQMaIY3ajVpoi3im8cAiLBqU', '2026-04-27 09:17:14.37545+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('mbl7cangqxn1u8uenc235sbokv0qy4eq', '.eJxVj0FOBCEQRa9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sN70FD2qLim84O76ikFpHhWAWdGJ1fFErSNTINS6L1NyEuOrIvZ-FCnFIG-w923HEGSrk4ZRc6sEpEKWSbfnAvxdyP457muECo_-El5QTtQqt1IfXTtDG_ABqFnxLn6l9sZMwxsxKSqF-fgGUVF7W:1wHXtu:qoOFiYgPAXIDYhY6NZodM1mWG_aHr08Wv9V6Dcw_So4', '2026-04-28 02:15:14.83819+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('popk3nklvekkyqhh3pva1wvca4hobrxf', '.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSnG9amZ-fgGUjF7l:1wHIi3:t0pKK0Vh7H7WZoTF28zpDq4fRTbjOet_dZxBwbBwzho', '2026-04-27 10:01:59.298304+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('pk0nqycb847amwk15wnnji7e2qvkjgfj', '.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJcC6XF5QqUmF7n:1wHIxc:qqJdVeGWeu8V1D0RCthsZHqqHyQuhxGDsMLUV8fHP1g', '2026-04-27 10:18:04.660971+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('adxjv9j2aa4kw18ctp8q77bwwixron3m', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01quSgpmfX5R_XuE:1wHdwA:MzEszg6Icvw2-tXQp0LwDSDdJw-Q8pt_o0t37kIlzQ0', '2026-04-28 08:41:58.350483+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('5xzq44gax05mmgj195vqes4f6qfl62sb', '.eJxVj01OBCEQha9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk4qd33flLvm1nobbedQrUJ2YkJ9vifOfDvIV8FfIN8LpMvudXkpqtluqk0vRQMx_PNe1ewA-0jvekteFBbVHzD2fEVhdQ6KgSzoBOr44taQaJGrnFZpOYmxFVH7v0sVIijtMHesx1PnKFCHp2SSz04BaJUsi0f-Dch9-O4pxkuMPxPeEk5UavQSn147QRtxA-gZsG39JnaFzsJY8w8TomfX5SCXt8:1wHg6P:id5PdiGFuNsn-_jA7Xgu5cSC4kTPRRT1jjVWA4vyAmk', '2026-04-28 11:00:41.98458+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('gh6a14j7af9qeoi1fk41otldcylniha5', '.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSq2KacN_fgGUjV7k:1wHfca:CUafORlX360L8r72ImuwjroGAT8F8FQ6BonDgloW3ZY', '2026-04-28 10:29:52.442204+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('fblki3vqo86ixe5jn6owm7w14ebhb5ql', '.eJxVj8tOBCEQRX_FsDYdmoaie3a6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5sZo__mUX37tM1oDdM5zy5nFqJdrpWpltap5dM_ni-de8EO9Z9rDfYvEO5Bck3WixfaRYAQRJqRXZeLVdyRUFAHEgpAVz7sELgzi2z9GFIG-49mXHEGQum4RRcwODV1xpzMvmD_l5I_TjuacILjv4TXWKKtRVsuTy89optzA-szaBr8TO2L3aatdYLaNDq5xeUnV7o:1wHeWZ:hqgdnQzMza9CMWRVFpnBtbJ_KlKnOpasqHLH-bRr1sc', '2026-04-28 09:19:35.15349+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ppslereh6xdxzcgzmi7f9eho0ibca3am', '.eJxVj8tOBCEQRX_FsDYdXg3N7HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2ujTLBgzRRUoPC0Q0ZVypKBL2iY5ujq9yAo0KqcF25ojrETUXqvWAyxCntsI9s5xFnqJCnk1OuJm-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRPTWgtlhFA_v5SRXuQ:1wHexM:1xMJuGxSbBSyNAFrV-wLM9wDrohcdr5h7AYtnDiJ7vw', '2026-04-28 09:47:16.996035+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('i8x2g8h91la0t7a2prwjayhzarxlk08f', 'e30:1wJmcf:46cDcd9pRT671JnXrZbPr8KApi67EHCRtZK8Y3G2z-c', '2026-05-04 06:22:41.070028+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('74ezmonepn0w7a7d2khbdj468chjbayb', 'e30:1wJoEy:WJ_97O9KjK5wcdXc3oGUKb5FRugWJZEg3WYfAAn-A4A', '2026-05-04 08:06:20.995064+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('mdtxu62j9n4d2nqxz65w7v0rt56tawgg', '.eJxVj0luAyEQRa8SsY5agBm6vUv2kXwDVFDgJmlDxGApinx3Y8sLe_v-UPX_iYHeVtOrLyYi2RNG3p-ZBffj003Ab0jHPLmcWol2ulmmh1qnr4x--3x4XwpWqOtIL2rxDsQSBF1wZ-mMjCsVBIKWaNlsqRQzcFRIFUrJFdU-zCpQ53ZM-DBKG6w9mfHEEQqk0ckpV4NXX2vMyeRfvE9IfdteaYITDP8HnmKKtRVoubwdeoU24hvUZsC1eI7tj-yZ1nqcl1JdrpSGXuM:1wIJrA:fIcLlOSbFAcd7ZmzO-dCdq5boCZO69z15TGdXO4Pwqs', '2026-04-30 05:27:36.453217+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('3c451xsqwsuoog1ba610o85pwzujo0fj', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZZcamV-fgGUkF7n:1wIJeS:zPnZmHkjD2V1Kf-wHCAMkC7J5u8-kErvdSUZBPtaruU', '2026-04-30 05:14:28.338986+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('5xwf71b5p8tu5cgtskd768fipymkyf7m', '.eJxVj8tOBCEQRX_FsDYdmuY5O92b-AekoGAa7QHDw8QY_13GzMLZnnvvSdU3sTD6bkcL1SYkJ7KSx__MgX8P-RrgG-RzWXzJvSa3XCvLLW3LS8FwPN-6d4Id2j7XRprggZvIqcHNUY0rkzJyBCXQrdpRwTUwlEglCsEkVSFqGan328pDnNIO-8h2HnGGCnk6GWVy8hZaSyXb8oF_L-RxHPc0wwVm_wkvKafWK_RSH15Hgz7nB7Ruwff0mfoXOa1KKbHpzdCfX5SOXuI:1wIMw3:9NdbcEoUGgMEacp_4fOko8CJaBRZhIND4KEI6H6YIjQ', '2026-04-30 08:44:51.198515+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('rjtkt8nq7kllnhkgmi6qszym4cze9boe', '.eJxVj0tuAyEQRK8SsY5GwPCZ8c7eR8oNUEODh2QMEZ9IUeS7G0dexNtXVU_dv8RAb5vp1RcTkRwII6__mQX36dM9wA9I5zy5nFqJdrpXpkdap7eMfj89uk-CDeo21qtavQOxBkFXnC1dkHGlgkDQEi1bLJViAY4KqUIpuaLah0UF6tzMhA9D2mDryYwjzlAgDSenXA1efa0xJ5O_8O-F1Pf9mSa4wOgf8RJTrK1Ay-XlvVdoY75DbQZci9-x_ZAD01rLmSsprzeUel7g:1wILRX:c_OwOfJVXP6rpepvfBiSgLc6szCzzyBNIFShLYRiNQc', '2026-04-30 07:09:15.087884+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('lztro8weyn2wjyxh3qsua0gdp9sdbhxq', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZaCG8V_fgGUhV7h:1wIO6A:4RCbQCF_kHsVoPp2S0mZ1uaUC33VpCH5il4yy9NPz8g', '2026-04-30 09:59:22.083387+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('asasn4khuqu9y3hun14838jcilsnpmco', '.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa2loEKyyxWUZl7Z:1wINTH:UFESLRmXCSySAuOV8TgwPKq6ow9DDfjTTFNUvpU-2TU', '2026-04-30 09:19:11.917419+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('08wq6owzux3wtyp0ubpl795y377q1bdh', '.eJxVj0tuAyEQRK8SsY5GwPCZ8c7eR8oNUEODh2QMEZ9IUeS7G0dexNtXVU_dv8RAb5vp1RcTkRwII6__mQX36dM9wA9I5zy5nFqJdrpXpkdap7eMfj89uk-CDeo21qtavQOxBkFXnC1dkHGlgkDQEi1bLJViAY4KqUIpuaLah0UF6tzMhA9D2mDryYwjzlAgDSenXA1efa0xJ5O_8O-F1Pf9mSa4wOgf8RJTrK1Ay-XlvVdoY75DbQZci9-x_ZAD01pLMc9cXW-Ucl7d:1wIODe:VK_bFCtafIXIorAIquhvnLlquyiUcemCSeIAYj7XvK0', '2026-04-30 10:07:06.186037+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('po5t82sxv57sbrvtkcal78es69i1q0nv', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZZSUG1-fgGUhF7j:1wIR14:-5t5b8gR0YLZ2z07vDxnPSWne8cchSmCXx8KczIL7mo', '2026-04-30 13:06:18.193479+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('5tqvm8sdti98q2lbr3id48r6t5co4e51', '.eJxVj0tuAyEQRK8SsY5GgPkM3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtVEmeBAmCmrw4OiKjCsVBYKW6NjqqBQrcFRIFUrJFdUhripS7w9MhDilHbaR7TziDBXydHLK1eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZ1loKaRj9-QWUhV7e:1wIOtK:BshtfQOnf-Wnh-I1dE2VrGBs2DnPL7iqUIUwvXNcs9o', '2026-04-30 10:50:10.660924+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('9hoba1rcuaqf933imceldghmsdvouixd', '.eJxVj0luAyEQRa8SsY5agBm6vUv2kXwDVFDgJmlDxGApinx3Y8sLe1Gb9wfV_ycGeltNr76YiGRPGHl_Zhbcj083Ab8hHfPkcmol2ulmmR5qnb4y-u3z4X0pWKGuI72oxTsQSxB0wZ2lMzKuVBAIWqJls6VSzMBRIVUoJVdU-zCrQJ3bMeHDKG2w9mTGE0cokEYnp1wNXn2tMSeTf_E-IfVte6UJTjD8H3iKKdZWoOXydugV2ohvUJsB1-I5tj-yZ1prKcbRyxWUk17i:1wIPN0:G2HAlDrTm2fMb2AAz2_wxah1dAqYQJOJui-T0qt60n0', '2026-04-30 11:20:50.622509+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('m70emo38un9m2agvu15digw6c3f495cb', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZZSGaF_fgGUo17p:1wIRjj:o_mKoOnfOYxLe97x9Edbh880rKHso-0TMDt5yrte-Go', '2026-04-30 13:52:27.977486+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('lferf9l7szsqz4s9dh2g9zlriwrytxhk', '.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa2l1EzRyxWUhF7e:1wIRom:VrZkz_ZX9O4SFUN-4VLA9i8bBVDVbEI9T1cdhWV5Z6Q', '2026-04-30 13:57:40.127929+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('zovt9coysbreo08srs90z05ixjseresd', '.eJxVj81OAyEUhV_FsDYToAzMdKd7k74BuXChg04vhp8mxvjuUtOF3X7nJ-d8Mwu9bbbXUGxCdmSCPf9nDvxHoJuA70DnPPlMrSQ33SzTXa3TW8awv969DwUb1G2kV70GD2qNiq94cHxBIbWOCsHM6MTi-KwWkKiRa5xnqbkJcdGRe38QKsRR2mDrZMeIMxSg0Sm51IPXUGvKZPMn_l2gvu-PlOACw_-Cl0SptgItl6dTr9BGfIfaLPiWrql9saMwxowpQvOfX5SDXt4:1wIPTc:s7hC7VM33jJecSg--oWSM_4lZ1b7UWaBygNIKnZzsLU', '2026-04-30 11:27:40.474324+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('bjqdnth7r1kge9jtj9lvndbrjncov5hy', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01quWRumfX5SiXuo:1wHgeh:4ycjD89Nm6YKnc5FDwqFj-luJNQm5S3dOEPRl7X2CAY', '2026-04-28 11:36:07.791552+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('sc9fh2rp41wy7ko4k6ujhevulyekpov9', '.eJxVj8tOBCEQRX_FsDYdoIGG2enexD8gBQXTaA8YHibG-O8yZhbO9tx7T6q-iYXRdztaqDYhORFGHv8zB_495GuAb5DPZfEl95rccq0st7QtLwXD8Xzr3gl2aPtcG2WCB2GioAZXRzUyrlQUCJtEx7SjUmjgqJAqlJIruoWoVaTer0yEOKUd9pHtPOIMFfJ0csrV5C20lkq25QP_XsjjOO5phgvM_hNeUk6tV-ilPryOBn3OD2jdgu_pM_UvcmLbtklu2Kp_fgGUg17i:1wIKWo:S4ifqpHj344-EIQbTE6fj_fgg0TvhK7s1dvx2fqb0cw', '2026-04-30 06:10:38.769328+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('t8gbqx9g63hzmihr2z165tx2r3p2u3sn', '.eJxVj8tOBCEQRX_FsDYdoHk0s9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NsoED8JEQQ2ujm7IuFJRIGiJjm2OSrEBR4VUoZRcUR3ipiL1fmUixCntsI9s5xFnqJCnk1OuJm-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRPTWsuVGkN_fgGUfl7g:1wIL0g:fQnnVmShmu-K1ISWbmCE4DcOb34QK7GE79b1bBjbWeE', '2026-04-30 06:41:30.859949+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('0oslh4gv40iqxkrc8qx48pldvahkg6wt', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZaSGqp_fgGUeV7f:1wIQAJ:cQ0mp0X67PIP9uu1OoPUo9Nm-d9JBAMooFAWJ-sXnO0', '2026-04-30 12:11:47.934332+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ke7xpqn3djo5x25z68ikx0k3zrjwy8i6', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01nLV2qw_v5ScXuc:1wIMmF:WEhXy1mZ9LjZ1uI_NB4PugaPtoCUQ9g-NGzC-oktsJU', '2026-04-30 08:34:43.957618+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('q0s7oagenfpfeviph41d1ps3hu6zxrv8', '.eJxVj8tOBCEQRX_FsDYdoIGG2enexD8gBQXTaA8YHibG-O8yZhbO9tx7T6q-iYXRdztaqDYhORFGHv8zB_495GuAb5DPZfEl95rccq0st7QtLwXD8Xzr3gl2aPtcG2WCB2GioAZXRzUyrlQUCJtEx7SjUmjgqJAqlJIruoWoVaTer0yEOKUd9pHtPOIMFfJ0csrV5C20lkq25QP_XsjjOO5phgvM_hNeUk6tV-ilPryOBn3OD2jdgu_pM_UvcmLbtknJVm1-fgGUhl7l:1wIQJh:WWAdMtVZ2qMdJcxkFuE88dtp0XKH0KeHZsWERrUhOcA', '2026-04-30 12:21:29.978457+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('eu95lwwj5l1y3j02rjjgt791pyligte3', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01lKaVZifX5SbXuc:1wIS7w:ixjY8REfGU_VzEL7UOz1c7eJtTRTnoYtKntncvzAYL0', '2026-04-30 14:17:28.978687+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('3ykvhoi3i5pahovcdfej3s0yy7yhjeqj', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtTbKCCl_fgGUt17q:1wJknf:I0fE7o722l2pHL-AlbRJurlCZu2clKQmIz7gYIJuhI0', '2026-05-04 04:25:55.140577+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('mf4d3azs3rc7iwq3jox401vktoevjn2x', '.eJxVj0tOAzEQRK-CvEYjj-NvdrBHyg2sttvOGCY28icSQtwdB2VBtq-qnrq_iYXRNztaqDYhOZKVPP9nDvxHyLcA3yGfy-JL7jW55VZZ7mlb3gqG_fXefRBs0La5NtIED9xETg0eHNW4MikjR1AC3aodFVwDQ4lUohBMUhWilpF6f1h5iFPaYRvZziPOUCFPJ6NMTt5Ca6lkWz7x74U89v2RZrjA7L_gJeXUeoVe6tNpNOhzvkPrFnxP19S_yHFVSmlFDRU_v5SaXuM:1wJlRB:826v4pRVDMKdTQ-tpFbTUI8NkNNwTt2uEh9733qXZOk', '2026-05-04 05:06:45.95774+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('b4ltqifvxsbgvft9m3jknk60mktlyyrt', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01kYzua4_v5SUXuE:1wJlbJ:IDF8ZEPo7j5-Gxm-VBpA0UViPaNHUwNjS4sNCgcTEI4', '2026-05-04 05:17:13.337455+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('v4x6baxhkbul9cl7tt8287ervijunnde', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01kbqlZmfX5SiXuY:1wJhu2:lpHFqrA0ea3Yn_5f-bEhFf-a1fY_-Y2-IzjJu4dPaWQ', '2026-05-04 01:20:18.273789+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('6va9cvqslelqp43txb5npxyxyquvrao7', '.eJxVj81OQyEQhV_FsDY3QIEL3enepG9ABgZ60Vsw_DQxxneXmi7s9jvnfJn5JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zbZQJHoSJgho8OKqRcaWiQFglOqYdlUIDR4VUoZRc0TVErSL1_sBEiFPaYRvZziPOUCFPJ6dcTd5Ca6lkWz7x74U89v2RZrjA7L_gJeXUeoVe6tNpNOhzvkPrFnxP19S_yJGt66qlkYr9_AKUtV7o:1wJiUD:BhwHiHh_y2l1mmCeq3P2feKlioEwunf38NEXFqw58eY', '2026-05-04 01:57:41.310247+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('x63j0cij2bmt0ivgn3s40edeekexxctx', '.eJxVj0tOAzEQRK-CvEYjjzO47ezCPlJuYLU_yRgmbeS2kRDi7jgoC7J9VfXU_S0c9ra6zqm6HMVezOL5P_MY3hPdgviGdClTKNRq9tOtMt1Tno4lpu313n0QrMjrWHvtpVkAlV_szmsbAvhZgjoH45eodkbG5RzBKp-slAGSTVIDzCpoNBDVkDZcO7lxxAUr0nAqqfTgnJhzIVc-4t8L1LftkRJecfQP8Zopc6vYSn06dcY25htycxha_sztS-xnADAvxoD8-QV-Sl63:1wJiJ4:d7jUGs3dQbf2NTZAE6mFw1bl8V9b_x7493s7gkJ5yo8', '2026-05-04 01:46:10.912449+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('kzqlog7683lq0oegu6akpyh34t6hlhjc', '.eJxVj81uAjEQg1-lyhmtyB-T9Fj1isQbRJNMyqbQpNpkK1WId2eoOJSr7c-yLyLgOuaw9ryEQuJVOLH5r0VMp1zvBn1iPbYptTqWEqd7ZHq4fdo3yue3R_apYMY-Mw0qeq-TtBijtqAcaEkGtQL0lMkY763-gBylIR29VYnIGycdSUKrgEsHzmsNPOKIC1buVFu1Y73n3kuroX3T3wX5LFX8Qg6_l4r95cD7CpUT8xtxxj4CplF-yvhlDgCck3onrzf7Slt7:1wJo9p:VJ6zzW9wUEDSaXBp8bMJ3ewcdUvVZEvJxFtjcqO-n_c', '2026-05-04 08:01:01.771668+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ua1oth0345dzps7mfc7ba0qatrss6s89', '.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJaUi745QqUfl7c:1wJifC:3YHJnnm9Zt0V0APtq441KQiurq9Lhtj7M8gw8dKkdEE', '2026-05-04 02:09:02.31154+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('f8ktv3t0r54sihbaox4roebcsecxcngt', 'e30:1wJods:AfzKyVN0PT4CTT3eohhS19K8I5tVda9zsKaWYZ3y5OY', '2026-05-04 08:32:04.041742+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('4x7sjxi9q3cfubtj349tj9ilzemzpio3', '.eJxVj8tuwyAQRX-lYl1ZeOwyJrt0X6l_gGaAxLQOVDwqVVX-PSTKItmee-_RzL8w1OpqWvHZBCd2YhSvj4zJfvt4DdwXxWMabIo1Bx6uleGeluEjOb-937tPgpXK2tesWC4zEvCsJ1baWuRRIhzswrODaZFuPjjUwF5LadFrLxXiCFbRgg66tNLaoulHHClT7E6QoDovvpSQokk_7vZCbNv2TCOdqPf37hRiKDVTTfnlsxWqfb5RqYZsDb-h_ondiIhvSgJM5wt98l6l:1wIScB:WRSvPQQIwNLmfnVYQAbvdw7ZtzIPkrGR6O1Z23RM5s8', '2026-04-30 14:48:43.414954+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ny97ngp74kwi26pjoz5xi7uiujdj8h9n', 'e30:1wJpSS:zONY6DFenJ6ssiW_fRukY0GDdTV4-xMRECTeIbcYKyo', '2026-05-04 09:24:20.070882+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('qm0zf5cqdco5w38rkceawynj57rut3vr', '.eJxVj81uAjEQg1-lyhmtyB-T9Fj1Wok3iCaZlE2BpNpkkaqKd2eoOJSr7c-yf0XAdcxh7XkJhcSrcGLzX4uYjrneDfrCemhTanUsJU73yPRw-_TRKJ_eHtmnghn7zDSo6L1O0mKM2oJyoCUZ1ArQUyZjvLf6E3KUhnT0ViUib5x0JAmtAi4dOK818IgDLli5U23VjvWeey-thvZNfxfks1TxjBx-LxX7y573FSpH5jfihH0ETKNcyvhhDgAcOKXc9Qb7ZVuD:1wJnLI:qI6mMtZOsj7HgPGfhIk0EN-rYWdLdVum-7W0PmI_jtg', '2026-05-04 07:08:48.644675+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ptgwd2xrf8vpmc4ns8eyxe9yxdueay2y', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtTbaKCp_fgGUtl7o:1wJnRN:lH8M2f4hbG6mVFyNepxKR14YBfSx1B11mq6pJuNo-7k', '2026-05-04 07:15:05.882276+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('9vh9owf3ddnbor178qlc9fgmcn0xz955', 'e30:1wJnWG:uK4whOIQ6SDQ2mhO1l4IcfORRhXuNJibB_y-uU5tlaU', '2026-05-04 07:20:08.430847+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('j25rude2xybnu0v7erfc3j5bu47l8f2t', '.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaW0okzN1xuUi17g:1wJlFO:bf0m5_nAXNWBPPVO8OB49U2vR-fVTYfWUKBFTz1Uw84', '2026-05-04 04:54:34.041178+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('o1dc7e7r5ml5c0ir0psq67mi5p1zv5mj', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01kaxlcqfX5SBXt0:1wJiwL:zJ2k4hg4BEHi4MRHnvShKFgaX9SakkQ7CtdF-meFIb0', '2026-05-04 02:26:45.633724+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('at1i0ow1wzfpltv5pgjkneksd8oq4t8r', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtTZaMkV_fgGUm17h:1wJmXo:XH4U8S2i3HLil4uANY3MpOJnD_-mWgoAGtrDuDTPIUE', '2026-05-04 06:17:40.773208+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('nzyver8v8ndx5w7y4nwmrvxe1r0uxi23', '.eJxVj81uAjEQg1-lyhmtyB-T9Fj1Wok3iCaZlE2BpNpkkaqKd2eoOJSr7c-yf0XAdcxh7XkJhcSrcGLzX4uYjrneDfrCemhTanUsJU73yPRw-_TRKJ_eHtmnghn7zDSo6L1O0mKM2oJyoCUZ1ArQUyZjvLf6E3KUhnT0ViUib5x0JAmtAi4dOK818IgDLli5U23VjvWeey-thvZNfxfks1TxjBx-LxX7y573FSpH5jfihH0ETKNcyvhhDgAceA36egP7c1uF:1wJndl:CHjUtf8_H4qg5Wj-KJHor8JFDX_IvaMbgNBgXMrV19s', '2026-05-04 07:27:53.522804+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('d7c5qhzy03bwqkdlkjp13j48pf3s6dos', '.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJaCibY5QqUjF7e:1wJjg5:lV1MWvxGVgaeCQYYpIYd5HsXCuKu3m6sNK2G0IpoHok', '2026-05-04 03:14:01.845282+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('590ncls1r4nqpjwkb4qa4cd5zf75vdpp', 'e30:1wJnih:K2UCjtVtcypdJcl-Fs-_kWtcR3gNSV_23fepvJ-bhww', '2026-05-04 07:32:59.713909+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('e7rb3l9uv3dbsij2f7inoxr18lnsv12e', '.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSmnNDV9_fgGUrF7m:1wJoZ1:3TDSs_aTwKDddjdHRihtyFRMiS0PClj52AsfmRzQ_lY', '2026-05-04 08:27:03.663415+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('tygbu3w4fc7ospklkxfi8o77qz2jh4pf', '.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtTZGUUl_fgGUn17h:1wJpNT:YwpROit-Vd4wfdHbSiAJ5Rplx70JiN1liBp7G_Dy7-w', '2026-05-04 09:19:11.013705+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('p3q6mr36f7dvc69j3flhtoo22gomt5em', '.eJxVj81qAzEMhF-l-FyWru31T24NvYU-g5FsEbtN7bL2Bkrpu1dbcmgOgmE0-hh9iwDbyGHrtIaSxEF48fjfQ4jvVPdFeoN6blNsdawFpz0y3bZ9em2JLsdb9g6QoWe-1t5biuS1XBTa6JIC8A4jGTSL1BEQ9TLPS9ROozEKVbROorbGqkRubzUgbzVwiTOsUJkpn6Rhv1PvpdXQPtPfC9LeexU-gNNHSFAfTrQxgcULz3OnwYJWyMy5QB8B4ijXMr7EYbbWOi-VcT-_pQdgVw:1wJr1M:jtAFQdQb2JT5He_bi-m3fL2MHl1Z02nxExjHwAZkOLg', '2026-05-04 11:04:28.365837+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('kt3fq8fv2myoum57hh89k8wcpk4y9xu5', '.eJxVj0tuAyEQRK8SsY5GgBk-3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtZEmeBAmCmrw4KhGxqWMAkGt6Jh2dBUaOEqkEteVS6pC1DJS7w9MhDilHbaR7TziDBXydHLK5eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZUkpraZj5-QWUyV7v:1wJpbT:TVTGbabaWpksfF4N077_4QekRcw7jD9fPcNAJDcxISk', '2026-05-04 09:33:39.840492+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('1guqgskqespn7y0j540wem3qbm3k1gbi', '.eJxVj81uAjEQg1-lyhmtyB-T9Fj1isQbRJNMyqbQpNpkK1WId2eoOJSr7c-yLyLgOuaw9ryEQuJVOLH5r0VMp1zvBn1iPbYptTqWEqd7ZHq4fdo3yue3R_apYMY-Mw0qeq-TtBijtqAcaEkGtQL0lMkY763-gBylIR29VYnIGycdSUKrgEsHzmsNPOKIC1buVFu1Y73n3kuroX3T3wX5LFX8Qg6_l4r95cD7CpUT8xtxxj4CplF-yvhlDgCcV-B31xv7eFuJ:1wJr8G:uxIb64sG8chFdjkZz-WTzGBALKhUN8jYPfAYl163YdU', '2026-05-04 11:11:36.249583+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('nkmi6xo0z12v519k8n53zx9eeocfoiuq', '.eJxVj81uAjEQg1-lyhmtyB-T9Fj1isQbRJNMyqbQpNpkK1WId2eoOJSr7c-yLyLgOuaw9ryEQuJVOLH5r0VMp1zvBn1iPbYptTqWEqd7ZHq4fdo3yue3R_apYMY-Mw0qeq-TtBijtqAcaEkGtQL0lMkY763-gBylIR29VYnIGycdSUKrgEsHzmsNPOKIC1buVFu1Y73n3kuroX3T3wX5LFX8Qg6_l4r95cD7CpUT8xtxxj4CplF-yvhlDgCc805vrzf7e1uE:1wJqMQ:Cibr6BT0gsGEbJBkPIsi2yZBB1mZOQH6blSPlUaXgxk', '2026-05-04 10:22:10.290727+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('f4zodrafvd6w0lqakh11xj00n1yudfku', '.eJxVj0tuAyEQRK8SsY5GgBk-3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtZEmeBAmCmrw4KhGxqWMAkGt6Jh2dBUaOEqkEteVS6pC1DJS7w9MhDilHbaR7TziDBXydHLK5eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZUkobxgT9-QWUjV7d:1wJqhY:ClovLECJsaS7Yz2sWBPJ03Ktj1SsS46M-CMLp2HOs14', '2026-05-04 10:44:00.265208+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('3oh9resueakcg470zsgnn0xpz6w1mdhn', '.eJxVj0tOAzEQRK-CvEYje-JvdrBHyg2sttvOGCY28icSQtwdB2VBtq-qnrq_iYXRNztaqDYhORJGnv8zB_4j5FuA75DPZfEl95rccqss97QtbwXD_nrvPgg2aNtcG2mCB24ipwYPjmpkq5SRIyiBjmlHBdewokQqUYhVUhWilpF6f2A8xCntsI1s5xFnqJCnc6WrnLyF1lLJtnzi3wt57PsjzXCB2X_BS8qp9Qq91KfTaNDnfIfWLfierql_kSNTSmnDpFA_v5SyXuo:1wJqpt:Rnb1eSzgxE0u1FXfkv0I9_wNDQDsK-Cb3CEWBEY4Efs', '2026-05-04 10:52:37.557701+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('6ozrh8tm6i4tsrxaslnxym7l9b6wdrje', '.eJxVj81uAjEQg1-lyhmtyB-T9Fj1isQbRJNMyqbQpNpkK1WId2eoOJSr7c-yLyLgOuaw9ryEQuJVOLH5r0VMp1zvBn1iPbYptTqWEqd7ZHq4fdo3yue3R_apYMY-Mw0qeq-TtBijtqAcaEkGtQL0lMkY763-gBylIR29VYnIGycdSUKrgEsHzmsNPOKIC1buVFu1Y73n3kuroX3T3wX5LFX8Qg6_l4r95cD7CpUT8xtxxj4CplF-yvhlDgC83Tprrjf7UVt_:1wK6Eg:Kxwc_z5D_mIGiM8yAVeMg-nOKSHb5_ukY076Nw0wjpg', '2026-05-05 03:19:14.67847+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('adswatv4m0uwqdzfvldle15qwjbn6x31', '.eJxVj01uwyAQha9SsY4scAFDl1G2lXoDNGYgpkmgMjhSFOXumURe1Mv53o_e3JmDpU1uqWF2CdkXM2z3n43gTyG_BPyFfCydL7nNaexelm5Va_ddMJz3q3dTMEGdKM21MMiDVJILqUaNETF8cmkVgASrPAZvpLLcDDbCGDRqQ1eM1kehekGlDaYlOxpxhBkydfa818RrqDWV7Mofvl8QW5ThAmQ-pAz144f2JUwnyu_YGWpz4Fu6pnaj3DAMlgvRm8cTLqpb1g:1wJtIe:hPoQGVn-zqix3pE5ZiehqgZP-5t9K0FeXF5dDQKLA5U', '2026-05-04 13:30:28.546454+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('3i8ri8fb7rsdf95muadkefqws47r9mot', '.eJxVj8tuwyAQRX8lYh1Z4ACGLKNuK_UP0JiBmDygMrhSFeXfO668SJZz7kN3HszB0ia31DC7hOzIDNu_shH8NeRVwAvkc-l8yW1OY7dauk2t3WfBcDtt3reCCepEaa6FQR6kklxINWqMiOHApVUAEqzyGLyRynIz2Ahj0KgNXTFaH4XqBZU2mJbsaMQZZsjU2fNeE6-h1lSyK9_4_4J4RxnuQOaPlKHuvmhfwnSl_J7doDYHvqWf1H4pNwyDlQfO1fMPLrxb1g:1wK4C6:YrFi2X5w0G-5_jNjklmZh2Nr_F4oHyI-Z4GsalJWhYM', '2026-05-05 01:08:26.068735+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('33pi1jxjemgaeb7emkqp3f8xp0fps5dz', 'e30:1wK4HM:jw7j8peVDleRkjOsOXynbvJgVwB_tD0cdsYqeEOC1gk', '2026-05-05 01:13:52.31762+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('o3obdlxpvvyhgcvn3tqf0m86aw3sd8hd', '.eJxVj81uwjAQhF8F-Yyi-i8bc6y4IvEG1tpriIHaKHYqVVXfvUvFoVxn5hvNfAuPa5_92tLiM4mdmMT2vxYwXlN5GHTBcq5DrKUvOQyPyPB023ColG7vz-xLwYxtZhpUcE5HaTEEbUFNoCUZ1ArQUSJjnLP6BClIQzo4qyKRM5OcSBJaBVzacV6L5xFnXLBwp3pTI-sttZZr8fVOfxfkq1TwAzm8zwXb5sj7MuUr81txw9Y9xp4_c_9iDgCcMeM4_vwC-15bgw:1wK4cs:h51ThKPF0_C4qAi95Oj6JLc9Nkam2lxXkvJKHoxx2ho', '2026-05-05 01:36:06.540496+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('oiob1sx9sy6dkn6tkyetni48a5vdj873', 'e30:1wK4mS:poi0K4Ax5VRlrVOFzJ6xjcQJUTa23NFhcX9WnDX3MDI', '2026-05-05 01:46:00.182613+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ocwraszhw4h73cn6ajsoxdxrd9i5xum4', '.eJxVj81uAjEQg1-lyhmtyB-T9Fj1Wok3iCaZlE2BpNpkkaqKd2eoOJSr7c-yf0XAdcxh7XkJhcSrcGLzX4uYjrneDfrCemhTanUsJU73yPRw-_TRKJ_eHtmnghn7zDSo6L1O0mKM2oJyoCUZ1ArQUyZjvLf6E3KUhnT0ViUib5x0JAmtAi4dOK818IgDLli5U23VjvWeey-thvZNfxfks1TxjBx-LxX7y573FSpH5jfihH0ETKNcyvhhDgC8sU7B9Qb7YVuD:1wK4vb:V-HJ7KeVDrnFnE9Kl0jvVqbaKwicnWrhyR_j27fV9rc', '2026-05-05 01:55:27.993055+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('78yjd99imfmzd8f2u4rhw92w1pj1hzue', 'e30:1wK50c:DwWLLpRVT7rF_2NdOUTZlPBccxyWimvI85kFTGUn8nI', '2026-05-05 02:00:38.133704+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('2nzm53fqy698e3kzk8e9hffb3zd0wzgl', '.eJxVj8FuAyEQQ3-l4hytAgMBeoxyrdQ_QANDszQJVAtbqary75lUOTRX28-yf0XAdcxh7XkJhcSrcGLzX4uYTrneDfrEemxTanUsJU73yPRw-_TWKJ_3j-xTwYx9Ztqq6D0kaTBGMFY5C5I0grLoKZPW3hv4sDlKTRC9UYnIaycdSUKjLJcOnNcaeMQRF6zcqbZqx3rPvZdWQ_uivwvyWap4QQ4fSsX-8s77CpUT8xtxxj4CplG-y_hhzlq3Bb0DuN4A-xJbdA:1wKS1x:K_cL8kywzPobU27dAOxBkmKq25MUZUDHcRJTm0mBMEc', '2026-05-06 02:35:33.148836+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('pxpp44fks4slb85fyp36aatlkdcrskms', '.eJxVj0tuAyEQRK8SsY5GgBkGvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtZbaOxA6CKpxZ6lCxqUMAmGZ0TJl6SwUcJRIJc4zl3TxQclAndsx4cOQNlh7MuOIIxRIw8kpl4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzZVFUMK3U5QqUe17l:1wKTwb:xRTu9t-fCVMVNi2eKmG_L-mWlPgWF6jHUs85VNF6w3Y', '2026-05-06 04:38:09.059666+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('p1966g5oepzxmjbuwspu8ond9tk6w6xa', '.eJxVj81OAzEQg18F5VytyF9nhyPiWqlvEE0yoRtaErTJIiHEuzNFPdCr7c-yv1WgbSxh63kNhdWTmtXuvxYpnXO9GvxG9dSm1OpYS5yukenm9unQOF-eb9m7goX6IjSYiGiT9hSj9WBmsJodWQOEnNk5RG9fIUft2Eb0JjGjm_XMmskbkNJBy1aDjDjRSlU6zaPZi95z76XV0D7474K-lyq9k4RfSqX-cJR9hctZ-J26UB-B0iifZXwJBwDoYA_48wv7dluK:1wK5PU:sFEA8DbfhI73UwrubEvdJ0pYwMD_7YyKeOCKiy5nYz0', '2026-05-05 02:26:20.001588+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('klgl7srf8p5p5dwj3nmhjljzh7m9dr6x', '.eJxVj0tuAyEQRK8SsY5GgIFhvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9aIW70AsQdAFd5ZqZFypIBBmiZZpS6XQwFEhVSglV3T2QatAndsx4cOQNlh7MuOIIxRIw8kpV4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzedZUcEHl5QqUTl7W:1wKU3K:oLAf7jda09jEGeuGmvvTDXuFqBoNzBn29-GXPejnOjI', '2026-05-06 04:45:06.094932+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('85n8pcuhn7r8kjzi9dqcpx83obbrwf2j', '.eJxVj81uAjEMhF-lyhmtyB_e9Fj1isQbRE4c2ABNqk22UoV4dwziANeZ-cbji_C49MkvLc0-k_gUo1i9agHjKZW7QUcshzrEWvqcw3CPDE-3DdtK6fz1zL4VTNgmpkEF53SUFkPQFtQIWpJBrQAdJTLGOav3kII0pIOzKhI5M8qRJKFVwKUdp6V4HnHAGQt3qrXasN5Sa7kWX3_p8YJ8lwr-IIe_c8H2seN9mfKJ-ZU4Y-seY89_uf8zBwB8cmPhegP7cVuH:1wK5fF:YSyrTMWUxTAuPGc08XW0atVmPJ9l7TTvzR7IQoDpvog', '2026-05-05 02:42:37.889357+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('rv4fpf56werbv8awmx29151w7j7vgl5c', 'e30:1wK5xr:qXiOvvaU-xUTsrxxXqq8YrjiAoKjFK2yp-pALSRxj8Y', '2026-05-05 03:01:51.610288+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('p448eb6r51mdqa95yy0c667suyvaq65j', 'e30:1wK5xr:qXiOvvaU-xUTsrxxXqq8YrjiAoKjFK2yp-pALSRxj8Y', '2026-05-05 03:01:51.624648+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('rmaixvakmqtu83r2l4pvn0yxnni6s5m8', 'e30:1wK5xr:qXiOvvaU-xUTsrxxXqq8YrjiAoKjFK2yp-pALSRxj8Y', '2026-05-05 03:01:51.62599+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('3z2vfees3w8tvp9fdsj5ew79lxsx1uk1', 'e30:1wK5xr:qXiOvvaU-xUTsrxxXqq8YrjiAoKjFK2yp-pALSRxj8Y', '2026-05-05 03:01:51.818871+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ivnzoseb4cw028536ioyshf13v2tpq9i', '.eJxVj81uAjEQg18F5YxW5K-z4Yi4IvEG0SSTsimQoE0WCVV99w4Vh3K1_Vn2t_C49MkvLc0-k9iKUaz_awHjOZWnQV9YTnWItfQ5h-EZGV5uGw6V0mX3yr4VTNgmpkEF53SUFkPQFtQIWpJBrQAdJTLGOas_IQVpSAdnVSRyZpQjSUKrgEs7TkvxPOKEMxbuVBv1wXpLreVafL3R3wX5LhW8Iof3uWBbHXlfpnxmfi0u2LrH2PM99wdzAODsRoL5-QX7O1t6:1wK63i:x5RYeqkgVFzXrJL1K4KMptzyXje6zKwl_8m5Zz5cju4', '2026-05-05 03:07:54.866332+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ev7ildf8pnp03j1g6gsj1dzo01vp725j', '.eJxVj8tOBCEQRX_FsDYdoOlqena6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5MsMf_zKJ79-ka0Bumc55cTq1EO10r0y2t00smfzzfuneCHes-1hts3qHaguIbzZZrEhIgKMJ1ISu05YvSKAmIAy2LBL76oCFw52ahfBjShntPZhxxxoJpOCWXMHj1tcacTP6gvxdSP457mvCCo_9El5hibQVbLg-vvWIb8wNrM-ha_Izti53EumohNMzw8wuUdF7g:1wKnsq:XV34nHtCiAQ09bvVbQrZJ4S49Uix1Ov6jlVtkVSup94', '2026-05-07 01:55:36.141336+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ajm4vbgn44hpu1dhiwxjkgfihvthnwiq', '.eJxVj0tuAyEQRK8SsY5GwDAMeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUbay21dyB0EFTjbKlCxqUMAmFd0DJl6SIUcJRIJS4Ll3T1QclAnZuZ8GFIG2w9mXHEGQqk4eSUy8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jg66qYEJrN1xuUcl7d:1wKuif:SAQHYbyJtx7ehiVP6Ncgn2SLdwFiJ7L2QSGe8XieUiA', '2026-05-07 09:13:33.525383+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('qr089v9to3ihjroxuw03lhrm6j92c33n', '.eJxVj0tuAyEQRK8SsY5GgBk-3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtZEmeBAmCmrw4KhGxqWMAkGt6Jh2dBUaOEqkEteVS6pC1DJS7w9MhDilHbaR7TziDBXydHLK5eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZUpoqqY35-QWUp17u:1wKd1f:JA1Cwd6Ul65dzKye72sGbo1r7g1jg8inHAJAlkr-jzQ', '2026-05-06 14:19:59.858147+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('c9idwwdcj4tazifh3shbkfi3hux6ns2j', '.eJxVj0tuAyEQRK8SsY5GgIFhvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9aIW70AsQdAFd5ZqZFypIBBmiZZpS6XQwFEhVSglV3T2QatAndsx4cOQNlh7MuOIIxRIw8kpV4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzedZUCCHl5QqUZ17d:1wKUaN:ix3nFLocv8-gzAMJr-osfDbO8FVAv4xEytZiof9wVe8', '2026-05-06 05:19:15.342721+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('2kvvdkou5nykgwoyj8ayicrcxnz5cmsy', 'e30:1wKdAU:Lgk3t2VfoVziMkh7I3F2LBVBcDHu720QVpjy0eiriqQ', '2026-05-06 14:29:06.940146+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ixjg4sg92ddtdz5ke9vl95q3qfudusmn', '.eJxVj0tuAyEQRK8SsY5GwADDeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wt3oFYg6ArzpZqZFypIBAWiZZpS6XQwFEhVSglV3TxQatAnZuZ8GFIG2w9mXHEGQqk4eSUq8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jgy6KZkLPm1xuUcl7e:1wKuqE:6MkxAMXCVSGI5Y20eD2JFYzdLQAKpRWPevScFHqKLOw', '2026-05-07 09:21:22.2614+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('d8ggn6lphl8wlwkooc8813s046eoldx8', '.eJxVj8tOBCEQRX_FsDYdoOlqena6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5MsMf_zKJ79-ka0Bumc55cTq1EO10r0y2t00smfzzfuneCHes-1hts3qHaguIbzZZrEhIgKMJ1ISu05YvSKAmIAy2LBL76oCFw52ahfBjShntPZhxxxoJpOCWXMHj1tcacTP6gvxdSP457mvCCo_9El5hibQVbLg-vvWIb8wNrM-ha_Izti53EumoBAub15xeUcV7f:1wKz4P:UuiBo1Icxe1gEtBn8svNn-bFeZ_nv23UfY8Z7MELqUY', '2026-05-07 14:17:17.701848+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('zr59nixmilykrlkd4sv0af10wsq6ca9l', '.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS0NoyvTMufX5RXXto:1wKp43:Nf1NN6vgGVJzFXaY1isXj47eJy4CcXhvIU4nnpfR-r4', '2026-05-07 03:11:15.844652+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('o7sd89y8vt183gq0p4ayq1jt4stpg6ky', '.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaXZTJWerzeUZV7d:1wKr2l:prBT8r6U3ulsisSz4slGmEPMdi2rVFCjO937TKpzEj0', '2026-05-07 05:18:03.128638+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('8kivvhy7e6mdrwr4hga4kf5nmm9tks2m', '.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlNJUacX45QqUh17g:1wKdUu:Y3xrQ3czFasEGkEacJfqB8W1Y70KJRin2Z-Vd5e68m0', '2026-05-06 14:50:12.207274+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('xm8wq1bc9ebwsdi0mskd5sdz38andxrq', 'e30:1wKdbT:mOgi53XgDflLsUovxei8KgLGT8Aw56s4heOoBuepsx0', '2026-05-06 14:56:59.18294+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('xfknffe85t63re4icgim9tx8w28mhn3n', '.eJxVj0tuAyEQRK8SsY5GwADDeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wt3oFYg6ArzpZqZFypIBAWiZZpS6XQwFEhVSglV3TxQatAnZuZ8GFIG2w9mXHEGQqk4eSUq8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jgy6KZnLlg1xuUXF7X:1wKwsz:rVRmzcduVziRY9XFVOeUWDRscTRo4SI2-homivdFPEk', '2026-05-07 11:32:21.437027+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('52omrolswcqv442zfp4sq26jpot14xbp', '.eJxVj01OBCEQha9iWJsO0DRNz073Jt6AFBRMoz1gKDAxxrvLmFk42-_9VL1vZqG33XYK1SZkJybY43_mwL-HfBXwDfK5TL7kVpObrpbpptL0UjAczzfvXcEOtI_0prfgQW1R8Q1nxw0KqXVUCOuCThjHF2VAokaucVmk5muIRkfu_SxUiKO0wd6zHU-coUIenZJLPTgFolSyLR_4NyH347inGS4w_E94STlRq9BKfXjtBG3ED6Bmwbf0mdoXO4l1NWIe5-efX5RkXts:1wKsQ5:IJF5RI_w1H6W7fiCuq-ZOeJOCKhYP-OBeXLSjkVvVZc', '2026-05-07 06:46:13.380247+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('t63h7zfvhrlzd0hv9ak2zxz1kukbau6w', '.eJxVj0tuAyEQRK8SsY5GDWYYxrtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZknD3_Zxbdh0-3gN4xnfPkcmol2ulWme5pnd4y-f313n0QbFi3sV7V6h3KNUhY6WBBExdKBUm4zGS5tjBLjYIUgaJ5FgoWH7QK4NyBSx-GtOHWkxlHnLFgGk4BQg1efa0xJ5M_6e-F1Pf9kSa84Oi_0CWmWFvBlsvTqVdsY75jbQZdi9fYvtiRL4sGDRzkzy-UTl7U:1wKdrM:vb2Z5qGOFXISOuwOl7KabdxPKZgjaC778u56rBI3xZ4', '2026-05-06 15:13:24.371981+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('iuzezyz4j3yfgg8qor5o8kmfqi2eaolk', '.eJxVj81OQyEQhV_FsDY3QIEL3enepG9ABgZ60Vsw_DQxxneXmi7s9jvnfJn5JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zbZQJHoSJgho8OKqRcaWiQFglOqYdlUIDR4VUoZRc0TVErSL1_sBEiFPaYRvZziPOUCFPJ6dcTd5Ca6lkWz7x74U89v2RZrjA7L_gJeXUeoVe6tNpNOhzvkPrFnxP19S_yJGtq6aaSmZ-fgGUa17e:1wKdy3:jq-75K8ZRr7DG1tDDMi5W7LQj_jqmRTjs9Izftt1bO4', '2026-05-06 15:20:19.561612+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('i24ywwrghkeg4s0c6b9eff7hboe6f7yh', 'e30:1wKaVW:dy84JCdOxJY5EkCC3ZyOvMeNRfIQeWExHFm1sYm4X48', '2026-05-06 11:38:38.265932+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('6tmrsbnw0s67wg5vlzkdb8ifs6xuks9i', 'e30:1wKaw4:iTYJI9Io3OYYNgiG8esM5vuhAcXx1hFSW13Y_8QlfW0', '2026-05-06 12:06:04.696443+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('6hd7iorcp22pnul2aizhyfp7gci3nu3u', '.eJxVj8tqwzAUBX_F3LUxsmK9vGvIruQbxLGk2m7Sq2LJgVL67yUli2Y7Mxw43-Sx18XvJW1-jTRSL6j9DyeES-K7ie_gOXchc93Wqbsn3cOW7pxjuh4f7dPAgrLQSHYaXHBBaiAMUEhSxmiitvaglXTB9CoKZYag4iSd6A8O4i0IAaedkgnUUsWyswfPMzYwjSSF1NRSSaWsmX3-jH8fpHlmjA_QSEdEcPOadvAMbk7g5qWk2pyQNizU0hWleoS63tb6RWNvjBVaD9r-_ALHZmBf:1wKaJQ:c5drqDerJQeUdmnmjHtzn4ZgelpIoTKxO6qHfIFnn-U', '2026-05-06 11:26:08.395183+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('tkcvuw0dv14224hnbx4vlmhr1dqokf9t', '.eJxVj0FqwzAUBa9i_toYWbEky7uG7ErOIJ4l1VKTfhdLDpTSu5eULJrtzPDgfZPDXpPbS9xcDjRRL6j9D2f4S-S7Ce_gZe38ynXLc3dPuoct3XkN8Xp8tE8DCSXRROM8WG-91IAfoBClDMEEPY4HraT1pldBKDN4FWZpRX-wEG9eCFhtlYyglirSzg68LNjANJEUUlNLJZaSV3brZ_j7IM0zY3yAJjoigJvXuIMXcHMCNy8l1uaEuCFRS1eU6uBrvuX6RVNvzCi0tkL9_ALHYmBb:1wKaQU:EpOGTWH0yDMwjPfDftiSDSEnbuwPmDsMLDfSwWOn6lw', '2026-05-06 11:33:26.066764+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('u9glph9s4j4qsq687nyfktazbl6ztobb', '.eJxVj81qAyEURl-l3PUwqFHnZ5fuA3kDuXp1xnaixZ9CKX33kpJFsz3n8MH3DQZ7202vvphIsAKH4T-z6N59ugt6w7Tl0eXUSrTjPRkfto6XTP54fbRPAzvWHVZY9OIdyiVIttDJspm40DpIwkmR5bNlSs4oSBPTpJTQbPJh1oE5d-LSBxig4d6TwbRtWDDBCoIJDQNUX2vMyeQP-ruQ-nE804Q3hBXOdIsp1law5fJy7RUbDHBgbQZdi5-xfcHKp2lmWinBf34BlGte2g:1wKa4A:SW1UJSISBnRpwGr4St-oBscvE7GJXmxranSWYQWTvnU', '2026-05-06 11:10:22.077634+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('p14ax45r1avyv9j2w0krj5716lasnsg6', '.eJxVj0FqwzAQRa9SZm2MrEiy7F26D-QGYqSRbLXOqFhyoZTevaRk0Wzfe3z43-DwaKs7atxdJphhgO4_8xjeI98FvSEvpQ-F2559f0_6h639pVDcXh_t08CKdYUZJjPFgGpKSkx08sLSII1JinDU5AfrhVYWJRkShrSWRowxWZNECKdBxQQdNFwPdsjLgjsyzCCFNNBBjbXmwq580N8FPrbtmTLeEGY40y1zrm3HVvaX61GxQQcb1uYwtPyZ2xfMwzhaYazS488vlIte5Q:1wKapV:h8xaW71Y-UOL49v3pTrmL-3GLKst7V0WejxG294Fo58', '2026-05-06 11:59:17.814269+00');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('cubf16orzf65v0xq8uztmtuettto036q', '.eJxVj0tuAyEQRK8SsY5GgBkGvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtZbaOxA6CKpxZ6lCxqUMAmGZ0TJl6SwUcJRIJc4zl3TxQclAndsx4cOQNlh7MuOIIxRIw8kpl4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzZVFMaKHp5QqUiV7i:1wKvuU:oGCEo3v_-7-oQTDTngXT7zzWSu7OEcRZzWnukG128yQ', '2026-05-07 10:29:50.342013+00');


ALTER TABLE public.django_session ENABLE TRIGGER ALL;

--
-- Data for Name: menus_menu; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.menus_menu DISABLE TRIGGER ALL;

INSERT INTO public.menus_menu (id, nama, icon, urutan) VALUES (1, 'Umum', 'ti-settings', 2);
INSERT INTO public.menus_menu (id, nama, icon, urutan) VALUES (2, 'Admin', 'ti-settings-automation', 0);
INSERT INTO public.menus_menu (id, nama, icon, urutan) VALUES (3, 'Peraturan', 'ti-shield-lock', 1);
INSERT INTO public.menus_menu (id, nama, icon, urutan) VALUES (4, 'Perintah', 'ti-settings', 3);


ALTER TABLE public.menus_menu ENABLE TRIGGER ALL;

--
-- Data for Name: menus_submenu; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.menus_submenu DISABLE TRIGGER ALL;

INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (3, 'Role', 'permission_page', 1, 2);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (8, 'User Profile', 'userprofile_list', 0, 2);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (7, 'Hak Akses', 'role_list', 2, 2);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (6, 'OPD', 'opd_list', 2, 1);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (9, 'Pangkat', 'pangkat_list', 3, 1);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (10, 'Jenis Jabatan', 'jenis_jabatan_list', 4, 1);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (4, 'Menu', 'menu_list', 3, 2);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (5, 'Sub Menu', 'submenu_list', 4, 2);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (11, 'Status ASN', 'status_asn_list', 5, 1);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (13, 'Peraturan', 'dasar_peraturan_list', 0, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (12, 'Tingkat SPD', 'tingkat_list', 2, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (14, 'Jenis SPD', 'jenis_spd_list', 1, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (15, 'Jenis Kegiatan', 'jenis_kegiatan_list', 3, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (21, 'Transport', 'standard_transportasi_list', 9, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (22, 'Uang Representasi', 'standard_representasi_list', 10, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (20, 'Jenis Transport', 'jenis_transportasi_list', 4, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (16, 'Lokasi', 'lokasi_kegiatan_list', 5, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (17, 'Penginapan', 'standard_penginapan_list', 6, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (18, 'Pesawat', 'standard_pesawat_list', 7, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (19, 'Uang Harian', 'standard_uang_harian_list', 8, 3);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (23, 'Eselon', 'eselon_list', 6, 1);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (25, 'Identitas Pemda', 'pemda_list', 7, 1);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (26, 'Pemberi Perintah', 'pemberi_tugas_list', 1, 4);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (24, 'Perintah Tugas', 'spt_list', 0, 4);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (27, 'Kop Surat', 'kop_surat_list', 8, 1);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (1, 'Pegawai', 'pegawai_list', 0, 1);
INSERT INTO public.menus_submenu (id, nama, url, urutan, menu_id) VALUES (2, 'Pejabat Penandatangan', 'penandatangan_list', 1, 1);


ALTER TABLE public.menus_submenu ENABLE TRIGGER ALL;

--
-- Data for Name: profiles_role; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.profiles_role DISABLE TRIGGER ALL;

INSERT INTO public.profiles_role (id, nama) VALUES (1, 'Administrator');
INSERT INTO public.profiles_role (id, nama) VALUES (2, 'Pengguna');


ALTER TABLE public.profiles_role ENABLE TRIGGER ALL;

--
-- Data for Name: menus_rolepermission; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.menus_rolepermission DISABLE TRIGGER ALL;

INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (7, true, true, true, true, 1, 24);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (1, true, true, true, true, 1, 1);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (8, false, false, false, false, 1, 13);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (9, true, true, true, true, 1, 8);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (10, false, false, false, false, 1, 14);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (2, true, true, true, true, 1, 2);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (3, false, false, false, false, 1, 3);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (11, true, true, true, true, 1, 26);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (12, false, false, false, false, 1, 7);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (13, false, false, false, false, 1, 12);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (14, false, false, false, false, 1, 6);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (15, false, false, false, false, 1, 15);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (16, false, false, false, false, 1, 4);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (17, false, false, false, false, 1, 9);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (18, false, false, false, false, 1, 10);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (19, false, false, false, false, 1, 5);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (20, false, false, false, false, 1, 20);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (21, false, false, false, false, 1, 16);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (22, false, false, false, false, 1, 11);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (23, false, false, false, false, 1, 23);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (24, false, false, false, false, 1, 17);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (25, false, false, false, false, 1, 18);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (26, true, true, true, true, 1, 25);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (27, false, false, false, false, 1, 19);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (28, true, true, true, true, 1, 27);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (29, false, false, false, false, 1, 21);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (30, false, false, false, false, 1, 22);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (31, true, false, false, false, 2, 24);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (4, true, false, true, false, 2, 1);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (32, false, false, false, false, 2, 13);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (33, false, false, false, false, 2, 8);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (34, false, false, false, false, 2, 14);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (5, false, false, false, false, 2, 2);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (6, false, false, false, false, 2, 3);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (35, true, false, false, false, 2, 26);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (36, false, false, false, false, 2, 7);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (37, false, false, false, false, 2, 12);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (38, false, false, false, false, 2, 6);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (39, false, false, false, false, 2, 15);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (40, false, false, false, false, 2, 4);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (41, false, false, false, false, 2, 9);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (42, false, false, false, false, 2, 10);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (43, false, false, false, false, 2, 5);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (44, false, false, false, false, 2, 20);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (45, false, false, false, false, 2, 16);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (46, false, false, false, false, 2, 11);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (47, false, false, false, false, 2, 23);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (48, false, false, false, false, 2, 17);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (49, false, false, false, false, 2, 18);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (50, false, false, false, false, 2, 25);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (51, false, false, false, false, 2, 19);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (52, false, false, false, false, 2, 27);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (53, false, false, false, false, 2, 21);
INSERT INTO public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) VALUES (54, false, false, false, false, 2, 22);


ALTER TABLE public.menus_rolepermission ENABLE TRIGGER ALL;

--
-- Data for Name: spd_jeniskegiatan; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_jeniskegiatan DISABLE TRIGGER ALL;

INSERT INTO public.spd_jeniskegiatan (id, nama) VALUES (3, 'Diklat');
INSERT INTO public.spd_jeniskegiatan (id, nama) VALUES (4, 'Fullboard');
INSERT INTO public.spd_jeniskegiatan (id, nama) VALUES (5, 'Fullday/ Halfday di dalam kota');
INSERT INTO public.spd_jeniskegiatan (id, nama) VALUES (6, 'Residence di dalam kota');
INSERT INTO public.spd_jeniskegiatan (id, nama) VALUES (2, 'Konsultasi/ Koordinasi/ Kunjungan Dalam Kabupaten');
INSERT INTO public.spd_jeniskegiatan (id, nama) VALUES (1, 'Konsultasi/ Koordinasi/ Kunjungan Luar Kabupaten');


ALTER TABLE public.spd_jeniskegiatan ENABLE TRIGGER ALL;

--
-- Data for Name: spd_jenisspd; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_jenisspd DISABLE TRIGGER ALL;

INSERT INTO public.spd_jenisspd (id, nama) VALUES (1, 'Luar Daerah Luar Provinsi');
INSERT INTO public.spd_jenisspd (id, nama) VALUES (2, 'Luar Daerah Dalam Provinsi');
INSERT INTO public.spd_jenisspd (id, nama) VALUES (3, 'Dalam Daerah');


ALTER TABLE public.spd_jenisspd ENABLE TRIGGER ALL;

--
-- Data for Name: spd_lokasi; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_lokasi DISABLE TRIGGER ALL;

INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (1, 'Aceh', 1, 'Banda Aceh');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (2, 'Sumatera Utara', 1, 'Medan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (3, 'Riau', 1, 'Pekanbaru');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (4, 'Kepulauan Riau', 1, 'Tanjungpinang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (5, 'Jambi', 1, 'Jambi');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (6, 'Sumatera Barat', 1, 'Padang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (7, 'Sumatera Selatan', 1, 'Palembang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (8, 'Lampung', 1, 'Bandar Lampung');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (9, 'Bengkulu', 1, 'Bengkulu');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (10, 'Bangka Belitung', 1, 'Pangkalpinang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (11, 'Banten', 1, 'Serang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (12, 'Jawa Barat', 1, 'Bandung');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (13, 'D.K.I Jakarta', 1, 'Jakarta');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (14, 'Jawa Tengah', 1, 'Semarang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (15, 'D.I. Yogyakarta', 1, 'Yogyakarta');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (16, 'Jawa Timur', 1, 'Surabaya');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (17, 'Bali', 1, 'Denpasar');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (18, 'Nusa Tenggara Barat', 1, 'Mataram');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (19, 'Nusa Tenggara Timur', 1, 'Kupang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (20, 'Kalimantan Barat', 1, 'Pontianak');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (21, 'Kalimantan Tengah', 1, 'Palangka Raya');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (22, 'Kalimantan Selatan', 1, 'Banjarbaru');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (23, 'Kalimantan Timur', 1, 'Samarinda');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (24, 'Kalimantan Utara', 1, 'Tanjung Selor');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (25, 'Sulawesi Utara', 1, 'Manado');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (26, 'Gorontalo', 1, 'Gorontalo');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (27, 'Sulawesi Barat', 1, 'Mamuju');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (28, 'Sulawesi Selatan', 1, 'Makassar');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (29, 'Sulawesi Tengah', 1, 'Palu');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (30, 'Sulawesi Tenggara', 1, 'Kendari');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (31, 'Maluku', 1, 'Ambon');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (32, 'Maluku Utara', 1, 'Sofifi');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (33, 'Papua', 1, 'Jayapura');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (34, 'Papua Barat', 1, 'Manokwari');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (35, 'Papua Barat Daya', 1, 'Sorong');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (36, 'Papua Tengah', 1, 'Nabire');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (37, 'Papua Selatan', 1, 'Merauke');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (38, 'Papua Pegunungan', 1, 'Jayawijaya');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (39, 'Kabupaten Batubara', 2, 'Limapuluh');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (40, 'Kabupaten Dairi', 2, 'Sidikalang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (41, 'Kabupaten Deli Serdang', 2, 'Lubuk Pakam');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (42, 'Kabupaten Humbang Hasundutan', 2, 'Dolok Sanggul');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (43, 'Kabupaten Karo', 2, 'Kabanjahe');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (44, 'Kabupaten Labuhan Batu', 2, 'Rantau Prapat');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (45, 'Kabupaten Labuhan Batu Selatan', 2, 'Kota Pinang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (46, 'Kabupaten Labuhan Batu Utara', 2, 'Aek Kanopan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (47, 'Kabupaten Langkat', 2, 'Stabat');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (48, 'Kabupaten Mandailing Natal', 2, 'Panyabungan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (49, 'Kabupaten Nias', 2, 'Gido');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (50, 'Kabupaten Nias Barat', 2, 'Lahomi');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (51, 'Kabupaten Nias Selatan', 2, 'Teluk Dalam');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (52, 'Kabupaten Nias Utara', 2, 'Lotu');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (53, 'Kabupaten Padang Lawas', 2, 'Sibuhuan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (54, 'Kabupaten Padang Lawas Utara', 2, 'Gunung Tua');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (55, 'Kabupaten Pakpak Barat', 2, 'Salak');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (56, 'Kabupaten Samosir', 2, 'Pangururan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (57, 'Kabupaten Serdang Bedagai', 2, 'Sei Rampah');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (58, 'Kabupaten Simalungun', 2, 'Raya');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (59, 'Kabupaten Tapanuli Selatan', 2, 'Sipirok');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (60, 'Kabupaten Tapanuli Tengah', 2, 'Pandan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (61, 'Kabupaten Tapanuli Utara', 2, 'Tarutung');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (62, 'Kabupaten Toba Samosir', 2, 'Balige');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (63, 'Kota Binjai', 2, 'Binjai');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (64, 'Kota Gunung Sitoli', 2, 'Gunung Sitoli');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (65, 'Kota Medan', 2, 'Medan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (66, 'Kota Padangsidimpuan', 2, 'Padangsidempuan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (67, 'Kota Pematang Siantar', 2, 'Siantar');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (68, 'Kota Sibolga', 2, 'Sibolga');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (69, 'Kota Tanjung Balai', 2, 'Tanjung Balai');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (70, 'Kota Tebing Tinggi', 2, 'Tebing Tinggi');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (71, 'Kecamatan Meranti', 3, 'Meranti');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (72, 'Kecamatan Pulo Bandring', 3, 'Pulo Bandring');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (73, 'Kecamatan Air Joman', 3, 'Air Joman');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (74, 'Kecamatan Sei Dadap', 3, 'Sei Dadap');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (75, 'Kecamatan Rawang Panca Arga', 3, 'Rawang Panca Arga');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (76, 'Kecamatan  Tanjung Balai', 3, 'Tanjung Balai');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (77, 'Kecamatan Buntu Pane', 3, 'Buntu Pane');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (78, 'Kecamatan Setia Janji', 3, 'Setia Janji');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (79, 'Kecamatan Tinggi Raja', 3, 'Tinggi Raja');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (80, 'Kecamatan Silau Laut', 3, 'Silau Laut');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (81, 'Kecamatan Simpang Empat', 3, 'Simpang Empat');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (82, 'Kecamatan Air Batu', 3, 'Air Batu');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (83, 'Kecamatan Teluk Dalam', 3, 'Teluk Dalam');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (84, 'Kecamatan Bandar Pasir Mandoge', 3, 'Bandar Pasir Mandoge');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (85, 'Kecamatan Bandar Pulau', 3, 'Bandar Pulau');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (86, 'Kecamatan Aek Kuasan', 3, 'Aek Kuasan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (87, 'Kecamatan Aek Ledong', 3, 'Aek Ledong');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (88, 'Kecamatan Aek Songsongan', 3, 'Aek Songsongan');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (89, 'Kecamatan Rahuning', 3, 'Rahuning');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (90, 'Kecamatan Pulau Rakyat', 3, 'Pulau Rakyat');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (91, 'Kecamatan Sei Kepayang', 3, 'Sei Kepayang');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (92, 'Kecamatan Sei Kepayang Barat', 3, 'Sei Kepayang Barat');
INSERT INTO public.spd_lokasi (id, lokasi, jenis_spd_id, kota) VALUES (93, 'Kecamatan Sei Kepayang Timur', 3, 'Sei Kepayang Timur');


ALTER TABLE public.spd_lokasi ENABLE TRIGGER ALL;

--
-- Data for Name: perintah_spt; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.perintah_spt DISABLE TRIGGER ALL;

INSERT INTO public.perintah_spt (id, dasar, berita, lama_perjalanan, tgl_berangkat, tgl_kembali, kendaraan, jenis_kegiatan_id, kota_tujuan_id, tempat_tujuan) VALUES (8, 'Surat Kepala KPPN Tanjungbalai No. S-291/KPN.0206/2026 Tanggal 30 April 2026 Hal : Press Release Kinerja APBN, Evaluasi Pelaksana Anggaran, Forum Konsultasi Publik dan KPPN Tanjungbalai Award Semester II Tahun 2025', 'Menghadiri Acara Sosialisasi Anti Gratifikasi, Press Release Kinerja APBN s.d April 2026, Evaluasi Pelaksana Anggaran s.d April 2026, Forum Konsultasi Publik/ Stakeholders Day dan KPPN Tanjungbalai Award atas Kinerja Semester II Tahun 2025', 1, '2026-05-06', '2026-05-06', 'kendaraan_dinas', 2, 69, 'Aula KPPN Tanjungbalai Jl. Jenderal Sudirman No. 101');
INSERT INTO public.perintah_spt (id, dasar, berita, lama_perjalanan, tgl_berangkat, tgl_kembali, kendaraan, jenis_kegiatan_id, kota_tujuan_id, tempat_tujuan) VALUES (9, '', 'Menyampaikan Nota Kredit Pengembalian Temuan BPK - RI atas Pemeriksaan LKPD Pemerintah Kabupaten Asahan Tahun Angaran 2025', 2, '2026-05-07', '2026-05-08', 'transport_umum', 1, 65, 'BPK RI Perwakilan Provinsi Sumatera Utara');


ALTER TABLE public.perintah_spt ENABLE TRIGGER ALL;

--
-- Data for Name: profiles_opd; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.profiles_opd DISABLE TRIGGER ALL;

INSERT INTO public.profiles_opd (id, nama) VALUES (1, 'Dinas Pendidikan');
INSERT INTO public.profiles_opd (id, nama) VALUES (2, 'Dinas Kesehatan');
INSERT INTO public.profiles_opd (id, nama) VALUES (3, 'UPTD Rumah Sakit Umum Daerah H. Abdul Manan Simatupang');
INSERT INTO public.profiles_opd (id, nama) VALUES (4, 'Dinas Pekerjaan Umum Dan Tata Ruang');
INSERT INTO public.profiles_opd (id, nama) VALUES (5, 'Dinas Perumahan Dan Kawasan Permukiman');
INSERT INTO public.profiles_opd (id, nama) VALUES (6, 'Badan Penanggulangan Bencana Daerah');
INSERT INTO public.profiles_opd (id, nama) VALUES (7, 'Satuan Polisi Pamong Praja');
INSERT INTO public.profiles_opd (id, nama) VALUES (8, 'Dinas Sosial');
INSERT INTO public.profiles_opd (id, nama) VALUES (9, 'Dinas Ketenagakerjaan');
INSERT INTO public.profiles_opd (id, nama) VALUES (10, 'Dinas Ketahanan Pangan');
INSERT INTO public.profiles_opd (id, nama) VALUES (11, 'Dinas Lingkungan Hidup');
INSERT INTO public.profiles_opd (id, nama) VALUES (12, 'Dinas Kependudukan Dan Pencatatan Sipil');
INSERT INTO public.profiles_opd (id, nama) VALUES (13, 'Dinas Pemberdayaan Masyarakat Dan Desa');
INSERT INTO public.profiles_opd (id, nama) VALUES (14, 'Dinas Pengendalian Penduduk, Keluarga Berencana, Pemberdayaan Perempuan Dan Perlindungan Anak');
INSERT INTO public.profiles_opd (id, nama) VALUES (15, 'Dinas Perhubungan');
INSERT INTO public.profiles_opd (id, nama) VALUES (16, 'Dinas Komunikasi Dan Informatika');
INSERT INTO public.profiles_opd (id, nama) VALUES (17, 'Dinas Koperasi, Perdagangan Dan Perindustrian');
INSERT INTO public.profiles_opd (id, nama) VALUES (18, 'Dinas Penanaman Modal Dan Pelayanan Terpadu Satu Pintu');
INSERT INTO public.profiles_opd (id, nama) VALUES (19, 'Dinas Pemuda, Olahraga Dan Pariwisata');
INSERT INTO public.profiles_opd (id, nama) VALUES (20, 'Dinas Perpustakaan Dan Arsip');
INSERT INTO public.profiles_opd (id, nama) VALUES (21, 'Dinas Perikanan');
INSERT INTO public.profiles_opd (id, nama) VALUES (22, 'Dinas Pertanian');
INSERT INTO public.profiles_opd (id, nama) VALUES (23, 'Dinas Peternakan Dan Kesehatan Hewan');
INSERT INTO public.profiles_opd (id, nama) VALUES (24, 'Sekretariat Daerah');
INSERT INTO public.profiles_opd (id, nama) VALUES (25, 'Sekretariat DPRD');
INSERT INTO public.profiles_opd (id, nama) VALUES (26, 'Badan Perencanaan Pembangunan Riset dan Inovasi Daerah');
INSERT INTO public.profiles_opd (id, nama) VALUES (27, 'Badan Keuangan Dan Aset Daerah');
INSERT INTO public.profiles_opd (id, nama) VALUES (28, 'Badan Pendapatan Daerah');
INSERT INTO public.profiles_opd (id, nama) VALUES (29, 'Badan Kepegawaian Dan Pengembangan Sumber Daya Manusia');
INSERT INTO public.profiles_opd (id, nama) VALUES (30, 'Inspektorat');
INSERT INTO public.profiles_opd (id, nama) VALUES (31, 'Badan Kesatuan Bangsa Dan Politik');
INSERT INTO public.profiles_opd (id, nama) VALUES (32, 'Kecamatan Aek Kuasan');
INSERT INTO public.profiles_opd (id, nama) VALUES (33, 'Kecamatan Aek Ledong');
INSERT INTO public.profiles_opd (id, nama) VALUES (34, 'Kecamatan Aek Songsongan');
INSERT INTO public.profiles_opd (id, nama) VALUES (35, 'Kecamatan Air Batu');
INSERT INTO public.profiles_opd (id, nama) VALUES (36, 'Kecamatan Air Joman');
INSERT INTO public.profiles_opd (id, nama) VALUES (37, 'Kecamatan Bandar Pulau');
INSERT INTO public.profiles_opd (id, nama) VALUES (38, 'Kecamatan Bandar Pasir Mandoge');
INSERT INTO public.profiles_opd (id, nama) VALUES (39, 'Kecamatan Buntu Pane');
INSERT INTO public.profiles_opd (id, nama) VALUES (40, 'Kecamatan Kota Kisaran Barat');
INSERT INTO public.profiles_opd (id, nama) VALUES (41, 'Kecamatan Kota Kisaran Timur');
INSERT INTO public.profiles_opd (id, nama) VALUES (42, 'Kecamatan Meranti');
INSERT INTO public.profiles_opd (id, nama) VALUES (43, 'Kecamatan Pulau Rakyat');
INSERT INTO public.profiles_opd (id, nama) VALUES (44, 'Kecamatan Pulo Bandring');
INSERT INTO public.profiles_opd (id, nama) VALUES (45, 'Kecamatan Rahuning');
INSERT INTO public.profiles_opd (id, nama) VALUES (46, 'Kecamatan Rawang Panca Arga');
INSERT INTO public.profiles_opd (id, nama) VALUES (47, 'Kecamatan Sei Dadap');
INSERT INTO public.profiles_opd (id, nama) VALUES (48, 'Kecamatan Sei Kepayang');
INSERT INTO public.profiles_opd (id, nama) VALUES (49, 'Kecamatan Sei Kepayang Barat');
INSERT INTO public.profiles_opd (id, nama) VALUES (50, 'Kecamatan Sei Kepayang Timur');
INSERT INTO public.profiles_opd (id, nama) VALUES (51, 'Kecamatan Setia Janji');
INSERT INTO public.profiles_opd (id, nama) VALUES (52, 'Kecamatan Silau Laut');
INSERT INTO public.profiles_opd (id, nama) VALUES (53, 'Kecamatan Simpang Empat');
INSERT INTO public.profiles_opd (id, nama) VALUES (54, 'Kecamatan Tanjung Balai');
INSERT INTO public.profiles_opd (id, nama) VALUES (55, 'Kecamatan Teluk Dalam');
INSERT INTO public.profiles_opd (id, nama) VALUES (56, 'Kecamatan Tinggi Raja');
INSERT INTO public.profiles_opd (id, nama) VALUES (57, 'Bupati Asahan');
INSERT INTO public.profiles_opd (id, nama) VALUES (58, 'Wakil Bupati Asahan');


ALTER TABLE public.profiles_opd ENABLE TRIGGER ALL;

--
-- Data for Name: umum_eselon; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_eselon DISABLE TRIGGER ALL;

INSERT INTO public.umum_eselon (id, eselon, keterangan) VALUES (1, 'I', 'Eselon I');
INSERT INTO public.umum_eselon (id, eselon, keterangan) VALUES (2, 'II', 'Eselon II');
INSERT INTO public.umum_eselon (id, eselon, keterangan) VALUES (3, 'III', 'Eselon III');
INSERT INTO public.umum_eselon (id, eselon, keterangan) VALUES (4, 'IV', 'Eselon IV');
INSERT INTO public.umum_eselon (id, eselon, keterangan) VALUES (5, 'Non Eselon', 'Staf');


ALTER TABLE public.umum_eselon ENABLE TRIGGER ALL;

--
-- Data for Name: umum_jenisjabatan; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_jenisjabatan DISABLE TRIGGER ALL;

INSERT INTO public.umum_jenisjabatan (id, nama, fungsi, keterangan) VALUES (1, 'Defenitif', 'pejabat yang memegang jabatan secara tetap dan sah', 'Jabatan Tetap');
INSERT INTO public.umum_jenisjabatan (id, nama, fungsi, keterangan) VALUES (2, 'Plt.', 'pejabat yang melaksanakan tugas rutin dari pejabat definitif yang berhalangan tetap', 'Pelaksana Tugas');
INSERT INTO public.umum_jenisjabatan (id, nama, fungsi, keterangan) VALUES (3, 'Plh.', 'pejabat yang melaksanakan tugas rutin dari pejabat definitif yang berhalangan sementara', 'Pelaksana Harian');
INSERT INTO public.umum_jenisjabatan (id, nama, fungsi, keterangan) VALUES (4, 'Pj.', 'menggantikan pejabat definitif kepala daerah yang berhalangan tetap', 'Penjabat');
INSERT INTO public.umum_jenisjabatan (id, nama, fungsi, keterangan) VALUES (5, 'Pjs.', 'menggantikan pejabat definitif kepala daerah yang berhalangan sementara karena menjalankan cuti di luar tanggungan negara', 'Penjabat Sementara');


ALTER TABLE public.umum_jenisjabatan ENABLE TRIGGER ALL;

--
-- Data for Name: umum_pangkat; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_pangkat DISABLE TRIGGER ALL;

INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (1, 'Juru Muda', 'I', 'a');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (2, 'Juru Muda Tk.  I', 'I', 'b');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (3, 'Juru', 'I', 'c');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (4, 'Juru Tk.  I', 'I', 'd');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (5, 'Pengatur Muda', 'II', 'a');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (6, 'Pengatur Muda Tk.  I', 'II', 'b');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (7, 'Pengatur', 'II', 'c');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (8, 'Pengatur Tk. I', 'II', 'd');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (9, 'Penata Muda', 'III', 'a');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (10, 'Penata Muda Tk.  I', 'III', 'b');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (11, 'Penata', 'III', 'c');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (12, 'Penata Tk.  I', 'III', 'd');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (13, 'Pembina', 'IV', 'a');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (14, 'Pembina Tk.  I', 'IV', 'b');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (15, 'Pembina Utama Muda', 'IV', 'c');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (16, 'Pembina Utama Madya', 'IV', 'd');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (17, 'Pembina Utama', 'IV', 'e');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (18, 'Pemula', 'V', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (19, 'Terampil', 'VI', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (20, 'Terampil', 'VII', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (21, 'Mahir', 'IX', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (22, 'Penyelia', 'X', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (23, 'Ahli Muda', 'XI', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (24, 'Lektor', 'XII', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (25, 'Ahli Madya', 'XIII', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (26, 'Lektor Kepala', 'XIV', '');
INSERT INTO public.umum_pangkat (id, pangkat, golongan, ruang) VALUES (27, 'Ahli Utama', 'XVI', '');


ALTER TABLE public.umum_pangkat ENABLE TRIGGER ALL;

--
-- Data for Name: umum_statusasn; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_statusasn DISABLE TRIGGER ALL;

INSERT INTO public.umum_statusasn (id, nama) VALUES (1, 'PNS');
INSERT INTO public.umum_statusasn (id, nama) VALUES (2, 'PPPK');
INSERT INTO public.umum_statusasn (id, nama) VALUES (3, 'PPPKPW');


ALTER TABLE public.umum_statusasn ENABLE TRIGGER ALL;

--
-- Data for Name: umum_tingkat; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_tingkat DISABLE TRIGGER ALL;

INSERT INTO public.umum_tingkat (id, tingkat, ket, kapal, keretaapian, lainnya, pesawat) VALUES (1, 'A', 'Bupati/ Wakil Bupati dan Pimpinan DPRD', 'Vip/ Kelas I A', 'Eksekutif', 'Sesuai Kenyataan', 'Bisnis');
INSERT INTO public.umum_tingkat (id, tingkat, ket, kapal, keretaapian, lainnya, pesawat) VALUES (2, 'B', 'Pejabat Eselon II (Pejabat Pimpinan Tinggi Pratama) dan Anggota DPRD', 'Kelas I B', 'Eksekutif', 'Sesuai Kenyataan', 'Ekonomi');
INSERT INTO public.umum_tingkat (id, tingkat, ket, kapal, keretaapian, lainnya, pesawat) VALUES (3, 'C', 'Pejabat Eselon III (Pejabat Administrator), Pejabat Fungsional Ahli Utama, Pejabat Fungsional Ahli Madya, dan PNS Golongan IV (Jabatan Pelaksana)', 'Kelas I B', 'Eksekutif', 'Sesuai Kenyataan', 'Ekonomi');
INSERT INTO public.umum_tingkat (id, tingkat, ket, kapal, keretaapian, lainnya, pesawat) VALUES (4, 'D', 'Pejabat Eselon IV (Pejabat Pengawas), Jafung Ahli Muda, Jafung Ahli Pratama, Jafung Mahir, Jafung Penyelia, ASN Gol. III (JP), Jafung Terampil, ASN Gol. II dan Gol. I (JP), PPPK', 'Kelas I B', 'Eksekutif', 'Sesuai Kenyataan', 'Ekonomi');


ALTER TABLE public.umum_tingkat ENABLE TRIGGER ALL;

--
-- Data for Name: umum_pegawai; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_pegawai DISABLE TRIGGER ALL;

INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (1, '197305071992032001', 'Sri Lusi Masdiany, S.I.P.                                            ', 'Sekretaris Badan Keuangan dan Aset Daerah', '1973-05-07', 1, 27, 14, 1, 3, 3);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (2, '198004212009011002', 'M. Idris S.Pd.I, M.Si.', 'Kabid Aset', '1980-04-21', 1, 27, 12, 1, 3, 3);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (3, '197604072009031002', 'Chairun Nasri Hutagaol, S.E.', 'Kabid Perbendaharaan', '1976-04-07', 1, 27, 13, 1, 3, 3);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (4, '199408012018081001', 'Ashdillah Putra, S.Stp.', 'Kabid Anggaran', '1994-08-01', 1, 27, 11, 1, 3, 3);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (5, '198302172002121004', 'Herdi Siagian, S.H.                                 ', 'Kabid Akuntansi dan Pelaporan', '1983-02-17', 1, 27, 13, 1, 3, 3);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (6, '196904241989032005', 'Nilawati, S.H.                                          ', 'Analis Perencana Muda', '1969-04-24', 1, 27, 12, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (7, '197210301993032004', 'Sumarmiati, S.E.                                    ', 'Kasubbid Perbendaharaan', '1972-10-30', 1, 27, 12, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (8, '197902232000032002', 'Elvirawati,  S.E.                                          ', 'Kasubbid Akuntansi dan Pelaporan Penerimaan', '1979-02-23', 1, 27, 12, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (9, '197807152009011004', 'Budi Syahriza, S.H.                  ', 'Kasubbid Akuntansi dan Pelaporan Pengeluaran', '1978-07-15', 1, 27, 11, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (10, '197807222009032003', 'Dwi Priyayi Sugesti, S.E.                       ', 'Kasubbid Pencatatan, Pelaporan dan Analisa Kebutuhan Barang Daerah', '1978-07-22', 1, 27, 12, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (11, '196806011993032002', 'Vera Yuninda                                ', 'Kasubbag Umum Dan Kepegawaian', '1968-06-01', 1, 27, 12, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (12, '197604142009032002', 'Erna Komalasari, S.T.                                     ', 'Kasubbid Pemeliharaan dan Penghapusan', '1976-04-14', 1, 27, 11, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (13, '198309142005022001', 'Lusy Elidha, S.E.                                  ', 'Kasubbid Pengelolaan Kas', '1983-09-14', 1, 27, 12, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (14, '198004132009011003', 'Afri Chandra Kirana, S.E.                               ', 'Kasubbid Anggaran I', '1980-04-13', 1, 27, 11, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (15, '198405182010012008', 'Kusuma Aprina Siagian, S.E.                                 ', 'Kasubbid Anggaran II', '1984-05-18', 1, 27, 10, 1, 4, 4);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (17, '198112072009011004', 'Guslan Harahap, S.M.', 'Penelaah Teknis Kebijakan', '1981-12-07', 1, 27, 8, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (18, '196806031992032004', 'Nurhamidah Siregar', 'Pengelola Data Dan Informasi', '1968-06-03', 1, 27, 10, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (19, '198105062010011004', 'Irvan Syahputra, S.M.', 'Pengelola Data Dan Informasi', '1981-05-06', 1, 27, 9, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (20, '198606082009032007', 'Nasiah, S.E.', 'Penelaah Teknis Kebijakan', '1986-06-08', 1, 27, 12, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (21, '198404292010011002', 'Firmansyah Tarigan S', 'Administrasi Perkantoran', '1984-04-29', 1, 27, 8, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (22, '197507212009012003', 'Nuraini, S. Sos', 'Penelaah Teknis Kebijakan', '1975-07-21', 1, 27, 12, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (23, '197806052009012003', 'Yulita Elfika Siregar, S.E.', 'Penelaah Teknis Kebijakan', '1978-06-05', 1, 27, 11, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (24, '197410282008012002', 'Rosdawaty, S.E.', 'Pengelola Data Dan Informasi', '1974-10-28', 1, 27, 11, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (25, '198309292011011013', 'Rahmad Saleh Sitorus, S.Kom.                   ', 'Pengelola Data Dan Informasi', '1983-09-29', NULL, 27, 10, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (26, '198010262009011002', 'Hendrik , S.M.                                            ', 'Administrasi Perkantoran', '1980-10-26', NULL, 27, 9, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (27, '197210262008011001', 'Muh. Arfi                                                      ', 'Administrasi Perkantoran', '1972-10-26', NULL, 27, 5, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (28, '197811012005022001', 'Herlin Tanujaya, S.E.', 'Penelaah Teknis Kebijakan', '1978-11-01', NULL, 27, 12, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (29, '197009122002122004', 'Rosmidawati, S.E.                                 ', 'Penelaah Teknis Kebijakan', '1970-09-12', NULL, 27, 12, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (30, '198206262010012001', 'T. Dhani Vaulina                                 ', 'Penelaah Teknis Kebijakan', '1982-06-26', NULL, 27, 10, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (31, '198101122009011004', 'Muhammad Syafri                                      ', 'Pengelola Data Dan Informasi', '1981-01-12', NULL, 27, 9, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (32, '196812061989032005', 'Heryanti, S.H.                                     ', 'Penelaah Teknis Kebijakan', '1968-12-06', NULL, 27, 12, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (33, '197808142005022002', 'Rubiah, S.S.                                      ', 'Pengelola Data Dan Informasi', '1978-08-14', NULL, 27, 11, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (34, '198805202022031001', 'Eddy Haris Siregar, S.E.', 'Penelaah Teknis Kebijakan', '1988-05-20', NULL, 27, 9, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (35, '199611242025062003', 'Dessy Permatasari, S.Ak.', 'Analis Keuangan Pusat Dan Daerah Ahli Pertama', '1996-11-24', NULL, 27, 9, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (36, '200203022025062003', 'Pratiwi, S.Ak.', 'Analis Keuangan Pusat Dan Daerah Ahli Pertama', '2002-03-02', NULL, 27, 9, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (37, '197303262006041006', 'Irwan', 'Administrasi Perkantoran', '1973-03-26', NULL, 27, 7, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (39, '197403092025212002', 'Nani Susanti', 'Pengadministrasi Pekantoran', '1974-03-09', NULL, 27, 18, 2, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (40, '198508312025212011', 'Tri Eva Yanti', 'Pengadministrasi Pekantoran', '1985-08-31', NULL, 27, 18, 2, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (41, '199612312025212019', 'Dinda Khofifah', 'Pengelola Layanan Operasional', '1996-12-31', NULL, 27, 20, 2, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (42, '198404142025211024', 'Tri Agung Anugerah', 'Penata Layanan Operasional', '1984-04-14', NULL, 27, 21, 2, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (43, '198303262025212016', 'Tuti Mulyani', 'Pengadministrasi Pekantoran', '1983-03-26', NULL, 27, 18, 2, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (44, '198208112025211058', 'Muhammad.Arif Effendi, S.E.', 'Penata Layanan Operasional', '1982-08-11', NULL, 27, NULL, 3, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (16, '198109022009012004', 'Kamis Riati', 'Pengelola Data Dan Informasi', '1981-09-02', 1, 27, 9, 1, 4, 5);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (38, '197903252008011002', 'Oman Surahman                                          ', 'Pengelola Data Dan Informasi', '1979-03-25', NULL, 27, 5, 1, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (45, '198703072025211140', 'M.Yusuf Butar Butar', 'Penata Layanan Operasional', '1987-03-07', NULL, 27, NULL, 3, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (46, '199009292025212132', 'Lisa Maya Sarie', 'Operator Layanan Operasional', '1990-09-29', NULL, 27, NULL, 3, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (47, '199501172025212059', 'Thivani Amanda Tanjung', 'Operator Layanan Operasional', '1995-01-17', NULL, 27, NULL, 3, 4, NULL);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (48, '197305071992032001', 'Sri Lusi Masdiany, S.I.P.', 'Plt. Kepala Badan Keuangan dan Aset Daerah', '1973-05-07', 2, 27, 14, 1, 2, 2);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (49, '196703071993031020', 'Budi Sianturi', 'Kepala Dinas Pendidikan', '1967-03-07', 1, 1, 13, 1, 2, 2);
INSERT INTO public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id) VALUES (50, '197305071992032023', 'Helana Hutasoit', 'Kepala Bidang Sekolah Dasar', '1973-05-07', 1, 1, 12, 1, 3, 3);


ALTER TABLE public.umum_pegawai ENABLE TRIGGER ALL;

--
-- Data for Name: perintah_pelaksana; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.perintah_pelaksana DISABLE TRIGGER ALL;

INSERT INTO public.perintah_pelaksana (id, nama_id, spt_id) VALUES (25, 3, 8);
INSERT INTO public.perintah_pelaksana (id, nama_id, spt_id) VALUES (26, 25, 8);
INSERT INTO public.perintah_pelaksana (id, nama_id, spt_id) VALUES (27, 22, 9);
INSERT INTO public.perintah_pelaksana (id, nama_id, spt_id) VALUES (28, 25, 9);
INSERT INTO public.perintah_pelaksana (id, nama_id, spt_id) VALUES (29, 26, 9);
INSERT INTO public.perintah_pelaksana (id, nama_id, spt_id) VALUES (30, 35, 9);


ALTER TABLE public.perintah_pelaksana ENABLE TRIGGER ALL;

--
-- Data for Name: umum_penandatangan; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_penandatangan DISABLE TRIGGER ALL;

INSERT INTO public.umum_penandatangan (id, nama, nip, tugas, jenis_jabatan_id, opd_id, pangkat_id) VALUES (1, 'Taufik Zainal Abidin', NULL, 'Bupati', 1, 57, NULL);
INSERT INTO public.umum_penandatangan (id, nama, nip, tugas, jenis_jabatan_id, opd_id, pangkat_id) VALUES (2, 'Rianto', NULL, 'Wakil Bupati', 1, 58, NULL);
INSERT INTO public.umum_penandatangan (id, nama, nip, tugas, jenis_jabatan_id, opd_id, pangkat_id) VALUES (6, 'Drs. H. Zainal Aripin Sinaga, M.H.', '196703071993031010', 'Sekretaris Daerah', 1, 24, 15);
INSERT INTO public.umum_penandatangan (id, nama, nip, tugas, jenis_jabatan_id, opd_id, pangkat_id) VALUES (7, 'Budi Sianturi', '196703071993031020', 'Kepala', 1, 1, 13);
INSERT INTO public.umum_penandatangan (id, nama, nip, tugas, jenis_jabatan_id, opd_id, pangkat_id) VALUES (8, 'Azrai Sinaga', '199002042005011001', 'PPK', 1, 1, 10);
INSERT INTO public.umum_penandatangan (id, nama, nip, tugas, jenis_jabatan_id, opd_id, pangkat_id) VALUES (3, 'Sri Lusi Masdiany, S.I.P.', '197305071992032001', 'Kepala', 2, 27, 14);
INSERT INTO public.umum_penandatangan (id, nama, nip, tugas, jenis_jabatan_id, opd_id, pangkat_id) VALUES (4, 'M. Idris, S.Pd.I.,M.Si.', '198004212009011002', 'PPK', 1, 27, 13);


ALTER TABLE public.umum_penandatangan ENABLE TRIGGER ALL;

--
-- Data for Name: perintah_pemberitugas; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.perintah_pemberitugas DISABLE TRIGGER ALL;

INSERT INTO public.perintah_pemberitugas (id, nama, nip, pangkat, tugas, jenis_jabatan, opd, penandatangan_id, spt_id, nomor_spt, tanggal_spt, nomor_spd, nomor_urut) VALUES (14, 'Sri Lusi Masdiany, S.I.P.', '197305071992032001', 'Pembina Tk.  I', 'Kepala', 'Plt.', 'Badan Keuangan Dan Aset Daerah', 3, 8, '', '2026-05-06', '', '');
INSERT INTO public.perintah_pemberitugas (id, nama, nip, pangkat, tugas, jenis_jabatan, opd, penandatangan_id, spt_id, nomor_spt, tanggal_spt, nomor_spd, nomor_urut) VALUES (15, 'Sri Lusi Masdiany, S.I.P.', '197305071992032001', 'Pembina Tk.  I', 'Kepala', 'Plt.', 'Badan Keuangan Dan Aset Daerah', 3, 9, '', '2026-05-06', '', '');


ALTER TABLE public.perintah_pemberitugas ENABLE TRIGGER ALL;

--
-- Data for Name: profiles_userprofile; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.profiles_userprofile DISABLE TRIGGER ALL;

INSERT INTO public.profiles_userprofile (id, opd_id, role_id, user_id) VALUES (1, 1, 1, 8);
INSERT INTO public.profiles_userprofile (id, opd_id, role_id, user_id) VALUES (2, 27, 2, 9);
INSERT INTO public.profiles_userprofile (id, opd_id, role_id, user_id) VALUES (3, 27, 1, 10);


ALTER TABLE public.profiles_userprofile ENABLE TRIGGER ALL;

--
-- Data for Name: spd_dasarperaturan; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_dasarperaturan DISABLE TRIGGER ALL;

INSERT INTO public.spd_dasarperaturan (id, nama_peraturan, nomor_peraturan, tanggal_peraturan, keterangan, aktif, created_at, updated_at) VALUES (1, 'Peraturan Bupati Asahan', '4 Tahun 2026', '2026-12-02', 'Perjalanan Dinas dalam Negeri Bagi Pejabat Negara, Pejabat Daerah, Aparatur Sipil Negara, dan Pihak Lain', true, '2026-04-23 09:39:46.786136+00', '2026-04-23 09:40:50.42632+00');


ALTER TABLE public.spd_dasarperaturan ENABLE TRIGGER ALL;

--
-- Data for Name: spd_jenistransportasi; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_jenistransportasi DISABLE TRIGGER ALL;

INSERT INTO public.spd_jenistransportasi (id, nama) VALUES (1, 'Taksi');
INSERT INTO public.spd_jenistransportasi (id, nama) VALUES (2, 'Transportasi Darat');
INSERT INTO public.spd_jenistransportasi (id, nama) VALUES (3, 'Sewa Kendaraan');


ALTER TABLE public.spd_jenistransportasi ENABLE TRIGGER ALL;

--
-- Data for Name: spd_standardpenginapan; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_standardpenginapan DISABLE TRIGGER ALL;

INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (2, '2026-04-24 09:05:04.480508+00', '2026-04-24 09:05:04.480534+00', 4420000.00, 1, 1, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (3, '2026-04-24 09:05:04.525999+00', '2026-04-24 09:05:04.526034+00', 4960000.00, 1, 2, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (4, '2026-04-24 09:05:04.543703+00', '2026-04-24 09:05:04.543743+00', 3820000.00, 1, 3, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (5, '2026-04-24 09:05:04.563362+00', '2026-04-24 09:05:04.563396+00', 5344000.00, 1, 4, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (6, '2026-04-24 09:05:04.577413+00', '2026-04-24 09:05:04.577452+00', 5000000.00, 1, 5, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (7, '2026-04-24 09:05:04.59577+00', '2026-04-24 09:05:04.595813+00', 5236000.00, 1, 6, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (8, '2026-04-24 09:05:04.612324+00', '2026-04-24 09:05:04.612371+00', 5850000.00, 1, 7, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (9, '2026-04-24 09:05:04.628774+00', '2026-04-24 09:05:04.628812+00', 4491000.00, 1, 8, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (10, '2026-04-24 09:05:04.644095+00', '2026-04-24 09:05:04.644135+00', 2140000.00, 1, 9, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (11, '2026-04-24 09:05:04.661054+00', '2026-04-24 09:05:04.661091+00', 3827000.00, 1, 10, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (12, '2026-04-24 09:05:04.678279+00', '2026-04-24 09:05:04.678368+00', 5725000.00, 1, 11, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (13, '2026-04-24 09:05:04.697792+00', '2026-04-24 09:05:04.697857+00', 5381000.00, 1, 12, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (14, '2026-04-24 09:05:04.72052+00', '2026-04-24 09:05:04.720563+00', 8720000.00, 1, 13, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (15, '2026-04-24 09:05:04.736994+00', '2026-04-24 09:05:04.737036+00', 5303000.00, 1, 14, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (16, '2026-04-24 09:05:04.753577+00', '2026-04-24 09:05:04.753618+00', 5017000.00, 1, 15, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (17, '2026-04-24 09:05:04.770066+00', '2026-04-24 09:05:04.770108+00', 4449000.00, 1, 16, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (18, '2026-04-24 09:05:04.787336+00', '2026-04-24 09:05:04.78738+00', 6848000.00, 1, 17, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (19, '2026-04-24 09:05:04.80271+00', '2026-04-24 09:05:04.802751+00', 4375000.00, 1, 18, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (20, '2026-04-24 09:05:04.820366+00', '2026-04-24 09:05:04.82041+00', 3750000.00, 1, 19, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (21, '2026-04-24 09:05:04.83775+00', '2026-04-24 09:05:04.837799+00', 2654000.00, 1, 20, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (22, '2026-04-24 09:05:04.854601+00', '2026-04-24 09:05:04.854643+00', 4901000.00, 1, 21, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (23, '2026-04-24 09:05:04.870809+00', '2026-04-24 09:05:04.87085+00', 4797000.00, 1, 22, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (24, '2026-04-24 09:05:04.887688+00', '2026-04-24 09:05:04.88773+00', 4000000.00, 1, 23, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (25, '2026-04-24 09:05:04.904725+00', '2026-04-24 09:05:04.904766+00', 4000000.00, 1, 24, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (26, '2026-04-24 09:05:04.920815+00', '2026-04-24 09:05:04.920856+00', 4919000.00, 1, 25, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (27, '2026-04-24 09:05:04.937793+00', '2026-04-24 09:05:04.937837+00', 4168000.00, 1, 26, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (28, '2026-04-24 09:05:04.953773+00', '2026-04-24 09:05:04.953819+00', 4076000.00, 1, 27, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (29, '2026-04-24 09:05:04.970465+00', '2026-04-24 09:05:04.97051+00', 4820000.00, 1, 28, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (30, '2026-04-24 09:05:04.987107+00', '2026-04-24 09:05:04.987149+00', 2309000.00, 1, 29, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (31, '2026-04-24 09:05:05.003663+00', '2026-04-24 09:05:05.003704+00', 3088800.00, 1, 30, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (32, '2026-04-24 09:05:05.020933+00', '2026-04-24 09:05:05.020975+00', 3467000.00, 1, 31, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (33, '2026-04-24 09:05:05.037205+00', '2026-04-24 09:05:05.037247+00', 4611600.00, 1, 32, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (34, '2026-04-24 09:05:05.053637+00', '2026-04-24 09:05:05.053679+00', 3859000.00, 1, 33, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (35, '2026-04-24 09:05:05.070433+00', '2026-04-24 09:05:05.070476+00', 3872000.00, 1, 34, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (36, '2026-04-24 09:05:05.087611+00', '2026-04-24 09:05:05.087678+00', 3872000.00, 1, 35, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (37, '2026-04-24 09:05:05.103346+00', '2026-04-24 09:05:05.103392+00', 3859000.00, 1, 36, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (38, '2026-04-24 09:05:05.120436+00', '2026-04-24 09:05:05.120478+00', 5673000.00, 1, 37, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (39, '2026-04-24 09:05:05.137114+00', '2026-04-24 09:05:05.137156+00', 5711000.00, 1, 38, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (40, '2026-04-24 09:05:05.153994+00', '2026-04-24 09:05:05.154035+00', 3526000.00, 1, 1, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (41, '2026-04-24 09:05:05.174228+00', '2026-04-24 09:05:05.174257+00', 2195000.00, 1, 2, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (42, '2026-04-24 09:05:05.19081+00', '2026-04-24 09:05:05.190842+00', 3119000.00, 1, 3, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (43, '2026-04-24 09:05:05.206109+00', '2026-04-24 09:05:05.206129+00', 2318000.00, 1, 4, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (44, '2026-04-24 09:05:05.214034+00', '2026-04-24 09:05:05.214054+00', 4102000.00, 1, 5, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (45, '2026-04-24 09:05:05.221973+00', '2026-04-24 09:05:05.221992+00', 3332000.00, 1, 6, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (46, '2026-04-24 09:05:05.230154+00', '2026-04-24 09:05:05.230173+00', 3083000.00, 1, 7, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (47, '2026-04-24 09:05:05.241298+00', '2026-04-24 09:05:05.24135+00', 2488000.00, 1, 8, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (48, '2026-04-24 09:05:05.257294+00', '2026-04-24 09:05:05.257339+00', 1628000.00, 1, 9, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (49, '2026-04-24 09:05:05.274026+00', '2026-04-24 09:05:05.274052+00', 2838000.00, 1, 10, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (50, '2026-04-24 09:05:05.290708+00', '2026-04-24 09:05:05.290729+00', 2373000.00, 1, 11, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (51, '2026-04-24 09:05:05.305769+00', '2026-04-24 09:05:05.305789+00', 2755000.00, 1, 12, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (52, '2026-04-24 09:05:05.314479+00', '2026-04-24 09:05:05.3145+00', 2063000.00, 1, 13, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (53, '2026-04-24 09:05:05.324775+00', '2026-04-24 09:05:05.324796+00', 1850000.00, 1, 14, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (54, '2026-04-24 09:05:05.394687+00', '2026-04-24 09:05:05.394728+00', 2695000.00, 1, 15, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (55, '2026-04-24 09:05:05.411694+00', '2026-04-24 09:05:05.411737+00', 2007000.00, 1, 16, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (56, '2026-04-24 09:05:05.428032+00', '2026-04-24 09:05:05.428074+00', 2433000.00, 1, 17, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (57, '2026-04-24 09:05:05.44523+00', '2026-04-24 09:05:05.445273+00', 2648000.00, 1, 18, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (58, '2026-04-24 09:05:05.465721+00', '2026-04-24 09:05:05.46578+00', 2133000.00, 1, 19, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (59, '2026-04-24 09:05:05.487501+00', '2026-04-24 09:05:05.487543+00', 1923000.00, 1, 20, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (60, '2026-04-24 09:05:05.503584+00', '2026-04-24 09:05:05.503626+00', 3391000.00, 1, 21, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (61, '2026-04-24 09:05:05.520597+00', '2026-04-24 09:05:05.520638+00', 3316000.00, 1, 22, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (62, '2026-04-24 09:05:05.536213+00', '2026-04-24 09:05:05.536256+00', 2188000.00, 1, 23, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (63, '2026-04-24 09:05:05.552631+00', '2026-04-24 09:05:05.552672+00', 2735000.00, 1, 24, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (64, '2026-04-24 09:05:05.601227+00', '2026-04-24 09:05:05.601268+00', 2290000.00, 1, 25, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (65, '2026-04-24 09:05:05.629338+00', '2026-04-24 09:05:05.629381+00', 3107000.00, 1, 26, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (66, '2026-04-24 09:05:05.645898+00', '2026-04-24 09:05:05.64594+00', 3098000.00, 1, 27, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (67, '2026-04-24 09:05:05.661348+00', '2026-04-24 09:05:05.661391+00', 1938000.00, 1, 28, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (68, '2026-04-24 09:05:05.678625+00', '2026-04-24 09:05:05.678667+00', 2027000.00, 1, 29, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (69, '2026-04-24 09:05:05.696827+00', '2026-04-24 09:05:05.696871+00', 2574000.00, 1, 30, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (70, '2026-04-24 09:05:05.71119+00', '2026-04-24 09:05:05.711233+00', 3240000.00, 1, 31, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (71, '2026-04-24 09:05:05.727878+00', '2026-04-24 09:05:05.727919+00', 3843000.00, 1, 32, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (72, '2026-04-24 09:05:05.745243+00', '2026-04-24 09:05:05.745286+00', 3318000.00, 1, 33, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (73, '2026-04-24 09:05:05.762142+00', '2026-04-24 09:05:05.762183+00', 3341000.00, 1, 34, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (74, '2026-04-24 09:05:05.778887+00', '2026-04-24 09:05:05.778931+00', 3341000.00, 1, 35, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (75, '2026-04-24 09:05:05.795979+00', '2026-04-24 09:05:05.796022+00', 3318000.00, 1, 36, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (76, '2026-04-24 09:05:05.812486+00', '2026-04-24 09:05:05.812528+00', 4877000.00, 1, 37, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (77, '2026-04-24 09:05:05.829194+00', '2026-04-24 09:05:05.829235+00', 4911000.00, 1, 38, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (78, '2026-04-24 09:05:05.846342+00', '2026-04-24 09:05:05.846387+00', 1533000.00, 1, 1, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (79, '2026-04-24 09:05:05.861196+00', '2026-04-24 09:05:05.861238+00', 1100000.00, 1, 2, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (80, '2026-04-24 09:05:05.87815+00', '2026-04-24 09:05:05.878191+00', 1650000.00, 1, 3, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (81, '2026-04-24 09:05:05.897416+00', '2026-04-24 09:05:05.897459+00', 1297000.00, 1, 4, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (82, '2026-04-24 09:05:05.921152+00', '2026-04-24 09:05:05.921194+00', 1225000.00, 1, 5, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (83, '2026-04-24 09:05:05.938237+00', '2026-04-24 09:05:05.938279+00', 1353000.00, 1, 6, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (84, '2026-04-24 09:05:05.954194+00', '2026-04-24 09:05:05.954236+00', 1955000.00, 1, 7, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (85, '2026-04-24 09:05:05.971214+00', '2026-04-24 09:05:05.971257+00', 1425000.00, 1, 8, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (86, '2026-04-24 09:05:05.987722+00', '2026-04-24 09:05:05.987766+00', 1546000.00, 1, 9, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (87, '2026-04-24 09:05:06.004362+00', '2026-04-24 09:05:06.004406+00', 1957000.00, 1, 10, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (88, '2026-04-24 09:05:06.021018+00', '2026-04-24 09:05:06.021067+00', 1204000.00, 1, 11, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (89, '2026-04-24 09:05:06.036652+00', '2026-04-24 09:05:06.036694+00', 1201000.00, 1, 12, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (90, '2026-04-24 09:05:06.054188+00', '2026-04-24 09:05:06.054232+00', 992000.00, 1, 13, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (91, '2026-04-24 09:05:06.071285+00', '2026-04-24 09:05:06.071377+00', 1201000.00, 1, 14, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (92, '2026-04-24 09:05:06.087905+00', '2026-04-24 09:05:06.087948+00', 1384000.00, 1, 15, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (93, '2026-04-24 09:05:06.103221+00', '2026-04-24 09:05:06.103263+00', 1153000.00, 1, 16, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (94, '2026-04-24 09:05:06.119731+00', '2026-04-24 09:05:06.119773+00', 1685000.00, 1, 17, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (95, '2026-04-24 09:05:06.136663+00', '2026-04-24 09:05:06.136705+00', 1418000.00, 1, 18, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (96, '2026-04-24 09:05:06.154279+00', '2026-04-24 09:05:06.154363+00', 1355000.00, 1, 19, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (97, '2026-04-24 09:05:06.170613+00', '2026-04-24 09:05:06.170656+00', 1125000.00, 1, 20, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (98, '2026-04-24 09:05:06.187441+00', '2026-04-24 09:05:06.187485+00', 1160000.00, 1, 21, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (99, '2026-04-24 09:05:06.204207+00', '2026-04-24 09:05:06.204249+00', 1500000.00, 1, 22, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (100, '2026-04-24 09:05:06.220882+00', '2026-04-24 09:05:06.220922+00', 1507000.00, 1, 23, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (101, '2026-04-24 09:05:06.237463+00', '2026-04-24 09:05:06.237505+00', 1507000.00, 1, 24, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (102, '2026-04-24 09:05:06.253247+00', '2026-04-24 09:05:06.253289+00', 1207000.00, 1, 25, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (103, '2026-04-24 09:05:06.26996+00', '2026-04-24 09:05:06.270003+00', 1606000.00, 1, 26, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (104, '2026-04-24 09:05:06.286805+00', '2026-04-24 09:05:06.286848+00', 1344000.00, 1, 27, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (105, '2026-04-24 09:05:06.304175+00', '2026-04-24 09:05:06.304216+00', 1423000.00, 1, 28, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (106, '2026-04-24 09:05:06.320934+00', '2026-04-24 09:05:06.320976+00', 1679000.00, 1, 29, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (107, '2026-04-24 09:05:06.3377+00', '2026-04-24 09:05:06.337743+00', 1297000.00, 1, 30, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (108, '2026-04-24 09:05:06.353526+00', '2026-04-24 09:05:06.353567+00', 1059000.00, 1, 31, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (109, '2026-04-24 09:05:06.371259+00', '2026-04-24 09:05:06.3713+00', 1160000.00, 1, 32, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (110, '2026-04-24 09:05:06.387403+00', '2026-04-24 09:05:06.387446+00', 2521000.00, 1, 33, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (111, '2026-04-24 09:05:06.404467+00', '2026-04-24 09:05:06.404509+00', 2056000.00, 1, 34, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (112, '2026-04-24 09:05:06.420691+00', '2026-04-24 09:05:06.420734+00', 2056000.00, 1, 35, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (113, '2026-04-24 09:05:06.437685+00', '2026-04-24 09:05:06.437725+00', 2521000.00, 1, 36, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (114, '2026-04-24 09:05:06.454109+00', '2026-04-24 09:05:06.45415+00', 3706000.00, 1, 37, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (115, '2026-04-24 09:05:06.469595+00', '2026-04-24 09:05:06.469637+00', 3731000.00, 1, 38, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (116, '2026-04-24 09:05:06.486529+00', '2026-04-24 09:05:06.486571+00', 770000.00, 1, 1, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (117, '2026-04-24 09:05:06.503707+00', '2026-04-24 09:05:06.50375+00', 699000.00, 1, 2, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (118, '2026-04-24 09:05:06.519939+00', '2026-04-24 09:05:06.519982+00', 852000.00, 1, 3, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (119, '2026-04-24 09:05:06.536566+00', '2026-04-24 09:05:06.536608+00', 792000.00, 1, 4, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (120, '2026-04-24 09:05:06.553146+00', '2026-04-24 09:05:06.553188+00', 580000.00, 1, 5, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (121, '2026-04-24 09:05:06.569737+00', '2026-04-24 09:05:06.569778+00', 701000.00, 1, 6, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (122, '2026-04-24 09:05:06.587572+00', '2026-04-24 09:05:06.587614+00', 861000.00, 1, 7, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (123, '2026-04-24 09:05:06.603054+00', '2026-04-24 09:05:06.603096+00', 580000.00, 1, 8, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (124, '2026-04-24 09:05:06.620999+00', '2026-04-24 09:05:06.62104+00', 692000.00, 1, 9, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (125, '2026-04-24 09:05:06.637752+00', '2026-04-24 09:05:06.637792+00', 649000.00, 1, 10, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (126, '2026-04-24 09:05:06.653533+00', '2026-04-24 09:05:06.653576+00', 724000.00, 1, 11, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (127, '2026-04-24 09:05:06.669971+00', '2026-04-24 09:05:06.670013+00', 686000.00, 1, 12, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (128, '2026-04-24 09:05:06.686499+00', '2026-04-24 09:05:06.68654+00', 730000.00, 1, 13, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (129, '2026-04-24 09:05:06.705908+00', '2026-04-24 09:05:06.705952+00', 750000.00, 1, 14, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (130, '2026-04-24 09:05:06.729215+00', '2026-04-24 09:05:06.729255+00', 845000.00, 1, 15, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (131, '2026-04-24 09:05:06.745241+00', '2026-04-24 09:05:06.745284+00', 814000.00, 1, 16, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (132, '2026-04-24 09:05:06.762002+00', '2026-04-24 09:05:06.762043+00', 1138000.00, 1, 17, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (133, '2026-04-24 09:05:06.779149+00', '2026-04-24 09:05:06.779189+00', 907000.00, 1, 18, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (134, '2026-04-24 09:05:06.795073+00', '2026-04-24 09:05:06.795115+00', 688000.00, 1, 19, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (135, '2026-04-24 09:05:06.812857+00', '2026-04-24 09:05:06.812899+00', 538000.00, 1, 20, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (136, '2026-04-24 09:05:06.82962+00', '2026-04-24 09:05:06.829662+00', 659000.00, 1, 21, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (137, '2026-04-24 09:05:06.845332+00', '2026-04-24 09:05:06.845372+00', 697000.00, 1, 22, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (138, '2026-04-24 09:05:06.860787+00', '2026-04-24 09:05:06.860824+00', 804000.00, 1, 23, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (139, '2026-04-24 09:05:06.878196+00', '2026-04-24 09:05:06.878237+00', 904000.00, 1, 24, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (140, '2026-04-24 09:05:06.897283+00', '2026-04-24 09:05:06.897365+00', 978000.00, 1, 25, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (141, '2026-04-24 09:05:06.912139+00', '2026-04-24 09:05:06.912182+00', 955000.00, 1, 26, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (142, '2026-04-24 09:05:06.929337+00', '2026-04-24 09:05:06.92938+00', 704000.00, 1, 27, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (143, '2026-04-24 09:05:06.946479+00', '2026-04-24 09:05:06.946546+00', 745000.00, 1, 28, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (144, '2026-04-24 09:05:06.962537+00', '2026-04-24 09:05:06.962579+00', 951000.00, 1, 29, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (145, '2026-04-24 09:05:06.979137+00', '2026-04-24 09:05:06.97918+00', 786000.00, 1, 30, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (146, '2026-04-24 09:05:06.995723+00', '2026-04-24 09:05:06.995765+00', 667000.00, 1, 31, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (147, '2026-04-24 09:05:07.012039+00', '2026-04-24 09:05:07.012079+00', 605000.00, 1, 32, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (148, '2026-04-24 09:05:07.028491+00', '2026-04-24 09:05:07.028532+00', 1038000.00, 1, 33, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (149, '2026-04-24 09:05:07.045137+00', '2026-04-24 09:05:07.04518+00', 967000.00, 1, 34, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (150, '2026-04-24 09:05:07.061679+00', '2026-04-24 09:05:07.061724+00', 967000.00, 1, 35, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (151, '2026-04-24 09:05:07.079239+00', '2026-04-24 09:05:07.079281+00', 1308000.00, 1, 36, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (152, '2026-04-24 09:05:07.09551+00', '2026-04-24 09:05:07.095553+00', 1526000.00, 1, 37, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (153, '2026-04-24 09:05:07.111224+00', '2026-04-24 09:05:07.111266+00', 1536000.00, 1, 38, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (154, '2026-04-24 09:05:07.128235+00', '2026-04-24 09:05:07.128275+00', 750000.00, 1, 39, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (155, '2026-04-24 09:05:07.145219+00', '2026-04-24 09:05:07.145262+00', 4960000.00, 1, 40, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (156, '2026-04-24 09:05:07.162506+00', '2026-04-24 09:05:07.162548+00', 4960000.00, 1, 41, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (157, '2026-04-24 09:05:07.178707+00', '2026-04-24 09:05:07.178748+00', 4960000.00, 1, 42, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (158, '2026-04-24 09:05:07.196863+00', '2026-04-24 09:05:07.196925+00', 4960000.00, 1, 43, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (159, '2026-04-24 09:05:07.221233+00', '2026-04-24 09:05:07.221276+00', 4960000.00, 1, 44, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (160, '2026-04-24 09:05:07.23815+00', '2026-04-24 09:05:07.23819+00', 4960000.00, 1, 45, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (161, '2026-04-24 09:05:07.254793+00', '2026-04-24 09:05:07.254835+00', 750000.00, 1, 46, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (162, '2026-04-24 09:05:07.288131+00', '2026-04-24 09:05:07.288173+00', 4960000.00, 1, 47, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (163, '2026-04-24 09:05:07.30402+00', '2026-04-24 09:05:07.304061+00', 4960000.00, 1, 48, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (164, '2026-04-24 09:05:07.320112+00', '2026-04-24 09:05:07.320155+00', 4960000.00, 1, 49, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (165, '2026-04-24 09:05:07.345842+00', '2026-04-24 09:05:07.345884+00', 4960000.00, 1, 50, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (166, '2026-04-24 09:05:07.361894+00', '2026-04-24 09:05:07.361936+00', 4960000.00, 1, 51, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (167, '2026-04-24 09:05:07.378566+00', '2026-04-24 09:05:07.378608+00', 4960000.00, 1, 52, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (168, '2026-04-24 09:05:07.403534+00', '2026-04-24 09:05:07.403575+00', 4960000.00, 1, 53, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (169, '2026-04-24 09:05:07.422004+00', '2026-04-24 09:05:07.422047+00', 4960000.00, 1, 54, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (170, '2026-04-24 09:05:07.438197+00', '2026-04-24 09:05:07.43824+00', 4960000.00, 1, 55, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (171, '2026-04-24 09:05:07.454005+00', '2026-04-24 09:05:07.454048+00', 4960000.00, 1, 56, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (172, '2026-04-24 09:05:07.470162+00', '2026-04-24 09:05:07.470204+00', 4960000.00, 1, 57, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (173, '2026-04-24 09:05:07.488221+00', '2026-04-24 09:05:07.488263+00', 4960000.00, 1, 58, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (174, '2026-04-24 09:05:07.505336+00', '2026-04-24 09:05:07.505379+00', 4960000.00, 1, 59, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (175, '2026-04-24 09:05:07.52112+00', '2026-04-24 09:05:07.521163+00', 4960000.00, 1, 60, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (176, '2026-04-24 09:05:07.53773+00', '2026-04-24 09:05:07.537772+00', 4960000.00, 1, 61, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (177, '2026-04-24 09:05:07.554375+00', '2026-04-24 09:05:07.554419+00', 4960000.00, 1, 62, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (178, '2026-04-24 09:05:07.57116+00', '2026-04-24 09:05:07.571203+00', 4960000.00, 1, 63, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (179, '2026-04-24 09:05:07.587909+00', '2026-04-24 09:05:07.587951+00', 4960000.00, 1, 64, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (180, '2026-04-24 09:05:07.620115+00', '2026-04-24 09:05:07.620156+00', 4960000.00, 1, 65, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (181, '2026-04-24 09:05:07.636878+00', '2026-04-24 09:05:07.636921+00', 4960000.00, 1, 66, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (182, '2026-04-24 09:05:07.654087+00', '2026-04-24 09:05:07.654131+00', 4960000.00, 1, 67, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (183, '2026-04-24 09:05:07.67992+00', '2026-04-24 09:05:07.679961+00', 4960000.00, 1, 68, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (184, '2026-04-24 09:05:07.696472+00', '2026-04-24 09:05:07.696513+00', 750000.00, 1, 69, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (185, '2026-04-24 09:05:07.712413+00', '2026-04-24 09:05:07.712457+00', 4960000.00, 1, 70, 1, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (186, '2026-04-24 09:05:07.747949+00', '2026-04-24 09:05:07.748009+00', 700000.00, 1, 39, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (187, '2026-04-24 09:05:07.778648+00', '2026-04-24 09:05:07.77869+00', 2195000.00, 1, 40, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (188, '2026-04-24 09:05:07.829535+00', '2026-04-24 09:05:07.829579+00', 2195000.00, 1, 41, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (189, '2026-04-24 09:05:07.889474+00', '2026-04-24 09:05:07.889537+00', 2195000.00, 1, 42, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (190, '2026-04-24 09:05:07.91177+00', '2026-04-24 09:05:07.911807+00', 2195000.00, 1, 43, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (191, '2026-04-24 09:05:07.929358+00', '2026-04-24 09:05:07.9294+00', 2195000.00, 1, 44, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (192, '2026-04-24 09:05:07.946396+00', '2026-04-24 09:05:07.946439+00', 2195000.00, 1, 45, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (193, '2026-04-24 09:05:07.963702+00', '2026-04-24 09:05:07.963741+00', 700000.00, 1, 46, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (194, '2026-04-24 09:05:07.981049+00', '2026-04-24 09:05:07.981092+00', 2195000.00, 1, 47, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (195, '2026-04-24 09:05:07.996715+00', '2026-04-24 09:05:07.996758+00', 2195000.00, 1, 48, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (196, '2026-04-24 09:05:08.013148+00', '2026-04-24 09:05:08.013189+00', 2195000.00, 1, 49, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (197, '2026-04-24 09:05:08.029155+00', '2026-04-24 09:05:08.029196+00', 2195000.00, 1, 50, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (198, '2026-04-24 09:05:08.046677+00', '2026-04-24 09:05:08.04672+00', 2195000.00, 1, 51, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (199, '2026-04-24 09:05:08.063225+00', '2026-04-24 09:05:08.063267+00', 2195000.00, 1, 52, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (200, '2026-04-24 09:05:08.080077+00', '2026-04-24 09:05:08.08012+00', 2195000.00, 1, 53, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (201, '2026-04-24 09:05:08.097489+00', '2026-04-24 09:05:08.097536+00', 2195000.00, 1, 54, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (202, '2026-04-24 09:05:08.112771+00', '2026-04-24 09:05:08.112814+00', 2195000.00, 1, 55, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (203, '2026-04-24 09:05:08.129648+00', '2026-04-24 09:05:08.12969+00', 2195000.00, 1, 56, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (204, '2026-04-24 09:05:08.146718+00', '2026-04-24 09:05:08.146761+00', 2195000.00, 1, 57, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (205, '2026-04-24 09:05:08.163166+00', '2026-04-24 09:05:08.163207+00', 2195000.00, 1, 58, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (206, '2026-04-24 09:05:08.179908+00', '2026-04-24 09:05:08.179949+00', 2195000.00, 1, 59, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (207, '2026-04-24 09:05:08.19653+00', '2026-04-24 09:05:08.196574+00', 2195000.00, 1, 60, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (208, '2026-04-24 09:05:08.213201+00', '2026-04-24 09:05:08.213244+00', 2195000.00, 1, 61, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (209, '2026-04-24 09:05:08.229715+00', '2026-04-24 09:05:08.229757+00', 2195000.00, 1, 62, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (210, '2026-04-24 09:05:08.246248+00', '2026-04-24 09:05:08.246289+00', 2195000.00, 1, 63, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (211, '2026-04-24 09:05:08.262668+00', '2026-04-24 09:05:08.26271+00', 2195000.00, 1, 64, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (212, '2026-04-24 09:05:08.279859+00', '2026-04-24 09:05:08.279901+00', 2195000.00, 1, 65, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (213, '2026-04-24 09:05:08.29689+00', '2026-04-24 09:05:08.296933+00', 2195000.00, 1, 66, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (214, '2026-04-24 09:05:08.311925+00', '2026-04-24 09:05:08.311967+00', 2195000.00, 1, 67, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (215, '2026-04-24 09:05:08.332862+00', '2026-04-24 09:05:08.333396+00', 2195000.00, 1, 68, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (216, '2026-04-24 09:05:08.355221+00', '2026-04-24 09:05:08.355264+00', 700000.00, 1, 69, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (217, '2026-04-24 09:05:08.371646+00', '2026-04-24 09:05:08.371689+00', 2195000.00, 1, 70, 2, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (218, '2026-04-24 09:05:08.390706+00', '2026-04-24 09:05:08.390748+00', 500000.00, 1, 39, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (219, '2026-04-24 09:05:08.413064+00', '2026-04-24 09:05:08.413106+00', 1100000.00, 1, 40, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (220, '2026-04-24 09:05:08.429947+00', '2026-04-24 09:05:08.42999+00', 1100000.00, 1, 41, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (221, '2026-04-24 09:05:08.446149+00', '2026-04-24 09:05:08.446189+00', 1100000.00, 1, 42, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (222, '2026-04-24 09:05:08.462182+00', '2026-04-24 09:05:08.462225+00', 1100000.00, 1, 43, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (223, '2026-04-24 09:05:08.478797+00', '2026-04-24 09:05:08.478839+00', 1100000.00, 1, 44, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (224, '2026-04-24 09:05:08.495554+00', '2026-04-24 09:05:08.495598+00', 1100000.00, 1, 45, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (225, '2026-04-24 09:05:08.512773+00', '2026-04-24 09:05:08.512814+00', 500000.00, 1, 46, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (226, '2026-04-24 09:05:08.528852+00', '2026-04-24 09:05:08.528893+00', 1100000.00, 1, 47, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (227, '2026-04-24 09:05:08.545899+00', '2026-04-24 09:05:08.545943+00', 1100000.00, 1, 48, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (228, '2026-04-24 09:05:08.563717+00', '2026-04-24 09:05:08.563759+00', 1100000.00, 1, 49, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (229, '2026-04-24 09:05:08.588806+00', '2026-04-24 09:05:08.588848+00', 1100000.00, 1, 50, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (230, '2026-04-24 09:05:08.605987+00', '2026-04-24 09:05:08.606031+00', 1100000.00, 1, 51, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (231, '2026-04-24 09:05:08.620926+00', '2026-04-24 09:05:08.620967+00', 1100000.00, 1, 52, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (232, '2026-04-24 09:05:08.663717+00', '2026-04-24 09:05:08.66376+00', 1100000.00, 1, 53, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (233, '2026-04-24 09:05:08.680728+00', '2026-04-24 09:05:08.680771+00', 1100000.00, 1, 54, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (234, '2026-04-24 09:05:08.697519+00', '2026-04-24 09:05:08.697561+00', 1100000.00, 1, 55, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (235, '2026-04-24 09:05:08.71502+00', '2026-04-24 09:05:08.715063+00', 1100000.00, 1, 56, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (236, '2026-04-24 09:05:08.729825+00', '2026-04-24 09:05:08.729867+00', 1100000.00, 1, 57, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (237, '2026-04-24 09:05:08.747235+00', '2026-04-24 09:05:08.747277+00', 1100000.00, 1, 58, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (238, '2026-04-24 09:05:08.763995+00', '2026-04-24 09:05:08.764037+00', 1100000.00, 1, 59, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (239, '2026-04-24 09:05:08.780348+00', '2026-04-24 09:05:08.780391+00', 1100000.00, 1, 60, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (240, '2026-04-24 09:05:08.797456+00', '2026-04-24 09:05:08.7975+00', 1100000.00, 1, 61, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (241, '2026-04-24 09:05:08.813717+00', '2026-04-24 09:05:08.81376+00', 1100000.00, 1, 62, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (242, '2026-04-24 09:05:08.830351+00', '2026-04-24 09:05:08.830395+00', 1100000.00, 1, 63, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (243, '2026-04-24 09:05:08.846945+00', '2026-04-24 09:05:08.846988+00', 1100000.00, 1, 64, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (244, '2026-04-24 09:05:08.86307+00', '2026-04-24 09:05:08.863113+00', 1100000.00, 1, 65, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (245, '2026-04-24 09:05:08.881477+00', '2026-04-24 09:05:08.88152+00', 1100000.00, 1, 66, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (246, '2026-04-24 09:05:08.905259+00', '2026-04-24 09:05:08.905336+00', 1100000.00, 1, 67, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (247, '2026-04-24 09:05:08.921638+00', '2026-04-24 09:05:08.921678+00', 1100000.00, 1, 68, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (248, '2026-04-24 09:05:08.938195+00', '2026-04-24 09:05:08.938236+00', 500000.00, 1, 69, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (249, '2026-04-24 09:05:08.954276+00', '2026-04-24 09:05:08.95436+00', 1100000.00, 1, 70, 3, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (250, '2026-04-24 09:05:08.97089+00', '2026-04-24 09:05:08.970929+00', 500000.00, 1, 39, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (251, '2026-04-24 09:05:08.988927+00', '2026-04-24 09:05:08.98897+00', 699000.00, 1, 40, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (252, '2026-04-24 09:05:09.004756+00', '2026-04-24 09:05:09.004798+00', 699000.00, 1, 41, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (253, '2026-04-24 09:05:09.020937+00', '2026-04-24 09:05:09.020978+00', 699000.00, 1, 42, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (254, '2026-04-24 09:05:09.037285+00', '2026-04-24 09:05:09.037356+00', 699000.00, 1, 43, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (255, '2026-04-24 09:05:09.052411+00', '2026-04-24 09:05:09.052443+00', 699000.00, 1, 44, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (256, '2026-04-24 09:05:09.070837+00', '2026-04-24 09:05:09.070877+00', 699000.00, 1, 45, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (257, '2026-04-24 09:05:09.088246+00', '2026-04-24 09:05:09.08829+00', 500000.00, 1, 46, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (258, '2026-04-24 09:05:09.105062+00', '2026-04-24 09:05:09.1051+00', 699000.00, 1, 47, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (259, '2026-04-24 09:05:09.120875+00', '2026-04-24 09:05:09.120912+00', 699000.00, 1, 48, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (260, '2026-04-24 09:05:09.137516+00', '2026-04-24 09:05:09.137553+00', 699000.00, 1, 49, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (261, '2026-04-24 09:05:09.155292+00', '2026-04-24 09:05:09.155388+00', 699000.00, 1, 50, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (262, '2026-04-24 09:05:09.1721+00', '2026-04-24 09:05:09.17214+00', 699000.00, 1, 51, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (263, '2026-04-24 09:05:09.188892+00', '2026-04-24 09:05:09.188934+00', 699000.00, 1, 52, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (264, '2026-04-24 09:05:09.205372+00', '2026-04-24 09:05:09.205414+00', 699000.00, 1, 53, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (265, '2026-04-24 09:05:09.22206+00', '2026-04-24 09:05:09.222101+00', 699000.00, 1, 54, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (266, '2026-04-24 09:05:09.238396+00', '2026-04-24 09:05:09.238438+00', 699000.00, 1, 55, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (267, '2026-04-24 09:05:09.255296+00', '2026-04-24 09:05:09.255369+00', 699000.00, 1, 56, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (268, '2026-04-24 09:05:09.27196+00', '2026-04-24 09:05:09.272002+00', 699000.00, 1, 57, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (269, '2026-04-24 09:05:09.288563+00', '2026-04-24 09:05:09.288606+00', 699000.00, 1, 58, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (270, '2026-04-24 09:05:09.305735+00', '2026-04-24 09:05:09.305779+00', 699000.00, 1, 59, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (271, '2026-04-24 09:05:09.321967+00', '2026-04-24 09:05:09.32201+00', 699000.00, 1, 60, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (272, '2026-04-24 09:05:09.338174+00', '2026-04-24 09:05:09.338216+00', 699000.00, 1, 61, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (273, '2026-04-24 09:05:09.354467+00', '2026-04-24 09:05:09.35451+00', 699000.00, 1, 62, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (274, '2026-04-24 09:05:09.371837+00', '2026-04-24 09:05:09.371879+00', 699000.00, 1, 63, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (275, '2026-04-24 09:05:09.389006+00', '2026-04-24 09:05:09.389048+00', 699000.00, 1, 64, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (276, '2026-04-24 09:05:09.404086+00', '2026-04-24 09:05:09.404129+00', 699000.00, 1, 65, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (277, '2026-04-24 09:05:09.421017+00', '2026-04-24 09:05:09.421058+00', 699000.00, 1, 66, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (278, '2026-04-24 09:05:09.437131+00', '2026-04-24 09:05:09.437172+00', 699000.00, 1, 67, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (279, '2026-04-24 09:05:09.455555+00', '2026-04-24 09:05:09.455598+00', 699000.00, 1, 68, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (280, '2026-04-24 09:05:09.471754+00', '2026-04-24 09:05:09.471798+00', 500000.00, 1, 69, 4, 'OH');
INSERT INTO public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) VALUES (281, '2026-04-24 09:05:09.488496+00', '2026-04-24 09:05:09.488539+00', 699000.00, 1, 70, 4, 'OH');


ALTER TABLE public.spd_standardpenginapan ENABLE TRIGGER ALL;

--
-- Data for Name: spd_standardpesawat; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_standardpesawat DISABLE TRIGGER ALL;



ALTER TABLE public.spd_standardpesawat ENABLE TRIGGER ALL;

--
-- Data for Name: spd_standardrepresentasi; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_standardrepresentasi DISABLE TRIGGER ALL;



ALTER TABLE public.spd_standardrepresentasi ENABLE TRIGGER ALL;

--
-- Data for Name: spd_standardtransportasi; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_standardtransportasi DISABLE TRIGGER ALL;

INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (1, '2026-04-24 10:15:59.984585+00', '2026-04-24 10:15:59.984608+00', 'Per Hari', 962000.00, 1, 3, 1);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (2, '2026-04-24 10:16:00.021794+00', '2026-04-24 10:16:00.021823+00', 'Per Hari', 978000.00, 1, 3, 3);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (3, '2026-04-24 10:16:00.040784+00', '2026-04-24 10:16:00.040816+00', 'Per Hari', 1049000.00, 1, 3, 4);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (4, '2026-04-24 10:16:00.057408+00', '2026-04-24 10:16:00.057441+00', 'Per Hari', 1152000.00, 1, 3, 5);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (5, '2026-04-24 10:16:00.075846+00', '2026-04-24 10:16:00.075901+00', 'Per Hari', 922000.00, 1, 3, 6);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (6, '2026-04-24 10:16:00.08764+00', '2026-04-24 10:16:00.087668+00', 'Per Hari', 1507000.00, 1, 3, 7);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (7, '2026-04-24 10:16:00.107272+00', '2026-04-24 10:16:00.107328+00', 'Per Hari', 897000.00, 1, 3, 8);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (8, '2026-04-24 10:16:00.125894+00', '2026-04-24 10:16:00.125924+00', 'Per Hari', 985000.00, 1, 3, 9);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (9, '2026-04-24 10:16:00.143097+00', '2026-04-24 10:16:00.143129+00', 'Per Hari', 1258000.00, 1, 3, 10);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (10, '2026-04-24 10:16:00.156856+00', '2026-04-24 10:16:00.156886+00', 'Per Hari', 1017000.00, 1, 3, 11);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (11, '2026-04-24 10:16:00.174716+00', '2026-04-24 10:16:00.174752+00', 'Per Hari', 988000.00, 1, 3, 12);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (12, '2026-04-24 10:16:00.190118+00', '2026-04-24 10:16:00.190149+00', 'Per Hari', 1305000.00, 1, 3, 13);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (13, '2026-04-24 10:16:00.206381+00', '2026-04-24 10:16:00.206437+00', 'Per Hari', 1347000.00, 1, 3, 14);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (14, '2026-04-24 10:16:00.224212+00', '2026-04-24 10:16:00.224248+00', 'Per Hari', 978000.00, 1, 3, 15);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (15, '2026-04-24 10:16:00.240287+00', '2026-04-24 10:16:00.240344+00', 'Per Hari', 1212000.00, 1, 3, 16);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (16, '2026-04-24 10:16:00.257234+00', '2026-04-24 10:16:00.257263+00', 'Per Hari', 1275000.00, 1, 3, 17);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (17, '2026-04-24 10:16:00.274454+00', '2026-04-24 10:16:00.274482+00', 'Per Hari', 1103000.00, 1, 3, 18);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (18, '2026-04-24 10:16:00.292618+00', '2026-04-24 10:16:00.292655+00', 'Per Hari', 926000.00, 1, 3, 19);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (19, '2026-04-24 10:16:00.310121+00', '2026-04-24 10:16:00.310158+00', 'Per Hari', 921000.00, 1, 3, 20);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (20, '2026-04-24 10:16:00.326216+00', '2026-04-24 10:16:00.326255+00', 'Per Hari', 1177000.00, 1, 3, 21);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (21, '2026-04-24 10:16:00.341883+00', '2026-04-24 10:16:00.341922+00', 'Per Hari', 921000.00, 1, 3, 22);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (22, '2026-04-24 10:16:00.360248+00', '2026-04-24 10:16:00.360285+00', 'Per Hari', 1100000.00, 1, 3, 23);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (23, '2026-04-24 10:16:00.3738+00', '2026-04-24 10:16:00.373843+00', 'Per Hari', 1188000.00, 1, 3, 24);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (24, '2026-04-24 10:16:00.39296+00', '2026-04-24 10:16:00.393003+00', 'Per Hari', 1195000.00, 1, 3, 25);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (25, '2026-04-24 10:16:00.410009+00', '2026-04-24 10:16:00.410052+00', 'Per Hari', 908000.00, 1, 3, 26);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (26, '2026-04-24 10:16:00.425043+00', '2026-04-24 10:16:00.425081+00', 'Per Hari', 914000.00, 1, 3, 27);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (27, '2026-04-24 10:16:00.441828+00', '2026-04-24 10:16:00.441872+00', 'Per Hari', 938000.00, 1, 3, 28);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (28, '2026-04-24 10:16:00.45897+00', '2026-04-24 10:16:00.459013+00', 'Per Hari', 824000.00, 1, 3, 29);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (29, '2026-04-24 10:16:00.475686+00', '2026-04-24 10:16:00.475729+00', 'Per Hari', 945000.00, 1, 3, 30);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (30, '2026-04-24 10:16:00.492945+00', '2026-04-24 10:16:00.492987+00', 'Per Hari', 1241000.00, 1, 3, 31);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (31, '2026-04-24 10:16:00.509556+00', '2026-04-24 10:16:00.509599+00', 'Per Hari', 1095000.00, 1, 3, 32);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (32, '2026-04-24 10:16:00.526915+00', '2026-04-24 10:16:00.526979+00', 'Per Hari', 1204000.00, 1, 3, 33);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (33, '2026-04-24 10:16:00.542851+00', '2026-04-24 10:16:00.542894+00', 'Per Hari', 1171000.00, 1, 3, 34);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (34, '2026-04-24 10:16:00.558363+00', '2026-04-24 10:16:00.558402+00', 'Per Hari', 1171000.00, 1, 3, 35);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (35, '2026-04-24 10:16:00.575672+00', '2026-04-24 10:16:00.575739+00', 'Per Hari', 1204000.00, 1, 3, 36);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (36, '2026-04-24 10:16:00.592062+00', '2026-04-24 10:16:00.592104+00', 'Per Hari', 1638000.00, 1, 3, 37);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (37, '2026-04-24 10:16:00.610857+00', '2026-04-24 10:16:00.6109+00', 'Per Hari', 1649000.00, 1, 3, 38);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (38, '2026-04-24 10:16:00.625942+00', '2026-04-24 10:16:00.625979+00', 'Orang/Kali', 127000.00, 1, 1, 1);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (39, '2026-04-24 10:16:00.642702+00', '2026-04-24 10:16:00.642763+00', 'Orang/Kali', 308000.00, 1, 1, 2);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (40, '2026-04-24 10:16:00.657919+00', '2026-04-24 10:16:00.657962+00', 'Orang/Kali', 101000.00, 1, 1, 3);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (41, '2026-04-24 10:16:00.676888+00', '2026-04-24 10:16:00.676926+00', 'Orang/Kali', 165000.00, 1, 1, 4);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (42, '2026-04-24 10:16:00.691555+00', '2026-04-24 10:16:00.691576+00', 'Orang/Kali', 147000.00, 1, 1, 5);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (43, '2026-04-24 10:16:00.708288+00', '2026-04-24 10:16:00.70836+00', 'Orang/Kali', 190000.00, 1, 1, 6);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (44, '2026-04-24 10:16:00.725599+00', '2026-04-24 10:16:00.725638+00', 'Orang/Kali', 179000.00, 1, 1, 7);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (45, '2026-04-24 10:16:00.741856+00', '2026-04-24 10:16:00.741889+00', 'Orang/Kali', 168000.00, 1, 1, 8);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (46, '2026-04-24 10:16:00.75913+00', '2026-04-24 10:16:00.75916+00', 'Orang/Kali', 109000.00, 1, 1, 9);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (47, '2026-04-24 10:16:00.774915+00', '2026-04-24 10:16:00.774956+00', 'Orang/Kali', 97000.00, 1, 1, 10);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (48, '2026-04-24 10:16:00.79282+00', '2026-04-24 10:16:00.792858+00', 'Orang/Kali', 536000.00, 1, 1, 11);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (49, '2026-04-24 10:16:00.8091+00', '2026-04-24 10:16:00.809137+00', 'Orang/Kali', 200000.00, 1, 1, 12);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (50, '2026-04-24 10:16:00.825371+00', '2026-04-24 10:16:00.825415+00', 'Orang/Kali', 256000.00, 1, 1, 13);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (51, '2026-04-24 10:16:00.84209+00', '2026-04-24 10:16:00.842131+00', 'Orang/Kali', 108000.00, 1, 1, 14);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (52, '2026-04-24 10:16:00.858741+00', '2026-04-24 10:16:00.858784+00', 'Orang/Kali', 267000.00, 1, 1, 15);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (53, '2026-04-24 10:16:00.875365+00', '2026-04-24 10:16:00.875407+00', 'Orang/Kali', 233000.00, 1, 1, 16);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (54, '2026-04-24 10:16:00.892052+00', '2026-04-24 10:16:00.892093+00', 'Orang/Kali', 227000.00, 1, 1, 17);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (55, '2026-04-24 10:16:00.908918+00', '2026-04-24 10:16:00.908959+00', 'Orang/Kali', 231000.00, 1, 1, 18);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (56, '2026-04-24 10:16:00.926148+00', '2026-04-24 10:16:00.92619+00', 'Orang/Kali', 116000.00, 1, 1, 19);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (57, '2026-04-24 10:16:00.943389+00', '2026-04-24 10:16:00.943434+00', 'Orang/Kali', 171000.00, 1, 1, 20);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (58, '2026-04-24 10:16:00.960338+00', '2026-04-24 10:16:00.960382+00', 'Orang/Kali', 134000.00, 1, 1, 21);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (59, '2026-04-24 10:16:00.976936+00', '2026-04-24 10:16:00.976978+00', 'Orang/Kali', 180000.00, 1, 1, 22);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (60, '2026-04-24 10:16:00.993405+00', '2026-04-24 10:16:00.993448+00', 'Orang/Kali', 533000.00, 1, 1, 23);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (61, '2026-04-24 10:16:01.010397+00', '2026-04-24 10:16:01.01044+00', 'Orang/Kali', 218000.00, 1, 1, 24);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (62, '2026-04-24 10:16:01.02678+00', '2026-04-24 10:16:01.026823+00', 'Orang/Kali', 138000.00, 1, 1, 25);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (63, '2026-04-24 10:16:01.04327+00', '2026-04-24 10:16:01.043341+00', 'Orang/Kali', 265000.00, 1, 1, 26);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (64, '2026-04-24 10:16:01.06007+00', '2026-04-24 10:16:01.060113+00', 'Orang/Kali', 313000.00, 1, 1, 27);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (65, '2026-04-24 10:16:01.07727+00', '2026-04-24 10:16:01.077337+00', 'Orang/Kali', 187000.00, 1, 1, 28);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (66, '2026-04-24 10:16:01.093189+00', '2026-04-24 10:16:01.093231+00', 'Orang/Kali', 165000.00, 1, 1, 29);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (67, '2026-04-24 10:16:01.109115+00', '2026-04-24 10:16:01.109158+00', 'Orang/Kali', 171000.00, 1, 1, 30);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (68, '2026-04-24 10:16:01.126771+00', '2026-04-24 10:16:01.126814+00', 'Orang/Kali', 288000.00, 1, 1, 31);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (69, '2026-04-24 10:16:01.143816+00', '2026-04-24 10:16:01.143858+00', 'Orang/Kali', 215000.00, 1, 1, 32);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (70, '2026-04-24 10:16:01.159519+00', '2026-04-24 10:16:01.159562+00', 'Orang/Kali', 513000.00, 1, 1, 33);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (71, '2026-04-24 10:16:01.17585+00', '2026-04-24 10:16:01.175893+00', 'Orang/Kali', 236000.00, 1, 1, 34);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (72, '2026-04-24 10:16:01.193362+00', '2026-04-24 10:16:01.193405+00', 'Orang/Kali', 236000.00, 1, 1, 35);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (73, '2026-04-24 10:16:01.209562+00', '2026-04-24 10:16:01.209604+00', 'Orang/Kali', 513000.00, 1, 1, 36);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (74, '2026-04-24 10:16:01.225971+00', '2026-04-24 10:16:01.226013+00', 'Orang/Kali', 513000.00, 1, 1, 37);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (75, '2026-04-24 10:16:01.242187+00', '2026-04-24 10:16:01.242228+00', 'Orang/Kali', 513000.00, 1, 1, 38);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (76, '2026-04-24 10:16:01.262667+00', '2026-04-24 10:16:01.262709+00', 'Orang/Kali', 150000.00, 1, 2, 39);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (77, '2026-04-24 10:16:01.286598+00', '2026-04-24 10:16:01.286619+00', 'Orang/Kali', 350000.00, 1, 2, 40);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (78, '2026-04-24 10:16:01.300796+00', '2026-04-24 10:16:01.300835+00', 'Orang/Kali', 250000.00, 1, 2, 41);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (79, '2026-04-24 10:16:01.317693+00', '2026-04-24 10:16:01.317735+00', 'Orang/Kali', 350000.00, 1, 2, 42);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (80, '2026-04-24 10:16:01.334062+00', '2026-04-24 10:16:01.334106+00', 'Orang/Kali', 350000.00, 1, 2, 43);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (81, '2026-04-24 10:16:01.349668+00', '2026-04-24 10:16:01.349706+00', 'Orang/Kali', 200000.00, 1, 2, 44);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (82, '2026-04-24 10:16:01.365675+00', '2026-04-24 10:16:01.365702+00', 'Orang/Kali', 200000.00, 1, 2, 45);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (83, '2026-04-24 10:16:01.38246+00', '2026-04-24 10:16:01.382487+00', 'Orang/Kali', 150000.00, 1, 2, 46);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (84, '2026-04-24 10:16:01.399981+00', '2026-04-24 10:16:01.400014+00', 'Orang/Kali', 350000.00, 1, 2, 47);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (85, '2026-04-24 10:16:01.443183+00', '2026-04-24 10:16:01.443233+00', 'Orang/Kali', 350000.00, 1, 2, 48);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (86, '2026-04-24 10:16:01.461744+00', '2026-04-24 10:16:01.461783+00', 'Orang/Kali', 350000.00, 1, 2, 53);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (87, '2026-04-24 10:16:01.483908+00', '2026-04-24 10:16:01.48395+00', 'Orang/Kali', 350000.00, 1, 2, 54);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (88, '2026-04-24 10:16:01.501082+00', '2026-04-24 10:16:01.501124+00', 'Orang/Kali', 350000.00, 1, 2, 55);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (89, '2026-04-24 10:16:01.516962+00', '2026-04-24 10:16:01.517005+00', 'Orang/Kali', 350000.00, 1, 2, 56);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (90, '2026-04-24 10:16:01.534917+00', '2026-04-24 10:16:01.534954+00', 'Orang/Kali', 200000.00, 1, 2, 57);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (91, '2026-04-24 10:16:01.551742+00', '2026-04-24 10:16:01.551785+00', 'Orang/Kali', 250000.00, 1, 2, 58);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (92, '2026-04-24 10:16:01.567794+00', '2026-04-24 10:16:01.567833+00', 'Orang/Kali', 350000.00, 1, 2, 59);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (93, '2026-04-24 10:16:01.58402+00', '2026-04-24 10:16:01.584056+00', 'Orang/Kali', 350000.00, 1, 2, 60);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (94, '2026-04-24 10:16:01.599042+00', '2026-04-24 10:16:01.599081+00', 'Orang/Kali', 300000.00, 1, 2, 61);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (95, '2026-04-24 10:16:01.619914+00', '2026-04-24 10:16:01.619949+00', 'Orang/Kali', 350000.00, 1, 2, 62);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (96, '2026-04-24 10:16:01.634418+00', '2026-04-24 10:16:01.63448+00', 'Orang/Kali', 300000.00, 1, 2, 63);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (97, '2026-04-24 10:16:01.650411+00', '2026-04-24 10:16:01.650448+00', 'Orang/Kali', 250000.00, 1, 2, 65);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (98, '2026-04-24 10:16:01.668737+00', '2026-04-24 10:16:01.668776+00', 'Orang/Kali', 350000.00, 1, 2, 66);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (99, '2026-04-24 10:16:01.684697+00', '2026-04-24 10:16:01.684739+00', 'Orang/Kali', 150000.00, 1, 2, 67);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (100, '2026-04-24 10:16:01.699246+00', '2026-04-24 10:16:01.699274+00', 'Orang/Kali', 350000.00, 1, 2, 68);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (101, '2026-04-24 10:16:01.717369+00', '2026-04-24 10:16:01.717404+00', 'Orang/Kali', 100000.00, 1, 2, 69);
INSERT INTO public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) VALUES (102, '2026-04-24 10:16:01.733014+00', '2026-04-24 10:16:01.733049+00', 'Orang/Kali', 200000.00, 1, 2, 70);


ALTER TABLE public.spd_standardtransportasi ENABLE TRIGGER ALL;

--
-- Data for Name: spd_standarduangharian; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.spd_standarduangharian DISABLE TRIGGER ALL;

INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (2, '2026-04-24 09:51:11.089147+00', '2026-04-24 09:51:11.089181+00', 'OH', 360000.00, 1, 1, 1);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (3, '2026-04-24 09:51:11.145041+00', '2026-04-24 09:51:11.145086+00', 'OH', 370000.00, 1, 1, 2);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (4, '2026-04-24 09:51:11.16128+00', '2026-04-24 09:51:11.161349+00', 'OH', 370000.00, 1, 1, 3);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (5, '2026-04-24 09:51:11.177607+00', '2026-04-24 09:51:11.177652+00', 'OH', 370000.00, 1, 1, 4);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (6, '2026-04-24 09:51:11.193424+00', '2026-04-24 09:51:11.193469+00', 'OH', 370000.00, 1, 1, 5);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (7, '2026-04-24 09:51:11.2103+00', '2026-04-24 09:51:11.210376+00', 'OH', 380000.00, 1, 1, 6);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (8, '2026-04-24 09:51:11.226838+00', '2026-04-24 09:51:11.226882+00', 'OH', 380000.00, 1, 1, 7);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (9, '2026-04-24 09:51:11.245064+00', '2026-04-24 09:51:11.245109+00', 'OH', 380000.00, 1, 1, 8);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (10, '2026-04-24 09:51:11.261262+00', '2026-04-24 09:51:11.261329+00', 'OH', 380000.00, 1, 1, 9);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (11, '2026-04-24 09:51:11.278292+00', '2026-04-24 09:51:11.278365+00', 'OH', 410000.00, 1, 1, 10);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (12, '2026-04-24 09:51:11.295702+00', '2026-04-24 09:51:11.295747+00', 'OH', 370000.00, 1, 1, 11);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (13, '2026-04-24 09:51:11.311437+00', '2026-04-24 09:51:11.311482+00', 'OH', 430000.00, 1, 1, 12);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (14, '2026-04-24 09:51:11.328001+00', '2026-04-24 09:51:11.328045+00', 'OH', 530000.00, 1, 1, 13);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (15, '2026-04-24 09:51:11.344701+00', '2026-04-24 09:51:11.344745+00', 'OH', 370000.00, 1, 1, 14);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (16, '2026-04-24 09:51:11.361104+00', '2026-04-24 09:51:11.361148+00', 'OH', 420000.00, 1, 1, 15);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (17, '2026-04-24 09:51:11.377992+00', '2026-04-24 09:51:11.378037+00', 'OH', 410000.00, 1, 1, 16);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (18, '2026-04-24 09:51:11.394555+00', '2026-04-24 09:51:11.3946+00', 'OH', 480000.00, 1, 1, 17);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (19, '2026-04-24 09:51:11.411468+00', '2026-04-24 09:51:11.411514+00', 'OH', 440000.00, 1, 1, 18);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (20, '2026-04-24 09:51:11.428052+00', '2026-04-24 09:51:11.428094+00', 'OH', 430000.00, 1, 1, 19);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (21, '2026-04-24 09:51:11.445006+00', '2026-04-24 09:51:11.445048+00', 'OH', 380000.00, 1, 1, 20);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (22, '2026-04-24 09:51:11.460064+00', '2026-04-24 09:51:11.460106+00', 'OH', 360000.00, 1, 1, 21);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (23, '2026-04-24 09:51:11.476716+00', '2026-04-24 09:51:11.476758+00', 'OH', 380000.00, 1, 1, 22);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (24, '2026-04-24 09:51:11.492977+00', '2026-04-24 09:51:11.493021+00', 'OH', 430000.00, 1, 1, 23);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (25, '2026-04-24 09:51:11.512213+00', '2026-04-24 09:51:11.512255+00', 'OH', 430000.00, 1, 1, 24);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (26, '2026-04-24 09:51:11.529357+00', '2026-04-24 09:51:11.5294+00', 'OH', 370000.00, 1, 1, 25);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (27, '2026-04-24 09:51:11.545971+00', '2026-04-24 09:51:11.546014+00', 'OH', 370000.00, 1, 1, 26);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (28, '2026-04-24 09:51:11.561109+00', '2026-04-24 09:51:11.561151+00', 'OH', 410000.00, 1, 1, 27);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (29, '2026-04-24 09:51:11.576599+00', '2026-04-24 09:51:11.576641+00', 'OH', 430000.00, 1, 1, 28);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (30, '2026-04-24 09:51:11.595461+00', '2026-04-24 09:51:11.59552+00', 'OH', 370000.00, 1, 1, 29);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (31, '2026-04-24 09:51:11.607895+00', '2026-04-24 09:51:11.607932+00', 'OH', 380000.00, 1, 1, 30);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (32, '2026-04-24 09:51:11.623207+00', '2026-04-24 09:51:11.623229+00', 'OH', 380000.00, 1, 1, 31);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (33, '2026-04-24 09:51:11.638471+00', '2026-04-24 09:51:11.6385+00', 'OH', 430000.00, 1, 1, 32);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (34, '2026-04-24 09:51:11.646903+00', '2026-04-24 09:51:11.646924+00', 'OH', 580000.00, 1, 1, 33);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (35, '2026-04-24 09:51:11.654969+00', '2026-04-24 09:51:11.65499+00', 'OH', 480000.00, 1, 1, 34);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (36, '2026-04-24 09:51:11.663248+00', '2026-04-24 09:51:11.663269+00', 'OH', 480000.00, 1, 1, 35);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (37, '2026-04-24 09:51:11.672516+00', '2026-04-24 09:51:11.672537+00', 'OH', 580000.00, 1, 1, 36);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (38, '2026-04-24 09:51:11.688196+00', '2026-04-24 09:51:11.688217+00', 'OH', 580000.00, 1, 1, 37);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (39, '2026-04-24 09:51:11.696544+00', '2026-04-24 09:51:11.696566+00', 'OH', 580000.00, 1, 1, 38);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (40, '2026-04-24 09:51:11.706506+00', '2026-04-24 09:51:11.706538+00', 'OH', 110000.00, 1, 3, 1);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (41, '2026-04-24 09:51:11.721625+00', '2026-04-24 09:51:11.721647+00', 'OH', 110000.00, 1, 3, 2);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (42, '2026-04-24 09:51:11.729844+00', '2026-04-24 09:51:11.729865+00', 'OH', 110000.00, 1, 3, 3);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (43, '2026-04-24 09:51:11.738025+00', '2026-04-24 09:51:11.738046+00', 'OH', 110000.00, 1, 3, 4);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (44, '2026-04-24 09:51:11.746653+00', '2026-04-24 09:51:11.746674+00', 'OH', 110000.00, 1, 3, 5);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (45, '2026-04-24 09:51:11.756445+00', '2026-04-24 09:51:11.756624+00', 'OH', 110000.00, 1, 3, 6);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (46, '2026-04-24 09:51:11.773821+00', '2026-04-24 09:51:11.773841+00', 'OH', 110000.00, 1, 3, 7);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (47, '2026-04-24 09:51:11.790408+00', '2026-04-24 09:51:11.790428+00', 'OH', 110000.00, 1, 3, 8);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (48, '2026-04-24 09:51:11.809607+00', '2026-04-24 09:51:11.809651+00', 'OH', 110000.00, 1, 3, 9);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (49, '2026-04-24 09:51:11.82813+00', '2026-04-24 09:51:11.828172+00', 'OH', 120000.00, 1, 3, 10);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (50, '2026-04-24 09:51:11.844358+00', '2026-04-24 09:51:11.844394+00', 'OH', 110000.00, 1, 3, 11);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (51, '2026-04-24 09:51:11.85906+00', '2026-04-24 09:51:11.859095+00', 'OH', 130000.00, 1, 3, 12);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (52, '2026-04-24 09:51:11.876079+00', '2026-04-24 09:51:11.876117+00', 'OH', 160000.00, 1, 3, 13);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (53, '2026-04-24 09:51:11.894413+00', '2026-04-24 09:51:11.894456+00', 'OH', 110000.00, 1, 3, 14);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (54, '2026-04-24 09:51:11.910405+00', '2026-04-24 09:51:11.910449+00', 'OH', 130000.00, 1, 3, 15);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (55, '2026-04-24 09:51:11.927784+00', '2026-04-24 09:51:11.927827+00', 'OH', 120000.00, 1, 3, 16);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (56, '2026-04-24 09:51:11.943817+00', '2026-04-24 09:51:11.943856+00', 'OH', 140000.00, 1, 3, 17);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (57, '2026-04-24 09:51:11.959479+00', '2026-04-24 09:51:11.959517+00', 'OH', 130000.00, 1, 3, 18);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (58, '2026-04-24 09:51:11.977718+00', '2026-04-24 09:51:11.977762+00', 'OH', 130000.00, 1, 3, 19);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (59, '2026-04-24 09:51:11.995001+00', '2026-04-24 09:51:11.995046+00', 'OH', 110000.00, 1, 3, 20);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (60, '2026-04-24 09:51:12.010696+00', '2026-04-24 09:51:12.010738+00', 'OH', 110000.00, 1, 3, 21);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (61, '2026-04-24 09:51:12.027044+00', '2026-04-24 09:51:12.027088+00', 'OH', 110000.00, 1, 3, 22);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (62, '2026-04-24 09:51:12.0444+00', '2026-04-24 09:51:12.044448+00', 'OH', 130000.00, 1, 3, 23);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (63, '2026-04-24 09:51:12.060713+00', '2026-04-24 09:51:12.060756+00', 'OH', 130000.00, 1, 3, 24);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (64, '2026-04-24 09:51:12.077155+00', '2026-04-24 09:51:12.077197+00', 'OH', 110000.00, 1, 3, 25);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (65, '2026-04-24 09:51:12.094459+00', '2026-04-24 09:51:12.094503+00', 'OH', 110000.00, 1, 3, 26);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (66, '2026-04-24 09:51:12.110337+00', '2026-04-24 09:51:12.110385+00', 'OH', 120000.00, 1, 3, 27);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (67, '2026-04-24 09:51:12.131624+00', '2026-04-24 09:51:12.131669+00', 'OH', 130000.00, 1, 3, 28);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (68, '2026-04-24 09:51:12.153243+00', '2026-04-24 09:51:12.153287+00', 'OH', 110000.00, 1, 3, 29);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (69, '2026-04-24 09:51:12.16998+00', '2026-04-24 09:51:12.170024+00', 'OH', 110000.00, 1, 3, 30);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (70, '2026-04-24 09:51:12.187278+00', '2026-04-24 09:51:12.187374+00', 'OH', 110000.00, 1, 3, 31);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (71, '2026-04-24 09:51:12.204406+00', '2026-04-24 09:51:12.204449+00', 'OH', 130000.00, 1, 3, 32);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (72, '2026-04-24 09:51:12.220041+00', '2026-04-24 09:51:12.220086+00', 'OH', 170000.00, 1, 3, 33);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (73, '2026-04-24 09:51:12.236669+00', '2026-04-24 09:51:12.236714+00', 'OH', 140000.00, 1, 3, 34);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (74, '2026-04-24 09:51:12.252593+00', '2026-04-24 09:51:12.252635+00', 'OH', 140000.00, 1, 3, 35);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (75, '2026-04-24 09:51:12.269026+00', '2026-04-24 09:51:12.269069+00', 'OH', 170000.00, 1, 3, 36);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (76, '2026-04-24 09:51:12.286693+00', '2026-04-24 09:51:12.286734+00', 'OH', 170000.00, 1, 3, 37);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (77, '2026-04-24 09:51:12.302993+00', '2026-04-24 09:51:12.303037+00', 'OH', 170000.00, 1, 3, 38);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (78, '2026-04-24 09:51:12.319527+00', '2026-04-24 09:51:12.31957+00', 'OH', 75000.00, 1, 2, 71);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (79, '2026-04-24 09:51:12.336496+00', '2026-04-24 09:51:12.33654+00', 'OH', 75000.00, 1, 2, 72);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (80, '2026-04-24 09:51:12.352975+00', '2026-04-24 09:51:12.353018+00', 'OH', 75000.00, 1, 2, 73);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (81, '2026-04-24 09:51:12.370026+00', '2026-04-24 09:51:12.37007+00', 'OH', 75000.00, 1, 2, 74);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (82, '2026-04-24 09:51:12.386426+00', '2026-04-24 09:51:12.38647+00', 'OH', 75000.00, 1, 2, 75);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (83, '2026-04-24 09:51:12.402962+00', '2026-04-24 09:51:12.403005+00', 'OH', 100000.00, 1, 2, 76);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (84, '2026-04-24 09:51:12.419618+00', '2026-04-24 09:51:12.419661+00', 'OH', 100000.00, 1, 2, 77);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (85, '2026-04-24 09:51:12.436355+00', '2026-04-24 09:51:12.436398+00', 'OH', 100000.00, 1, 2, 78);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (86, '2026-04-24 09:51:12.454651+00', '2026-04-24 09:51:12.454693+00', 'OH', 100000.00, 1, 2, 79);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (87, '2026-04-24 09:51:12.469961+00', '2026-04-24 09:51:12.470003+00', 'OH', 100000.00, 1, 2, 80);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (88, '2026-04-24 09:51:12.486283+00', '2026-04-24 09:51:12.486353+00', 'OH', 100000.00, 1, 2, 81);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (89, '2026-04-24 09:51:12.503032+00', '2026-04-24 09:51:12.503075+00', 'OH', 100000.00, 1, 2, 82);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (90, '2026-04-24 09:51:12.520227+00', '2026-04-24 09:51:12.520271+00', 'OH', 100000.00, 1, 2, 83);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (91, '2026-04-24 09:51:12.536118+00', '2026-04-24 09:51:12.536161+00', 'OH', 125000.00, 1, 2, 84);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (92, '2026-04-24 09:51:12.552342+00', '2026-04-24 09:51:12.552389+00', 'OH', 125000.00, 1, 2, 85);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (93, '2026-04-24 09:51:12.569965+00', '2026-04-24 09:51:12.570008+00', 'OH', 125000.00, 1, 2, 86);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (94, '2026-04-24 09:51:12.587007+00', '2026-04-24 09:51:12.58705+00', 'OH', 125000.00, 1, 2, 87);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (95, '2026-04-24 09:51:12.602735+00', '2026-04-24 09:51:12.602778+00', 'OH', 125000.00, 1, 2, 88);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (96, '2026-04-24 09:51:12.621641+00', '2026-04-24 09:51:12.621687+00', 'OH', 125000.00, 1, 2, 89);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (97, '2026-04-24 09:51:12.635714+00', '2026-04-24 09:51:12.635758+00', 'OH', 125000.00, 1, 2, 90);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (98, '2026-04-24 09:51:12.654029+00', '2026-04-24 09:51:12.654072+00', 'OH', 125000.00, 1, 2, 91);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (99, '2026-04-24 09:51:12.670297+00', '2026-04-24 09:51:12.67037+00', 'OH', 125000.00, 1, 2, 92);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (100, '2026-04-24 09:51:12.687059+00', '2026-04-24 09:51:12.687103+00', 'OH', 125000.00, 1, 2, 93);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (101, '2026-04-24 09:51:12.701142+00', '2026-04-24 09:51:12.701175+00', 'OH', 120000.00, 1, 4, 1);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (102, '2026-04-24 09:51:12.718603+00', '2026-04-24 09:51:12.71864+00', 'OH', 130000.00, 1, 4, 2);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (103, '2026-04-24 09:51:12.735231+00', '2026-04-24 09:51:12.73527+00', 'OH', 130000.00, 1, 4, 3);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (104, '2026-04-24 09:51:12.750434+00', '2026-04-24 09:51:12.750474+00', 'OH', 130000.00, 1, 4, 4);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (105, '2026-04-24 09:51:12.7696+00', '2026-04-24 09:51:12.769642+00', 'OH', 130000.00, 1, 4, 5);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (106, '2026-04-24 09:51:12.786157+00', '2026-04-24 09:51:12.786195+00', 'OH', 120000.00, 1, 4, 6);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (107, '2026-04-24 09:51:12.803825+00', '2026-04-24 09:51:12.803864+00', 'OH', 120000.00, 1, 4, 7);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (108, '2026-04-24 09:51:12.8168+00', '2026-04-24 09:51:12.816824+00', 'OH', 130000.00, 1, 4, 8);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (109, '2026-04-24 09:51:12.836693+00', '2026-04-24 09:51:12.836739+00', 'OH', 130000.00, 1, 4, 9);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (110, '2026-04-24 09:51:12.854899+00', '2026-04-24 09:51:12.854943+00', 'OH', 130000.00, 1, 4, 10);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (111, '2026-04-24 09:51:12.870913+00', '2026-04-24 09:51:12.870956+00', 'OH', 120000.00, 1, 4, 11);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (112, '2026-04-24 09:51:12.887094+00', '2026-04-24 09:51:12.887137+00', 'OH', 150000.00, 1, 4, 12);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (113, '2026-04-24 09:51:12.901669+00', '2026-04-24 09:51:12.901708+00', 'OH', 180000.00, 1, 4, 13);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (114, '2026-04-24 09:51:12.919968+00', '2026-04-24 09:51:12.920009+00', 'OH', 130000.00, 1, 4, 14);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (115, '2026-04-24 09:51:12.937021+00', '2026-04-24 09:51:12.937063+00', 'OH', 140000.00, 1, 4, 15);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (116, '2026-04-24 09:51:12.954013+00', '2026-04-24 09:51:12.954055+00', 'OH', 140000.00, 1, 4, 16);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (117, '2026-04-24 09:51:12.970101+00', '2026-04-24 09:51:12.970143+00', 'OH', 160000.00, 1, 4, 17);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (118, '2026-04-24 09:51:12.986997+00', '2026-04-24 09:51:12.987039+00', 'OH', 150000.00, 1, 4, 18);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (119, '2026-04-24 09:51:13.003597+00', '2026-04-24 09:51:13.003642+00', 'OH', 140000.00, 1, 4, 19);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (120, '2026-04-24 09:51:13.021217+00', '2026-04-24 09:51:13.02126+00', 'OH', 130000.00, 1, 4, 20);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (121, '2026-04-24 09:51:13.037078+00', '2026-04-24 09:51:13.037121+00', 'OH', 120000.00, 1, 4, 21);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (122, '2026-04-24 09:51:13.053856+00', '2026-04-24 09:51:13.0539+00', 'OH', 130000.00, 1, 4, 22);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (123, '2026-04-24 09:51:13.070169+00', '2026-04-24 09:51:13.070213+00', 'OH', 150000.00, 1, 4, 23);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (124, '2026-04-24 09:51:13.087033+00', '2026-04-24 09:51:13.087084+00', 'OH', 150000.00, 1, 4, 24);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (125, '2026-04-24 09:51:13.103959+00', '2026-04-24 09:51:13.104002+00', 'OH', 130000.00, 1, 4, 25);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (126, '2026-04-24 09:51:13.119541+00', '2026-04-24 09:51:13.119584+00', 'OH', 130000.00, 1, 4, 26);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (127, '2026-04-24 09:51:13.135982+00', '2026-04-24 09:51:13.136024+00', 'OH', 120000.00, 1, 4, 27);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (128, '2026-04-24 09:51:13.154288+00', '2026-04-24 09:51:13.154417+00', 'OH', 150000.00, 1, 4, 28);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (129, '2026-04-24 09:51:13.169083+00', '2026-04-24 09:51:13.169126+00', 'OH', 130000.00, 1, 4, 29);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (130, '2026-04-24 09:51:13.185831+00', '2026-04-24 09:51:13.185874+00', 'OH', 130000.00, 1, 4, 30);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (131, '2026-04-24 09:51:13.202239+00', '2026-04-24 09:51:13.202281+00', 'OH', 120000.00, 1, 4, 31);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (132, '2026-04-24 09:51:13.219195+00', '2026-04-24 09:51:13.219238+00', 'OH', 130000.00, 1, 4, 32);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (133, '2026-04-24 09:51:13.235668+00', '2026-04-24 09:51:13.235711+00', 'OH', 200000.00, 1, 4, 33);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (134, '2026-04-24 09:51:13.253139+00', '2026-04-24 09:51:13.253181+00', 'OH', 160000.00, 1, 4, 34);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (135, '2026-04-24 09:51:13.269851+00', '2026-04-24 09:51:13.269894+00', 'OH', 160000.00, 1, 4, 35);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (136, '2026-04-24 09:51:13.290694+00', '2026-04-24 09:51:13.290756+00', 'OH', 200000.00, 1, 4, 36);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (137, '2026-04-24 09:51:13.311899+00', '2026-04-24 09:51:13.311943+00', 'OH', 200000.00, 1, 4, 37);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (138, '2026-04-24 09:51:13.328587+00', '2026-04-24 09:51:13.328629+00', 'OH', 200000.00, 1, 4, 38);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (139, '2026-04-24 09:51:13.345094+00', '2026-04-24 09:51:13.345138+00', 'OH', 85000.00, 1, 5, 1);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (140, '2026-04-24 09:51:13.36242+00', '2026-04-24 09:51:13.362462+00', 'OH', 95000.00, 1, 5, 2);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (141, '2026-04-24 09:51:13.378498+00', '2026-04-24 09:51:13.37854+00', 'OH', 85000.00, 1, 5, 3);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (142, '2026-04-24 09:51:13.395267+00', '2026-04-24 09:51:13.395298+00', 'OH', 95000.00, 1, 5, 4);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (143, '2026-04-24 09:51:13.411036+00', '2026-04-24 09:51:13.411099+00', 'OH', 95000.00, 1, 5, 5);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (144, '2026-04-24 09:51:13.427505+00', '2026-04-24 09:51:13.427548+00', 'OH', 85000.00, 1, 5, 6);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (145, '2026-04-24 09:51:13.443642+00', '2026-04-24 09:51:13.443697+00', 'OH', 85000.00, 1, 5, 7);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (146, '2026-04-24 09:51:13.460226+00', '2026-04-24 09:51:13.460263+00', 'OH', 95000.00, 1, 5, 8);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (147, '2026-04-24 09:51:13.475149+00', '2026-04-24 09:51:13.475186+00', 'OH', 95000.00, 1, 5, 9);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (148, '2026-04-24 09:51:13.494141+00', '2026-04-24 09:51:13.494186+00', 'OH', 95000.00, 1, 5, 10);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (149, '2026-04-24 09:51:13.51197+00', '2026-04-24 09:51:13.511992+00', 'OH', 85000.00, 1, 5, 11);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (150, '2026-04-24 09:51:13.523714+00', '2026-04-24 09:51:13.523783+00', 'OH', 105000.00, 1, 5, 12);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (151, '2026-04-24 09:51:13.543652+00', '2026-04-24 09:51:13.543704+00', 'OH', 130000.00, 1, 5, 13);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (152, '2026-04-24 09:51:13.559953+00', '2026-04-24 09:51:13.559992+00', 'OH', 95000.00, 1, 5, 14);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (153, '2026-04-24 09:51:13.577481+00', '2026-04-24 09:51:13.577526+00', 'OH', 100000.00, 1, 5, 15);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (154, '2026-04-24 09:51:13.59424+00', '2026-04-24 09:51:13.594282+00', 'OH', 100000.00, 1, 5, 16);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (155, '2026-04-24 09:51:13.611888+00', '2026-04-24 09:51:13.611929+00', 'OH', 115000.00, 1, 5, 17);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (156, '2026-04-24 09:51:13.627442+00', '2026-04-24 09:51:13.627486+00', 'OH', 105000.00, 1, 5, 18);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (157, '2026-04-24 09:51:13.645236+00', '2026-04-24 09:51:13.645279+00', 'OH', 100000.00, 1, 5, 19);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (158, '2026-04-24 09:51:13.662038+00', '2026-04-24 09:51:13.662082+00', 'OH', 95000.00, 1, 5, 20);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (159, '2026-04-24 09:51:13.677513+00', '2026-04-24 09:51:13.677555+00', 'OH', 85000.00, 1, 5, 21);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (160, '2026-04-24 09:51:13.695133+00', '2026-04-24 09:51:13.695176+00', 'OH', 95000.00, 1, 5, 22);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (161, '2026-04-24 09:51:13.711774+00', '2026-04-24 09:51:13.711819+00', 'OH', 105000.00, 1, 5, 23);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (162, '2026-04-24 09:51:13.727958+00', '2026-04-24 09:51:13.728001+00', 'OH', 105000.00, 1, 5, 24);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (163, '2026-04-24 09:51:13.744223+00', '2026-04-24 09:51:13.744265+00', 'OH', 95000.00, 1, 5, 25);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (164, '2026-04-24 09:51:13.778428+00', '2026-04-24 09:51:13.778472+00', 'OH', 95000.00, 1, 5, 26);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (165, '2026-04-24 09:51:13.793937+00', '2026-04-24 09:51:13.79398+00', 'OH', 85000.00, 1, 5, 27);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (166, '2026-04-24 09:51:13.810609+00', '2026-04-24 09:51:13.810651+00', 'OH', 105000.00, 1, 5, 28);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (167, '2026-04-24 09:51:13.844184+00', '2026-04-24 09:51:13.844228+00', 'OH', 95000.00, 1, 5, 29);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (168, '2026-04-24 09:51:13.861607+00', '2026-04-24 09:51:13.86165+00', 'OH', 95000.00, 1, 5, 30);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (169, '2026-04-24 09:51:13.89443+00', '2026-04-24 09:51:13.894474+00', 'OH', 85000.00, 1, 5, 31);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (170, '2026-04-24 09:51:13.911377+00', '2026-04-24 09:51:13.91142+00', 'OH', 95000.00, 1, 5, 32);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (171, '2026-04-24 09:51:13.930013+00', '2026-04-24 09:51:13.930057+00', 'OH', 140000.00, 1, 5, 33);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (172, '2026-04-24 09:51:14.028767+00', '2026-04-24 09:51:14.028809+00', 'OH', 115000.00, 1, 5, 34);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (173, '2026-04-24 09:51:14.052787+00', '2026-04-24 09:51:14.052835+00', 'OH', 115000.00, 1, 5, 35);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (174, '2026-04-24 09:51:14.069243+00', '2026-04-24 09:51:14.069285+00', 'OH', 140000.00, 1, 5, 36);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (175, '2026-04-24 09:51:14.08596+00', '2026-04-24 09:51:14.086003+00', 'OH', 140000.00, 1, 5, 37);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (176, '2026-04-24 09:51:14.10262+00', '2026-04-24 09:51:14.102664+00', 'OH', 140000.00, 1, 5, 38);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (177, '2026-04-24 09:51:14.119266+00', '2026-04-24 09:51:14.119358+00', 'OH', 120000.00, 1, 6, 1);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (178, '2026-04-24 09:51:14.136152+00', '2026-04-24 09:51:14.136196+00', 'OH', 130000.00, 1, 6, 2);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (179, '2026-04-24 09:51:14.152637+00', '2026-04-24 09:51:14.15268+00', 'OH', 130000.00, 1, 6, 3);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (180, '2026-04-24 09:51:14.169233+00', '2026-04-24 09:51:14.169276+00', 'OH', 130000.00, 1, 6, 4);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (181, '2026-04-24 09:51:14.186199+00', '2026-04-24 09:51:14.186241+00', 'OH', 130000.00, 1, 6, 5);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (182, '2026-04-24 09:51:14.202715+00', '2026-04-24 09:51:14.202758+00', 'OH', 120000.00, 1, 6, 6);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (183, '2026-04-24 09:51:14.219494+00', '2026-04-24 09:51:14.219538+00', 'OH', 120000.00, 1, 6, 7);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (184, '2026-04-24 09:51:14.236102+00', '2026-04-24 09:51:14.236145+00', 'OH', 130000.00, 1, 6, 8);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (185, '2026-04-24 09:51:14.269399+00', '2026-04-24 09:51:14.269443+00', 'OH', 130000.00, 1, 6, 9);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (186, '2026-04-24 09:51:14.286104+00', '2026-04-24 09:51:14.286148+00', 'OH', 130000.00, 1, 6, 10);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (187, '2026-04-24 09:51:14.302642+00', '2026-04-24 09:51:14.302684+00', 'OH', 120000.00, 1, 6, 11);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (188, '2026-04-24 09:51:14.327856+00', '2026-04-24 09:51:14.3279+00', 'OH', 150000.00, 1, 6, 12);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (189, '2026-04-24 09:51:14.344741+00', '2026-04-24 09:51:14.344785+00', 'OH', 180000.00, 1, 6, 13);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (190, '2026-04-24 09:51:14.361517+00', '2026-04-24 09:51:14.36156+00', 'OH', 130000.00, 1, 6, 14);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (191, '2026-04-24 09:51:14.386041+00', '2026-04-24 09:51:14.386084+00', 'OH', 140000.00, 1, 6, 15);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (192, '2026-04-24 09:51:14.402779+00', '2026-04-24 09:51:14.40282+00', 'OH', 140000.00, 1, 6, 16);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (193, '2026-04-24 09:51:14.41811+00', '2026-04-24 09:51:14.418151+00', 'OH', 160000.00, 1, 6, 17);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (194, '2026-04-24 09:51:14.444837+00', '2026-04-24 09:51:14.44488+00', 'OH', 150000.00, 1, 6, 18);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (195, '2026-04-24 09:51:14.461913+00', '2026-04-24 09:51:14.461958+00', 'OH', 140000.00, 1, 6, 19);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (196, '2026-04-24 09:51:14.478805+00', '2026-04-24 09:51:14.478846+00', 'OH', 130000.00, 1, 6, 20);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (197, '2026-04-24 09:51:14.495418+00', '2026-04-24 09:51:14.495463+00', 'OH', 120000.00, 1, 6, 21);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (198, '2026-04-24 09:51:14.512338+00', '2026-04-24 09:51:14.512383+00', 'OH', 130000.00, 1, 6, 22);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (199, '2026-04-24 09:51:14.528695+00', '2026-04-24 09:51:14.528738+00', 'OH', 150000.00, 1, 6, 23);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (200, '2026-04-24 09:51:14.545353+00', '2026-04-24 09:51:14.545399+00', 'OH', 150000.00, 1, 6, 24);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (201, '2026-04-24 09:51:14.561847+00', '2026-04-24 09:51:14.56189+00', 'OH', 130000.00, 1, 6, 25);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (202, '2026-04-24 09:51:14.578815+00', '2026-04-24 09:51:14.578855+00', 'OH', 130000.00, 1, 6, 26);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (203, '2026-04-24 09:51:14.595632+00', '2026-04-24 09:51:14.595676+00', 'OH', 120000.00, 1, 6, 27);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (204, '2026-04-24 09:51:14.612825+00', '2026-04-24 09:51:14.612868+00', 'OH', 150000.00, 1, 6, 28);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (205, '2026-04-24 09:51:14.628269+00', '2026-04-24 09:51:14.628365+00', 'OH', 130000.00, 1, 6, 29);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (206, '2026-04-24 09:51:14.652952+00', '2026-04-24 09:51:14.652995+00', 'OH', 130000.00, 1, 6, 30);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (207, '2026-04-24 09:51:14.668571+00', '2026-04-24 09:51:14.668614+00', 'OH', 120000.00, 1, 6, 31);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (208, '2026-04-24 09:51:14.686223+00', '2026-04-24 09:51:14.686265+00', 'OH', 130000.00, 1, 6, 32);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (209, '2026-04-24 09:51:14.711357+00', '2026-04-24 09:51:14.7114+00', 'OH', 200000.00, 1, 6, 33);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (210, '2026-04-24 09:51:14.728039+00', '2026-04-24 09:51:14.728082+00', 'OH', 160000.00, 1, 6, 34);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (211, '2026-04-24 09:51:14.744497+00', '2026-04-24 09:51:14.74454+00', 'OH', 160000.00, 1, 6, 35);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (212, '2026-04-24 09:51:14.769538+00', '2026-04-24 09:51:14.76958+00', 'OH', 200000.00, 1, 6, 36);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (213, '2026-04-24 09:51:14.787405+00', '2026-04-24 09:51:14.787448+00', 'OH', 200000.00, 1, 6, 37);
INSERT INTO public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) VALUES (214, '2026-04-24 09:51:14.804058+00', '2026-04-24 09:51:14.804102+00', 'OH', 200000.00, 1, 6, 38);


ALTER TABLE public.spd_standarduangharian ENABLE TRIGGER ALL;

--
-- Data for Name: umum_pemda; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_pemda DISABLE TRIGGER ALL;

INSERT INTO public.umum_pemda (id, nama_pemda, nama_dinas_id, alamat, telepon, email, logo, website, ibukota, nama_kabupaten) VALUES (2, 'PEMERINTAH KABUPATEN ASAHAN', 57, NULL, NULL, NULL, 'pemda_logos/lambang-burung-garuda-333_ratio-16x9.webp', NULL, 'Kisaran', NULL);
INSERT INTO public.umum_pemda (id, nama_pemda, nama_dinas_id, alamat, telepon, email, logo, website, ibukota, nama_kabupaten) VALUES (3, 'PEMERINTAH KABUPATEN ASAHAN', 58, NULL, NULL, NULL, 'pemda_logos/lambang-burung-garuda-333_ratio-16x9_OjzwZoG.webp', NULL, 'Kisaran', NULL);
INSERT INTO public.umum_pemda (id, nama_pemda, nama_dinas_id, alamat, telepon, email, logo, website, ibukota, nama_kabupaten) VALUES (5, 'PEMERINTAH KABUPATEN ASAHAN', 1, 'Jalan Lintas Sumatera No. 15 Kisaran', 'K I S A R A N - 2 1 2 1 6', NULL, 'pemda_logos/Logo_kabupaten_asahan_5idLkaS.gif', NULL, 'Kisaran', 'Asahan');
INSERT INTO public.umum_pemda (id, nama_pemda, nama_dinas_id, alamat, telepon, email, logo, website, ibukota, nama_kabupaten) VALUES (4, 'PEMERINTAH KABUPATEN ASAHAN', 24, 'Jalan Jenderal Sudirman No. 5 Telepon 41928', 'K I S A R A N - 2 1 2 1 6', NULL, 'pemda_logos/Logo_kabupaten_asahan_HQ7aNku.gif', NULL, 'Kisaran', 'Asahan');
INSERT INTO public.umum_pemda (id, nama_pemda, nama_dinas_id, alamat, telepon, email, logo, website, ibukota, nama_kabupaten) VALUES (1, 'PEMERINTAH KABUPATEN ASAHAN', 27, 'JALAN TURI NO. 7 KISARAN - 2 1 2 1 6', NULL, 'asahanbkad@gmail.com', 'pemda_logos/Logo_kabupaten_asahan.gif', 'https://bpkad.asahankab.go.id/', 'Kisaran', 'Asahan');


ALTER TABLE public.umum_pemda ENABLE TRIGGER ALL;

--
-- Data for Name: umum_kopsurat; Type: TABLE DATA; Schema: public; Owner: raselstr
--

ALTER TABLE public.umum_kopsurat DISABLE TRIGGER ALL;

INSERT INTO public.umum_kopsurat (id, font_family, region_font_size_pt, office_font_size_pt, address_font_size_pt, contact_font_size_pt, logo_width_px, logo_height_px, print_scale_percent, pemda_id, default_spd_number_format, default_spt_number_format, margin_bottom_mm, margin_left_mm, margin_right_mm, margin_top_mm) VALUES (4, 'Arial, sans-serif', 14, 20, 12, 10, 80, 80, 96, 4, '800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}', '800.1.11.1/{nomor_urut}/SEKDA/{bulan}/{tahun}', 1, 1, 1, 1);
INSERT INTO public.umum_kopsurat (id, font_family, region_font_size_pt, office_font_size_pt, address_font_size_pt, contact_font_size_pt, logo_width_px, logo_height_px, print_scale_percent, pemda_id, default_spd_number_format, default_spt_number_format, margin_bottom_mm, margin_left_mm, margin_right_mm, margin_top_mm) VALUES (1, 'Arial, sans-serif', 14, 20, 12, 10, 160, 0, 90, 2, '800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}', '800.1.11.1/{nomor_urut}/BKAD/{bulan}/{tahun}', 1, 1, 1, 1);
INSERT INTO public.umum_kopsurat (id, font_family, region_font_size_pt, office_font_size_pt, address_font_size_pt, contact_font_size_pt, logo_width_px, logo_height_px, print_scale_percent, pemda_id, default_spd_number_format, default_spt_number_format, margin_bottom_mm, margin_left_mm, margin_right_mm, margin_top_mm) VALUES (2, 'Arial, sans-serif', 14, 20, 10, 10, 160, 0, 96, 3, '800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}', '800.1.11.1/{nomor_urut}/{bulan}/{tahun}', 1, 1, 1, 1);
INSERT INTO public.umum_kopsurat (id, font_family, region_font_size_pt, office_font_size_pt, address_font_size_pt, contact_font_size_pt, logo_width_px, logo_height_px, print_scale_percent, pemda_id, default_spd_number_format, default_spt_number_format, margin_bottom_mm, margin_left_mm, margin_right_mm, margin_top_mm) VALUES (5, 'Arial, sans-serif', 14, 20, 10, 10, 90, 90, 96, 5, '800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}', '800.1.11.1/{nomor_urut}/DISDIK/{bulan}/{tahun}', 1, 1, 1, 1);
INSERT INTO public.umum_kopsurat (id, font_family, region_font_size_pt, office_font_size_pt, address_font_size_pt, contact_font_size_pt, logo_width_px, logo_height_px, print_scale_percent, pemda_id, default_spd_number_format, default_spt_number_format, margin_bottom_mm, margin_left_mm, margin_right_mm, margin_top_mm) VALUES (3, 'Arial, sans-serif', 14, 20, 12, 10, 80, 80, 90, 1, '800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}', '800.1.11.1/{nomor_urut}/BKAD/{bulan}/{tahun}', 1, 15, 10, 1);


ALTER TABLE public.umum_kopsurat ENABLE TRIGGER ALL;

--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 162, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 10, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 40, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 57, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 103, true);


--
-- Name: menus_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.menus_menu_id_seq', 4, true);


--
-- Name: menus_rolepermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.menus_rolepermission_id_seq', 54, true);


--
-- Name: menus_submenu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.menus_submenu_id_seq', 27, true);


--
-- Name: perintah_pelaksana_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.perintah_pelaksana_id_seq', 36, true);


--
-- Name: perintah_pemberitugas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.perintah_pemberitugas_id_seq', 16, true);


--
-- Name: perintah_spt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.perintah_spt_id_seq', 11, true);


--
-- Name: profiles_opd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.profiles_opd_id_seq', 58, true);


--
-- Name: profiles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.profiles_role_id_seq', 2, true);


--
-- Name: profiles_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.profiles_userprofile_id_seq', 3, true);


--
-- Name: spd_dasarperaturan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_dasarperaturan_id_seq', 1, true);


--
-- Name: spd_jeniskegiatan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_jeniskegiatan_id_seq', 6, true);


--
-- Name: spd_jenisspd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_jenisspd_id_seq', 3, true);


--
-- Name: spd_jenistransportasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_jenistransportasi_id_seq', 3, true);


--
-- Name: spd_lokasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_lokasi_id_seq', 93, true);


--
-- Name: spd_standardpenginapan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_standardpenginapan_id_seq', 281, true);


--
-- Name: spd_standardpesawat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_standardpesawat_id_seq', 1, false);


--
-- Name: spd_standardrepresentasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_standardrepresentasi_id_seq', 1, false);


--
-- Name: spd_standardtransportasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_standardtransportasi_id_seq', 102, true);


--
-- Name: spd_standarduangharian_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.spd_standarduangharian_id_seq', 214, true);


--
-- Name: umum_eselon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_eselon_id_seq', 5, true);


--
-- Name: umum_jenisjabatan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_jenisjabatan_id_seq', 5, true);


--
-- Name: umum_kopsurat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_kopsurat_id_seq', 5, true);


--
-- Name: umum_pangkat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_pangkat_id_seq', 27, true);


--
-- Name: umum_pegawai_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_pegawai_id_seq', 50, true);


--
-- Name: umum_pemda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_pemda_id_seq', 5, true);


--
-- Name: umum_penandatangan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_penandatangan_id_seq', 8, true);


--
-- Name: umum_statusasn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_statusasn_id_seq', 3, true);


--
-- Name: umum_tingkat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raselstr
--

SELECT pg_catalog.setval('public.umum_tingkat_id_seq', 4, true);


--
-- PostgreSQL database dump complete
--

\unrestrict bGfDnaiugPbkQOWbE1pNjkE5E1FhwtUcVETLDBYJ3OxGHGNBy8yxizyngHcYLO4

