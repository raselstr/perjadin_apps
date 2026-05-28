--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Debian 14.18-1.pgdg120+1)
-- Dumped by pg_dump version 14.18 (Debian 14.18-1.pgdg120+1)

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

ALTER TABLE IF EXISTS ONLY public.umum_penandatangan DROP CONSTRAINT IF EXISTS umum_penandatangan_pangkat_id_697cc8a5_fk_umum_pangkat_id;
ALTER TABLE IF EXISTS ONLY public.umum_penandatangan DROP CONSTRAINT IF EXISTS umum_penandatangan_opd_id_30339ea1_fk_profiles_opd_id;
ALTER TABLE IF EXISTS ONLY public.umum_penandatangan DROP CONSTRAINT IF EXISTS umum_penandatangan_jenis_jabatan_id_d115c405_fk_umum_jeni;
ALTER TABLE IF EXISTS ONLY public.umum_pemda DROP CONSTRAINT IF EXISTS umum_pemda_nama_dinas_id_be26a2f6_fk_profiles_opd_id;
ALTER TABLE IF EXISTS ONLY public.umum_pegawai DROP CONSTRAINT IF EXISTS umum_pegawai_tingkat_id_bb65036c_fk_umum_tingkat_id;
ALTER TABLE IF EXISTS ONLY public.umum_pegawai DROP CONSTRAINT IF EXISTS umum_pegawai_status_id_8ea6d472_fk_umum_statusasn_id;
ALTER TABLE IF EXISTS ONLY public.umum_pegawai DROP CONSTRAINT IF EXISTS umum_pegawai_pangkat_id_7e4f60c0_fk_umum_pangkat_id;
ALTER TABLE IF EXISTS ONLY public.umum_pegawai DROP CONSTRAINT IF EXISTS umum_pegawai_opd_id_b8e98922_fk_profiles_opd_id;
ALTER TABLE IF EXISTS ONLY public.umum_pegawai DROP CONSTRAINT IF EXISTS umum_pegawai_jenis_jabatan_id_b1a5b8a1_fk_umum_jenisjabatan_id;
ALTER TABLE IF EXISTS ONLY public.umum_pegawai DROP CONSTRAINT IF EXISTS umum_pegawai_eselon_id_c16ef4a4_fk_umum_eselon_id;
ALTER TABLE IF EXISTS ONLY public.umum_kopsurat DROP CONSTRAINT IF EXISTS umum_kopsurat_pemda_id_bfe75c1c_fk_umum_pemda_id;
ALTER TABLE IF EXISTS ONLY public.spj_uangrepresentasi DROP CONSTRAINT IF EXISTS spj_uangrepresentasi_verified_by_id_4a005d5a_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.spj_uangrepresentasi DROP CONSTRAINT IF EXISTS spj_uangrepresentasi_spt_id_b4e03078_fk_perintah_spt_id;
ALTER TABLE IF EXISTS ONLY public.spj_uangrepresentasi DROP CONSTRAINT IF EXISTS spj_uangrepresentasi_pelaksana_id_8aaef51e_fk_perintah_;
ALTER TABLE IF EXISTS ONLY public.spj_uangharian DROP CONSTRAINT IF EXISTS spj_uangharian_verified_by_id_045cf338_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.spj_uangharian DROP CONSTRAINT IF EXISTS spj_uangharian_spt_id_fa993f0a_fk_perintah_spt_id;
ALTER TABLE IF EXISTS ONLY public.spj_uangharian DROP CONSTRAINT IF EXISTS spj_uangharian_pelaksana_id_81e2f85d_fk_perintah_pelaksana_id;
ALTER TABLE IF EXISTS ONLY public.spj_transport DROP CONSTRAINT IF EXISTS spj_transport_verified_by_id_fb53c6ea_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.spj_transport DROP CONSTRAINT IF EXISTS spj_transport_tujuan_id_af6b34d8_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.spj_transport DROP CONSTRAINT IF EXISTS spj_transport_spt_id_2c70cf40_fk_perintah_spt_id;
ALTER TABLE IF EXISTS ONLY public.spj_transport DROP CONSTRAINT IF EXISTS spj_transport_pelaksana_id_5847adb6_fk_perintah_pelaksana_id;
ALTER TABLE IF EXISTS ONLY public.spj_transport DROP CONSTRAINT IF EXISTS spj_transport_lokasi_berangkat_id_df1e12f8_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.spj_transport DROP CONSTRAINT IF EXISTS spj_transport_jenis_transportasi_i_678611a3_fk_spd_jenis;
ALTER TABLE IF EXISTS ONLY public.spj_transport DROP CONSTRAINT IF EXISTS spj_transport_jenis_spj_id_d687964b_fk_spj_jenisspj_id;
ALTER TABLE IF EXISTS ONLY public.spj_pesawat DROP CONSTRAINT IF EXISTS spj_pesawat_verified_by_id_9b22df6b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.spj_pesawat DROP CONSTRAINT IF EXISTS spj_pesawat_tujuan_bandara_id_ed085db5_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.spj_pesawat DROP CONSTRAINT IF EXISTS spj_pesawat_spt_id_e2dec9ae_fk_perintah_spt_id;
ALTER TABLE IF EXISTS ONLY public.spj_pesawat DROP CONSTRAINT IF EXISTS spj_pesawat_pelaksana_id_47433962_fk_perintah_pelaksana_id;
ALTER TABLE IF EXISTS ONLY public.spj_pesawat DROP CONSTRAINT IF EXISTS spj_pesawat_lokasi_bandara_id_7d836592_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.spj_pesawat DROP CONSTRAINT IF EXISTS spj_pesawat_jenis_spj_id_2f0a30db_fk_spj_jenisspj_id;
ALTER TABLE IF EXISTS ONLY public.spj_penginapan DROP CONSTRAINT IF EXISTS spj_penginapan_verified_by_id_e731e455_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.spj_penginapan DROP CONSTRAINT IF EXISTS spj_penginapan_spt_id_5fc25b62_fk_perintah_spt_id;
ALTER TABLE IF EXISTS ONLY public.spj_penginapan DROP CONSTRAINT IF EXISTS spj_penginapan_pelaksana_id_674df12e_fk_perintah_pelaksana_id;
ALTER TABLE IF EXISTS ONLY public.spj_laporanperjalanan DROP CONSTRAINT IF EXISTS spj_laporanperjalanan_verified_by_id_191d54c5_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.spj_laporanperjalanan DROP CONSTRAINT IF EXISTS spj_laporanperjalanan_spt_id_1f901426_fk_perintah_spt_id;
ALTER TABLE IF EXISTS ONLY public.spj_laporanperjalanan DROP CONSTRAINT IF EXISTS spj_laporanperjalana_pelaksana_id_03e49a6c_fk_perintah_;
ALTER TABLE IF EXISTS ONLY public.spd_standarduangharian DROP CONSTRAINT IF EXISTS spd_standarduangharian_lokasi_id_efa10a7a_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.spd_standarduangharian DROP CONSTRAINT IF EXISTS spd_standarduanghari_jenis_kegiatan_id_034ff9c4_fk_spd_jenis;
ALTER TABLE IF EXISTS ONLY public.spd_standarduangharian DROP CONSTRAINT IF EXISTS spd_standarduanghari_dasar_peraturan_id_472e4728_fk_spd_dasar;
ALTER TABLE IF EXISTS ONLY public.spd_standardtransportasi DROP CONSTRAINT IF EXISTS spd_standardtranspor_kota_tujuan_id_b7a6a2e7_fk_spd_lokas;
ALTER TABLE IF EXISTS ONLY public.spd_standardtransportasi DROP CONSTRAINT IF EXISTS spd_standardtranspor_jenis_transportasi_i_6b515fb4_fk_spd_jenis;
ALTER TABLE IF EXISTS ONLY public.spd_standardtransportasi DROP CONSTRAINT IF EXISTS spd_standardtranspor_dasar_peraturan_id_9956d460_fk_spd_dasar;
ALTER TABLE IF EXISTS ONLY public.spd_standardrepresentasi DROP CONSTRAINT IF EXISTS spd_standardrepresen_tingkat_spd_id_40a75aba_fk_umum_ting;
ALTER TABLE IF EXISTS ONLY public.spd_standardrepresentasi DROP CONSTRAINT IF EXISTS spd_standardrepresen_jenis_spd_id_d975ab10_fk_spd_jenis;
ALTER TABLE IF EXISTS ONLY public.spd_standardrepresentasi DROP CONSTRAINT IF EXISTS spd_standardrepresen_dasar_peraturan_id_317cdf7b_fk_spd_dasar;
ALTER TABLE IF EXISTS ONLY public.spd_standardpesawat DROP CONSTRAINT IF EXISTS spd_standardpesawat_tingkat_id_b55f4198_fk_umum_tingkat_id;
ALTER TABLE IF EXISTS ONLY public.spd_standardpesawat DROP CONSTRAINT IF EXISTS spd_standardpesawat_kota_tujuan_id_282f3121_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.spd_standardpesawat DROP CONSTRAINT IF EXISTS spd_standardpesawat_kota_asal_id_3ecfa369_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.spd_standardpesawat DROP CONSTRAINT IF EXISTS spd_standardpesawat_dasar_peraturan_id_81f2291b_fk_spd_dasar;
ALTER TABLE IF EXISTS ONLY public.spd_standardpenginapan DROP CONSTRAINT IF EXISTS spd_standardpenginapan_tingkat_id_227cbcc0_fk_umum_tingkat_id;
ALTER TABLE IF EXISTS ONLY public.spd_standardpenginapan DROP CONSTRAINT IF EXISTS spd_standardpenginapan_lokasi_id_ebff99ab_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.spd_standardpenginapan DROP CONSTRAINT IF EXISTS spd_standardpenginap_dasar_peraturan_id_0bfe7347_fk_spd_dasar;
ALTER TABLE IF EXISTS ONLY public.spd_lokasi DROP CONSTRAINT IF EXISTS spd_lokasi_jenis_spd_id_986735bc_fk_spd_jenisspd_id;
ALTER TABLE IF EXISTS ONLY public.profiles_userprofile DROP CONSTRAINT IF EXISTS profiles_userprofile_user_id_616bed88_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.profiles_userprofile DROP CONSTRAINT IF EXISTS profiles_userprofile_role_id_05631c9c_fk_profiles_role_id;
ALTER TABLE IF EXISTS ONLY public.profiles_userprofile DROP CONSTRAINT IF EXISTS profiles_userprofile_opd_id_92cf6435_fk_profiles_opd_id;
ALTER TABLE IF EXISTS ONLY public.perintah_ttdsptspd DROP CONSTRAINT IF EXISTS perintah_ttdsptspd_pemberi_tugas_id_55a595eb_fk_perintah_;
ALTER TABLE IF EXISTS ONLY public.perintah_spt DROP CONSTRAINT IF EXISTS perintah_spt_kota_tujuan_id_44be4bdc_fk_spd_lokasi_id;
ALTER TABLE IF EXISTS ONLY public.perintah_spt_kota_tujuan_tambahan DROP CONSTRAINT IF EXISTS perintah_spt_kota_tu_spt_id_e5374b99_fk_perintah_;
ALTER TABLE IF EXISTS ONLY public.perintah_spt_kota_tujuan_tambahan DROP CONSTRAINT IF EXISTS perintah_spt_kota_tu_lokasi_id_b8b1010b_fk_spd_lokas;
ALTER TABLE IF EXISTS ONLY public.perintah_spt DROP CONSTRAINT IF EXISTS perintah_spt_jenis_kegiatan_id_5633ddcd_fk_spd_jeniskegiatan_id;
ALTER TABLE IF EXISTS ONLY public.perintah_pemberitugas DROP CONSTRAINT IF EXISTS perintah_pemberitugas_spt_id_5dac4e73_fk_perintah_spt_id;
ALTER TABLE IF EXISTS ONLY public.perintah_pemberitugas DROP CONSTRAINT IF EXISTS perintah_pemberituga_penandatangan_id_8de52a83_fk_umum_pena;
ALTER TABLE IF EXISTS ONLY public.perintah_pelaksana DROP CONSTRAINT IF EXISTS perintah_pelaksana_spt_id_d06c47a0_fk_perintah_spt_id;
ALTER TABLE IF EXISTS ONLY public.perintah_pelaksana DROP CONSTRAINT IF EXISTS perintah_pelaksana_nama_id_4e3b5fe4_fk_umum_pegawai_id;
ALTER TABLE IF EXISTS ONLY public.menus_submenu DROP CONSTRAINT IF EXISTS menus_submenu_menu_id_160cb379_fk_menus_menu_id;
ALTER TABLE IF EXISTS ONLY public.menus_rolepermission DROP CONSTRAINT IF EXISTS menus_rolepermission_submenu_id_16f03829_fk_menus_submenu_id;
ALTER TABLE IF EXISTS ONLY public.menus_rolepermission DROP CONSTRAINT IF EXISTS menus_rolepermission_role_id_e75d12b7_fk_profiles_role_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_group_id_97559544_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX IF EXISTS public.unique_nomor_spt_not_blank;
DROP INDEX IF EXISTS public.unique_nomor_spd_not_blank;
DROP INDEX IF EXISTS public.umum_tingkat_tingkat_3eb7ce42_like;
DROP INDEX IF EXISTS public.umum_statusasn_nama_818a149d_like;
DROP INDEX IF EXISTS public.umum_penandatangan_pangkat_id_697cc8a5;
DROP INDEX IF EXISTS public.umum_penandatangan_opd_id_30339ea1;
DROP INDEX IF EXISTS public.umum_penandatangan_jenis_jabatan_id_d115c405;
DROP INDEX IF EXISTS public.umum_pegawai_tingkat_id_bb65036c;
DROP INDEX IF EXISTS public.umum_pegawai_status_id_8ea6d472;
DROP INDEX IF EXISTS public.umum_pegawai_pangkat_id_7e4f60c0;
DROP INDEX IF EXISTS public.umum_pegawai_opd_id_b8e98922;
DROP INDEX IF EXISTS public.umum_pegawai_jenis_jabatan_id_b1a5b8a1;
DROP INDEX IF EXISTS public.umum_pegawai_eselon_id_c16ef4a4;
DROP INDEX IF EXISTS public.umum_jenisjabatan_nama_bcb554f6_like;
DROP INDEX IF EXISTS public.umum_eselon_eselon_30743a78_like;
DROP INDEX IF EXISTS public.spj_uangrepresentasi_verified_by_id_4a005d5a;
DROP INDEX IF EXISTS public.spj_uangrepresentasi_spt_id_b4e03078;
DROP INDEX IF EXISTS public.spj_uangrepresentasi_pelaksana_id_8aaef51e;
DROP INDEX IF EXISTS public.spj_uangharian_verified_by_id_045cf338;
DROP INDEX IF EXISTS public.spj_uangharian_spt_id_fa993f0a;
DROP INDEX IF EXISTS public.spj_uangharian_pelaksana_id_81e2f85d;
DROP INDEX IF EXISTS public.spj_transport_verified_by_id_fb53c6ea;
DROP INDEX IF EXISTS public.spj_transport_tujuan_id_af6b34d8;
DROP INDEX IF EXISTS public.spj_transport_spt_id_2c70cf40;
DROP INDEX IF EXISTS public.spj_transport_pelaksana_id_5847adb6;
DROP INDEX IF EXISTS public.spj_transport_lokasi_berangkat_id_df1e12f8;
DROP INDEX IF EXISTS public.spj_transport_jenis_transportasi_id_678611a3;
DROP INDEX IF EXISTS public.spj_transport_jenis_spj_id_d687964b;
DROP INDEX IF EXISTS public.spj_pesawat_verified_by_id_9b22df6b;
DROP INDEX IF EXISTS public.spj_pesawat_tujuan_bandara_id_ed085db5;
DROP INDEX IF EXISTS public.spj_pesawat_spt_id_e2dec9ae;
DROP INDEX IF EXISTS public.spj_pesawat_pelaksana_id_47433962;
DROP INDEX IF EXISTS public.spj_pesawat_lokasi_bandara_id_7d836592;
DROP INDEX IF EXISTS public.spj_pesawat_jenis_spj_id_2f0a30db;
DROP INDEX IF EXISTS public.spj_penginapan_verified_by_id_e731e455;
DROP INDEX IF EXISTS public.spj_penginapan_spt_id_5fc25b62;
DROP INDEX IF EXISTS public.spj_penginapan_pelaksana_id_674df12e;
DROP INDEX IF EXISTS public.spj_laporanperjalanan_verified_by_id_191d54c5;
DROP INDEX IF EXISTS public.spj_laporanperjalanan_pelaksana_id_03e49a6c;
DROP INDEX IF EXISTS public.spj_jenisspj_jenis_spj_3f362204_like;
DROP INDEX IF EXISTS public.spd_standarduangharian_lokasi_id_efa10a7a;
DROP INDEX IF EXISTS public.spd_standarduangharian_jenis_kegiatan_id_034ff9c4;
DROP INDEX IF EXISTS public.spd_standarduangharian_dasar_peraturan_id_472e4728;
DROP INDEX IF EXISTS public.spd_standardtransportasi_kota_tujuan_id_b7a6a2e7;
DROP INDEX IF EXISTS public.spd_standardtransportasi_jenis_transportasi_id_6b515fb4;
DROP INDEX IF EXISTS public.spd_standardtransportasi_dasar_peraturan_id_9956d460;
DROP INDEX IF EXISTS public.spd_standardrepresentasi_tingkat_spd_id_40a75aba;
DROP INDEX IF EXISTS public.spd_standardrepresentasi_jenis_spd_id_d975ab10;
DROP INDEX IF EXISTS public.spd_standardrepresentasi_dasar_peraturan_id_317cdf7b;
DROP INDEX IF EXISTS public.spd_standardpesawat_tingkat_id_b55f4198;
DROP INDEX IF EXISTS public.spd_standardpesawat_kota_tujuan_id_282f3121;
DROP INDEX IF EXISTS public.spd_standardpesawat_kota_asal_id_3ecfa369;
DROP INDEX IF EXISTS public.spd_standardpesawat_dasar_peraturan_id_81f2291b;
DROP INDEX IF EXISTS public.spd_standardpenginapan_tingkat_id_227cbcc0;
DROP INDEX IF EXISTS public.spd_standardpenginapan_lokasi_id_ebff99ab;
DROP INDEX IF EXISTS public.spd_standardpenginapan_dasar_peraturan_id_0bfe7347;
DROP INDEX IF EXISTS public.spd_lokasi_lokasi_a1486dc6_like;
DROP INDEX IF EXISTS public.spd_lokasi_jenis_spd_id_986735bc;
DROP INDEX IF EXISTS public.spd_jenistransportasi_nama_4eff6df1_like;
DROP INDEX IF EXISTS public.spd_jenisspd_nama_cd359412_like;
DROP INDEX IF EXISTS public.spd_jeniskegiatan_nama_5be3d9d0_like;
DROP INDEX IF EXISTS public.profiles_userprofile_role_id_05631c9c;
DROP INDEX IF EXISTS public.profiles_userprofile_opd_id_92cf6435;
DROP INDEX IF EXISTS public.profiles_role_nama_be00b652_like;
DROP INDEX IF EXISTS public.profiles_opd_nama_5050e697_like;
DROP INDEX IF EXISTS public.perintah_spt_kota_tujuan_tambahan_spt_id_e5374b99;
DROP INDEX IF EXISTS public.perintah_spt_kota_tujuan_tambahan_lokasi_id_b8b1010b;
DROP INDEX IF EXISTS public.perintah_spt_kota_tujuan_id_44be4bdc;
DROP INDEX IF EXISTS public.perintah_spt_jenis_kegiatan_id_5633ddcd;
DROP INDEX IF EXISTS public.perintah_pemberitugas_spt_id_5dac4e73;
DROP INDEX IF EXISTS public.perintah_pemberitugas_penandatangan_id_8de52a83;
DROP INDEX IF EXISTS public.perintah_pelaksana_spt_id_d06c47a0;
DROP INDEX IF EXISTS public.perintah_pelaksana_nama_id_4e3b5fe4;
DROP INDEX IF EXISTS public.menus_submenu_menu_id_160cb379;
DROP INDEX IF EXISTS public.menus_rolepermission_submenu_id_16f03829;
DROP INDEX IF EXISTS public.menus_rolepermission_role_id_e75d12b7;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.auth_user_username_6821ab7c_like;
DROP INDEX IF EXISTS public.auth_user_user_permissions_user_id_a95ead1b;
DROP INDEX IF EXISTS public.auth_user_user_permissions_permission_id_1fbb5f2c;
DROP INDEX IF EXISTS public.auth_user_groups_user_id_6a12ed8b;
DROP INDEX IF EXISTS public.auth_user_groups_group_id_97559544;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
ALTER TABLE IF EXISTS ONLY public.spd_standarduangharian DROP CONSTRAINT IF EXISTS unique_uang_harian_lokasi_kegiatan_dasar_peraturan;
ALTER TABLE IF EXISTS ONLY public.spd_standardtransportasi DROP CONSTRAINT IF EXISTS unique_transportasi_jenis_kota_dasar_peraturan;
ALTER TABLE IF EXISTS ONLY public.spd_standardrepresentasi DROP CONSTRAINT IF EXISTS unique_representasi_tingkat_spd_dasar_peraturan;
ALTER TABLE IF EXISTS ONLY public.spd_standardpesawat DROP CONSTRAINT IF EXISTS unique_pesawat_asal_tujuan_tingkat_dasar_peraturan;
ALTER TABLE IF EXISTS ONLY public.spd_standardpenginapan DROP CONSTRAINT IF EXISTS unique_penginapan_lokasi_tingkat_dasar_peraturan;
ALTER TABLE IF EXISTS ONLY public.perintah_pemberitugas DROP CONSTRAINT IF EXISTS unique_pemberi_tugas_spt_penandatangan;
ALTER TABLE IF EXISTS ONLY public.umum_pegawai DROP CONSTRAINT IF EXISTS unique_pegawai_nip_eselon_jenis_jabatan;
ALTER TABLE IF EXISTS ONLY public.umum_pangkat DROP CONSTRAINT IF EXISTS unique_pangkat_golongan_ruang;
ALTER TABLE IF EXISTS ONLY public.umum_penandatangan DROP CONSTRAINT IF EXISTS uniq_penandatangan_nama_tugas_jenis_jabatan_opd;
ALTER TABLE IF EXISTS ONLY public.umum_tingkat DROP CONSTRAINT IF EXISTS umum_tingkat_tingkat_key;
ALTER TABLE IF EXISTS ONLY public.umum_tingkat DROP CONSTRAINT IF EXISTS umum_tingkat_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_statusasn DROP CONSTRAINT IF EXISTS umum_statusasn_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_statusasn DROP CONSTRAINT IF EXISTS umum_statusasn_nama_818a149d_uniq;
ALTER TABLE IF EXISTS ONLY public.umum_penandatangan DROP CONSTRAINT IF EXISTS umum_penandatangan_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_pemda DROP CONSTRAINT IF EXISTS umum_pemda_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_pemda DROP CONSTRAINT IF EXISTS umum_pemda_nama_dinas_key;
ALTER TABLE IF EXISTS ONLY public.umum_pegawai DROP CONSTRAINT IF EXISTS umum_pegawai_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_pangkat DROP CONSTRAINT IF EXISTS umum_pangkat_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_kopsurat DROP CONSTRAINT IF EXISTS umum_kopsurat_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_kopsurat DROP CONSTRAINT IF EXISTS umum_kopsurat_pemda_id_key;
ALTER TABLE IF EXISTS ONLY public.umum_jenisjabatan DROP CONSTRAINT IF EXISTS umum_jenisjabatan_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_jenisjabatan DROP CONSTRAINT IF EXISTS umum_jenisjabatan_nama_bcb554f6_uniq;
ALTER TABLE IF EXISTS ONLY public.umum_eselon DROP CONSTRAINT IF EXISTS umum_eselon_pkey;
ALTER TABLE IF EXISTS ONLY public.umum_eselon DROP CONSTRAINT IF EXISTS umum_eselon_eselon_key;
ALTER TABLE IF EXISTS ONLY public.spj_uangrepresentasi DROP CONSTRAINT IF EXISTS spj_uangrepresentasi_pkey;
ALTER TABLE IF EXISTS ONLY public.spj_uangharian DROP CONSTRAINT IF EXISTS spj_uangharian_pkey;
ALTER TABLE IF EXISTS ONLY public.spj_transport DROP CONSTRAINT IF EXISTS spj_transport_pkey;
ALTER TABLE IF EXISTS ONLY public.spj_pesawat DROP CONSTRAINT IF EXISTS spj_pesawat_pkey;
ALTER TABLE IF EXISTS ONLY public.spj_penginapan DROP CONSTRAINT IF EXISTS spj_penginapan_pkey;
ALTER TABLE IF EXISTS ONLY public.spj_laporanperjalanan DROP CONSTRAINT IF EXISTS spj_laporanperjalanan_spt_id_key;
ALTER TABLE IF EXISTS ONLY public.spj_laporanperjalanan DROP CONSTRAINT IF EXISTS spj_laporanperjalanan_pkey;
ALTER TABLE IF EXISTS ONLY public.spj_jenisspj DROP CONSTRAINT IF EXISTS spj_jenisspj_pkey;
ALTER TABLE IF EXISTS ONLY public.spj_jenisspj DROP CONSTRAINT IF EXISTS spj_jenisspj_jenis_spj_key;
ALTER TABLE IF EXISTS ONLY public.spd_standarduangharian DROP CONSTRAINT IF EXISTS spd_standarduangharian_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_standardtransportasi DROP CONSTRAINT IF EXISTS spd_standardtransportasi_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_standardrepresentasi DROP CONSTRAINT IF EXISTS spd_standardrepresentasi_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_standardpesawat DROP CONSTRAINT IF EXISTS spd_standardpesawat_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_standardpenginapan DROP CONSTRAINT IF EXISTS spd_standardpenginapan_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_lokasi DROP CONSTRAINT IF EXISTS spd_lokasi_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_lokasi DROP CONSTRAINT IF EXISTS spd_lokasi_lokasi_key;
ALTER TABLE IF EXISTS ONLY public.spd_jenistransportasi DROP CONSTRAINT IF EXISTS spd_jenistransportasi_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_jenistransportasi DROP CONSTRAINT IF EXISTS spd_jenistransportasi_nama_key;
ALTER TABLE IF EXISTS ONLY public.spd_jenisspd DROP CONSTRAINT IF EXISTS spd_jenisspd_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_jenisspd DROP CONSTRAINT IF EXISTS spd_jenisspd_nama_key;
ALTER TABLE IF EXISTS ONLY public.spd_jeniskegiatan DROP CONSTRAINT IF EXISTS spd_jeniskegiatan_pkey;
ALTER TABLE IF EXISTS ONLY public.spd_jeniskegiatan DROP CONSTRAINT IF EXISTS spd_jeniskegiatan_nama_key;
ALTER TABLE IF EXISTS ONLY public.spd_dasarperaturan DROP CONSTRAINT IF EXISTS spd_dasarperaturan_pkey;
ALTER TABLE IF EXISTS ONLY public.profiles_userprofile DROP CONSTRAINT IF EXISTS profiles_userprofile_user_id_key;
ALTER TABLE IF EXISTS ONLY public.profiles_userprofile DROP CONSTRAINT IF EXISTS profiles_userprofile_pkey;
ALTER TABLE IF EXISTS ONLY public.profiles_role DROP CONSTRAINT IF EXISTS profiles_role_pkey;
ALTER TABLE IF EXISTS ONLY public.profiles_role DROP CONSTRAINT IF EXISTS profiles_role_nama_key;
ALTER TABLE IF EXISTS ONLY public.profiles_opd DROP CONSTRAINT IF EXISTS profiles_opd_pkey;
ALTER TABLE IF EXISTS ONLY public.profiles_opd DROP CONSTRAINT IF EXISTS profiles_opd_nama_key;
ALTER TABLE IF EXISTS ONLY public.perintah_ttdsptspd DROP CONSTRAINT IF EXISTS perintah_ttdsptspd_pkey;
ALTER TABLE IF EXISTS ONLY public.perintah_ttdsptspd DROP CONSTRAINT IF EXISTS perintah_ttdsptspd_pemberi_tugas_id_key;
ALTER TABLE IF EXISTS ONLY public.perintah_spt DROP CONSTRAINT IF EXISTS perintah_spt_pkey;
ALTER TABLE IF EXISTS ONLY public.perintah_spt_kota_tujuan_tambahan DROP CONSTRAINT IF EXISTS perintah_spt_kota_tujuan_tambahan_pkey;
ALTER TABLE IF EXISTS ONLY public.perintah_spt_kota_tujuan_tambahan DROP CONSTRAINT IF EXISTS perintah_spt_kota_tujuan_spt_id_lokasi_id_fa6c345c_uniq;
ALTER TABLE IF EXISTS ONLY public.perintah_pemberitugas DROP CONSTRAINT IF EXISTS perintah_pemberitugas_pkey;
ALTER TABLE IF EXISTS ONLY public.perintah_pelaksana DROP CONSTRAINT IF EXISTS perintah_pelaksana_pkey;
ALTER TABLE IF EXISTS ONLY public.menus_submenu DROP CONSTRAINT IF EXISTS menus_submenu_pkey;
ALTER TABLE IF EXISTS ONLY public.menus_rolepermission DROP CONSTRAINT IF EXISTS menus_rolepermission_role_id_submenu_id_c26af5f6_uniq;
ALTER TABLE IF EXISTS ONLY public.menus_rolepermission DROP CONSTRAINT IF EXISTS menus_rolepermission_pkey;
ALTER TABLE IF EXISTS ONLY public.menus_menu DROP CONSTRAINT IF EXISTS menus_menu_pkey;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_username_key;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_group_id_94350c0c_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
DROP TABLE IF EXISTS public.umum_tingkat;
DROP TABLE IF EXISTS public.umum_statusasn;
DROP TABLE IF EXISTS public.umum_penandatangan;
DROP TABLE IF EXISTS public.umum_pemda;
DROP TABLE IF EXISTS public.umum_pegawai;
DROP TABLE IF EXISTS public.umum_pangkat;
DROP TABLE IF EXISTS public.umum_kopsurat;
DROP TABLE IF EXISTS public.umum_jenisjabatan;
DROP TABLE IF EXISTS public.umum_eselon;
DROP TABLE IF EXISTS public.spj_uangrepresentasi;
DROP TABLE IF EXISTS public.spj_uangharian;
DROP TABLE IF EXISTS public.spj_transport;
DROP TABLE IF EXISTS public.spj_pesawat;
DROP TABLE IF EXISTS public.spj_penginapan;
DROP TABLE IF EXISTS public.spj_laporanperjalanan;
DROP TABLE IF EXISTS public.spj_jenisspj;
DROP TABLE IF EXISTS public.spd_standarduangharian;
DROP TABLE IF EXISTS public.spd_standardtransportasi;
DROP TABLE IF EXISTS public.spd_standardrepresentasi;
DROP TABLE IF EXISTS public.spd_standardpesawat;
DROP TABLE IF EXISTS public.spd_standardpenginapan;
DROP TABLE IF EXISTS public.spd_lokasi;
DROP TABLE IF EXISTS public.spd_jenistransportasi;
DROP TABLE IF EXISTS public.spd_jenisspd;
DROP TABLE IF EXISTS public.spd_jeniskegiatan;
DROP TABLE IF EXISTS public.spd_dasarperaturan;
DROP TABLE IF EXISTS public.profiles_userprofile;
DROP TABLE IF EXISTS public.profiles_role;
DROP TABLE IF EXISTS public.profiles_opd;
DROP TABLE IF EXISTS public.perintah_ttdsptspd;
DROP TABLE IF EXISTS public.perintah_spt_kota_tujuan_tambahan;
DROP TABLE IF EXISTS public.perintah_spt;
DROP TABLE IF EXISTS public.perintah_pemberitugas;
DROP TABLE IF EXISTS public.perintah_pelaksana;
DROP TABLE IF EXISTS public.menus_submenu;
DROP TABLE IF EXISTS public.menus_rolepermission;
DROP TABLE IF EXISTS public.menus_menu;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.auth_user_user_permissions;
DROP TABLE IF EXISTS public.auth_user_groups;
DROP TABLE IF EXISTS public.auth_user;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: menus_menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menus_menu (
    id bigint NOT NULL,
    nama character varying(100) NOT NULL,
    icon character varying(100),
    urutan integer NOT NULL
);


--
-- Name: menus_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.menus_menu ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.menus_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: menus_rolepermission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menus_rolepermission (
    id bigint NOT NULL,
    can_view boolean NOT NULL,
    can_add boolean NOT NULL,
    can_edit boolean NOT NULL,
    can_delete boolean NOT NULL,
    role_id bigint NOT NULL,
    submenu_id bigint NOT NULL
);


--
-- Name: menus_rolepermission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.menus_rolepermission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.menus_rolepermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: menus_submenu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menus_submenu (
    id bigint NOT NULL,
    nama character varying(100) NOT NULL,
    url character varying(255) NOT NULL,
    urutan integer NOT NULL,
    menu_id bigint NOT NULL
);


--
-- Name: menus_submenu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.menus_submenu ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.menus_submenu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: perintah_pelaksana; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.perintah_pelaksana (
    id bigint NOT NULL,
    nama_id bigint NOT NULL,
    spt_id bigint NOT NULL
);


--
-- Name: perintah_pelaksana_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.perintah_pelaksana ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.perintah_pelaksana_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: perintah_pemberitugas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.perintah_pemberitugas (
    id bigint NOT NULL,
    nama character varying(200) NOT NULL,
    nip character varying(30) NOT NULL,
    pangkat character varying(30) NOT NULL,
    tugas character varying(200) NOT NULL,
    jenis_jabatan character varying(100) NOT NULL,
    opd character varying(200) NOT NULL,
    penandatangan_id bigint NOT NULL,
    spt_id bigint NOT NULL,
    nomor_spt character varying(150),
    tanggal_spt date,
    nomor_spd character varying(150),
    nomor_urut character varying(50) NOT NULL
);


--
-- Name: perintah_pemberitugas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.perintah_pemberitugas ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.perintah_pemberitugas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: perintah_spt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.perintah_spt (
    id bigint NOT NULL,
    dasar text,
    berita text,
    lama_perjalanan integer NOT NULL,
    tgl_berangkat date NOT NULL,
    tgl_kembali date,
    kendaraan character varying(50) NOT NULL,
    jenis_kegiatan_id bigint NOT NULL,
    kota_tujuan_id bigint,
    tempat_tujuan text
);


--
-- Name: perintah_spt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.perintah_spt ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.perintah_spt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: perintah_spt_kota_tujuan_tambahan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.perintah_spt_kota_tujuan_tambahan (
    id bigint NOT NULL,
    spt_id bigint NOT NULL,
    lokasi_id bigint NOT NULL
);


--
-- Name: perintah_spt_kota_tujuan_tambahan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.perintah_spt_kota_tujuan_tambahan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.perintah_spt_kota_tujuan_tambahan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: perintah_ttdsptspd; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.perintah_ttdsptspd (
    id bigint NOT NULL,
    hardcopy character varying(100),
    pemberi_tugas_id bigint
);


--
-- Name: perintah_ttdsptspd_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.perintah_ttdsptspd ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.perintah_ttdsptspd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: profiles_opd; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles_opd (
    id bigint NOT NULL,
    nama character varying(255) NOT NULL
);


--
-- Name: profiles_opd_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.profiles_opd ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.profiles_opd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: profiles_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles_role (
    id bigint NOT NULL,
    nama character varying(100) NOT NULL
);


--
-- Name: profiles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.profiles_role ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.profiles_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: profiles_userprofile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles_userprofile (
    id bigint NOT NULL,
    opd_id bigint,
    role_id bigint,
    user_id integer NOT NULL,
    foto character varying(100)
);


--
-- Name: profiles_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.profiles_userprofile ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.profiles_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_dasarperaturan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_dasarperaturan (
    id bigint NOT NULL,
    nama_peraturan character varying(255) NOT NULL,
    nomor_peraturan character varying(150),
    tanggal_peraturan date,
    keterangan text,
    aktif boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: spd_dasarperaturan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_dasarperaturan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_dasarperaturan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_jeniskegiatan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_jeniskegiatan (
    id bigint NOT NULL,
    nama character varying(100) NOT NULL
);


--
-- Name: spd_jeniskegiatan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_jeniskegiatan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_jeniskegiatan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_jenisspd; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_jenisspd (
    id bigint NOT NULL,
    nama character varying(100) NOT NULL
);


--
-- Name: spd_jenisspd_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_jenisspd ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_jenisspd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_jenistransportasi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_jenistransportasi (
    id bigint NOT NULL,
    nama character varying(100) NOT NULL
);


--
-- Name: spd_jenistransportasi_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_jenistransportasi ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_jenistransportasi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_lokasi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_lokasi (
    id bigint NOT NULL,
    lokasi character varying(150) NOT NULL,
    jenis_spd_id bigint,
    kota character varying(100)
);


--
-- Name: spd_lokasi_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_lokasi ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_lokasi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_standardpenginapan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_standardpenginapan (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    biaya numeric(14,2) NOT NULL,
    dasar_peraturan_id bigint NOT NULL,
    lokasi_id bigint NOT NULL,
    tingkat_id bigint NOT NULL,
    satuan character varying(50)
);


--
-- Name: spd_standardpenginapan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_standardpenginapan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_standardpenginapan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_standardpesawat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_standardpesawat (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    biaya numeric(14,2) NOT NULL,
    dasar_peraturan_id bigint NOT NULL,
    kota_asal_id bigint NOT NULL,
    kota_tujuan_id bigint NOT NULL,
    tingkat_id bigint NOT NULL
);


--
-- Name: spd_standardpesawat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_standardpesawat ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_standardpesawat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_standardrepresentasi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_standardrepresentasi (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    biaya numeric(14,2) NOT NULL,
    dasar_peraturan_id bigint NOT NULL,
    tingkat_spd_id bigint NOT NULL,
    jenis_spd_id bigint NOT NULL
);


--
-- Name: spd_standardrepresentasi_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_standardrepresentasi ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_standardrepresentasi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_standardtransportasi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_standardtransportasi (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    satuan character varying(50) NOT NULL,
    biaya numeric(14,2) NOT NULL,
    dasar_peraturan_id bigint NOT NULL,
    jenis_transportasi_id bigint NOT NULL,
    kota_tujuan_id bigint NOT NULL
);


--
-- Name: spd_standardtransportasi_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_standardtransportasi ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_standardtransportasi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spd_standarduangharian; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spd_standarduangharian (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    satuan character varying(50) NOT NULL,
    biaya numeric(14,2) NOT NULL,
    dasar_peraturan_id bigint NOT NULL,
    jenis_kegiatan_id bigint NOT NULL,
    lokasi_id bigint NOT NULL
);


--
-- Name: spd_standarduangharian_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spd_standarduangharian ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spd_standarduangharian_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spj_jenisspj; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spj_jenisspj (
    id bigint NOT NULL,
    jenis_spj character varying(20) NOT NULL
);


--
-- Name: spj_jenisspj_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spj_jenisspj ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spj_jenisspj_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spj_laporanperjalanan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spj_laporanperjalanan (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    verif_status character varying(20) NOT NULL,
    verif_catatan text NOT NULL,
    verified_at timestamp with time zone,
    judul character varying(250) NOT NULL,
    dasar_pelaksanaan text NOT NULL,
    maksud_perjalanan text NOT NULL,
    instansi_dikunjungi text NOT NULL,
    waktu_pelaksanaan text NOT NULL,
    hasil text NOT NULL,
    penutup text NOT NULL,
    foto_1 character varying(100) NOT NULL,
    foto_2 character varying(100),
    foto_3 character varying(100),
    foto_4 character varying(100),
    pelaksana_id bigint NOT NULL,
    spt_id bigint NOT NULL,
    verified_by_id integer
);


--
-- Name: spj_laporanperjalanan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spj_laporanperjalanan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spj_laporanperjalanan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spj_penginapan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spj_penginapan (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    nama_hotel character varying(200) NOT NULL,
    alamat_hotel text NOT NULL,
    lama_menginap integer NOT NULL,
    harga_per_malam numeric(14,2) NOT NULL,
    bukti character varying(100),
    pelaksana_id bigint NOT NULL,
    spt_id bigint NOT NULL,
    foto_hotel character varying(100),
    latitude numeric(10,7),
    longitude numeric(10,7),
    nomor_kamar character varying(50) NOT NULL,
    tanggal_checkin date,
    tanggal_checkout date,
    tipe_kamar character varying(100) NOT NULL,
    verif_catatan text NOT NULL,
    verif_status character varying(20) NOT NULL,
    verified_at timestamp with time zone,
    verified_by_id integer,
    CONSTRAINT spj_penginapan_lama_menginap_check CHECK ((lama_menginap >= 0))
);


--
-- Name: spj_penginapan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spj_penginapan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spj_penginapan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spj_pesawat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spj_pesawat (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    harga_tiket numeric(14,2) NOT NULL,
    bukti character varying(100),
    jenis_spj_id bigint NOT NULL,
    lokasi_bandara_id bigint NOT NULL,
    pelaksana_id bigint NOT NULL,
    spt_id bigint NOT NULL,
    tujuan_bandara_id bigint NOT NULL,
    kode_booking character varying(100) NOT NULL,
    nama_maskapai character varying(100) NOT NULL,
    nomor_tiket character varying(100) NOT NULL,
    tanggal_penerbangan date,
    verif_catatan text NOT NULL,
    verif_status character varying(20) NOT NULL,
    verified_at timestamp with time zone,
    verified_by_id integer
);


--
-- Name: spj_pesawat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spj_pesawat ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spj_pesawat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spj_transport; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spj_transport (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    biaya numeric(14,2) NOT NULL,
    bukti character varying(100),
    jenis_spj_id bigint NOT NULL,
    jenis_transportasi_id bigint NOT NULL,
    lokasi_berangkat_id bigint NOT NULL,
    pelaksana_id bigint NOT NULL,
    spt_id bigint NOT NULL,
    tujuan_id bigint NOT NULL,
    verif_catatan text NOT NULL,
    verif_status character varying(20) NOT NULL,
    verified_at timestamp with time zone,
    verified_by_id integer
);


--
-- Name: spj_transport_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spj_transport ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spj_transport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spj_uangharian; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spj_uangharian (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    uang_harian_per_hari numeric(14,2) NOT NULL,
    total_uang_harian numeric(14,2) NOT NULL,
    pelaksana_id bigint NOT NULL,
    spt_id bigint NOT NULL,
    verif_catatan text NOT NULL,
    verif_status character varying(20) NOT NULL,
    verified_at timestamp with time zone,
    verified_by_id integer
);


--
-- Name: spj_uangharian_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spj_uangharian ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spj_uangharian_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spj_uangrepresentasi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spj_uangrepresentasi (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    biaya numeric(14,2) NOT NULL,
    pelaksana_id bigint NOT NULL,
    spt_id bigint NOT NULL,
    verif_catatan text NOT NULL,
    verif_status character varying(20) NOT NULL,
    verified_at timestamp with time zone,
    verified_by_id integer
);


--
-- Name: spj_uangrepresentasi_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spj_uangrepresentasi ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.spj_uangrepresentasi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_eselon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_eselon (
    id bigint NOT NULL,
    eselon character varying(100) NOT NULL,
    keterangan character varying(200)
);


--
-- Name: umum_eselon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_eselon ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_eselon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_jenisjabatan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_jenisjabatan (
    id bigint NOT NULL,
    nama character varying(150) NOT NULL,
    fungsi character varying(200),
    keterangan character varying(200)
);


--
-- Name: umum_jenisjabatan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_jenisjabatan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_jenisjabatan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_kopsurat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_kopsurat (
    id bigint NOT NULL,
    font_family character varying(120) NOT NULL,
    region_font_size_pt smallint NOT NULL,
    office_font_size_pt smallint NOT NULL,
    address_font_size_pt smallint NOT NULL,
    contact_font_size_pt smallint NOT NULL,
    logo_width_px smallint NOT NULL,
    logo_height_px smallint NOT NULL,
    print_scale_percent smallint NOT NULL,
    pemda_id bigint NOT NULL,
    default_spd_number_format character varying(100) NOT NULL,
    default_spt_number_format character varying(100) NOT NULL,
    margin_bottom_mm smallint NOT NULL,
    margin_left_mm smallint NOT NULL,
    margin_right_mm smallint NOT NULL,
    margin_top_mm smallint NOT NULL,
    CONSTRAINT umum_kopsurat_address_font_size_pt_check CHECK ((address_font_size_pt >= 0)),
    CONSTRAINT umum_kopsurat_contact_font_size_pt_check CHECK ((contact_font_size_pt >= 0)),
    CONSTRAINT umum_kopsurat_logo_height_px_check CHECK ((logo_height_px >= 0)),
    CONSTRAINT umum_kopsurat_logo_width_px_check CHECK ((logo_width_px >= 0)),
    CONSTRAINT umum_kopsurat_margin_bottom_mm_check CHECK ((margin_bottom_mm >= 0)),
    CONSTRAINT umum_kopsurat_margin_left_mm_check CHECK ((margin_left_mm >= 0)),
    CONSTRAINT umum_kopsurat_margin_right_mm_check CHECK ((margin_right_mm >= 0)),
    CONSTRAINT umum_kopsurat_margin_top_mm_check CHECK ((margin_top_mm >= 0)),
    CONSTRAINT umum_kopsurat_office_font_size_pt_check CHECK ((office_font_size_pt >= 0)),
    CONSTRAINT umum_kopsurat_print_scale_percent_check CHECK ((print_scale_percent >= 0)),
    CONSTRAINT umum_kopsurat_region_font_size_pt_check CHECK ((region_font_size_pt >= 0))
);


--
-- Name: umum_kopsurat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_kopsurat ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_kopsurat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_pangkat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_pangkat (
    id bigint NOT NULL,
    pangkat character varying(100) NOT NULL,
    golongan character varying(10) NOT NULL,
    ruang character varying(10) NOT NULL
);


--
-- Name: umum_pangkat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_pangkat ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_pangkat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_pegawai; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_pegawai (
    id bigint NOT NULL,
    nip character varying(30) NOT NULL,
    nama character varying(200) NOT NULL,
    jabatan character varying(200) NOT NULL,
    tgl_lahir date,
    jenis_jabatan_id bigint,
    opd_id bigint,
    pangkat_id bigint,
    status_id bigint,
    tingkat_id bigint,
    eselon_id bigint,
    foto character varying(100)
);


--
-- Name: umum_pegawai_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_pegawai ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_pegawai_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_pemda; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_pemda (
    id bigint NOT NULL,
    nama_pemda character varying(200) NOT NULL,
    nama_dinas_id bigint,
    alamat character varying(300),
    telepon character varying(50),
    email character varying(254),
    logo character varying(100),
    website character varying(200),
    ibukota character varying(100),
    nama_kabupaten character varying(200),
    password_standar character varying(128) NOT NULL
);


--
-- Name: umum_pemda_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_pemda ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_pemda_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_penandatangan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_penandatangan (
    id bigint NOT NULL,
    nama character varying(200) NOT NULL,
    nip character varying(30),
    tugas character varying(200),
    jenis_jabatan_id bigint,
    opd_id bigint,
    pangkat_id bigint
);


--
-- Name: umum_penandatangan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_penandatangan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_penandatangan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_statusasn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_statusasn (
    id bigint NOT NULL,
    nama character varying(100) NOT NULL
);


--
-- Name: umum_statusasn_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_statusasn ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_statusasn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: umum_tingkat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umum_tingkat (
    id bigint NOT NULL,
    tingkat character varying(100) NOT NULL,
    ket character varying(200),
    kapal character varying(100),
    keretaapian character varying(200),
    lainnya character varying(200),
    pesawat character varying(100)
);


--
-- Name: umum_tingkat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.umum_tingkat ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.umum_tingkat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add opd	7	add_opd
26	Can change opd	7	change_opd
27	Can delete opd	7	delete_opd
28	Can view opd	7	view_opd
29	Can add role	8	add_role
30	Can change role	8	change_role
31	Can delete role	8	delete_role
32	Can view role	8	view_role
33	Can add user profile	9	add_userprofile
34	Can change user profile	9	change_userprofile
35	Can delete user profile	9	delete_userprofile
36	Can view user profile	9	view_userprofile
37	Can add menu	10	add_menu
38	Can change menu	10	change_menu
39	Can delete menu	10	delete_menu
40	Can view menu	10	view_menu
41	Can add sub menu	11	add_submenu
42	Can change sub menu	11	change_submenu
43	Can delete sub menu	11	delete_submenu
44	Can view sub menu	11	view_submenu
45	Can add role permission	12	add_rolepermission
46	Can change role permission	12	change_rolepermission
47	Can delete role permission	12	delete_rolepermission
48	Can view role permission	12	view_rolepermission
49	Can add jenis jabatan	13	add_jenisjabatan
50	Can change jenis jabatan	13	change_jenisjabatan
51	Can delete jenis jabatan	13	delete_jenisjabatan
52	Can view jenis jabatan	13	view_jenisjabatan
53	Can add pangkat	14	add_pangkat
54	Can change pangkat	14	change_pangkat
55	Can delete pangkat	14	delete_pangkat
56	Can view pangkat	14	view_pangkat
57	Can add status asn	15	add_statusasn
58	Can change status asn	15	change_statusasn
59	Can delete status asn	15	delete_statusasn
60	Can view status asn	15	view_statusasn
61	Can add penandatangan	16	add_penandatangan
62	Can change penandatangan	16	change_penandatangan
63	Can delete penandatangan	16	delete_penandatangan
64	Can view penandatangan	16	view_penandatangan
65	Can add pegawai	17	add_pegawai
66	Can change pegawai	17	change_pegawai
67	Can delete pegawai	17	delete_pegawai
68	Can view pegawai	17	view_pegawai
69	Can add tingkat	18	add_tingkat
70	Can change tingkat	18	change_tingkat
71	Can delete tingkat	18	delete_tingkat
72	Can view tingkat	18	view_tingkat
73	Can add eselon	19	add_eselon
74	Can change eselon	19	change_eselon
75	Can delete eselon	19	delete_eselon
76	Can view eselon	19	view_eselon
77	Can add Pemda	20	add_pemda
78	Can change Pemda	20	change_pemda
79	Can delete Pemda	20	delete_pemda
80	Can view Pemda	20	view_pemda
81	Can add Kop Surat	21	add_kopsurat
82	Can change Kop Surat	21	change_kopsurat
83	Can delete Kop Surat	21	delete_kopsurat
84	Can view Kop Surat	21	view_kopsurat
85	Can add Dasar Peraturan	22	add_dasarperaturan
86	Can change Dasar Peraturan	22	change_dasarperaturan
87	Can delete Dasar Peraturan	22	delete_dasarperaturan
88	Can view Dasar Peraturan	22	view_dasarperaturan
89	Can add Jenis Kegiatan	23	add_jeniskegiatan
90	Can change Jenis Kegiatan	23	change_jeniskegiatan
91	Can delete Jenis Kegiatan	23	delete_jeniskegiatan
92	Can view Jenis Kegiatan	23	view_jeniskegiatan
93	Can add Jenis SPD	24	add_jenisspd
94	Can change Jenis SPD	24	change_jenisspd
95	Can delete Jenis SPD	24	delete_jenisspd
96	Can view Jenis SPD	24	view_jenisspd
97	Can add Jenis Transportasi	25	add_jenistransportasi
98	Can change Jenis Transportasi	25	change_jenistransportasi
99	Can delete Jenis Transportasi	25	delete_jenistransportasi
100	Can view Jenis Transportasi	25	view_jenistransportasi
101	Can add Lokasi	26	add_lokasi
102	Can change Lokasi	26	change_lokasi
103	Can delete Lokasi	26	delete_lokasi
104	Can view Lokasi	26	view_lokasi
105	Can add Standar Penginapan	27	add_standardpenginapan
106	Can change Standar Penginapan	27	change_standardpenginapan
107	Can delete Standar Penginapan	27	delete_standardpenginapan
108	Can view Standar Penginapan	27	view_standardpenginapan
109	Can add Standar Tiket Pesawat	28	add_standardpesawat
110	Can change Standar Tiket Pesawat	28	change_standardpesawat
111	Can delete Standar Tiket Pesawat	28	delete_standardpesawat
112	Can view Standar Tiket Pesawat	28	view_standardpesawat
113	Can add Standar Representasi	29	add_standardrepresentasi
114	Can change Standar Representasi	29	change_standardrepresentasi
115	Can delete Standar Representasi	29	delete_standardrepresentasi
116	Can view Standar Representasi	29	view_standardrepresentasi
117	Can add Standar Transportasi	30	add_standardtransportasi
118	Can change Standar Transportasi	30	change_standardtransportasi
119	Can delete Standar Transportasi	30	delete_standardtransportasi
120	Can view Standar Transportasi	30	view_standardtransportasi
121	Can add Standar Uang Harian	31	add_standarduangharian
122	Can change Standar Uang Harian	31	change_standarduangharian
123	Can delete Standar Uang Harian	31	delete_standarduangharian
124	Can view Standar Uang Harian	31	view_standarduangharian
125	Can add SPT	32	add_spt
126	Can change SPT	32	change_spt
127	Can delete SPT	32	delete_spt
128	Can view SPT	32	view_spt
129	Can add Pelaksana	33	add_pelaksana
130	Can change Pelaksana	33	change_pelaksana
131	Can delete Pelaksana	33	delete_pelaksana
132	Can view Pelaksana	33	view_pelaksana
133	Can add Pemberi Tugas	34	add_pemberitugas
134	Can change Pemberi Tugas	34	change_pemberitugas
135	Can delete Pemberi Tugas	34	delete_pemberitugas
136	Can view Pemberi Tugas	34	view_pemberitugas
163	Can add Tanda Tangan SPT/SPD	58	add_ttdsptspd
164	Can change Tanda Tangan SPT/SPD	58	change_ttdsptspd
165	Can delete Tanda Tangan SPT/SPD	58	delete_ttdsptspd
166	Can view Tanda Tangan SPT/SPD	58	view_ttdsptspd
167	Can add Jenis SPJ	59	add_jenisspj
168	Can change Jenis SPJ	59	change_jenisspj
169	Can delete Jenis SPJ	59	delete_jenisspj
170	Can view Jenis SPJ	59	view_jenisspj
171	Can add SPJ Penginapan	60	add_penginapan
172	Can change SPJ Penginapan	60	change_penginapan
173	Can delete SPJ Penginapan	60	delete_penginapan
174	Can view SPJ Penginapan	60	view_penginapan
175	Can add SPJ Pesawat	61	add_pesawat
176	Can change SPJ Pesawat	61	change_pesawat
177	Can delete SPJ Pesawat	61	delete_pesawat
178	Can view SPJ Pesawat	61	view_pesawat
179	Can add SPJ Transport	62	add_transport
180	Can change SPJ Transport	62	change_transport
181	Can delete SPJ Transport	62	delete_transport
182	Can view SPJ Transport	62	view_transport
183	Can add SPJ Uang Harian	63	add_uangharian
184	Can change SPJ Uang Harian	63	change_uangharian
185	Can delete SPJ Uang Harian	63	delete_uangharian
186	Can view SPJ Uang Harian	63	view_uangharian
187	Can add SPJ Uang Representasi	64	add_uangrepresentasi
188	Can change SPJ Uang Representasi	64	change_uangrepresentasi
189	Can delete SPJ Uang Representasi	64	delete_uangrepresentasi
190	Can view SPJ Uang Representasi	64	view_uangrepresentasi
191	Can add Laporan Perjalanan Dinas	65	add_laporanperjalanan
192	Can change Laporan Perjalanan Dinas	65	change_laporanperjalanan
193	Can delete Laporan Perjalanan Dinas	65	delete_laporanperjalanan
194	Can view Laporan Perjalanan Dinas	65	view_laporanperjalanan
139	Can add eselon	52	add_eselon
140	Can change eselon	52	change_eselon
141	Can delete eselon	52	delete_eselon
142	Can view eselon	52	view_eselon
143	Can add SPT	53	add_spt
144	Can change SPT	53	change_spt
145	Can delete SPT	53	delete_spt
146	Can view SPT	53	view_spt
147	Can add Pelaksana	54	add_pelaksana
148	Can change Pelaksana	54	change_pelaksana
149	Can delete Pelaksana	54	delete_pelaksana
150	Can view Pelaksana	54	view_pelaksana
151	Can add pemda	55	add_pemda
152	Can change pemda	55	change_pemda
153	Can delete pemda	55	delete_pemda
154	Can view pemda	55	view_pemda
155	Can add Pemberi Tugas	56	add_pemberitugas
156	Can change Pemberi Tugas	56	change_pemberitugas
157	Can delete Pemberi Tugas	56	delete_pemberitugas
158	Can view Pemberi Tugas	56	view_pemberitugas
159	Can add Kop Surat	57	add_kopsurat
160	Can change Kop Surat	57	change_kopsurat
161	Can delete Kop Surat	57	delete_kopsurat
162	Can view Kop Surat	57	view_kopsurat
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
9	pbkdf2_sha256$1000000$y0brC0d6vhB1BPA5K3kduY$S+FCNYmmT8OdReEmDNMpXROBqD6uxu63mgyA3pOLssY=	2026-05-07 12:48:51.360417+00	f	saleh			asahanbkad@gmail.com	f	t	2026-05-04 10:58:52.337548+00
8	pbkdf2_sha256$1000000$YvNcyfgbNksfvaBBumED6j$XNUw9EHib0+HoMBqN59PlZaQfNywex+wwyZFhkic4tE=	2026-05-06 01:36:00.480062+00	f	rahmad			rahmad@gmail.com	f	t	2026-05-04 06:38:25.087502+00
13	pbkdf2_sha256$1000000$kK6p5mtn85DLHWXLse54de$Ndkbk93ygNplmxLhcyKwnr9DvDLL/U5dappBROmD6wE=	2026-05-22 09:38:58.327352+00	f	198309292011011013	Rahmad Saleh Sitorus, S.Kom.			f	t	2026-05-22 09:38:56.961768+00
12	pbkdf2_sha256$1000000$WRajzaOTOr5pal9NLeg38i$r5xhQz9L4CacfnXxzQMmTbyTtGTMErLUT8/fJjq/6YM=	2026-05-26 01:15:06.996371+00	f	kantor			bkadasahan@gmail.com	f	t	2026-05-11 10:46:37.150367+00
1	pbkdf2_sha256$1000000$YjpAletTzOCcfOcwBIRKVV$MKlTJnH71Qd1E5Q+EkrxYxvTyhtD4KtAiktRiIlZPjg=	2026-05-28 10:31:12.579705+00	t	admin				t	t	2026-04-14 12:08:07.49271+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2026-04-16 04:21:39.634136+00	1	Umum	1	[{"added": {}}, {"added": {"name": "sub menu", "object": "Pegawai"}}]	10	1
2	2026-04-16 04:27:10.90715+00	1	Badan Keuangan dan Aset Daerah	1	[{"added": {}}]	7	1
3	2026-04-16 04:27:36.988674+00	1	Kepala	1	[{"added": {}}]	13	1
4	2026-04-16 04:27:44.043248+00	2	Plt.	1	[{"added": {}}]	13	1
5	2026-04-16 04:27:47.988727+00	3	Plh.	1	[{"added": {}}]	13	1
6	2026-04-16 04:28:16.097475+00	4	Sekretaris	1	[{"added": {}}]	13	1
7	2026-04-16 04:28:23.469872+00	5	Kepala Bidang	1	[{"added": {}}]	13	1
8	2026-04-16 04:28:58.054012+00	1	Pengatur Muda (III/a)	1	[{"added": {}}]	14	1
9	2026-04-16 04:29:08.991483+00	1	PNS	1	[{"added": {}}]	15	1
10	2026-04-16 09:14:35.030647+00	1	Umum	2	[{"added": {"name": "sub menu", "object": "Pejabat"}}]	10	1
11	2026-04-16 09:26:11.852836+00	2	rahmad	1	[{"added": {}}]	4	1
12	2026-04-16 09:26:22.085533+00	2	rahmad	2	[{"changed": {"fields": ["First name", "Last name"]}}]	4	1
13	2026-04-16 09:27:43.175323+00	1	Administrator	1	[{"added": {}}]	8	1
14	2026-04-16 09:27:56.330575+00	2	rahmad	2	[{"changed": {"fields": ["Opd", "Role"]}}]	9	1
15	2026-04-16 09:28:12.392039+00	1	Administrator - Pegawai	1	[{"added": {}}]	12	1
16	2026-04-16 10:14:54.48089+00	1	Administrator - Pegawai	2	[{"changed": {"fields": ["Can add"]}}]	12	1
17	2026-04-16 10:20:08.118657+00	1	Administrator - Pegawai	2	[{"changed": {"fields": ["Can edit", "Can delete"]}}]	12	1
18	2026-04-16 10:21:17.900442+00	1	Administrator - Pegawai	2	[{"changed": {"fields": ["Can add", "Can edit"]}}]	12	1
19	2026-04-16 10:42:43.322845+00	1	Administrator - Pegawai	2	[{"changed": {"fields": ["Can add"]}}]	12	1
20	2026-04-16 12:40:49.126548+00	1	Administrator - Pegawai	2	[{"changed": {"fields": ["Can add"]}}]	12	1
21	2026-04-16 12:48:04.415778+00	1	Administrator - Pegawai	2	[]	12	1
22	2026-04-16 12:48:15.576049+00	2	Administrator - Pejabat	1	[{"added": {}}]	12	1
23	2026-04-16 13:11:45.133691+00	1	Umum	2	[{"added": {"name": "sub menu", "object": "Role"}}, {"changed": {"name": "sub menu", "object": "Pejabat", "fields": ["Urutan"]}}]	10	1
24	2026-04-16 13:27:11.722798+00	2	Pengguna	1	[{"added": {}}]	8	1
25	2026-04-16 13:54:57.176435+00	3	Role	2	[]	11	1
26	2026-04-17 02:34:28.536319+00	2	Admin	1	[{"added": {}}]	10	1
27	2026-04-17 02:34:56.144858+00	3	Role	2	[{"changed": {"fields": ["Menu"]}}]	11	1
28	2026-04-17 02:35:06.891248+00	2	Admin	2	[{"changed": {"fields": ["Urutan"]}}]	10	1
29	2026-04-17 05:07:27.044499+00	2	Admin	2	[{"changed": {"fields": ["Icon"]}}]	10	1
30	2026-04-17 05:09:40.835967+00	2	Admin	2	[{"changed": {"fields": ["Icon"]}}]	10	1
31	2026-04-17 05:10:51.341004+00	2	Admin	2	[{"changed": {"fields": ["Icon"]}}]	10	1
32	2026-04-17 05:11:16.716516+00	1	Umum	2	[{"changed": {"fields": ["Icon"]}}]	10	1
33	2026-04-17 05:11:42.078456+00	2	Admin	2	[{"changed": {"fields": ["Icon"]}}]	10	1
34	2026-04-17 07:07:00.111969+00	2	Admin	2	[{"added": {"name": "sub menu", "object": "Menu"}}, {"changed": {"name": "sub menu", "object": "Role", "fields": ["Urutan"]}}]	10	1
35	2026-04-17 07:07:32.883372+00	2	Admin	2	[{"added": {"name": "sub menu", "object": "Sub Menu"}}]	10	1
36	2026-04-23 09:39:46.939253+00	1	Peraturan Bupati Asahan (4 Tahun 2026)	1	[{"added": {}}]	24	1
37	2026-04-23 09:40:50.429203+00	1	Peraturan Bupati Asahan (4 Tahun 2026)	2	[{"changed": {"fields": ["Keterangan"]}}]	24	1
38	2026-05-04 01:43:38.540755+00	1	PEMERINTAH KABUPATEN ASAHAN	2	[{"changed": {"fields": ["Nama kabupaten"]}}]	55	1
39	2026-05-04 06:37:50.973011+00	2	rahmad	3		4	1
40	2026-05-04 06:37:58.345089+00	7	saleh	3		4	1
41	2026-05-08 02:18:36.789732+00	10	Kantor	2	[]	4	1
42	2026-05-08 02:19:42.544151+00	10	Kantor	3		4	1
43	2026-05-11 10:45:42.317405+00	11	kantor	3		4	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	profiles	opd
8	profiles	role
9	profiles	userprofile
10	menus	menu
11	menus	submenu
12	menus	rolepermission
13	umum	jenisjabatan
14	umum	pangkat
15	umum	statusasn
16	umum	penandatangan
17	umum	pegawai
18	umum	tingkat
19	umum	eselon
20	umum	pemda
21	umum	kopsurat
22	spd	dasarperaturan
23	spd	jeniskegiatan
24	spd	jenisspd
25	spd	jenistransportasi
26	spd	lokasi
27	spd	standardpenginapan
28	spd	standardpesawat
29	spd	standardrepresentasi
30	spd	standardtransportasi
31	spd	standarduangharian
32	perintah	spt
33	perintah	pelaksana
34	perintah	pemberitugas
58	perintah	ttdsptspd
59	spj	jenisspj
60	spj	penginapan
61	spj	pesawat
62	spj	transport
63	spj	uangharian
64	spj	uangrepresentasi
65	spj	laporanperjalanan
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-05-08 02:11:19.491459+00
2	auth	0001_initial	2026-05-08 02:11:20.409251+00
3	admin	0001_initial	2026-05-08 02:11:20.601596+00
4	admin	0002_logentry_remove_auto_add	2026-05-08 02:11:20.622077+00
5	admin	0003_logentry_add_action_flag_choices	2026-05-08 02:11:20.649376+00
6	contenttypes	0002_remove_content_type_name	2026-05-08 02:11:20.70485+00
7	auth	0002_alter_permission_name_max_length	2026-05-08 02:11:20.741438+00
8	auth	0003_alter_user_email_max_length	2026-05-08 02:11:20.761341+00
9	auth	0004_alter_user_username_opts	2026-05-08 02:11:20.786671+00
10	auth	0005_alter_user_last_login_null	2026-05-08 02:11:20.815666+00
11	auth	0006_require_contenttypes_0002	2026-05-08 02:11:20.827898+00
12	auth	0007_alter_validators_add_error_messages	2026-05-08 02:11:20.853732+00
13	auth	0008_alter_user_username_max_length	2026-05-08 02:11:20.947608+00
14	auth	0009_alter_user_last_name_max_length	2026-05-08 02:11:21.034873+00
15	auth	0010_alter_group_name_max_length	2026-05-08 02:11:21.093955+00
16	auth	0011_update_proxy_permissions	2026-05-08 02:11:21.143609+00
17	auth	0012_alter_user_first_name_max_length	2026-05-08 02:11:21.177938+00
18	profiles	0001_initial	2026-05-08 02:11:21.79641+00
19	menus	0001_initial	2026-05-08 02:11:22.229242+00
20	umum	0001_initial	2026-05-08 02:11:23.023362+00
21	umum	0002_alter_penandatangan_nip	2026-05-08 02:11:23.060967+00
22	umum	0003_alter_pegawai_options	2026-05-08 02:11:23.091509+00
23	umum	0004_alter_penandatangan_options	2026-05-08 02:11:23.14848+00
24	umum	0005_alter_jenisjabatan_nama_alter_pangkat_pangkat_and_more	2026-05-08 02:11:23.459222+00
25	umum	0006_penandatangan_unique_nama_jenis_jabatan	2026-05-08 02:11:23.560641+00
26	umum	0007_tingkat	2026-05-08 02:11:23.764357+00
27	umum	0008_alter_tingkat_ket	2026-05-08 02:11:23.794535+00
28	umum	0009_pegawai_tingkat	2026-05-08 02:11:23.904995+00
29	umum	0010_tingkat_kapal_tingkat_keteraapian_tingkat_lainnya_and_more	2026-05-08 02:11:24.026174+00
30	umum	0011_rename_keteraapian_tingkat_keretaapian	2026-05-08 02:11:24.083234+00
31	umum	0012_alter_pangkat_pangkat_alter_pangkat_ruang_and_more	2026-05-08 02:11:24.233153+00
32	umum	0013_jenisjabatan_fungsi_jenisjabatan_keterangan	2026-05-08 02:11:24.326144+00
33	umum	0014_eselon	2026-05-08 02:11:24.478735+00
34	umum	0015_pegawai_eselon	2026-05-08 02:11:24.572686+00
35	umum	0016_pegawai_unique_pegawai_nip_eselon_jenis_jabatan	2026-05-08 02:11:24.648496+00
36	umum	0017_alter_pegawai_eselon_alter_pegawai_jenis_jabatan_and_more	2026-05-08 02:11:24.944163+00
37	umum	0018_alter_pegawai_eselon_alter_pegawai_jenis_jabatan_and_more	2026-05-08 02:11:25.351675+00
38	umum	0019_alter_pegawai_eselon_alter_pegawai_jenis_jabatan	2026-05-08 02:11:25.878997+00
39	umum	0020_alter_pegawai_nip	2026-05-08 02:11:25.935997+00
40	umum	0021_pemda	2026-05-08 02:11:26.291001+00
41	umum	0022_alter_pemda_options	2026-05-08 02:11:26.320755+00
42	umum	0023_remove_pemda_jenis_kop_pemda_website_and_more	2026-05-08 02:11:26.615753+00
43	umum	0024_pemda_ibukota	2026-05-08 02:11:26.666326+00
44	umum	0025_alter_penandatangan_tugas	2026-05-08 02:11:26.713913+00
45	umum	0026_remove_penandatangan_uniq_penandatangan_nama_jenis_jabatan_and_more	2026-05-08 02:11:26.850562+00
46	umum	0027_remove_penandatangan_uniq_penandatangan_nama_tugas_jenis_jabatan_opd_and_more	2026-05-08 02:11:26.931615+00
47	umum	0028_remove_penandatangan_uniq_penandatangan_nip_nama_tugas_jenis_jabatan_opd_and_more	2026-05-08 02:11:27.014495+00
48	umum	0029_remove_penandatangan_uniq_penandatangan_nama_tugas_jenis_jabatan_and_more	2026-05-08 02:11:27.097903+00
49	spd	0001_initial	2026-05-08 02:11:28.730769+00
50	spd	0002_alter_lokasi_options	2026-05-08 02:11:28.754073+00
51	spd	0003_remove_standardpenginapan_aktif_and_more	2026-05-08 02:11:28.852621+00
52	spd	0004_lokasi_kota	2026-05-08 02:11:28.876327+00
53	spd	0005_alter_lokasi_options	2026-05-08 02:11:28.89059+00
54	spd	0006_standardpenginapan_satuan	2026-05-08 02:11:28.911737+00
55	perintah	0001_initial	2026-05-08 02:11:29.222655+00
56	perintah	0002_spt_tempat_tujuan	2026-05-08 02:11:29.250482+00
57	perintah	0003_alter_spt_tempat_tujuan	2026-05-08 02:11:29.275325+00
58	perintah	0004_pemberitugas	2026-05-08 02:11:29.772932+00
59	perintah	0005_alter_spt_options_remove_spt_nomor_spt_and_more	2026-05-08 02:11:29.875408+00
60	perintah	0006_pemberitugas_unique_pemberi_tugas_spt_penandatangan	2026-05-08 02:11:29.945462+00
61	perintah	0007_pemberitugas_nomor_spd	2026-05-08 02:11:29.97154+00
62	perintah	0008_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_and_more	2026-05-08 02:11:30.046094+00
63	perintah	0009_alter_pemberitugas_nip_alter_pemberitugas_pangkat	2026-05-08 02:11:30.085212+00
64	perintah	0010_pemberitugas_nomor_urut	2026-05-08 02:11:30.103649+00
65	perintah	0011_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_nomor_spt_nomor_spd_and_more	2026-05-08 02:11:30.171968+00
66	sessions	0001_initial	2026-05-08 02:11:30.33144+00
67	umum	0030_alter_pemda_nama_dinas	2026-05-08 02:11:30.406672+00
68	umum	0031_kopsurat	2026-05-08 02:11:30.598236+00
69	umum	0032_kopsurat_default_spd_number_format_and_more	2026-05-08 02:11:30.753963+00
70	umum	0033_remove_kopsurat_footer_alignment_and_more	2026-05-08 02:11:30.925689+00
71	umum	0034_alter_kopsurat_default_spt_number_format_and_more	2026-05-08 02:11:30.952519+00
104	perintah	0012_alter_pemberitugas_document_numbers_unique	2026-05-19 05:04:34.789369+00
105	perintah	0013_spt_kota_tujuan_tambahan	2026-05-19 08:17:58.910403+00
106	perintah	0014_ttdsptspd	2026-05-22 05:08:15.91023+00
107	spd	0007_alter_jeniskegiatan_options_alter_jenisspd_options_and_more	2026-05-22 05:08:15.997115+00
108	spd	0008_alter_standardrepresentasi_options_and_more	2026-05-22 09:34:59.994259+00
109	spd	0009_alter_standardrepresentasi_options_and_more	2026-05-22 09:35:00.281661+00
110	spj	0001_initial	2026-05-22 09:35:02.00527+00
111	spj	0002_seed_spj_defaults	2026-05-22 09:35:02.597586+00
112	umum	0035_pemda_password_standar	2026-05-22 09:35:02.656952+00
113	profiles	0002_userprofile_foto	2026-05-28 10:08:58.07174+00
114	spj	0003_penginapan_foto_hotel_penginapan_latitude_and_more	2026-05-28 10:09:00.432734+00
115	umum	0036_pegawai_foto	2026-05-28 10:09:00.538893+00
72	umum	0014_eselon	2026-04-27 04:37:30.435294+00
73	umum	0015_pegawai_eselon	2026-04-27 04:38:28.293529+00
74	umum	0016_pegawai_unique_pegawai_nip_eselon_jenis_jabatan	2026-04-27 07:03:26.082337+00
75	umum	0017_alter_pegawai_eselon_alter_pegawai_jenis_jabatan_and_more	2026-04-27 07:09:33.783868+00
76	umum	0018_alter_pegawai_eselon_alter_pegawai_jenis_jabatan_and_more	2026-04-27 07:17:47.241321+00
77	umum	0019_alter_pegawai_eselon_alter_pegawai_jenis_jabatan	2026-04-27 07:29:56.501009+00
78	umum	0020_alter_pegawai_nip	2026-04-27 07:33:39.147647+00
79	perintah	0001_initial	2026-04-27 09:51:47.697958+00
80	perintah	0002_spt_tempat_tujuan	2026-04-28 11:03:33.065026+00
81	perintah	0003_alter_spt_tempat_tujuan	2026-04-28 11:06:34.589497+00
82	umum	0021_pemda	2026-04-30 04:22:58.600147+00
83	perintah	0004_pemberitugas	2026-04-30 04:22:59.350877+00
84	perintah	0005_alter_spt_options_remove_spt_nomor_spt_and_more	2026-04-30 04:30:55.047621+00
85	umum	0022_alter_pemda_options	2026-04-30 09:28:13.677508+00
86	umum	0023_remove_pemda_jenis_kop_pemda_website_and_more	2026-04-30 09:37:11.476717+00
87	perintah	0006_pemberitugas_unique_pemberi_tugas_spt_penandatangan	2026-04-30 09:40:31.064114+00
88	umum	0024_pemda_ibukota	2026-04-30 10:33:49.306107+00
89	umum	0025_alter_penandatangan_tugas	2026-04-30 10:54:29.707145+00
90	umum	0026_remove_penandatangan_uniq_penandatangan_nama_jenis_jabatan_and_more	2026-04-30 11:21:55.342022+00
91	umum	0027_remove_penandatangan_uniq_penandatangan_nama_tugas_jenis_jabatan_opd_and_more	2026-04-30 11:24:41.912176+00
92	umum	0028_remove_penandatangan_uniq_penandatangan_nip_nama_tugas_jenis_jabatan_opd_and_more	2026-04-30 12:59:47.184746+00
93	umum	0029_remove_penandatangan_uniq_penandatangan_nama_tugas_jenis_jabatan_and_more	2026-04-30 13:44:35.64216+00
94	perintah	0007_pemberitugas_nomor_spd	2026-04-30 13:44:35.682472+00
95	perintah	0008_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_and_more	2026-04-30 13:44:35.77591+00
96	umum	0030_alter_pemda_nama_dinas	2026-04-30 13:47:08.04122+00
97	perintah	0009_alter_pemberitugas_nip_alter_pemberitugas_pangkat	2026-04-30 14:11:37.466152+00
98	perintah	0010_pemberitugas_nomor_urut	2026-05-04 00:55:04.09774+00
99	umum	0031_kopsurat	2026-05-04 00:55:05.377202+00
100	umum	0032_kopsurat_default_spd_number_format_and_more	2026-05-04 00:55:05.615905+00
101	umum	0033_remove_kopsurat_footer_alignment_and_more	2026-05-04 00:55:05.746864+00
102	perintah	0011_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_nomor_spt_nomor_spd_and_more	2026-05-04 03:07:14.531831+00
103	umum	0034_alter_kopsurat_default_spt_number_format_and_more	2026-05-04 06:09:08.80437+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
5sk22cga97ptcoidlochvibu64am0oy6	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS0VmbVK5c_v5SLXuE:1wFQYX:9qeu6TBRE_WjmYq8bLut4Rg21QFcBYwp_eOmg7WTkYo	2026-04-22 06:00:25.651315+00
302fns8dnckt7oetu3pzflowm68f39yn	.eJxVj8sOwiAQRX_FsDYNRYqtO92b-AdkYMCidTA8VsZ_F40L3Z5778nMg2moZdY1u6QDsh3r2fqXGbBXR-8AL0Dn2NlIJQXTvSvdN83dMaJbDt_un2CGPLf1pCZnQU5e8gk3ho_YC6W8RNgOaPrR8EGOIFAhVzgMQvGt86Py3NpNL51v0gJzJd2OOEMCak7BhWo8u5xDJB3v-HmB6rL8U4IbtP4eb4FCLglKTKtTzVDY8wX2A1am:1wCcvP:kiRvj7RHZug_eWl2GPU1SJLgj0LiqkK1f0OcezERFeQ	2026-04-28 12:31:27.911404+00
2m7csykvshhe7911cu5zz3iwjlq6fpue	.eJxVj8sOwiAQRX_FsDYNRYqtO92b-AdkYMCidTA8VsZ_F40L3Z5778nMg2moZdY1u6QDsh3r2fqXGbBXR-8AL0Dn2NlIJQXTvSvdN83dMaJbDt_un2CGPLf1pCZnQU5e8gk3ho_YC6W8RNgOaPrR8EGOIFAhVzgMQvGt86Py3NpNL51v0gJzJd2OOEMCak7BhWo8u5xDJB3v-HmB6rL8U4IbtP4eb4FCLglKTKtTzVDY8wX2A1am:1wHCcC:_2PhuIR3dv7Nnz3bvy6o4_mejdTl67nsmW2WvcBzQKs	2026-04-27 03:31:32.046112+00
95bewzflk5fu3t0j0jbzx3fmd806zbtq	.eJxVj0tuAyEQRK8SsY5GMGZ6wLtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkgj3_Zxbdh0-3gN4xnfPkcmol2ulWme5pnd4y-f313n0QbFi3sdagvUOpg-SaDpYrEjNAkITrQlYoyxepcCYgDrQsM_DVBwWBO3cQ0ochbbj1ZMYRZyyYhnPmMwxefa0xJ5M_6e-F1Pf9kSa84Oi_0CWmWFvBlsvTqVdsY75jbQZdi9fYvthRrCsoqQXIn1-UnV7l:1wFTdU:3OkEtVoeaQMdHVA6calSZoQde-TGJVFxHW_YKfCJVSM	2026-04-22 09:17:44.923415+00
51octxwoxu2n84oxb5aypad4mzhf98mr	e30:1wIN1c:5dyAcAtSSEk5WfHZx9Qucuu6eNXcTarqARNOS339olI	2026-04-30 08:50:36.182089+00
ep4dk2cgevhzpv1hzonw0pt0lzyqhqgq	.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKSX1rJRQ1xuUpV7p:1wFQfM:JpZZOaHenWGAI4nysBkDCuwnHSwYT6sOnagCFHk5oKQ	2026-04-22 06:07:28.021175+00
370lzm1576r0eetab0171x6w7ibn127x	e30:1wINYX:nixGud1Ev-ua3kP--F8eQxu1RKv8BlAxyed2_cCjKmo	2026-04-30 09:24:37.768568+00
msfd2ysz5iujqraozv57b5kn505zm1ss	.eJxVj8tqAyEYhV-luC6DGked7Np9IW8gv_6asZ1o8RIoJe8eE7JItt-5cM4_MdDbanr1xUQke8LI-zOz4H58ugn4DemYJ5dTK9FON8v0UOv0ldFvnw_vS8EKdR3pRS7egViCoAvuLNXIuJRBIKgZLdOWzkIDR4lU4jxzSZUPWgbq3I4JH0Zpg7UnM0YcoUAanZxyOXj1tcacTP7F-4XUt-2VJjjB8H_gKaZYW4GWy9uhV2gjvkFtBlyL59j-yJ4pJfUYwNXlCpSNXuI:1wFVDH:eTV8QrYBJjvsr6BlqyZM--fKYRQ8jwLd8AmVvWMEbAE	2026-04-22 10:58:47.867269+00
xorscfe9l3c5eylwlmsk6vz7j95svxnk	.eJxVj8sOwiAQRX_FsDYNRYqtO92b-AdkYMCidTA8VsZ_F40L3Z5778nMg2moZdY1u6QDsh3r2fqXGbBXR-8AL0Dn2NlIJQXTvSvdN83dMaJbDt_un2CGPLf1pCZnQU5e8gk3ho_YC6W8RNgOaPrR8EGOIFAhVzgMQvGt86Py3NpNL51v0gJzJd2OOEMCak7BhWo8u5xDJB3v-HmB6rL8U4IbtP4eb4FCLglKTKtTzVDY8wX2A1am:1wFpRC:j4Po_yX5SXdTqxYDufGOMSpUrI_FqUeB3YRw6Tqzna4	2026-04-23 08:34:30.421262+00
iozp3vu5a0n73zvs31lrij33rqa211n1	.eJxVj0tuAyEQRK8SsY5G_IYZvLP3kXID1NDgIRlDxCdSFPnuxpEX8fZV1VP3LzHQ22Z69cVEJAfCyOt_ZsF9-nQP8APSOU8up1aine6V6ZHW6S2j30-P7pNgg7qNtVbaO5A6SKpRWLoi40oFibDMaNlq6SxX4KiQKpxnrujiw6oCdU4w6cOQNth6MuOIMxRIw8kpV4NXX2vMyeQv_Hsh9X1_pgkuMPpHvMQUayvQcnl57xXamO9QmwHX4ndsP-TAlkVpISgV1xuUaF7X:1wFpRj:KCMDxfduFLleZo3PyBMBWa3jsdikcesLUnZQbvtui4I	2026-04-23 08:35:03.635219+00
i86xbol9k9r7r9x813kuw7bu5xw8m5qh	.eJxVj0tuAyEQRK8SsY5GwADDeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wt3oFYg6ArzpZqZFypIBAWiZZpS6XQwFEhVSglV3TxQatAnZuZ8GFIG2w9mXHEGQqk4eSUq8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jgy6L0LMXMrzeUgl7e:1wFQ40:1RqvCISG75Jxp54GNBNBOyDI7LTDok2VZEzkUDrIV9M	2026-04-22 05:28:52.082163+00
k91q3ontk1bgi0wmgp5lwe2wznakwpmo	.eJxVj8tOBCEQRX_FsDYdoIGG2enexD8gBQXTaA8YHibG-O8yZhbO9tx7T6q-iYXRdztaqDYhORFGHv8zB_495GuAb5DPZfEl95rccq0st7QtLwXD8Xzr3gl2aPtcG2WCB2GioAZXRzUyrlQUCJtEx7SjUmjgqJAqlJIruoWoVaTer0yEOKUd9pHtPOIMFfJ0csrV5C20lkq25QP_XsjjOO5phgvM_hNeUk6tV-ilPryOBn3OD2jdgu_pM_UvcmLbpswquaY_v5SMXuA:1wFq2S:8ocd9bf6AA6AKB-JtEvZxHRg9uMiqx3Pm020pwah0GY	2026-04-23 09:13:00.963581+00
abkqwzvi0ahhgxsy503fmsfxreuilngs	.eJxVj8tOBCEQRX_FsDYdmuY5O92b-AekoGAa7QHDw8QY_13GzMLZnnvvSdU3sTD6bkcL1SYkJ7KSx__MgX8P-RrgG-RzWXzJvSa3XCvLLW3LS8FwPN-6d4Id2j7XRprggZvIqcHNUY0rkzJyBCXQrdpRwTUwlEglCsEkVSFqGan328pDnNIO-8h2HnGGCnk6GWVy8hZaSyXb8oF_L-RxHPc0wwVm_wkvKafWK_RSH15Hgz7nB7Ruwff0mfoXOa1KSbMJpeXPL5SsXus:1wFqAc:mNDWxfhXczPae9emPzLXBegZvyUiQY5XEQm720KUT5Y	2026-04-23 09:21:26.473709+00
0dcutqnzh3dllrph7gbrmkn5zhkg9gbt	.eJxVj8sOwiAQRX_FsDYNRYqtO92b-AdkYMCidTA8VsZ_F40L3Z5778nMg2moZdY1u6QDsh3r2fqXGbBXR-8AL0Dn2NlIJQXTvSvdN83dMaJbDt_un2CGPLf1pCZnQU5e8gk3ho_YC6W8RNgOaPrR8EGOIFAhVzgMQvGt86Py3NpNL51v0gJzJd2OOEMCak7BhWo8u5xDJB3v-HmB6rL8U4IbtP4eb4FCLglKTKtTzVDY8wX2A1am:1wEjab:_NtO7P1NjJuAbkSvMv2fH6sthOqPJliOuPstKJNSQ18	2026-05-04 08:02:41.592315+00
kgm3pdv7mybsxbd20a9rwnltlq6n4qea	.eJxVj0tuAyEQRK8SsY5GDGZ6wLtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkM3v-zyy6D59uAb1jOufJ5dRKtNOtMt3TOr1l8vvrvfsg2LBuY61Be4dSB8k1HSxXNAuAIAnXheysLF-kQkFAHGhZBPDVBwWBO3eYpQ9D2nDryYwjzlgwDafgAgavvtaYk8mf9PdC6vv-SBNecPRf6BJTrK1gy-Xp1Cu2Md-xNoOuxWtsX-w4rysoCVrBzy-UuF7u:1wFT4M:F4heCDuM3usdneg1irtX6m3pxVmraLpBNOsG_gfbDbI	2026-04-22 08:41:26.747006+00
9nmvdhc9ja1945eww6z78pk376eb0nd9	.eJxVj8tOBCEQRX_FsDYdmuY5O92b-AekoGAa7QHDw8QY_13GzMLZnnvvSdU3sTD6bkcL1SYkJ7KSx__MgX8P-RrgG-RzWXzJvSa3XCvLLW3LS8FwPN-6d4Id2j7XRprggZvIqcHNUY0rkzJyBCXQrdpRwTUwlEglCsEkVSFqGan328pDnNIO-8h2HnGGCnk6GWVy8hZaSyXb8oF_L-RxHPc0wwVm_wkvKafWK_RSH15Hgz7nB7Ruwff0mfoXOa1KSb0xJczPL5STXuc:1wFPMt:IhAvVR2rqTbuM5uBpam043y5_lXsyk1x9kqYuVSZsKM	2026-04-22 04:44:19.683517+00
itcyy6cxx2bdvsqs84uodeaea5aes02p	.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSurVKLr-_AKUm17j:1wFRAt:r5STu2mnD00vVfUx8pFfgIwJWv2v4Z2mj_ZUDijNTPw	2026-04-22 06:40:03.385997+00
boon14eblz0f6ul5k5hhex2ntghrdgjf	.eJxVj8tOBCEQRX_FsDYdmuY5O92b-AekoGAa7QHDw8QY_13GzMLZnnvvSdU3sTD6bkcL1SYkJ7KSx__MgX8P-RrgG-RzWXzJvSa3XCvLLW3LS8FwPN-6d4Id2j7XRprggZvIqcHNUY0rkzJyBCXQrdpRwTUwlEglCsEkVSFqGan328pDnNIO-8h2HnGGCnk6GWVy8hZaSyXb8oF_L-RxHPc0wwVm_wkvKafWK_RSH15Hgz7nB7Ruwff0mfoXOa1KSbMppsXPL5SgXuc:1wFqYn:JwPY4fSrY3s460QbBduVOR9gYJ-q0FZ2k7I7K8lI2Xk	2026-04-23 09:46:25.607735+00
1jd0ylrdkfkfj5mewopuixyeqjqb27fi	.eJxVj0tuAyEQRK8SsY5GwADDeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wt3oFYg6ArzpZqZFypIBAWiZZpS6XQwFEhVSglV3TxQatAnZuZ8GFIG2w9mXHEGQqk4eSUq8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jgy6L0zLUU1xuUjV7j:1wFPOQ:gAY4xhZ82j5wduhcwbHNx3mVR2aMM9Cp3vOL7uiJN7M	2026-04-22 04:45:54.142124+00
8j56cnkuaoz6vi97icd9hdoxogjyogpn	.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKSW1oLPi1xuUd17d:1wFRLg:K2YWkyOU9GZcZP3raH3jpdcVjroXp0JXR9BcQYt-JZM	2026-04-22 06:51:12.938293+00
1wqzmmsrra6g776zt4oivcy3fhrt76bx	.eJxVj8tOBCEQRX_FsDYdoOlqena6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5MsMf_zKJ79-ka0Bumc55cTq1EO10r0y2t00smfzzfuneCHes-1hts3qHaguIbzZZrEhIgKMJ1ISu05YvSKAmIAy2LBL76oCFw52ahfBjShntPZhxxxoJpOCWXMHj1tcacTP6gvxdSP457mvCCo_9El5hibQVbLg-vvWIb8wNrM-ha_Izti53EuoKeFXDx8wuUel7b:1wFPqb:PCJ1dM4MaoixBeGgladgXHl7EZIOrz5BAB-7GZlm1xM	2026-04-22 05:15:01.661856+00
roi6ynkf4zjw2awy7joqexy965i58l7q	e30:1wIQOa:RZLQhC30Zi8EIhcbshWLeBM2Si04-_eVG9BBVRd64gU	2026-04-30 12:26:32.679861+00
iz3p07j1jx36p2l28bi230ymuyijq5kl	e30:1wIOKl:eaEf0O05r1jOw5WWCFk7OCV7iXJqW_nSIh69CVMEZCI	2026-04-30 10:14:27.786945+00
8tbyhke2slhssvtyw9o52n3tgvjnoznm	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtabMCMl_fgGUW17a:1wGBfw:FU_H4xMX5gghPnU0z2p7Q3qmjdPkmxmwLkopquyeMbU	2026-04-24 08:19:12.817616+00
7ulqe6ber61xeiiq39kfzxu48rczoqe7	.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFKUaS3Y5QqUZl7c:1wGBmD:en6EG_cLedDpNauEhGURQmPaxSA85pv99kY3c14Aby8	2026-04-24 08:25:41.212512+00
os41vfmq43as9vtdio9qowzgrbrsl6ks	.eJxVj81OQyEQhV_FsDY3QIEL3enepG9ABgZ60Vsw_DQxxneXmi7s9jvnfJn5JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zbZQJHoSJgho8OKqRcaWiQFglOqYdlUIDR4VUoZRc0TVErSL1_sBEiFPaYRvZziPOUCFPJ6dcTd5Ca6lkWz7x74U89v2RZrjA7L_gJeXUeoVe6tNpNOhzvkPrFnxP19S_yJGtqzJGM7n-_AKUwF7s:1wG6Ob:N2daZfr0YnRbV9NwLFpzIkJNjLlIK2vhYdRlUUSw0BY	2026-04-24 02:40:57.412578+00
er1rkvps4wylqv8fija3ouzbejrttt23	.eJxVj8tOBCEQRX_FsDYdoGnonp3uTfwDUlAwjfYUhoeJMf67jJmFsz333pOqb2aht932GopNyE5MsMf_zIF_D3QN8A3onCefqZXkpmtluqV1eskYjudb906wQ93HetNb8KC2qPiGs-MrCql1VAhmQSdWxxe1gkSNXOOySM1NiKuO3PtZqBCHtMHeyY4jzlCAhlNyqQevodaUyeYP_HuB-nHcU4ILjP4TXhKl2gq0XB5ee4U25gfUZsG39JnaFzsJY8xslOLq5xeUdV7c:1wHgH6:IDnRr7ey38dEFEdNyJnlmOrOmdt-V6zpnOz34987WTs	2026-04-28 11:11:44.621348+00
ifltd8pya844twv9rj7bds0cwbo1w14y	.eJxVj8tOBCEQRX_FsDYdoOnqZna6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5MsMf_zKJ79-ka0Bumc55cTq1EO10r0y2t00smfzzfuneCHes-1hq0d6h0UFzTbPlGQgIERbguZMVm-aI2lATEgZZFAl992CBw52ahfBjShntPZhxxxoJpOCWXMHj1tcacTP6gvxdSP457mvCCo_9El5hibQVbLg-vvWIb8wNrM-ha_Izti53EuoKeteTi5xeUil7d:1wFr3h:cSMFzy9KCk3bZAhFFteHN6AO82zCdWgzBuZhjJYUpcw	2026-04-23 10:18:21.183245+00
6glhq7395kzqzmy9pnmowqmm3lovpkar	.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSlEqVqN_fgGUVV7e:1wG81G:fyhS-uhAr9zBbVAKTqHNAxEDIMMgGEbaMLMXfQjjklg	2026-04-24 04:24:58.638349+00
ytmxlqr5sgl6e5toq5ucf9f6ka4pvv10	.eJxVj0tuAyEQRK8SsY5GgIEZvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtVbaOxA6CKpxZ-mCjCsVBMIs0bLFUikW4KiQKpSSKzr7sKhAndsx4cOQNlh7MuOIIxRIw8kpV4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzeVZaa8nl5QqUyF7s:1wG6kf:cjKYIl-HG97BIct0Co0omZwysC-kc7bwCPj-3mXnHjI	2026-04-24 03:03:45.451381+00
h45axjy74zapc9zd5ur5zrnq5gz3untc	.eJxVj0tOAzEQRK-CvEajHsefmexgj5QbWG23nTFMbORPJIS4Ow7KgmxfVT11fzODvW2mV19MJHZkM3v-zyy6D59uAb1jOufJ5dRKtNOtMt3TOr1l8vvrvfsg2LBuY72q1TsUaxCw0sHCQjNXKghCLcnOiwUpFuSkCBRJyRVoHxYVwLnDLHwY0oZbT2YcccaCaTg5cDV49bXGnEz-pL8XUt_3R5rwgqP_QpeYYm0FWy5Pp16xjfmOtRl0LV5j-2LHWWsNIEHpn1-UQ17Y:1wG8C3:iwoJQT8n1iHA3FVi4P7_i13_ZP6qqYVuylm6Q5Q3HBo	2026-04-24 04:36:07.797074+00
cdd59cw7vidi6hlc322tbyca3hrtpvwp	.eJxVj8tOBCEQRX_FsDYdoGnonp3uTfwDUlAwjfYUhoeJMf67jJmFsz333pOqb2aht932GopNyE5MsMf_zIF_D3QN8A3onCefqZXkpmtluqV1eskYjudb906wQ93HetNb8KC2qPiGs-MrCql1VAhmQSdWxxe1gkSNXOOySM1NiKuO3PtZqBCHtMHeyY4jzlCAhlNyqQevodaUyeYP_HuB-nHcU4ILjP4TXhKl2gq0XB5ee4U25gfUZsG39JnaFzsJYwwXs5Ti5xeUL17P:1wGAJZ:hweoDaRUWXLF46KbiNDE0yR0JSbXDNUarmOy3CV8z60	2026-04-24 06:52:01.824094+00
at67vxvpa03gvxqcm2gjt8hjdvazg8iz	.eJxVj0tuAyEQRK8SsY5GDGZ6wLtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkM3v-zyy6D59uAb1jOufJ5dRKtNOtMt3TOr1l8vvrvfsg2LBuY61Be4dSB8k1HSxXNAuAIAnXheysLF-kQkFAHGhZBPDVBwWBO3eYpQ9D2nDryYwjzlgwDafgAgavvtaYk8mf9PdC6vv-SBNecPRf6BJTrK1gy-Xp1Cu2Md-xNoOuxWtsX-w4rytoDVKpn1-UzV7x:1wG5xg:X_bAov0Nu7ISpDYcqnBVRGUmLEgR7rct4wshCBCU2n0	2026-04-24 02:13:08.894734+00
q1vlpznaqpjflfzhxt1ptzvzzktegv50	.eJxVj0tuAyEQRK8SsY5GwDAweGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUbay21dyB0EFTjbOmKjEsZBIJa0LLV0kWswFEilbgsXFLlwyoDdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaUom6XW1xuUZF7i:1wGARI:Uj7wqKcH04BcpD1cp6vXwoTGiBTfAxxHub5qtF3WC94	2026-04-24 07:00:00.042269+00
fd4vtymi10zgciahe5au7ccee1ptkfsa	.eJxVj0FuwyAQRa9Ssa4sIBib7Np9pdwADQzEtA5UMESqqt69pMqi2b7__9PMN7PQabO9hWoTsiMT7Pk_c-A_Qr4F-A75XCZfMtXkpltluqdteisY9td790GwQdvG2mgTPCgTFTd4cHxFIbWOCmGZ0YnV8VmtIFEj1zjPUvMlxFVH7v1BqBCHlGDr2Y4jzlAhD6fkUg_eQmupZFs-8e-F3Pf9kWa4wOi_4CXl1KgClfp06g1ozHdoZMFTuib6YkexLNoYZaT4-QWUt17n:1wG5YP:n-W8KH_lPpfhmbEmKP7gxPZI3oL7En1_25vZbBBzviE	2026-04-24 01:47:01.582488+00
ire9l3cqx67r00d4vehgchtbdnhrwqk3	.eJxVj8tuwyAQRX-lYl1ZQPBgZ9fuK-UP0MBATOtAxSNSVfXfS6osmlme-9Dcb2awt8306ouJxI5MsOf_zKL78Okm0Dumc55cTq1EO90s012t01smv7_evQ8FG9ZtpFdYvUO1BsVXOli-kJAAQRHqmaxYLJ_VgpKAONA8S-DahwUCd-4glA-jtOHWkxlPnLFgGp2SSxi8-lpjTiZ_0t-E1Pf9kSa84PC_0CWmWFvBlsvTqVdsI75jbQZdi9fYvthRaK35OICfX5QoXtI:1wG6tO:giAQiqn9KpBVuVOamPm7nrT8SGxuRp3MR3FveSMlIr4	2026-04-24 03:12:46.058164+00
xsybn0k4j0vmudi6keix35zyslgu7s0d	.eJxVj81OAyEUhV_FsDYToAwzdKd7k74BuXChg04vhp8mxvjuUtOF3X7nJ-d8Mwu9bbbXUGxCdmSCPf9nDvxHoJuA70DnPPlMrSQ33SzTXa3TW8awv969DwUb1G2kjTbBgzJRcYMHx1cUUuuoEJYZnVgdn9UKEjVyjfMsNV9CXHXk3h-ECnGUNtg62THiDAVodEou9eA11Joy2fyJfxeo7_sjJbjA8L_gJVGqrUDL5enUK7QR36E2C76la2pf7CiWRRslxoKfX5SEXuA:1wFrfC:QrZ64i7rHML5vG5aKdjCpvi6ggmR9vMtaKL4md3WDnk	2026-04-23 10:57:06.142176+00
e3b8txjo714pdk78hc3r7n2kx6gosnrf	.eJxVj0FOBCEQRa9iWJsO0DTdzE73Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sjTbBgzJRcYOz4xsKqXVUCOuCTmyOL2oDiRq5xmWRmq8hbjpy72ehQhzSBnvPdhxxhgp5OCWXenAKRKlkWz7w74Xcj-OeZrjA6D_hJeVErUIr9eG1E7QxP4CaBd_SZ2pf7CTWVRslZ8N_fgGUil7g:1wFrt8:_Gvf5EaGvmQ6lR6jwfCpNJ9ptPcWWZDiMQuyeqJqVIs	2026-04-23 11:11:30.236769+00
mld45zs0asd8vma0dnw9jzbfz6ww98zb	.eJxVj0tuAyEQRK8SsY5GgPkM3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtVEmeBAmCmrw4OiKjCsVBYKW6NjqqBQrcFRIFUrJFdUhripS7w9MhDilHbaR7TziDBXydHLK1eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZ1soYqbT--QWUy17w:1wG5kb:8mo0_ZZZqdrWFHQINVUaF3vm10u0H66Xw3zzI_f2-Gc	2026-04-24 01:59:37.160323+00
jiv1jzpck336rk4daux0awgm6kn4gxdg	.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa0pU1KIyxWUVl7a:1wGBBB:jWL2cBGVULVeWfzpmEqnICPwIInJrkMUDiEslFNMo2U	2026-04-24 07:47:25.033522+00
9bxw8zjtza3qmg5n94va3e0ejm9iy3jv	.eJxVj0FuwyAQRa9Ssa4sIBjs7Np9pdwADQzEtA5UDESqqt69pMqi2b7__9PMN7PQ22Y7hWoTsiMT7Pk_c-A_Qr4F-A75XCZfcqvJTbfKdE9peisY9td790GwAW1jveo1eFBrVHzFg-MLCql1VAhmRicWx2e1gESNXOM8S81NiIuO3PuDUCEOaYOtZzuOOEOFPJySSz04BaJUsi2f-PdC7vv-SDNcYPRf8JJyolahlfp06gRtzHegZsG3dE3tix2FMYYLo436-QWUaF7f:1wGBTO:Onbc_n8C34yEbzK1XZFfqYJh442fYDsUjP6uvK3EgLw	2026-04-24 08:06:14.854106+00
a1r718qnt0iq9cn4cr6bk5x1sxnhwacg	.eJxVj0tuAyEQRK8SsY5GDQZmxrtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZknD3_Zxbdh0-3gN4xnfPkcmol2ulWme5pnd4y-f313n0QbFi3sV716h3KNUhY6WBhIS60DpJwVmT5YkHJBQVpAk1KCQ2zD4sO4NyBSx-GtOHWkxlHnLFgGk4BQg9efa0xJ5M_6e-F1Pf9kSa84Oi_0CWmWFvBlsvTqVdsY75jbQZdi9fYvtiRz_MMAErwn1-UJl7O:1wG70j:RZ_aLNdO2gWv5PMH7lAXfI8saWwBaLGfifrATdHP37A	2026-04-24 03:20:21.819865+00
wmo5bpzfvme48emdmb5egasg17nr7900	e30:1wJhyt:vqrIod9CI0m1fbk2mfM8-Bq1ebjPQoEOEmQf5WxUWyw	2026-05-04 01:25:19.077669+00
7kh8olohe20u7doo7by9wbzi4szlkwt7	e30:1wK6OJ:yQ-zyve7B_eJ5OxfonrP43ak7ISkARuY3djljIq_Wcg	2026-05-05 03:29:11.947257+00
df7yd575wi7y5977harwzw2hmahxxrdv	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01lyqVZifX5R8XuI:1wHBYy:qhNFt0D4QmqWCPuKyd4PeUaNA-5JxNVQU7lwi0VWaQ8	2026-04-27 02:24:08.153897+00
eyv3zuhdxpta53md3m0qjs0ngoiveo9h	.eJxVj0tuAyEQRK8SsY5GgJlmxrtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkgj3_Zxbdh0-3gN4xnfPkcmol2ulWme5pnd4y-f313n0QbFi3sV5h9Q7VGhRf6WD5QkICBEWoZ7JisXxWC0oC4kDzLIFrHxYI3LmDUD4MacOtJzOOOGPBNJySSxi8-lpjTiZ_0t8Lqe_7I014wdF_oUtMsbaCLZenU6_YxnzH2gy6Fq-xfbGj0FpzKQDEzy-UR17W:1wGCVh:X4ZiC4XIAp_vbtuQvrjxHkfS0So3OwY_J_a0uto-4C4	2026-04-24 09:12:41.611433+00
h88ozbh1owmx794zctep280et6fwonkl	e30:1wIR8M:ISdUed5aEy2XCbnW8XEIJZO8wphbIw5uceJk9lMuc3A	2026-04-30 13:13:50.507631+00
l1o9ddzifb6083esziavdsvqcq91ci7m	.eJxVj0luAyEQRa8SsY5agBm6vUv2kXwDVFDgJmlDxGApinx3Y8sLe_v-UPX_iYHeVtOrLyYi2RNG3p-ZBffj003Ab0jHPLmcWol2ulmmh1qnr4x--3x4XwpWqOtIL2rxDsQSBF1wZ-mMjCsVBIKWaNlsqRQzcFRIFUrJFdU-zCpQ53ZM-DBKG6w9mfHEEQqk0ckpV4NXX2vMyeRfvE9IfdteaYITDP8HnmKKtRVoubwdeoU24hvUZsC1eI7tj-yZ1npcF1RerpRWXtc:1wHCcP:ZFIqpSm-hSHbM_IYlOylT0IB7ouBlI_ex5OzvjJvxIc	2026-04-27 03:31:45.544598+00
btk8a77gmjggdhozq9bevonvmioe23s4	.eJxVj8tuwyAQRX-lYl1ZQDDg7JJ9pf4BGhiIaR2oeFSqqvx7cJVFsz33MXN_iYHeVtOrLyYiORJGXv8zC-7Tp13AD0iXPLmcWol22i3TQ63TW0a_nR_ep4IV6jrSi1y8A7EEQRc8WKqRcSmDQFAzWqYtnYUGjhKpxHnmkioftAzUuQMTPozSBmtPZjxxgQJpdHLK5eDV1xpzMvkL_yakvm3PNMEVhv-E15hibQVaLi_vvUIb8Q1qM-Ba_I7thxyZUmq_ruXtDpR8XuM:1wHCiY:srX_VLSILyhWcEsw2Rjpk-eJgUSFadWPtu3PGFP813o	2026-04-27 03:38:06.986659+00
mnb9133804jx36pc5128l75q46l01dk3	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtaacayN_fgGUXl7e:1wGCnp:ITvPDcd9YZ0PfhzJFqZyRZ-myQ4-u9fOlihRKkKbfN8	2026-04-24 09:31:25.136169+00
nhx0ay13741fr4v1r9yvme0e7xb64eoj	.eJxVj0tuAyEQRK8SsY5GgBmY8S7ZR_INUEODh2TcRHwsRVHuHhx5EW9fVT11fzMLvW2211BsQnZkgj3_Zw78R6BbgO9A5zz5TK0kN90q0z2t01vGsL_euw-CDeo21qtegwe1RsVXPDi-oJBaR4VgZnRicXxWC0jUyDXOs9TchLjoyL0_CBXikDbYOtlxxBkK0HBKLvXgNdSaMtn8iX8vUN_3R0pwgdF_wUuiVFuBlsvTqVdoY75DbRZ8S9fUvthRGGO4VIqrn1-UQl7U:1wGDDw:bbmmta1gV9s7tl_ZjbRPUGkoZQAroE8qL2v9iN7lHro	2026-04-24 09:58:24.806208+00
nqhdemhxz86sgxe1cob1avxnioo7lc40	.eJxVj0tuAyEQRK8SsY5GDIZmxrtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZkM3v-zyy6D59uAb1jOufJ5dRKtNOtMt3TOr1l8vvrvfsg2LBuY73C6h3KNUi-0sHyhWYBECShVmTnxXIlFxQExIGUEsC1DwsE7txhlj4MacOtJzOOOGPBNJyCCxi8-lpjTiZ_0t8Lqe_7I014wdF_oUtMsbaCLZenU6_YxnzH2gy6Fq-xfbHjrLUWSgOHn1-UfV7g:1wHBtG:zXAwuVsvrcMIEkNv___ojUIS2IZ-AsUMHUtrGEHRXgo	2026-04-27 02:45:06.510077+00
a50sp9k5a82v8u0ts6m8k5rvs9f8jl23	.eJxVj8tqAyEYhV-luC6DOo6O2SX7Qt9Afv01YzvR4qVQSt49pmTRbL9z4ZxfYqC3zfTqi4lIDoSR1__Mgvv06S7gB6RznlxOrUQ73S3TQ63TW0a_nx7ep4IN6jbSWmrvQOggqMbZ0hUZlzIIBLWgZauli1iBo0QqcVm4pMqHVQbq3MyED6O0wdaTGSPOUCCNTk65HLz6WmNOJn_h34XU9_2ZJrjA8B_xElOsrUDL5eW9V2gjvkNtBlyL37H9kANTSo1ldNbXG5R1XuA:1wHE5H:JYuQuAUCU7Qjg62ARnqkVlpboHBfPeb1x1qw-qz33a4	2026-04-27 05:05:39.210169+00
2dk3s95hzh7rk0vbhg2lgzdxcw2kxtrv	.eJxVj0tuAyEQRK8SsY5GwDAweGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUbay21dyB0EFTjbOmKjEsZBIJa0LLV0kWswFEilbgsXFLlwyoDdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaUo00rO1xuUcV7g:1wGC15:mY6EG_pM_FEdIqiZfdelWNJO4FftJmgftVWgQjeWyHc	2026-04-24 08:41:03.523149+00
s6glrobu7qoc3xyb5bwmmdwp4km44gm7	.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa25YpzJyxWUVl7X:1wHCpU:wuNqg-IUSWndvZcyDIFfzJNX3PjaxF7a0cubxCDvfhU	2026-04-27 03:45:16.01139+00
9sxzxzddcv68lse3k7x26alqq8zuhtbz	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemteZKCyN_fgGUkV7m:1wHESc:f69TDPQsXIGIz_JqBkqI8yRWE3iOA2gShFekUsRYQEc	2026-04-27 05:29:46.076687+00
p3a4gap66kw8hpffvvus7tg1a9j1t1ce	.eJxVj0tuAyEQRK8SsY5GgBkYvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtZbaOxA6CKpxZ-mCjEsZBIKa0bLF0lkswFEilTjPXFLlwyIDdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJcci3Y5QqUeF7e:1wHDHJ:iEj9eANZncQW-XwU6PqlHEwFovUBJlC5eg2v6AGxDz0	2026-04-27 04:14:01.763218+00
m4aqxiiiketist31sr1wgflfrakkuzu8	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01lyaVdCfX5R2Xtw:1wHC56:zxqK1ytUcXzbnaowaHIlYV_NYwu0YdUeifcSobb4GhA	2026-04-27 02:57:20.788807+00
7135ppr0xr0r64e5awubdzm2fukuxr4g	.eJxVj0FOBCEQRa9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sN70FD2qLim84O76ikFpHhWAWdGJ1fFErSNTINS6L1NyEuOrIvZ-FCnFIG-w923HEGSrk4ZRc6sEpEKWSbfnAvxdyP457muECo_-El5QTtQqt1IfXTtDG_ABqFnxLn6l9sZMwxgzvrOafX5RSXtg:1wGDjD:nhn3uSWUfsZ68Na0LxIPOJWpDRWiqRR3-iQQIdFeGy4	2026-04-24 10:30:43.786428+00
3142ldbde32pv1w9oqy7q1bptuautszx	.eJxVj8tOBCEQRX_FsDYdmqYLena6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5sZo__mUX37tM1oDdM5zy5nFqJdrpWpltap5dM_ni-de8EO9Z9rDfYvEO5Bck3WizXNAuAIAnVSnbWlq9SoyAgDrSuArjyQUPgzi2z9GFIG-49mXHEGQum4RRcwODV1xpzMvmD_l5I_TjuacILjv4TXWKKtRVsuTy89optzA-szaBr8TO2L3aalVIC5KLh5xeUgF7j:1wHDec:WIg_mQroya3OxnwrRLHmqpWD9YubieKA1NPWeP7GwX0	2026-04-27 04:38:06.8559+00
sa0z5orl3aa7jqfq4wxrbryf7z8sczng	.eJxVj0tuAyEQRK8SsY5GwDAweGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUbay21dyB0EFTjbOmKjEsZBIJa0LLV0kWswFEilbgsXFLlwyoDdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaW41DNn1xuUfV7d:1wHEwE:sXIrkju3GyWfloKePA_2D54ETR_pXA1Z1zWrYNtPHl0	2026-04-27 06:00:22.158225+00
ykj4x8kc2iz32e6exjiktkbnajcqx6vm	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtebSaKl_fgGUl17o:1wHCBp:A2gbIkKQvt7YCGnS74PDlU0EytHA7ljTq4fM7rauElc	2026-04-27 03:04:17.322522+00
7ssgkwesh6tkgjgvdlt14xbipirjag07	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemteaaSWl-fgGUel7i:1wHFWJ:HdSZ57nHZivDE2ibjRSVFOJyzr5lLeuVVVIznjRpKZo	2026-04-27 06:37:39.097162+00
ii0hj6x53kxngjx43mrf7fugkgui1bbq	.eJxVj0tuAyEQRK8SsY5GgBk-3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtZEmeBAmCmrw4KhGxqWMAkGt6Jh2dBUaOEqkEteVS6pC1DJS7w9MhDilHbaR7TziDBXydHLK5eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZUoorpo36-QWUkF7o:1wHFbl:aZOYrzWD6jFUHllFeKTXGtiIIW9GbiwQoa5pEVILzPA	2026-04-27 06:43:17.977801+00
c2whbx49bck0h4nm1o1019proaqe4akm	e30:1wJia0:ooFLAx766wReWTqNzsf8ZPXOK8V-CWEWh1bu4fQwkTw	2026-05-04 02:03:40.152569+00
gv9v8ienyucryca55tz6ji2fd0mycvzn	e30:1wKS6n:HtsXkKvVNn9vIRPsbBoTNJnZeh4IOGczHxeIrormIXw	2026-05-06 02:40:33.914701+00
c79hlkuo0w16f5tswooeyfd9tm07c7f9	.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa25lkLLyxWUil7k:1wHGXT:jcnwCAjIK1aoqEsvRIUYZGvMckvumtRNf5S1qpQGqaY	2026-04-27 07:42:55.864555+00
xxr6ip2d5pa9yfy7bm86gm0keu2rtk9v	e30:1wJikM:RCRcV3AsXZoDl-TZhZw1OL1XhXuT9ijKuHAx7OVW-p4	2026-05-04 02:14:22.177115+00
fsfdcvmilpuob701jf3bm8ioo3jxokga	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01lxLw9efX5SHXuE:1wHGd5:QTh3W_NsM9kz2Z8gqjkhL7-umxCpdQq6XP2AirMjBqc	2026-04-27 07:48:43.849013+00
22zb4iqleaqej7042o3xo0wjyc1tgxmh	e30:1wJj1C:0RxAoadKPeQHgcfC-GODs7nN612EeH8-F3NDrnZI6Ss	2026-05-04 02:31:46.051181+00
uslcgw551qrfrbmdb5zvja0qwdcc3vu1	.eJxVj0FOBCEQRa9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sN70FD2qLim84O76ikFpHhWAWdGJ1fFErSNTINS6L1NyEuOrIvZ-FCnFIG-w923HEGSrk4ZRc6sEpEKWSbfnAvxdyP457muECo_-El5QTtQqt1IfXTtDG_ABqFnxLn6l9sZMwxsyGc2F-fgGUWl7Y:1wHf8L:IXu46R_PVm44u1HMx4T2i8s0bN9b1RfvtPobjONwfY8	2026-04-28 09:58:37.185802+00
00xdgmndehf00ikucozziu4b40635fjl	.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa25VlyKyxWUf17g:1wHGk2:gbeaWBv4m8islN5xurczcsovnb6N5NPWhlb4eTiWAbY	2026-04-27 07:55:54.447604+00
yixjlxabzto10h3ya1tqz5kwd1v9h8ow	e30:1wJjkw:PbLkUM9kMJ1vdvkVUb8QR-7JRfnOLSiyJvszFwsoO44	2026-05-04 03:19:02.056261+00
u34i14c75sg7wye0k4oa979fxx3vt0bh	e30:1wJlgA:pGCCiKOKD7ZNUnuX4C6DekdZhDmNTGZbTj7ZKNByem8	2026-05-04 05:22:14.078342+00
cj2ytd52vfb77cely0nar62jna2iytrd	.eJxVj0tuAyEQRK8SsY5GgBkYvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtZbaOxA6CKpxZ-mCjEsZBIKa0bLF0lkswFEilTjPXFLlwyIDdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJcSSX05QqUml7p:1wHGs1:koIaELNCb2jorB2llwqNOLnfjcubZxtkZSLjvqZeKiM	2026-04-27 08:04:09.655811+00
imfvyrjllztenobur1u045g9kxeliwxl	.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJcaUrZ5QqUbF7Y:1wHHCD:Kr0kYPw7MTPMlEKVSZZOnFGU9xvo3l7fQ4OcgPYBvyA	2026-04-27 08:25:01.079694+00
1naydlhs7gstlm0f4pqdqksckv1z4dex	.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSq1i1dr8_AKUkF7p:1wHYKv:hElrl1JraISls-OYVtpco_CjzCaAKO-FmFgRmYtw5q8	2026-04-28 02:43:09.873291+00
0b2usa644vzwtdvpghnucq2s1yev659s	.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSnG1aml-fgGUlV7p:1wHG7Z:8KPDgMhmvinUz8RsflhJtxk4Ci8NsbBtlrWqYkOOTBo	2026-04-27 07:16:09.400398+00
34j2tvpsor2248crfh36e545e96thqvr	.eJxVj0FOBCEQRa9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sN70FD2qLim84O76ikFpHhWAWdGJ1fFErSNTINS6L1NyEuOrIvZ-FCnFIG-w923HEGSrk4ZRc6sEpEKWSbfnAvxdyP457muECo_-El5QTtQqt1IfXTtDG_ABqFnxLn6l9sZMwxsxKzZr__AKUaV7a:1wHYSW:lMlvu5RUqDs5fXJEq8vzXfaoAccpbJreqpajYaC64eo	2026-04-28 02:51:00.717278+00
tfldrsl7rze1iw6d4474rjsihez3cqmr	.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaW4ZmwW1xuUYl7Z:1wHI0k:pjBiXkPmNB67iXUPlNTiQMaIY3ajVpoi3im8cAiLBqU	2026-04-27 09:17:14.37545+00
mbl7cangqxn1u8uenc235sbokv0qy4eq	.eJxVj0FOBCEQRa9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk42_f_f6n6ZhZ6222nUG1CdmKCPf5nDvx7yNcA3yCfy-RLbjW56VqZbilNLwXD8Xzr3gl2oH2sN70FD2qLim84O76ikFpHhWAWdGJ1fFErSNTINS6L1NyEuOrIvZ-FCnFIG-w923HEGSrk4ZRc6sEpEKWSbfnAvxdyP457muECo_-El5QTtQqt1IfXTtDG_ABqFnxLn6l9sZMwxsxKSqF-fgGUVF7W:1wHXtu:qoOFiYgPAXIDYhY6NZodM1mWG_aHr08Wv9V6Dcw_So4	2026-04-28 02:15:14.83819+00
popk3nklvekkyqhh3pva1wvca4hobrxf	.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSnG9amZ-fgGUjF7l:1wHIi3:t0pKK0Vh7H7WZoTF28zpDq4fRTbjOet_dZxBwbBwzho	2026-04-27 10:01:59.298304+00
pk0nqycb847amwk15wnnji7e2qvkjgfj	.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJcC6XF5QqUmF7n:1wHIxc:qqJdVeGWeu8V1D0RCthsZHqqHyQuhxGDsMLUV8fHP1g	2026-04-27 10:18:04.660971+00
adxjv9j2aa4kw18ctp8q77bwwixron3m	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01quSgpmfX5R_XuE:1wHdwA:MzEszg6Icvw2-tXQp0LwDSDdJw-Q8pt_o0t37kIlzQ0	2026-04-28 08:41:58.350483+00
5xzq44gax05mmgj195vqes4f6qfl62sb	.eJxVj01OBCEQha9iWJsO0DR0z073Jt6AFBRMoz1gKDAxxrvLmFk4qd33flLvm1nobbedQrUJ2YkJ9vifOfDvIV8FfIN8LpMvudXkpqtluqk0vRQMx_PNe1ewA-0jvekteFBbVHzD2fEVhdQ6KgSzoBOr44taQaJGrnFZpOYmxFVH7v0sVIijtMHesx1PnKFCHp2SSz04BaJUsi0f-Dch9-O4pxkuMPxPeEk5UavQSn147QRtxA-gZsG39JnaFzsJY8w8TomfX5SCXt8:1wHg6P:id5PdiGFuNsn-_jA7Xgu5cSC4kTPRRT1jjVWA4vyAmk	2026-04-28 11:00:41.98458+00
gh6a14j7af9qeoi1fk41otldcylniha5	.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSq2KacN_fgGUjV7k:1wHfca:CUafORlX360L8r72ImuwjroGAT8F8FQ6BonDgloW3ZY	2026-04-28 10:29:52.442204+00
fblki3vqo86ixe5jn6owm7w14ebhb5ql	.eJxVj8tOBCEQRX_FsDYdmoaie3a6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5sZo__mUX37tM1oDdM5zy5nFqJdrpWpltap5dM_ni-de8EO9Z9rDfYvEO5Bck3WixfaRYAQRJqRXZeLVdyRUFAHEgpAVz7sELgzi2z9GFIG-49mXHEGQum4RRcwODV1xpzMvmD_l5I_TjuacILjv4TXWKKtRVsuTy89optzA-szaBr8TO2L3aatdYLaNDq5xeUnV7o:1wHeWZ:hqgdnQzMza9CMWRVFpnBtbJ_KlKnOpasqHLH-bRr1sc	2026-04-28 09:19:35.15349+00
ppslereh6xdxzcgzmi7f9eho0ibca3am	.eJxVj8tOBCEQRX_FsDYdXg3N7HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2ujTLBgzRRUoPC0Q0ZVypKBL2iY5ujq9yAo0KqcF25ojrETUXqvWAyxCntsI9s5xFnqJCnk1OuJm-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRPTWgtlhFA_v5SRXuQ:1wHexM:1xMJuGxSbBSyNAFrV-wLM9wDrohcdr5h7AYtnDiJ7vw	2026-04-28 09:47:16.996035+00
i8x2g8h91la0t7a2prwjayhzarxlk08f	e30:1wJmcf:46cDcd9pRT671JnXrZbPr8KApi67EHCRtZK8Y3G2z-c	2026-05-04 06:22:41.070028+00
74ezmonepn0w7a7d2khbdj468chjbayb	e30:1wJoEy:WJ_97O9KjK5wcdXc3oGUKb5FRugWJZEg3WYfAAn-A4A	2026-05-04 08:06:20.995064+00
mdtxu62j9n4d2nqxz65w7v0rt56tawgg	.eJxVj0luAyEQRa8SsY5agBm6vUv2kXwDVFDgJmlDxGApinx3Y8sLe_v-UPX_iYHeVtOrLyYi2RNG3p-ZBffj003Ab0jHPLmcWol2ulmmh1qnr4x--3x4XwpWqOtIL2rxDsQSBF1wZ-mMjCsVBIKWaNlsqRQzcFRIFUrJFdU-zCpQ53ZM-DBKG6w9mfHEEQqk0ckpV4NXX2vMyeRfvE9IfdteaYITDP8HnmKKtRVoubwdeoU24hvUZsC1eI7tj-yZ1nqcl1JdrpSGXuM:1wIJrA:fIcLlOSbFAcd7ZmzO-dCdq5boCZO69z15TGdXO4Pwqs	2026-04-30 05:27:36.453217+00
3c451xsqwsuoog1ba610o85pwzujo0fj	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZZcamV-fgGUkF7n:1wIJeS:zPnZmHkjD2V1Kf-wHCAMkC7J5u8-kErvdSUZBPtaruU	2026-04-30 05:14:28.338986+00
5xwf71b5p8tu5cgtskd768fipymkyf7m	.eJxVj8tOBCEQRX_FsDYdmuY5O92b-AekoGAa7QHDw8QY_13GzMLZnnvvSdU3sTD6bkcL1SYkJ7KSx__MgX8P-RrgG-RzWXzJvSa3XCvLLW3LS8FwPN-6d4Id2j7XRprggZvIqcHNUY0rkzJyBCXQrdpRwTUwlEglCsEkVSFqGan328pDnNIO-8h2HnGGCnk6GWVy8hZaSyXb8oF_L-RxHPc0wwVm_wkvKafWK_RSH15Hgz7nB7Ruwff0mfoXOa1KKbHpzdCfX5SOXuI:1wIMw3:9NdbcEoUGgMEacp_4fOko8CJaBRZhIND4KEI6H6YIjQ	2026-04-30 08:44:51.198515+00
rjtkt8nq7kllnhkgmi6qszym4cze9boe	.eJxVj0tuAyEQRK8SsY5GwPCZ8c7eR8oNUEODh2QMEZ9IUeS7G0dexNtXVU_dv8RAb5vp1RcTkRwII6__mQX36dM9wA9I5zy5nFqJdrpXpkdap7eMfj89uk-CDeo21qtavQOxBkFXnC1dkHGlgkDQEi1bLJViAY4KqUIpuaLah0UF6tzMhA9D2mDryYwjzlAgDSenXA1efa0xJ5O_8O-F1Pf9mSa4wOgf8RJTrK1Ay-XlvVdoY75DbQZci9-x_ZAD01rLmSsprzeUel7g:1wILRX:c_OwOfJVXP6rpepvfBiSgLc6szCzzyBNIFShLYRiNQc	2026-04-30 07:09:15.087884+00
lztro8weyn2wjyxh3qsua0gdp9sdbhxq	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZaCG8V_fgGUhV7h:1wIO6A:4RCbQCF_kHsVoPp2S0mZ1uaUC33VpCH5il4yy9NPz8g	2026-04-30 09:59:22.083387+00
asasn4khuqu9y3hun14838jcilsnpmco	.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa2loEKyyxWUZl7Z:1wINTH:UFESLRmXCSySAuOV8TgwPKq6ow9DDfjTTFNUvpU-2TU	2026-04-30 09:19:11.917419+00
08wq6owzux3wtyp0ubpl795y377q1bdh	.eJxVj0tuAyEQRK8SsY5GwPCZ8c7eR8oNUEODh2QMEZ9IUeS7G0dexNtXVU_dv8RAb5vp1RcTkRwII6__mQX36dM9wA9I5zy5nFqJdrpXpkdap7eMfj89uk-CDeo21qtavQOxBkFXnC1dkHGlgkDQEi1bLJViAY4KqUIpuaLah0UF6tzMhA9D2mDryYwjzlAgDSenXA1efa0xJ5O_8O-F1Pf9mSa4wOgf8RJTrK1Ay-XlvVdoY75DbQZci9-x_ZAD01pLMc9cXW-Ucl7d:1wIODe:VK_bFCtafIXIorAIquhvnLlquyiUcemCSeIAYj7XvK0	2026-04-30 10:07:06.186037+00
po5t82sxv57sbrvtkcal78es69i1q0nv	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZZSUG1-fgGUhF7j:1wIR14:-5t5b8gR0YLZ2z07vDxnPSWne8cchSmCXx8KczIL7mo	2026-04-30 13:06:18.193479+00
5tqvm8sdti98q2lbr3id48r6t5co4e51	.eJxVj0tuAyEQRK8SsY5GgPkM3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtVEmeBAmCmrw4OiKjCsVBYKW6NjqqBQrcFRIFUrJFdUhripS7w9MhDilHbaR7TziDBXydHLK1eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZ1loKaRj9-QWUhV7e:1wIOtK:BshtfQOnf-Wnh-I1dE2VrGBs2DnPL7iqUIUwvXNcs9o	2026-04-30 10:50:10.660924+00
9hoba1rcuaqf933imceldghmsdvouixd	.eJxVj0luAyEQRa8SsY5agBm6vUv2kXwDVFDgJmlDxGApinx3Y8sLe1Gb9wfV_ycGeltNr76YiGRPGHl_Zhbcj083Ab8hHfPkcmol2ulmmR5qnb4y-u3z4X0pWKGuI72oxTsQSxB0wZ2lMzKuVBAIWqJls6VSzMBRIVUoJVdU-zCrQJ3bMeHDKG2w9mTGE0cokEYnp1wNXn2tMSeTf_E-IfVte6UJTjD8H3iKKdZWoOXydugV2ohvUJsB1-I5tj-yZ1prKcbRyxWUk17i:1wIPN0:G2HAlDrTm2fMb2AAz2_wxah1dAqYQJOJui-T0qt60n0	2026-04-30 11:20:50.622509+00
m70emo38un9m2agvu15digw6c3f495cb	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZZSGaF_fgGUo17p:1wIRjj:o_mKoOnfOYxLe97x9Edbh880rKHso-0TMDt5yrte-Go	2026-04-30 13:52:27.977486+00
lferf9l7szsqz4s9dh2g9zlriwrytxhk	.eJxVj0tuAyEQRK8SsY5GgPnMeJfsI_kGqKHBQzKGiI-lKPLdjS0v7O2rqqfuf2Kgt9X06ouJSPaEkfdnZsH9-HQL8BvSMU8up1ainW6V6ZHW6Suj3z4f3RfBCnUd60Ut3oFYgqAL7iydkXGlgkDQEi2bLZViBo4KqUIpuaLah1kF6tyOCR-GtMHakxlHHKFAGk5OuRq8-lpjTib_4v2F1LftlSY4weh_4CmmWFuBlsvboVdoY75BbQZci-fY_sieaa2l1EzRyxWUhF7e:1wIRom:VrZkz_ZX9O4SFUN-4VLA9i8bBVDVbEI9T1cdhWV5Z6Q	2026-04-30 13:57:40.127929+00
zovt9coysbreo08srs90z05ixjseresd	.eJxVj81OAyEUhV_FsDYToAzMdKd7k74BuXChg04vhp8mxvjuUtOF3X7nJ-d8Mwu9bbbXUGxCdmSCPf9nDvxHoJuA70DnPPlMrSQ33SzTXa3TW8awv969DwUb1G2kV70GD2qNiq94cHxBIbWOCsHM6MTi-KwWkKiRa5xnqbkJcdGRe38QKsRR2mDrZMeIMxSg0Sm51IPXUGvKZPMn_l2gvu-PlOACw_-Cl0SptgItl6dTr9BGfIfaLPiWrql9saMwxowpQvOfX5SDXt4:1wIPTc:s7hC7VM33jJecSg--oWSM_4lZ1b7UWaBygNIKnZzsLU	2026-04-30 11:27:40.474324+00
bjqdnth7r1kge9jtj9lvndbrjncov5hy	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01quWRumfX5SiXuo:1wHgeh:4ycjD89Nm6YKnc5FDwqFj-luJNQm5S3dOEPRl7X2CAY	2026-04-28 11:36:07.791552+00
sc9fh2rp41wy7ko4k6ujhevulyekpov9	.eJxVj8tOBCEQRX_FsDYdoIGG2enexD8gBQXTaA8YHibG-O8yZhbO9tx7T6q-iYXRdztaqDYhORFGHv8zB_495GuAb5DPZfEl95rccq0st7QtLwXD8Xzr3gl2aPtcG2WCB2GioAZXRzUyrlQUCJtEx7SjUmjgqJAqlJIruoWoVaTer0yEOKUd9pHtPOIMFfJ0csrV5C20lkq25QP_XsjjOO5phgvM_hNeUk6tV-ilPryOBn3OD2jdgu_pM_UvcmLbtklu2Kp_fgGUg17i:1wIKWo:S4ifqpHj344-EIQbTE6fj_fgg0TvhK7s1dvx2fqb0cw	2026-04-30 06:10:38.769328+00
t8gbqx9g63hzmihr2z165tx2r3p2u3sn	.eJxVj8tOBCEQRX_FsDYdoHk0s9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NsoED8JEQQ2ujm7IuFJRIGiJjm2OSrEBR4VUoZRcUR3ipiL1fmUixCntsI9s5xFnqJCnk1OuJm-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRPTWsuVGkN_fgGUfl7g:1wIL0g:fQnnVmShmu-K1ISWbmCE4DcOb34QK7GE79b1bBjbWeE	2026-04-30 06:41:30.859949+00
0oslh4gv40iqxkrc8qx48pldvahkg6wt	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtZaSGqp_fgGUeV7f:1wIQAJ:cQ0mp0X67PIP9uu1OoPUo9Nm-d9JBAMooFAWJ-sXnO0	2026-04-30 12:11:47.934332+00
ke7xpqn3djo5x25z68ikx0k3zrjwy8i6	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01nLV2qw_v5ScXuc:1wIMmF:WEhXy1mZ9LjZ1uI_NB4PugaPtoCUQ9g-NGzC-oktsJU	2026-04-30 08:34:43.957618+00
q0s7oagenfpfeviph41d1ps3hu6zxrv8	.eJxVj8tOBCEQRX_FsDYdoIGG2enexD8gBQXTaA8YHibG-O8yZhbO9tx7T6q-iYXRdztaqDYhORFGHv8zB_495GuAb5DPZfEl95rccq0st7QtLwXD8Xzr3gl2aPtcG2WCB2GioAZXRzUyrlQUCJtEx7SjUmjgqJAqlJIruoWoVaTer0yEOKUd9pHtPOIMFfJ0csrV5C20lkq25QP_XsjjOO5phgvM_hNeUk6tV-ilPryOBn3OD2jdgu_pM_UvcmLbtknJVm1-fgGUhl7l:1wIQJh:WWAdMtVZ2qMdJcxkFuE88dtp0XKH0KeHZsWERrUhOcA	2026-04-30 12:21:29.978457+00
eu95lwwj5l1y3j02rjjgt791pyligte3	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01lKaVZifX5SbXuc:1wIS7w:ixjY8REfGU_VzEL7UOz1c7eJtTRTnoYtKntncvzAYL0	2026-04-30 14:17:28.978687+00
3ykvhoi3i5pahovcdfej3s0yy7yhjeqj	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtTbKCCl_fgGUt17q:1wJknf:I0fE7o722l2pHL-AlbRJurlCZu2clKQmIz7gYIJuhI0	2026-05-04 04:25:55.140577+00
mf4d3azs3rc7iwq3jox401vktoevjn2x	.eJxVj0tOAzEQRK-CvEYjj-NvdrBHyg2sttvOGCY28icSQtwdB2VBtq-qnrq_iYXRNztaqDYhOZKVPP9nDvxHyLcA3yGfy-JL7jW55VZZ7mlb3gqG_fXefRBs0La5NtIED9xETg0eHNW4MikjR1AC3aodFVwDQ4lUohBMUhWilpF6f1h5iFPaYRvZziPOUCFPJ6NMTt5Ca6lkWz7x74U89v2RZrjA7L_gJeXUeoVe6tNpNOhzvkPrFnxP19S_yHFVSmlFDRU_v5SaXuM:1wJlRB:826v4pRVDMKdTQ-tpFbTUI8NkNNwTt2uEh9733qXZOk	2026-05-04 05:06:45.95774+00
b4ltqifvxsbgvft9m3jknk60mktlyyrt	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01kYzua4_v5SUXuE:1wJlbJ:IDF8ZEPo7j5-Gxm-VBpA0UViPaNHUwNjS4sNCgcTEI4	2026-05-04 05:17:13.337455+00
v4x6baxhkbul9cl7tt8287ervijunnde	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01kbqlZmfX5SiXuY:1wJhu2:lpHFqrA0ea3Yn_5f-bEhFf-a1fY_-Y2-IzjJu4dPaWQ	2026-05-04 01:20:18.273789+00
6va9cvqslelqp43txb5npxyxyquvrao7	.eJxVj81OQyEQhV_FsDY3QIEL3enepG9ABgZ60Vsw_DQxxneXmi7s9jvnfJn5JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zbZQJHoSJgho8OKqRcaWiQFglOqYdlUIDR4VUoZRc0TVErSL1_sBEiFPaYRvZziPOUCFPJ6dcTd5Ca6lkWz7x74U89v2RZrjA7L_gJeXUeoVe6tNpNOhzvkPrFnxP19S_yJGt66qlkYr9_AKUtV7o:1wJiUD:BhwHiHh_y2l1mmCeq3P2feKlioEwunf38NEXFqw58eY	2026-05-04 01:57:41.310247+00
x63j0cij2bmt0ivgn3s40edeekexxctx	.eJxVj0tOAzEQRK-CvEYjjzO47ezCPlJuYLU_yRgmbeS2kRDi7jgoC7J9VfXU_S0c9ra6zqm6HMVezOL5P_MY3hPdgviGdClTKNRq9tOtMt1Tno4lpu313n0QrMjrWHvtpVkAlV_szmsbAvhZgjoH45eodkbG5RzBKp-slAGSTVIDzCpoNBDVkDZcO7lxxAUr0nAqqfTgnJhzIVc-4t8L1LftkRJecfQP8Zopc6vYSn06dcY25htycxha_sztS-xnADAvxoD8-QV-Sl63:1wJiJ4:d7jUGs3dQbf2NTZAE6mFw1bl8V9b_x7493s7gkJ5yo8	2026-05-04 01:46:10.912449+00
kzqlog7683lq0oegu6akpyh34t6hlhjc	.eJxVj81uAjEQg1-lyhmtyB-T9Fj1isQbRJNMyqbQpNpkK1WId2eoOJSr7c-yLyLgOuaw9ryEQuJVOLH5r0VMp1zvBn1iPbYptTqWEqd7ZHq4fdo3yue3R_apYMY-Mw0qeq-TtBijtqAcaEkGtQL0lMkY763-gBylIR29VYnIGycdSUKrgEsHzmsNPOKIC1buVFu1Y73n3kuroX3T3wX5LFX8Qg6_l4r95cD7CpUT8xtxxj4CplF-yvhlDgCck3onrzf7Slt7:1wJo9p:VJ6zzW9wUEDSaXBp8bMJ3ewcdUvVZEvJxFtjcqO-n_c	2026-05-04 08:01:01.771668+00
ua1oth0345dzps7mfc7ba0qatrss6s89	.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJaUi745QqUfl7c:1wJifC:3YHJnnm9Zt0V0APtq441KQiurq9Lhtj7M8gw8dKkdEE	2026-05-04 02:09:02.31154+00
f8ktv3t0r54sihbaox4roebcsecxcngt	e30:1wJods:AfzKyVN0PT4CTT3eohhS19K8I5tVda9zsKaWYZ3y5OY	2026-05-04 08:32:04.041742+00
4x7sjxi9q3cfubtj349tj9ilzemzpio3	.eJxVj8tuwyAQRX-lYl1ZeOwyJrt0X6l_gGaAxLQOVDwqVVX-PSTKItmee-_RzL8w1OpqWvHZBCd2YhSvj4zJfvt4DdwXxWMabIo1Bx6uleGeluEjOb-937tPgpXK2tesWC4zEvCsJ1baWuRRIhzswrODaZFuPjjUwF5LadFrLxXiCFbRgg66tNLaoulHHClT7E6QoDovvpSQokk_7vZCbNv2TCOdqPf37hRiKDVTTfnlsxWqfb5RqYZsDb-h_ondiIhvSgJM5wt98l6l:1wIScB:WRSvPQQIwNLmfnVYQAbvdw7ZtzIPkrGR6O1Z23RM5s8	2026-04-30 14:48:43.414954+00
ny97ngp74kwi26pjoz5xi7uiujdj8h9n	e30:1wJpSS:zONY6DFenJ6ssiW_fRukY0GDdTV4-xMRECTeIbcYKyo	2026-05-04 09:24:20.070882+00
qm0zf5cqdco5w38rkceawynj57rut3vr	.eJxVj81uAjEQg1-lyhmtyB-T9Fj1Wok3iCaZlE2BpNpkkaqKd2eoOJSr7c-yf0XAdcxh7XkJhcSrcGLzX4uYjrneDfrCemhTanUsJU73yPRw-_TRKJ_eHtmnghn7zDSo6L1O0mKM2oJyoCUZ1ArQUyZjvLf6E3KUhnT0ViUib5x0JAmtAi4dOK818IgDLli5U23VjvWeey-thvZNfxfks1TxjBx-LxX7y573FSpH5jfihH0ETKNcyvhhDgAcOKXc9Qb7ZVuD:1wJnLI:qI6mMtZOsj7HgPGfhIk0EN-rYWdLdVum-7W0PmI_jtg	2026-05-04 07:08:48.644675+00
ptgwd2xrf8vpmc4ns8eyxe9yxdueay2y	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtTbaKCp_fgGUtl7o:1wJnRN:lH8M2f4hbG6mVFyNepxKR14YBfSx1B11mq6pJuNo-7k	2026-05-04 07:15:05.882276+00
9vh9owf3ddnbor178qlc9fgmcn0xz955	e30:1wJnWG:uK4whOIQ6SDQ2mhO1l4IcfORRhXuNJibB_y-uU5tlaU	2026-05-04 07:20:08.430847+00
j25rude2xybnu0v7erfc3j5bu47l8f2t	.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaW0okzN1xuUi17g:1wJlFO:bf0m5_nAXNWBPPVO8OB49U2vR-fVTYfWUKBFTz1Uw84	2026-05-04 04:54:34.041178+00
o1dc7e7r5ml5c0ir0psq67mi5p1zv5mj	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS01kaxlcqfX5SBXt0:1wJiwL:zJ2k4hg4BEHi4MRHnvShKFgaX9SakkQ7CtdF-meFIb0	2026-05-04 02:26:45.633724+00
at1i0ow1wzfpltv5pgjkneksd8oq4t8r	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtTZaMkV_fgGUm17h:1wJmXo:XH4U8S2i3HLil4uANY3MpOJnD_-mWgoAGtrDuDTPIUE	2026-05-04 06:17:40.773208+00
nzyver8v8ndx5w7y4nwmrvxe1r0uxi23	.eJxVj81uAjEQg1-lyhmtyB-T9Fj1Wok3iCaZlE2BpNpkkaqKd2eoOJSr7c-yf0XAdcxh7XkJhcSrcGLzX4uYjrneDfrCemhTanUsJU73yPRw-_TRKJ_eHtmnghn7zDSo6L1O0mKM2oJyoCUZ1ArQUyZjvLf6E3KUhnT0ViUib5x0JAmtAi4dOK818IgDLli5U23VjvWeey-thvZNfxfks1TxjBx-LxX7y573FSpH5jfihH0ETKNcyvhhDgAceA36egP7c1uF:1wJndl:CHjUtf8_H4qg5Wj-KJHor8JFDX_IvaMbgNBgXMrV19s	2026-05-04 07:27:53.522804+00
d7c5qhzy03bwqkdlkjp13j48pf3s6dos	.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlFJaCibY5QqUjF7e:1wJjg5:lV1MWvxGVgaeCQYYpIYd5HsXCuKu3m6sNK2G0IpoHok	2026-05-04 03:14:01.845282+00
590ncls1r4nqpjwkb4qa4cd5zf75vdpp	e30:1wJnih:K2UCjtVtcypdJcl-Fs-_kWtcR3gNSV_23fepvJ-bhww	2026-05-04 07:32:59.713909+00
e7rb3l9uv3dbsij2f7inoxr18lnsv12e	.eJxVj8tOBCEQRX_FsDYdoGkes9O9iX9ACgqm0R4wPEyM8d9lzCyc7bn3nlR9Ewuj73a0UG1CciKMPP5nDvx7yNcA3yCfy-JL7jW55VpZbmlbXgqG4_nWvRPs0Pa5NtIED8JEQQ2ujmpkXMooENSGjmlHN6GBo0Qqcdu4pCpELSP1fmUixCntsI9s5xFnqJCnk1MuJ2-htVSyLR_490Iex3FPM1xg9p_wknJqvUIv9eF1NOhzfkDrFnxPn6l_kRNTSmnNDV9_fgGUrF7m:1wJoZ1:3TDSs_aTwKDddjdHRihtyFRMiS0PClj52AsfmRzQ_lY	2026-05-04 08:27:03.663415+00
tygbu3w4fc7ospklkxfi8o77qz2jh4pf	.eJxVj0tuAyEQRK8SsY5GgPmNd8k-km-AGho8JGOI-FiKotw9OPIi3r6qeur-JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zvao1eBBrFHTFg6MGGVcqCgQt0THjqBQGOCqkCqXkiuoQjYrU-wMTIU5ph21kO484Q4U8nZxyNXkLraWSbfnEvxfy2PdHmuECs_-Cl5RT6xV6qU-n0aDP-Q6tW_A9XVP_IkemtTZGUUl_fgGUn17h:1wJpNT:YwpROit-Vd4wfdHbSiAJ5Rplx70JiN1liBp7G_Dy7-w	2026-05-04 09:19:11.013705+00
p3q6mr36f7dvc69j3flhtoo22gomt5em	.eJxVj81qAzEMhF-l-FyWru31T24NvYU-g5FsEbtN7bL2Bkrpu1dbcmgOgmE0-hh9iwDbyGHrtIaSxEF48fjfQ4jvVPdFeoN6blNsdawFpz0y3bZ9em2JLsdb9g6QoWe-1t5biuS1XBTa6JIC8A4jGTSL1BEQ9TLPS9ROozEKVbROorbGqkRubzUgbzVwiTOsUJkpn6Rhv1PvpdXQPtPfC9LeexU-gNNHSFAfTrQxgcULz3OnwYJWyMy5QB8B4ijXMr7EYbbWOi-VcT-_pQdgVw:1wJr1M:jtAFQdQb2JT5He_bi-m3fL2MHl1Z02nxExjHwAZkOLg	2026-05-04 11:04:28.365837+00
kt3fq8fv2myoum57hh89k8wcpk4y9xu5	.eJxVj0tuAyEQRK8SsY5GgBk-3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtZEmeBAmCmrw4KhGxqWMAkGt6Jh2dBUaOEqkEteVS6pC1DJS7w9MhDilHbaR7TziDBXydHLK5eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZUkpraZj5-QWUyV7v:1wJpbT:TVTGbabaWpksfF4N077_4QekRcw7jD9fPcNAJDcxISk	2026-05-04 09:33:39.840492+00
1guqgskqespn7y0j540wem3qbm3k1gbi	.eJxVj81uAjEQg1-lyhmtyB-T9Fj1isQbRJNMyqbQpNpkK1WId2eoOJSr7c-yLyLgOuaw9ryEQuJVOLH5r0VMp1zvBn1iPbYptTqWEqd7ZHq4fdo3yue3R_apYMY-Mw0qeq-TtBijtqAcaEkGtQL0lMkY763-gBylIR29VYnIGycdSUKrgEsHzmsNPOKIC1buVFu1Y73n3kuroX3T3wX5LFX8Qg6_l4r95cD7CpUT8xtxxj4CplF-yvhlDgCcV-B31xv7eFuJ:1wJr8G:uxIb64sG8chFdjkZz-WTzGBALKhUN8jYPfAYl163YdU	2026-05-04 11:11:36.249583+00
nkmi6xo0z12v519k8n53zx9eeocfoiuq	.eJxVj81uAjEQg1-lyhmtyB-T9Fj1isQbRJNMyqbQpNpkK1WId2eoOJSr7c-yLyLgOuaw9ryEQuJVOLH5r0VMp1zvBn1iPbYptTqWEqd7ZHq4fdo3yue3R_apYMY-Mw0qeq-TtBijtqAcaEkGtQL0lMkY763-gBylIR29VYnIGycdSUKrgEsHzmsNPOKIC1buVFu1Y73n3kuroX3T3wX5LFX8Qg6_l4r95cD7CpUT8xtxxj4CplF-yvhlDgCc805vrzf7e1uE:1wJqMQ:Cibr6BT0gsGEbJBkPIsi2yZBB1mZOQH6blSPlUaXgxk	2026-05-04 10:22:10.290727+00
f4zodrafvd6w0lqakh11xj00n1yudfku	.eJxVj0tuAyEQRK8SsY5GgBk-3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtZEmeBAmCmrw4KhGxqWMAkGt6Jh2dBUaOEqkEteVS6pC1DJS7w9MhDilHbaR7TziDBXydHLK5eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZUkobxgT9-QWUjV7d:1wJqhY:ClovLECJsaS7Yz2sWBPJ03Ktj1SsS46M-CMLp2HOs14	2026-05-04 10:44:00.265208+00
3oh9resueakcg470zsgnn0xpz6w1mdhn	.eJxVj0tOAzEQRK-CvEYje-JvdrBHyg2sttvOGCY28icSQtwdB2VBtq-qnrq_iYXRNztaqDYhORJGnv8zB_4j5FuA75DPZfEl95rccqss97QtbwXD_nrvPgg2aNtcG2mCB24ipwYPjmpkq5SRIyiBjmlHBdewokQqUYhVUhWilpF6f2A8xCntsI1s5xFnqJCnc6WrnLyF1lLJtnzi3wt57PsjzXCB2X_BS8qp9Qq91KfTaNDnfIfWLfierql_kSNTSmnDpFA_v5SyXuo:1wJqpt:Rnb1eSzgxE0u1FXfkv0I9_wNDQDsK-Cb3CEWBEY4Efs	2026-05-04 10:52:37.557701+00
6ozrh8tm6i4tsrxaslnxym7l9b6wdrje	.eJxVj81uAjEQg1-lyhmtyB-T9Fj1isQbRJNMyqbQpNpkK1WId2eoOJSr7c-yLyLgOuaw9ryEQuJVOLH5r0VMp1zvBn1iPbYptTqWEqd7ZHq4fdo3yue3R_apYMY-Mw0qeq-TtBijtqAcaEkGtQL0lMkY763-gBylIR29VYnIGycdSUKrgEsHzmsNPOKIC1buVFu1Y73n3kuroX3T3wX5LFX8Qg6_l4r95cD7CpUT8xtxxj4CplF-yvhlDgC83Tprrjf7UVt_:1wK6Eg:Kxwc_z5D_mIGiM8yAVeMg-nOKSHb5_ukY076Nw0wjpg	2026-05-05 03:19:14.67847+00
adswatv4m0uwqdzfvldle15qwjbn6x31	.eJxVj01uwyAQha9SsY4scAFDl1G2lXoDNGYgpkmgMjhSFOXumURe1Mv53o_e3JmDpU1uqWF2CdkXM2z3n43gTyG_BPyFfCydL7nNaexelm5Va_ddMJz3q3dTMEGdKM21MMiDVJILqUaNETF8cmkVgASrPAZvpLLcDDbCGDRqQ1eM1kehekGlDaYlOxpxhBkydfa818RrqDWV7Mofvl8QW5ThAmQ-pAz144f2JUwnyu_YGWpz4Fu6pnaj3DAMlgvRm8cTLqpb1g:1wJtIe:hPoQGVn-zqix3pE5ZiehqgZP-5t9K0FeXF5dDQKLA5U	2026-05-04 13:30:28.546454+00
3i8ri8fb7rsdf95muadkefqws47r9mot	.eJxVj8tuwyAQRX8lYh1Z4ACGLKNuK_UP0JiBmDygMrhSFeXfO668SJZz7kN3HszB0ia31DC7hOzIDNu_shH8NeRVwAvkc-l8yW1OY7dauk2t3WfBcDtt3reCCepEaa6FQR6kklxINWqMiOHApVUAEqzyGLyRynIz2Ahj0KgNXTFaH4XqBZU2mJbsaMQZZsjU2fNeE6-h1lSyK9_4_4J4RxnuQOaPlKHuvmhfwnSl_J7doDYHvqWf1H4pNwyDlQfO1fMPLrxb1g:1wK4C6:YrFi2X5w0G-5_jNjklmZh2Nr_F4oHyI-Z4GsalJWhYM	2026-05-05 01:08:26.068735+00
33pi1jxjemgaeb7emkqp3f8xp0fps5dz	e30:1wK4HM:jw7j8peVDleRkjOsOXynbvJgVwB_tD0cdsYqeEOC1gk	2026-05-05 01:13:52.31762+00
o3obdlxpvvyhgcvn3tqf0m86aw3sd8hd	.eJxVj81uwjAQhF8F-Yyi-i8bc6y4IvEG1tpriIHaKHYqVVXfvUvFoVxn5hvNfAuPa5_92tLiM4mdmMT2vxYwXlN5GHTBcq5DrKUvOQyPyPB023ColG7vz-xLwYxtZhpUcE5HaTEEbUFNoCUZ1ArQUSJjnLP6BClIQzo4qyKRM5OcSBJaBVzacV6L5xFnXLBwp3pTI-sttZZr8fVOfxfkq1TwAzm8zwXb5sj7MuUr81txw9Y9xp4_c_9iDgCcMeM4_vwC-15bgw:1wK4cs:h51ThKPF0_C4qAi95Oj6JLc9Nkam2lxXkvJKHoxx2ho	2026-05-05 01:36:06.540496+00
oiob1sx9sy6dkn6tkyetni48a5vdj873	e30:1wK4mS:poi0K4Ax5VRlrVOFzJ6xjcQJUTa23NFhcX9WnDX3MDI	2026-05-05 01:46:00.182613+00
ocwraszhw4h73cn6ajsoxdxrd9i5xum4	.eJxVj81uAjEQg1-lyhmtyB-T9Fj1Wok3iCaZlE2BpNpkkaqKd2eoOJSr7c-yf0XAdcxh7XkJhcSrcGLzX4uYjrneDfrCemhTanUsJU73yPRw-_TRKJ_eHtmnghn7zDSo6L1O0mKM2oJyoCUZ1ArQUyZjvLf6E3KUhnT0ViUib5x0JAmtAi4dOK818IgDLli5U23VjvWeey-thvZNfxfks1TxjBx-LxX7y573FSpH5jfihH0ETKNcyvhhDgC8sU7B9Qb7YVuD:1wK4vb:V-HJ7KeVDrnFnE9Kl0jvVqbaKwicnWrhyR_j27fV9rc	2026-05-05 01:55:27.993055+00
78yjd99imfmzd8f2u4rhw92w1pj1hzue	e30:1wK50c:DwWLLpRVT7rF_2NdOUTZlPBccxyWimvI85kFTGUn8nI	2026-05-05 02:00:38.133704+00
2nzm53fqy698e3kzk8e9hffb3zd0wzgl	.eJxVj8FuAyEQQ3-l4hytAgMBeoxyrdQ_QANDszQJVAtbqary75lUOTRX28-yf0XAdcxh7XkJhcSrcGLzX4uYTrneDfrEemxTanUsJU73yPRw-_TWKJ_3j-xTwYx9Ztqq6D0kaTBGMFY5C5I0grLoKZPW3hv4sDlKTRC9UYnIaycdSUKjLJcOnNcaeMQRF6zcqbZqx3rPvZdWQ_uivwvyWap4QQ4fSsX-8s77CpUT8xtxxj4CplG-y_hhzlq3Bb0DuN4A-xJbdA:1wKS1x:K_cL8kywzPobU27dAOxBkmKq25MUZUDHcRJTm0mBMEc	2026-05-06 02:35:33.148836+00
pxpp44fks4slb85fyp36aatlkdcrskms	.eJxVj0tuAyEQRK8SsY5GgBkGvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtZbaOxA6CKpxZ6lCxqUMAmGZ0TJl6SwUcJRIJc4zl3TxQclAndsx4cOQNlh7MuOIIxRIw8kpl4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzZVFUMK3U5QqUe17l:1wKTwb:xRTu9t-fCVMVNi2eKmG_L-mWlPgWF6jHUs85VNF6w3Y	2026-05-06 04:38:09.059666+00
p1966g5oepzxmjbuwspu8ond9tk6w6xa	.eJxVj81OAzEQg18F5VytyF9nhyPiWqlvEE0yoRtaErTJIiHEuzNFPdCr7c-yv1WgbSxh63kNhdWTmtXuvxYpnXO9GvxG9dSm1OpYS5yukenm9unQOF-eb9m7goX6IjSYiGiT9hSj9WBmsJodWQOEnNk5RG9fIUft2Eb0JjGjm_XMmskbkNJBy1aDjDjRSlU6zaPZi95z76XV0D7474K-lyq9k4RfSqX-cJR9hctZ-J26UB-B0iifZXwJBwDoYA_48wv7dluK:1wK5PU:sFEA8DbfhI73UwrubEvdJ0pYwMD_7YyKeOCKiy5nYz0	2026-05-05 02:26:20.001588+00
klgl7srf8p5p5dwj3nmhjljzh7m9dr6x	.eJxVj0tuAyEQRK8SsY5GgIFhvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9aIW70AsQdAFd5ZqZFypIBBmiZZpS6XQwFEhVSglV3T2QatAndsx4cOQNlh7MuOIIxRIw8kpV4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzedZUcEHl5QqUTl7W:1wKU3K:oLAf7jda09jEGeuGmvvTDXuFqBoNzBn29-GXPejnOjI	2026-05-06 04:45:06.094932+00
85n8pcuhn7r8kjzi9dqcpx83obbrwf2j	.eJxVj81uAjEMhF-lyhmtyB_e9Fj1isQbRE4c2ABNqk22UoV4dwziANeZ-cbji_C49MkvLc0-k_gUo1i9agHjKZW7QUcshzrEWvqcw3CPDE-3DdtK6fz1zL4VTNgmpkEF53SUFkPQFtQIWpJBrQAdJTLGOav3kII0pIOzKhI5M8qRJKFVwKUdp6V4HnHAGQt3qrXasN5Sa7kWX3_p8YJ8lwr-IIe_c8H2seN9mfKJ-ZU4Y-seY89_uf8zBwB8cmPhegP7cVuH:1wK5fF:YSyrTMWUxTAuPGc08XW0atVmPJ9l7TTvzR7IQoDpvog	2026-05-05 02:42:37.889357+00
rv4fpf56werbv8awmx29151w7j7vgl5c	e30:1wK5xr:qXiOvvaU-xUTsrxxXqq8YrjiAoKjFK2yp-pALSRxj8Y	2026-05-05 03:01:51.610288+00
p448eb6r51mdqa95yy0c667suyvaq65j	e30:1wK5xr:qXiOvvaU-xUTsrxxXqq8YrjiAoKjFK2yp-pALSRxj8Y	2026-05-05 03:01:51.624648+00
rmaixvakmqtu83r2l4pvn0yxnni6s5m8	e30:1wK5xr:qXiOvvaU-xUTsrxxXqq8YrjiAoKjFK2yp-pALSRxj8Y	2026-05-05 03:01:51.62599+00
3z2vfees3w8tvp9fdsj5ew79lxsx1uk1	e30:1wK5xr:qXiOvvaU-xUTsrxxXqq8YrjiAoKjFK2yp-pALSRxj8Y	2026-05-05 03:01:51.818871+00
ivnzoseb4cw028536ioyshf13v2tpq9i	.eJxVj81uAjEQg18F5YxW5K-z4Yi4IvEG0SSTsimQoE0WCVV99w4Vh3K1_Vn2t_C49MkvLc0-k9iKUaz_awHjOZWnQV9YTnWItfQ5h-EZGV5uGw6V0mX3yr4VTNgmpkEF53SUFkPQFtQIWpJBrQAdJTLGOas_IQVpSAdnVSRyZpQjSUKrgEs7TkvxPOKEMxbuVBv1wXpLreVafL3R3wX5LhW8Iof3uWBbHXlfpnxmfi0u2LrH2PM99wdzAODsRoL5-QX7O1t6:1wK63i:x5RYeqkgVFzXrJL1K4KMptzyXje6zKwl_8m5Zz5cju4	2026-05-05 03:07:54.866332+00
ev7ildf8pnp03j1g6gsj1dzo01vp725j	.eJxVj8tOBCEQRX_FsDYdoOlqena6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5MsMf_zKJ79-ka0Bumc55cTq1EO10r0y2t00smfzzfuneCHes-1hts3qHaguIbzZZrEhIgKMJ1ISu05YvSKAmIAy2LBL76oCFw52ahfBjShntPZhxxxoJpOCWXMHj1tcacTP6gvxdSP457mvCCo_9El5hibQVbLg-vvWIb8wNrM-ha_Izti53EumohNMzw8wuUdF7g:1wKnsq:XV34nHtCiAQ09bvVbQrZJ4S49Uix1Ov6jlVtkVSup94	2026-05-07 01:55:36.141336+00
ajm4vbgn44hpu1dhiwxjkgfihvthnwiq	.eJxVj0tuAyEQRK8SsY5GwDAMeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUbay21dyB0EFTjbKlCxqUMAmFd0DJl6SIUcJRIJS4Ll3T1QclAnZuZ8GFIG2w9mXHEGQqk4eSUy8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jg66qYEJrN1xuUcl7d:1wKuif:SAQHYbyJtx7ehiVP6Ncgn2SLdwFiJ7L2QSGe8XieUiA	2026-05-07 09:13:33.525383+00
qr089v9to3ihjroxuw03lhrm6j92c33n	.eJxVj0tuAyEQRK8SsY5GgBk-3iX7SL4BamjwkIwh4mMpinL34MiLePuq6qn7m1gYfbOjhWoTkiNh5Pk_c-A_Qr4F-A75XBZfcq_JLbfKck_b8lYw7K_37oNgg7bNtZEmeBAmCmrw4KhGxqWMAkGt6Jh2dBUaOEqkEteVS6pC1DJS7w9MhDilHbaR7TziDBXydHLK5eQttJZKtuUT_17IY98faYYLzP4LXlJOrVfopT6dRoM-5zu0bsH3dE39ixyZUpoqqY35-QWUp17u:1wKd1f:JA1Cwd6Ul65dzKye72sGbo1r7g1jg8inHAJAlkr-jzQ	2026-05-06 14:19:59.858147+00
c9idwwdcj4tazifh3shbkfi3hux6ns2j	.eJxVj0tuAyEQRK8SsY5GgIFhvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9aIW70AsQdAFd5ZqZFypIBBmiZZpS6XQwFEhVSglV3T2QatAndsx4cOQNlh7MuOIIxRIw8kpV4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzedZUCCHl5QqUZ17d:1wKUaN:ix3nFLocv8-gzAMJr-osfDbO8FVAv4xEytZiof9wVe8	2026-05-06 05:19:15.342721+00
2kvvdkou5nykgwoyj8ayicrcxnz5cmsy	e30:1wKdAU:Lgk3t2VfoVziMkh7I3F2LBVBcDHu720QVpjy0eiriqQ	2026-05-06 14:29:06.940146+00
ixjg4sg92ddtdz5ke9vl95q3qfudusmn	.eJxVj0tuAyEQRK8SsY5GwADDeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wt3oFYg6ArzpZqZFypIBAWiZZpS6XQwFEhVSglV3TxQatAnZuZ8GFIG2w9mXHEGQqk4eSUq8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jgy6KZkLPm1xuUcl7e:1wKuqE:6MkxAMXCVSGI5Y20eD2JFYzdLQAKpRWPevScFHqKLOw	2026-05-07 09:21:22.2614+00
d8ggn6lphl8wlwkooc8813s046eoldx8	.eJxVj8tOBCEQRX_FsDYdoOlqena6N_EPSEHBNNoDhoeJMf67jJmFsz333pOqb2awt9306ouJxE5MsMf_zKJ79-ka0Bumc55cTq1EO10r0y2t00smfzzfuneCHes-1hts3qHaguIbzZZrEhIgKMJ1ISu05YvSKAmIAy2LBL76oCFw52ahfBjShntPZhxxxoJpOCWXMHj1tcacTP6gvxdSP457mvCCo_9El5hibQVbLg-vvWIb8wNrM-ha_Izti53EumoBAub15xeUcV7f:1wKz4P:UuiBo1Icxe1gEtBn8svNn-bFeZ_nv23UfY8Z7MELqUY	2026-05-07 14:17:17.701848+00
zr59nixmilykrlkd4sv0af10wsq6ca9l	.eJxVj8tOBCEQRX_FsDYdoHn17HRv4h-QgoJptAcMDxNj_HcZMwtne-69J1XfxMLoux0tVJuQnAgjj_-ZA_8e8jXAN8jnsviSe01uuVaWW9qWl4LheL517wQ7tH2uN7UFD2KLgm64OmqQcaWiQNASHTOOSmGAo0KqUEquqA7RqEi9X5kIcUo77CPbecQZKuTp5JSryVtoLZVsywf-vZDHcdzTDBeY_Se8pJxar9BLfXgdDfqcH9C6Bd_TZ-pf5MS0NoyvTMufX5RXXto:1wKp43:Nf1NN6vgGVJzFXaY1isXj47eJy4CcXhvIU4nnpfR-r4	2026-05-07 03:11:15.844652+00
o7sd89y8vt183gq0p4ayq1jt4stpg6ky	.eJxVj0tuAyEQRK8SsY5GwDDAeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wu3oFYg6ArzpZqZFzKIBDUgpZpSxehgaNEKnFZuKTKBy0DdW5mwochbbD1ZMYRZyiQhpNTLgevvtaYk8lf-PdC6vv-TBNcYPSPeIkp1lag5fLy3iu0Md-hNgOuxe_YfsiBKaXZTJWerzeUZV7d:1wKr2l:prBT8r6U3ulsisSz4slGmEPMdi2rVFCjO937TKpzEj0	2026-05-07 05:18:03.128638+00
8kivvhy7e6mdrwr4hga4kf5nmm9tks2m	.eJxVj0tuAyEQRK8SsY5GgBlgvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqO9SIX70AsQdAFd5ZqZFzKIBDUjJZpS2ehgaNEKnGeuaTKBy0DdW7HhA9D2mDtyYwjjlAgDSenXA5efa0xJ5N_8f5C6tv2ShOcYPQ_8BRTrK1Ay-Xt0Cu0Md-gNgOuxXNsf2TPlNJUacX45QqUh17g:1wKdUu:Y3xrQ3czFasEGkEacJfqB8W1Y70KJRin2Z-Vd5e68m0	2026-05-06 14:50:12.207274+00
xm8wq1bc9ebwsdi0mskd5sdz38andxrq	e30:1wKdbT:mOgi53XgDflLsUovxei8KgLGT8Aw56s4heOoBuepsx0	2026-05-06 14:56:59.18294+00
xfknffe85t63re4icgim9tx8w28mhn3n	.eJxVj0tuAyEQRK8SsY5GwADDeGfvI-UGqKHBQzKGiE-kKPLdjSMv4u2rqqfuX2Kgt8306ouJSA6Ekdf_zIL79Oke4Aekc55cTq1EO90r0yOt01tGv58e3SfBBnUb61Wt3oFYg6ArzpZqZFypIBAWiZZpS6XQwFEhVSglV3TxQatAnZuZ8GFIG2w9mXHEGQqk4eSUq8GrrzXmZPIX_r2Q-r4_0wQXGP0jXmKKtRVouby89wptzHeozYBr8Tu2H3Jgy6KZnLlg1xuUXF7X:1wKwsz:rVRmzcduVziRY9XFVOeUWDRscTRo4SI2-homivdFPEk	2026-05-07 11:32:21.437027+00
52omrolswcqv442zfp4sq26jpot14xbp	.eJxVj01OBCEQha9iWJsO0DRNz073Jt6AFBRMoz1gKDAxxrvLmFk42-_9VL1vZqG33XYK1SZkJybY43_mwL-HfBXwDfK5TL7kVpObrpbpptL0UjAczzfvXcEOtI_0prfgQW1R8Q1nxw0KqXVUCOuCThjHF2VAokaucVmk5muIRkfu_SxUiKO0wd6zHU-coUIenZJLPTgFolSyLR_4NyH347inGS4w_E94STlRq9BKfXjtBG3ED6Bmwbf0mdoXO4l1NWIe5-efX5RkXts:1wKsQ5:IJF5RI_w1H6W7fiCuq-ZOeJOCKhYP-OBeXLSjkVvVZc	2026-05-07 06:46:13.380247+00
t63h7zfvhrlzd0hv9ak2zxz1kukbau6w	.eJxVj0tuAyEQRK8SsY5GDWYYxrtkH8k3QA0NHpIxRHwsRVHuHhx5EW9fVT11fzODvW2mV19MJHZknD3_Zxbdh0-3gN4xnfPkcmol2ulWme5pnd4y-f313n0QbFi3sV7V6h3KNUhY6WBBExdKBUm4zGS5tjBLjYIUgaJ5FgoWH7QK4NyBSx-GtOHWkxlHnLFgGk4BQg1efa0xJ5M_6e-F1Pf9kSa84Oi_0CWmWFvBlsvTqVdsY75jbQZdi9fYvtiRL4sGDRzkzy-UTl7U:1wKdrM:vb2Z5qGOFXISOuwOl7KabdxPKZgjaC778u56rBI3xZ4	2026-05-06 15:13:24.371981+00
iuzezyz4j3yfgg8qor5o8kmfqi2eaolk	.eJxVj81OQyEQhV_FsDY3QIEL3enepG9ABgZ60Vsw_DQxxneXmi7s9jvnfJn5JhZG3-xoodqE5EgYef7PHPiPkG8BvkM-l8WX3Gtyy62y3NO2vBUM--u9-yDYoG1zbZQJHoSJgho8OKqRcaWiQFglOqYdlUIDR4VUoZRc0TVErSL1_sBEiFPaYRvZziPOUCFPJ6dcTd5Ca6lkWz7x74U89v2RZrjA7L_gJeXUeoVe6tNpNOhzvkPrFnxP19S_yJGtq6aaSmZ-fgGUa17e:1wKdy3:jq-75K8ZRr7DG1tDDMi5W7LQj_jqmRTjs9Izftt1bO4	2026-05-06 15:20:19.561612+00
i24ywwrghkeg4s0c6b9eff7hboe6f7yh	e30:1wKaVW:dy84JCdOxJY5EkCC3ZyOvMeNRfIQeWExHFm1sYm4X48	2026-05-06 11:38:38.265932+00
6tmrsbnw0s67wg5vlzkdb8ifs6xuks9i	e30:1wKaw4:iTYJI9Io3OYYNgiG8esM5vuhAcXx1hFSW13Y_8QlfW0	2026-05-06 12:06:04.696443+00
6hd7iorcp22pnul2aizhyfp7gci3nu3u	.eJxVj8tqwzAUBX_F3LUxsmK9vGvIruQbxLGk2m7Sq2LJgVL67yUli2Y7Mxw43-Sx18XvJW1-jTRSL6j9DyeES-K7ie_gOXchc93Wqbsn3cOW7pxjuh4f7dPAgrLQSHYaXHBBaiAMUEhSxmiitvaglXTB9CoKZYag4iSd6A8O4i0IAaedkgnUUsWyswfPMzYwjSSF1NRSSaWsmX3-jH8fpHlmjA_QSEdEcPOadvAMbk7g5qWk2pyQNizU0hWleoS63tb6RWNvjBVaD9r-_ALHZmBf:1wKaJQ:c5drqDerJQeUdmnmjHtzn4ZgelpIoTKxO6qHfIFnn-U	2026-05-06 11:26:08.395183+00
tkcvuw0dv14224hnbx4vlmhr1dqokf9t	.eJxVj0FqwzAUBa9i_toYWbEky7uG7ErOIJ4l1VKTfhdLDpTSu5eULJrtzPDgfZPDXpPbS9xcDjRRL6j9D2f4S-S7Ce_gZe38ynXLc3dPuoct3XkN8Xp8tE8DCSXRROM8WG-91IAfoBClDMEEPY4HraT1pldBKDN4FWZpRX-wEG9eCFhtlYyglirSzg68LNjANJEUUlNLJZaSV3brZ_j7IM0zY3yAJjoigJvXuIMXcHMCNy8l1uaEuCFRS1eU6uBrvuX6RVNvzCi0tkL9_ALHYmBb:1wKaQU:EpOGTWH0yDMwjPfDftiSDSEnbuwPmDsMLDfSwWOn6lw	2026-05-06 11:33:26.066764+00
u9glph9s4j4qsq687nyfktazbl6ztobb	.eJxVj81qAyEURl-l3PUwqFHnZ5fuA3kDuXp1xnaixZ9CKX33kpJFsz3n8MH3DQZ7202vvphIsAKH4T-z6N59ugt6w7Tl0eXUSrTjPRkfto6XTP54fbRPAzvWHVZY9OIdyiVIttDJspm40DpIwkmR5bNlSs4oSBPTpJTQbPJh1oE5d-LSBxig4d6TwbRtWDDBCoIJDQNUX2vMyeQP-ruQ-nE804Q3hBXOdIsp1law5fJy7RUbDHBgbQZdi5-xfcHKp2lmWinBf34BlGte2g:1wKa4A:SW1UJSISBnRpwGr4St-oBscvE7GJXmxranSWYQWTvnU	2026-05-06 11:10:22.077634+00
p14ax45r1avyv9j2w0krj5716lasnsg6	.eJxVj0FqwzAQRa9SZm2MrEiy7F26D-QGYqSRbLXOqFhyoZTevaRk0Wzfe3z43-DwaKs7atxdJphhgO4_8xjeI98FvSEvpQ-F2559f0_6h639pVDcXh_t08CKdYUZJjPFgGpKSkx08sLSII1JinDU5AfrhVYWJRkShrSWRowxWZNECKdBxQQdNFwPdsjLgjsyzCCFNNBBjbXmwq580N8FPrbtmTLeEGY40y1zrm3HVvaX61GxQQcb1uYwtPyZ2xfMwzhaYazS488vlIte5Q:1wKapV:h8xaW71Y-UOL49v3pTrmL-3GLKst7V0WejxG294Fo58	2026-05-06 11:59:17.814269+00
cubf16orzf65v0xq8uztmtuettto036q	.eJxVj0tuAyEQRK8SsY5GgBkGvEv2kXwD1NDgIRlDxMdSFPnuxpYX9vZV1VP3PzHQ22p69cVEJHvCyPszs-B-fLoF-A3pmCeXUyvRTrfK9Ejr9JXRb5-P7otghbqOtZbaOxA6CKpxZ6lCxqUMAmGZ0TJl6SwUcJRIJc4zl3TxQclAndsx4cOQNlh7MuOIIxRIw8kpl4NXX2vMyeRfvL-Q-ra90gQnGP0PPMUUayvQcnk79AptzDeozYBr8RzbH9mzZVFMaKHp5QqUiV7i:1wKvuU:oGCEo3v_-7-oQTDTngXT7zzWSu7OEcRZzWnukG128yQ	2026-05-07 10:29:50.342013+00
vjqiffbxrgs7ez4p1e5n4j8k4hrn8t68	.eJxVj81qxDAMhF-l-FyCpaxjZ29deit9BiP_ZO3u1i6xUyil716l7KF7EAyj0cfoW1jaerJbi6vNQRwFgHj8bzryl1j2TXijcq6Dr6Wv2Q17ZLht2_BaQ7yebtk7QKKW9mvpD4sPBg_KGYDZBb-gB-XBEaoxwAx6mkYyUZHUC4IcDcowLsZhRCUZ2iltxXKJM61UmIkSJ_ZbbC3XYutH-PsB9b1X6J04faJA5eElbkxg8czz1GJnEVdKzLlS65Z8z5-5f4kjaM0NjJrmn1-_MGBD:1wLBHN:CqPhsXQClYb3G9pw3upmjTDW8DJvQQE_BJIUu2ZhWYE	2026-05-08 03:19:29.089914+00
bqohta963hee9dtypzckloonegucsqiz	.eJxVj8FqwzAMhl9l-DxC7GRW2ttKb2XPYGTJrb119oidwSh99yqlh_Ug-PXr14d0UQ6XFt1Sw-wSq63SRr3-Nz3SV8jrhD8xn0pHJbc5-W6NdI9p7T4Kh_PukX0CRKxRtolsj9bbURN7z6bvJ_ZM2h-HSVqDAAObaWNo7TxqJDjyZhyAPIwwCrRhXLKTI044Yxam6Y0Vv4ZaU8mu_PD9BwPPXsZvlPQOGfPLISxCELGXeq-hiQgzRuGcsTaH1NJvan9qqwGmN6sHY683iKZhjg:1wMf30:1C8LW0vMJ6vCPnrwqiIlenK_-K39BPp_Z5C2Hj7v9bg	2026-05-12 05:18:46.451899+00
ctwlzcbyy04elg1s8ub1a5xmuh6ijo78	.eJxVj0tOAzEQRK-CvEYjT8dy29nBHokbWO1PMoZJG_mDhBB3x0FZkO2rqqfub-Fo9M2NlqrLURzFKh7_M0_hPfE1iG_E57KEwr1mv1wryy1ty0uJaX--de8EG7Vtrr320igk8MoevLYhoF8lwikYryIcjIzqFNGCT1bKgMkmqRFXCJoMRpjSTttgN484UyWeTpCgJ2-ptVzYlY_49wKPfb-nTBea_ad4yZxbr9RLfXgdjfqc79S6o9DzZ-5f4rgiGmXAaPj5BX4rXrI:1wMKdS:1P4LQZbmKZx5OeqoKR7OGfldnQgNYIrp8GkZDUmjE94	2026-05-11 07:31:02.50919+00
5xv3grp0mujkru69zbjfo8zyszc0s9zm	.eJxVj01qwzAQha9StC7Gkh1Lzq6hu5AziPlRIjWpVCy5UErv3nHJolkMvHnz5mPmW3lYW_RrDYtPrPZKG_X830Sga8jbhN8gX0pHJbclYbdFuvu0dqfC4Xa4Zx8AEWqUbaKphwmnURMjsul7x8ik8Tw4aQ1YO7Bxs6GtQ9BA9szzOFhCO9pRoA3imr0ccYEFsjBNbybxa6g1lezLB__9YOyjl-EdJH0Ahvx0DKsQRLxKvdTQRIQFonBuUJsHaukztS-119a63ax3bv75BYjYYZw:1wMmv7:JBxLukr1h4i5M4auULSP-qgJGayyTojTf5vPI6xvoXo	2026-05-12 13:43:09.122657+00
6p7xun3d3rhyesadr4hso7g4k2uj0kjk	.eJxVj0FuAyEMRa9Ssa5GwFAg2TXKLuoZkLFJoE2hGphKVdW711Nl0SwsfX9_P9nfIsA6clh7WkIhsRdKi8f_ZgR8S3Wb0CvUS5uw1bGUOG2R6Tbt00ujdD3csneADD3zNqKVYKM1CilG0lJ6ioQqnmfPrQbnZtJ-p3HrIihAd6admR1GZ5xh6IC81sBHXGCBykwttWW_p95Lq6F90N8P2t17Fd6B0wcgqA-ntDKBxZHruafBIi2QmXOFPgLgKJ9lfIm9cs4_-dka-fMLiMJhkQ:1wMkqu:Ch9SqTas9eWFD-Nj7UREPJxMWpcJB8_2WrnBZwUBVOg	2026-05-12 11:30:40.750764+00
9qfat054m5iliy0vonvwsg18wqy9eytg	.eJxVj8FqwzAMhl9l-DxC7LhR2lvLbmPPYGTJrb229oidwSh99ymjh_Ug-PXr14d0Uw6XFt1Sw-wSq53SRr3-Nz3SOeR1wp-YT6WjktucfLdGuse0dh-Fw-XwyD4BItYo20Rjj6MfrSb2nk3fT-yZtD8Ok7QGAQY209bQ2nnUSHDkrR2APFiwAm0Yl-zkiBPOmIVpejOKX0OtqWRXvvjvBwPPXsYrSvqAjPnlPSxCEPEmta-hiQgzRuFcsDaH1NJ3aj9qpwEm2JiN1fdfiLdhjw:1wNSn7:wQR4mgiww6hhe9Q84FeisqKuNr1LckcJdnBr4o7XkC0	2026-05-14 10:25:41.445054+00
elmwkv8dv2fb1gdhk8f2lsjnfnj34u97	.eJxVj0tqAzEQRK8StA6DpkeoJe-SfSA3EK2PPXLGUtDHYIzvHjl4YW9fVT26r8xQb6vpNRQTPduxmb0_M0vuJ6R74I-UDnlyObUS7XSvTI-0Tl_Zh-3z0X0RrFTXsbbSciWQwAq9WKmdQztzhL1TVnhYFPdi71GDDZpzh0EHLhFncJIUehjSRmtPZhxxoEJpOIGDHLyGWmNOJv_6_xdS37ZXmuhEo__hTzHF2gq1XN6-e6U25hvVZsi1eI7twnYzohJKLcBvf34lXq0:1wMM3U:GQYl3VGTxCQFRmdmMXvcbppYePfLM0UBATIRYvFbFnQ	2026-05-11 09:02:00.99101+00
3d5uf8pch36az7jq398goi5d4fc13nzp	.eJxVj81OQyEQhV_FsDY3XEoY6E73Jr4BmQHai94Ohh8TY3x3qenCbr9zzpeZb-Fx9M2PlqrPURzFKh7_M8LwnvgaxDfkc1lC4V4zLdfKckvb8lJi2p9v3TvBhm2bazIkrQZUpN2BjAsBaJWgTsGSjupgZdSnCE5RclIGSC5JA7CqYNBCVFPacRvs5xFnrMjTqaQyk7fUWi7sy0f8e4HHvt9TxgvO_lO8ZM6tV-ylPryOhn3Od2zdY-j5M_cvcVwBrHbgjPz5BX5KXrc:1wMOYy:FKdVzr2NVEUkOWGpteVgz3peoBW0VXGxIPoIgDUSmtk	2026-05-11 11:42:40.624185+00
088qmtkpwi78ifrsr60nyi7bvbz8x0zu	.eJxVj8FqwzAMhl9l-DxC7KRW0tvKbmPPYGTJrb119oidQRl79yqlh_Ug-PXr14f0qxyuLbq1hsUlVnuljXr-b3qkz5C3CX9gPpWOSm5L8t0W6e7T2r0XDufDPfsAiFijbBPZHq23oyb2nk3fT-yZtD8Ok7QGAQY202xo6zxqJDjyPA5AHkYYBdowrtnJESdcMAvT9MaKX0OtqWRXvvn2g4FHL-MXSvqAjPnpLaxCEPEq9VJDExEWjMI5Y20OqaWf1C5qrwEmu5sB9N8ViORhmg:1wN4ep:Q02oLLxqEMvMtiVV4qCWv4nlT2NkvHDzUjb2xohovhw	2026-05-13 08:39:31.50527+00
4yvwuadsh4u79fj9ah338udryzh83v7u	.eJxVj0FOAzEMRa-CskajJDPE0-6ouqs4Q-TYaRMoCZpkkBDi7nhQF3Rh6fv7-8n-Vh7Xnvza4uIzq70yVj3-NwPSWyzbhF-xXOpAtfQlh2GLDLdpG14qx-vhlr0DJGxJtomcRhfcZIhDYKv1zIHJhPM4S2sRYGQ77yxtXUCDBGfeTSNQgAkmgXZMa_FyxAUXLMK02jrxW2wt1-LrB__9YOHeK_iOkj4gY3k4xVUIIo5Szy12EXHBJJwrtu6Rev7M_UvtDcDsnH4C8_MLiLVhkA:1wN4rj:UFDusVrUPR1_TsgwiT72Csy0pUNrR3fd9BlPf7mOcZo	2026-05-13 08:52:51.478278+00
ivv0f2fsnix5hn4buwvhgjtrbieln4qh	.eJxVj0FuAyEMRa9Ssa5GwFCYZNcou6hnQMYmgTaFamAqVVHuHk-URbOw9P39_WRfhIelJ7-0OPtMYiuUFq__zQD4Fcs6oU8opzpgLX3OYVgjw2Paho9K8bx7ZJ8ACVribUQrwQZrFFIIpKWcKBCqcBwnbjU4N5KeNhrXLoACdEfamNFhcMYZhnZIS_F8xAlmKMzUUlv2W2wt1-LrD91_0O7ZK_ANnN4BQXk5xIUJLPZc7y12FnGGxJwztO4Be_7N_U9slXOTNUa-6esNiKVhjA:1wN0ZI:u8MfFm-qh0OTGCEDoBtCrW8f89aDU2fooRlAsyxJUNI	2026-05-13 04:17:32.592305+00
wmffshutcllzzjo6nms4dr5xi4qxg38v	.eJxVj0FuAyEMRa9Ssa5GA0OBZNcou6hnQMYmgTaFamAqVVHuHk-URbOw9P39_WRfhIelJ7-0OPtMYiukEq__zQD4Fcs6oU8opzpgLX3OYVgjw2Paho9K8bx7ZJ8ACVribUQzgglGS6QQSI2jo0Aow3Fy3CqwdiLlNgrXLoAEtEfa6MlisNpqhnZIS_F8xAlmKMxUozLst9harsXXH7r_oOyzV-AbOL0DgvJyiAsTWOy53lvsLOIMiTlnaN0D9vyb-5_YSmvdmzNa6esNiMthlA:1wMlZo:lceYO-TzaKAz4ikqadgZqMa39AoWhdwJqzNkyUQyYyU	2026-05-12 12:17:04.95684+00
cdfcztocijk9ftvwftiacqa0jbd7s9fs	.eJxVj01qAzEMha9SvC7D2DPYk-waugs5g9GPE7tN7DL2FErI3aMJWTQLwdPT04d0VR6WFv1Sw-wTq63SRr3_NxHoO-R1wl-QT6WjktucsFsj3XNau0PhcN49sy-ACDXKNpHtwaIdNTEim76fGJk0HodJWgPODWymjaG1Q9BA7sibcXCEbnSjQBvEJXs54gQzZGGa3ljxa6g1lezLDz9-MO7Vy3ABSe-AIb_twyIEEZ9SHzU0EWGGKJwz1OaBWvpN7U9ttXOTtdoO-nYHiLJhjg:1wN58p:LtRXX6479SWjIJlleXPd1NpuGyT4PXs9CdbyjleAHcU	2026-05-13 09:10:31.607118+00
jdxbdf10257ynvnueuxqhstwviutx6eh	.eJxVj8FOwzAMhl8F5YyqJK3idjcmbohniBw7WwJbgpoUCSHeHRftwA6Wfv_-_cn-Vh63nvzW4uozq4MyVj3-NwPSeyz7hN-wnOtAtfQ1h2GPDLdpG14rx8vxlr0DJGxJtomcRhfcZIhDYKv1zIHJhNM4S2sRYGQ7L5b2LqBBghMv0wgUYIJJoB3TVrwcccYVizCttk78FlvLtfj6wX8_WLj3Cl5R0kdkLA8vcROCiGeppxa7iLhiEs4FW_dIPX_m_qUOBmDRYEZnf34BiJVhiw:1wOnjO:zKBfS50LFrycAoRf2HmseqgOYW5r2j-NRwEqpcDQO6Q	2026-05-18 02:59:22.680422+00
8yd2ujgxx1ey310e5k6rrvv0wwu5fxy1	.eJxVj0FuAyEMRa9Ssa5GwIyAZNeouyhnQMYmgTaBamAqVVHuHk-URbOwZH9_P31fhYelJ7-0OPtMYiuUFu__xQD4Hcu6oS8opzpgLX3OYVgtw3PbhkOleN49vS-ABC3xNaKRYIKZFFIIpKV0FAhVOI6ORw3WjqTdRuM6BVCA9kibabQY7GQnhnZIS_Ec4gQzFGZqqQ3rLbaWa_H1hx4_aPuqFbgAu3dAUN72cWECN59cHy12buIMiTlnaN0D9vyb-5_YKmud4bzS3e6IsmGQ:1wN5mm:ELZfiwU6AxI1b9lPRhrmynfb6jQ_FG_U2aFh1eKaDug	2026-05-13 09:51:48.588573+00
8ynuijazv6mfbm2uyoj81q4mhp3gng48	.eJxVj0tuAjEQRK8SeR2Neoxx2-zIHokbWO0PjJPBjvyJFKHcPQaxgO2rqqfuKzPU22J6DcVEz3ZsZu_PzJL7CukW-E9K5zy5nFqJdrpVpkdap0P2Yf14dF8EC9VlrK20oAQSt0JvrNTOoZ0B-ckpKzzfKPDi5FFzGzSAw6ADSMSZO0kKPR_SRktPZhxxpkJpODlwOXgNtcacTP729xdSX9dXmuhCo7_3l5hibYVaLm_HXqmN-Uq1GXIt_sT2y3YzotoCoOB__33uXqY:1wMPHq:wbvNszzDGc9wz1Z15Uw4K4UrZ1cL89KISfLRRnWLXQw	2026-05-11 12:29:02.042223+00
r61cuyr1us5tfm6xtuynhe2iuwk1uthe	.eJxVj0FuAyEMRa9Ssa5GDBlhyK7dV-oNkMEkQzqBCkOlqurdQ6Isku37_z_Zf8Jhb6vrHKtLJPZiFq-PzGP4ivka0AnzsUyh5FaTn66V6Z7y9FEobu_37pNgRV7H2msvzQKo_GJ3XtsQwM8S1CEYv5DaGUnLgcAqH62UAaKNUgPMKmg0QGpIG649u3HEESvm4VRS6cE5MqeSXfmm2wu5b9szzXjG0X-jc8qJW8VW6stnZ2xjviE3h6Gln9R-xX4GMNoYC_L_An5aXro:1wNCFm:M4Q8NK60YVB0sIHvyPLsFFNJxbe12YsuVysHFg_xpA4	2026-05-13 16:46:10.51997+00
4eict1g8mpg1chsp488bevq2t68b2b3c	.eJxVj0FuAyEMRa9Ssa5GwFCYZNcou6hnQMYmgTaFamAqVVHuHk-URbOw9P39_WRfhIelJ7-0OPtMYiuUFq__zQD4Fcs6oU8opzpgLX3OYVgjw2Paho9K8bx7ZJ8ACVribUQrwQZrFFIIpKWcKBCqcBwnbjU4N5KeNhrXLoACdEfamNFhcMYZhnZIS_F8xAlmKMzUUlv2W2wt1-LrD91_0O7ZK_ANnN4BQXk5xIUJLPZc7y12FnGGxJwztO4Be_7N_U9slXPTm5XG6usNiKlhjg:1wMep4:-gyIZuMOS0IVZzXgVRagVfKurZU--wtXWeZl2Muvh54	2026-05-12 05:04:22.151246+00
dqlluzg37qc1av8a01ad6gxakd4q2pcv	.eJxVj0tOAzEQRK-CvEYjjzO47ezCPlJuYLU_yRgmNnK3kRDi7jgoC7J9VfXU_S0cdl5dp9RcjmIvZvH8n3kM76ncgviG5VKnUAu37KdbZbqnNB1rTNvrvfsgWJHWsfbaS7MAKr_Yndc2BPCzBHUOxi9R7YyMyzmCVT5ZKQMkm6QGmFXQaCCqIWVce3HjiAs2LMOppNKDUyLKtbj6Ef9eKH3bHmnBK47-IV5zycQNubanUyfkMd-Q2GHg_Jn5S-xnACuNtS_m5xd-R168:1wOsZK:04icsU34-F-S0JPSVExmIex0QkCe_ABr0nuxEsMWWYk	2026-05-18 08:09:18.023834+00
j0adt4ggg2glqeae2uf1fq4oi2ukwiwo	.eJxVj8tuwyAQRX-lYl1ZeOwyJrt0X6l_gGaAxLQOVDwqVVX-PSTKItmee-_RzL8w1OpqWvHZBCd2YhSvj4zJfvt4DdwXxWMabIo1Bx6uleGeluEjOb-937tPgpXK2tesWC4zEvCsJ1baWuRRIhzswrODaZFuPjjUwF5LadFrLxXiCFbRgg66tNLaoulHHClT7E6QoDovvpSQokk_7vZCbNv2TCOdqPf37hRiKDVTTfnlsxWqfb5RqYZsDb-h_ondiKgn9aZAnS9-I16x:1wQ2Ha:ZktI9iYWuB8XUToTpb8V3yjNFqGC_6t9eY3M1WLWZlY	2026-05-21 12:43:46.523954+00
9n4ztwyrws0j9oha4tbzs175ramz6jwo	.eJxVj8FqwzAMhl9l-DxC7AQr6a1lt7FnMLLk1l5be8TOYJS--5TRw3oQ_Pr160O6KYdri26tYXGJ1U5po17_mx7pHPI24U_Mp9JRyW1Jvtsi3WNau4_C4XJ4ZJ8AEWuUbSLbo_V21MTes-n7iT2T9sdhktYgwMBmmg1tnUeNBEeexwHIwwijQBvGNTs54oQLZmGa3ljxa6g1lezKF__9YODZy3hFSR-QMb-8h1UIIt6k9jU0EWHBKJwL1uaQWvpO7UftNMBswcIE91-I-GGh:1wRLEJ:0CMufyp9bRbpCcp70jdylrmgq_cqDQifnHpMm9OkRB0	2026-05-25 03:09:47.595428+00
wfxrqriby8erbs0qfmbkeb80m8yl402m	.eJxVj01OBCEQha9iWJsOzXSoZna6N_EGpAqYabSnMFCYGOPdZcwsnO33fvLet_LYZfO9pepzVEc1q8f_jDC8J74K8Q35XKZQWGqm6WqZbmqbXkpM-_PNe1ewYdtGmizpdQE0tLgDWRcC0KzBnMJKSzSHVcflFMEZSk7rAMklbQFmEyyuEM0oFdw6-zHijBV5dBpt7OAttZYL-_IR_y5w3_d7ynjB4X-Kl8y5SUUp9eG1N5QR37GJxyD5M8uXOs4AzoIbY39-AX5IXrc:1wRLpM:ZsJgpWYeVFd_gHO_6kGEauNdrZbJeO-P9MEnuaZgaz4	2026-05-25 03:48:04.993225+00
1kzlj9as3gazmkp1bokn8c7a7j76avaa	.eJxVj0tuAyEQRK8SsY5GDINo8C7ZR8oNUPOxB2cMETSWLMt3D468sLevqp66r8xip9X2FqtNge3YzN6fmUP_E_M9CEfMhzL5kqkmN90r0yNt01cJcft8dF8EK7Z1rJ1yXEtA4aRZnDLeg5s5iL3XTgaxaB7kPoARLhrOPUQTuQKYhVeoIYghJVx7tuOIA1bMwym4UIO32Foq2Zbf8P9C7tv2SjOecPQ_winl1Kgilfr23RvSmG_YyKKndE50YbsZwEi5GM1vf34mXrE:1wQMfM:j9CpfBHSCjs8yFDpCoOksj0IRkztnyTlXtqHcTbKIZ0	2026-05-22 10:29:40.150243+00
k7dxhcd6jx898omhs6g69iyu7lxc6lw8	.eJxVj81OQyEQhV_FsDY3MCXMpTvdm_gGZPhpL3oLhgETY3x3qenCbr9zzpeZb-Fo9M0NTs3lKI5Cicf_zFN4T-UaxDcq57qEWnrLfrlWllvKy0uNaX--de8EG_E21954uWok8NoevLEhoFcS4RRWryMcVhn1KaIFn6yUAZNN0iAqCIZWjDClnbZR3DziTI3KdIIEMzkn5lyLqx_x74Uy9v2eFrrQ7D_FSy6Ze6Ne28PrYOpzvhN3R6Hnz9y_xFEhWq01gvr5BX4TXqs:1wQMrJ:QwqebP4J01OIalX41kRReVu9A1-mMrQiRIdxOXM7hTE	2026-05-22 10:42:01.14361+00
usrocxs6loyvfwgwtg5ww3vg0bx6cln8	.eJxVj0FqAzEMRa9SvC6D7TH2THYJ3ZWewciSE7tJ7DL2FErI3aspWTQLwdfX10O6CQ9rT35tcfGZxE4oLV7_mwHwHMs2oU8opzpgLX3JYdgiw2Paho9K8XJ4ZJ8ACVribUQrwQZrFFIIpKWcKBCqcBwnbjU4N5KeZo1bF0ABuiPNZnQYnHGGoR3SWjwfcYIFCjO11Jb9FlvLtfj6RX8_aPfsFbgCpw9AUF7e48oEFm9c-xY7i7hAYs4FWveAPX_n_iN2yrlZSyvNfP8FiI5hjQ:1wPMll:sYhbZ_edo9NTe2jVPAsH9k_HNyPuLvaDDcuduupmKIQ	2026-05-19 16:24:09.893376+00
8yuo5tkduzfe1vp2pmf6al8doq3vk0hr	.eJxVj0FuAyEMRa9Ssa5GwIzwkF27r9QbIINJhnYCFZhIUdW7l1RZNNv3_3-yv4XDzpvrLVaXSByEEs__mcfwGfMtoA_MpzKFkrkmP90q0z1t01uhuL_euw-CDds21t54uS6A2i929saGAF5J0Mew-oX0vEpajgRW-2ilDBBtlAZA6WBwBdJDyrj17MYRJ6yYh1NLbQZvsbVUsitf9PdC7vv-SDOecfRf6JxyalyRS3167w15zHds7DBwuiS-ioMCsKBmJe3PL34DXqo:1wRUg9:xrbq2r1mwVGziSxh9JiU-8O3YQzL0nZrkL27tW8vBH8	2026-05-25 13:15:09.242332+00
7o8rfr3rhd10c4ds5swelokr1g48jda3	.eJxVj0tuAjEQRK8SeR2NbDO4bXZkj8QNrPYHxsnQjvyJFKHcPQaxgO2rqqfuK7PY22J7jcWmwHZMsPdn5tB_RboF4RPpnCefqZXkpltleqR1OuQQ149H90WwYF3G2inH9Qwo3Ww2ThnvwQkO8uS1m4PcaB7mUwAjXTSce4gmcgUgpFeoIcghbbh0suOIMxak4ZRcqsFrrDVlsvk73F-gvq6vlPCCo78Pl0SptoItl7djr9jGfMXaLPqWflL7ZTsBYBRshRZ__34yXrE:1wRKoP:I-zjztt0ZKw-qAVGOXDflIxnmgkmfJqlf5K44LW9kaM	2026-05-25 02:43:01.836818+00
7dzlzoc08b8m7d9rvuh5df759gyfsc67	.eJxVj9FuAiEQRX-l4bnZsLgyi2_23cQ_IAODLu0KDQNNGtN_Lxof9PXce09mrsJiq4ttHIqNJHZiFO_PzKH_CukW0Cemcx58TrVEN9wqwyPl4ZAprB-P7otgQV762mkn5wlQuclsnDbegxslqJOf3URqM0uaTgRGuWCk9BBMkBpgVF7jDKS6tOLSku1HnLFg6k4lle6cA3PMyeZvur-Q2rq-0oQX7P09XWKKXAvWXN6OjbH2-YpcLfoaf2L9FbsRwGjQBrZ__35cXr0:1wRLHL:0NCRCU8y33CThqxk-wEWXgZinQiwmvADw--oDFMsoBg	2026-05-25 03:12:55.854495+00
8ft5ja5sfhtiylw285ros931ountqdln	.eJxVj0tqAzEQRK8StA6DpmdQS94l-0BuIFofe5SMW0Efgwm5e-TgRbx9VfXo_haWettsr7HYFMRBzOL5P3PkPyPfgvBBfMqTz9xKctOtMt3TOr3lEPfXe_dBsFHdxtopJ_WKBG41i1PGe3SzRDh67dYAi5ZhPQY04KKR0mM0USrEGbwijQGGtNHW2Y4jTlSIhxMkqMFrrDVltvkr_L3Afd8fKdOZRv8lnBOn2gq1XJ7ee6U25jvVZsm3dEntKg4zolF6MQZ-fgF-U166:1wRN6W:Qztp6j3ZKwvH3Bv74IpoGZSijiaii60NyJDJYhspyQE	2026-05-25 05:09:52.590806+00
omvoelv807vywg877sla2wxfv2654j9f	.eJxVj0ESwiAMRe_CWplSoBSX7j0DkwIp1QpOKSvHu0udLuwy77_8Sd7EQFmDKdkvZnLkQhgnp384gH34uCXuDnFM1Ka4LtNAN4Xuaaa35Px83d1DQYAc6rZ1iKgECg26R4mayzp4y5kaOo5cSK-4VFwzx3vWO-ug0cKqTgKyVmItXSGUaOoRIywQa2fbtF3l2ec8pWjSy_1-iGWejzTCE6p_Jp8valJPlg:1wQMLJ:IUJHAgakTx4EQ2NDlaiDksJHBOGS6BHZS6fS69PcjEM	2026-05-22 10:08:57.661494+00
ocrxssnzwhdjah23xxvxdlv1dr8yel80	.eJxVj01qwzAQha9StC7Gkh3Jzq6hu9IziPlRIrWpVCy5EErvnnHIolkMvHnz5mPmV3lYW_RrDYtPrPZKG_X830Sgz5C3CX9APpWOSm5Lwm6LdPdp7d4Lh_Phnn0ARKhRtolsDxbtqIkR2fT9xMik8ThM0hpwbmAzzYa2DkEDuSPP4-AI3ehGgTaIa_ZyxAkWyMI0vbHi11BrKtmXb779YNyjl-ELJH0Ahvz0FlYhiHiVeqmhiQgLROGcoTYP1NJPahe1187Nxu6Gefq7AojGYZk:1wPcD0:F_juafZVuRXVtjJvnzf0Fp5faCceahUclav8z-yow8g	2026-05-20 08:53:18.59738+00
5cshnytd2r0gnna3wxu0id67jnhu6gqv	.eJxVj01qwzAQha9StC7Gkh3Jzq6hu9IziPlRIrWpVCy5EErvnnHIolkMvHnz5mPmV3lYW_RrDYtPrPZKG_X830Sgz5C3CX9APpWOSm5Lwm6LdPdp7d4Lh_Phnn0ARKhRtolsDxbtqIkR2fT9xMik8ThM0hpwbmAzzYa2DkEDuSPP4-AI3ehGgTaIa_ZyxAkWyMI0vbHi11BrKtmXb779YNyjl-ELJH0Ahvz0FlYhiHiVeqmhiQgLROGcoTYP1NJPahe1187NemesHv6uiJRhig:1wP8rt:uRF94BbJ9qE1fJjBC5AMjC3UeO8cncDZje_SIiruVfM	2026-05-19 01:33:33.282471+00
zrqgaro6mmlnnml8p0aov0rqz72n2ewd	.eJxVj01OxDAMha-CskZVk5a6nR0jdogzRP7JTAJDgpoUCSHujotmwSwsPT8_f7K_jcetRb_VsPok5mCsM_f_TUJ-C3mfyCvmc-m45LYm6vZId53W7qVIuByv2RtAxBp1m3nqcaJptCxE4vp-FhK2dBpmbR0CDOLmxfHeEVpkOMkyDsAEI4wKbRi37PWIM66Ylel6N6lfQ62pZF8-5O8HB7dexnfU9BEF891z2JSg4knrsYamIqwYlXPB2jxyS5-pfZmDBVjgYZkt_PwCiPFhnQ:1wRgpV:giWn-vkRlwbYbYP9OaIAKqxnsBplWU-EjZDhSTGR3rc	2026-05-26 02:13:37.821212+00
mx18485z980abf1z3vy8htoo1kru4jyy	.eJxVj0tuAjEQRK8SeR2NPGZwj9mRPRI3sNofGCdDO3LbkSKUu8cgFrB9VfXUfRUWW11s41hsCmInRvH-zBz6r0i3IHwinfPgM9WS3HCrDI-Uh0MOcf14dF8EC_LS1047OU-Ayk1m47TxHtwoQZ387KagNrMM0ymAUS4aKT1EE6UGGJXXOENQXVpxaWT7EWcsSN2ppNKdc2ROmWz-DvcXqK3rKyW8YO_vwyVR4lqw5vJ2bIy1z1fkatHX9JPqr9iNAMZoZfT27x9-VF66:1wSXg5:yOGKwN4K8DjL6EeqZs6wICSoL3FjsnPQ_rNT-Qdna3U	2026-05-28 10:39:25.274949+00
krozz4mkvkjgo9hc68ee4ogs59ystbra	.eJxVj81OQyEQhV_FsDY3XEoY6E73Jr4BmQHai94Ohh8TY3x3qenCbr9zzpeZb-Fx9M2PlqrPURzFKh7_M8LwnvgaxDfkc1lC4V4zLdfKckvb8lJi2p9v3TvBhm2bazIkrQZUpN2BjAsBaJWgTsGSjupgZdSnCE5RclIGSC5JA7CqYNBCVFPacRvs5xFnrMjTqaQyk7fUWi7sy0f8e4HHvt9TxgvO_lO8ZM6tV-ylPryOhn3Od2zdY-j5M_cvcVwBnDNagf35BX5LXrk:1wSY1G:Hs0G-L4O005JLJAFPjOJr2CjNEVWHlAKv-P57rKdGjg	2026-05-28 11:01:18.239032+00
jln88jc2q1iynf87qpnlthfgp1r15uj2	.eJxVj0FuAyEMRa9Ssa5GDIPwkF27r9QbIBtIhnYCFYZIUdW7l1RZNNv3_3-yv4XD3jbXOVaXgjiIWTz_Z4T-M-ZbED4wn8rkS2410XSrTPeUp7cS4v567z4INuRtrMmQXDWgIm0XMtZ7oFmCOvqVdFDLKoM-BrCKopXSQ7RRGoBZeYMrBDWkDbee3TjihBXzcCqpzOAcmVPJrnyFvxdy3_dHmvGMo_8SziknbhVbqU_vnbGN-Y7cHPqWLqldxWEGsAYWo-3PL35AXrg:1wRKPh:hHoe6LAjoohNW-fshF73Jt2odF9yzocz3kt9jKYJI-o	2026-05-25 02:17:29.087741+00
offwche8798hvhzu64evtsu4h5j885k4	.eJxVj8tqwzAQRX-laF2MLBuNlV27L_QPxIykxEqdUdEjEEL-vUrJItmee-9h5iostrraVkK20YudGMX7MyN0P4HvgT8iH9LgEtccabhXhkdahq_kw_b56L4IVixrX5MmucyAimYzkTbOAY0S1N4tNHs1LdLPew9GUTBSOggmSA0wKqdxAa-6tOLa2PYjDpiRu1NJpTsvoZSY2KZf__8Ct217pYwn7P0Pf4ocS81YU377bgVrn29YqkVX4znWi9iNAGbSE2h5-wN-HV6u:1wQ1nU:VvtaXRiAH1RanDIHJUUxDe84DIuOALjE0LDw5BwKO7A	2026-05-21 12:12:40.390012+00
27gqllpf9qt017yky1emep7cx84c38r5	.eJxVj8FqwzAMhl9l-DxC7LhR0tvKbqXPYGTJrb129oidwRh79ymjh_Ug-PXr14f0rRyuLbq1hsUlVnuljXr-b3qka8jbhN8wX0pHJbcl-W6LdPdp7U6Fw-1wzz4AItYo20Rjj6MfrSb2nk3fT-yZtD8Pk7QGAQY202xo6zxqJDjzbAcgDxasQBvGNTs54oILZmGa3ozi11BrKtmVD_77wcCjl_EdJX1Axvx0DKsQRLxKvdTQRIQFo3BuWJtDaukztS-11wCz1Tu9g59fiKBhjw:1wQFAU:SVW76sGKFsQ0TG_1Jepwe-KANe--XqveP_jwQs9lAQs	2026-05-22 02:29:18.133656+00
p62v9yaq8g679utdiuqzwgkk657gezg9	.eJxVj81OQyEQhV_FsDY3XCAMdKd7E9-ADD_tRW_BwNCkMb671HRht98558vMN3M4aHOjp-ZyZAe2suf_zGP4TOUWxA8sp7qEWqhlv9wqyz3ty1uNaX-9dx8EG_Ztrr323ChA4ZWVXtsQwK8cxDEYr6KQhkd1jGCFT5bzAMkmrgFWETQaiGJKCbdR3DzihA3LdAou9OQ99Z5rcfUr_r1Qxr4_0oJnnP2XeM4ld2pItT29j4405zt2chgoXzJd2WEFsFJao-TPL34tXrM:1wPvZj:By6JzBeaB2whcSZOAtkwzr9vPUS3F5k61qwMEFdI_to	2026-05-21 05:34:03.656409+00
uv2btziyg3fgulwy117flvk55blssiye	.eJxVj8tuwyAQRX-lYl1ZeOwyJrt0X6l_gIZHYloHKhgqVVX-PSTKItmee-_RzL8w1Hg1rYZiohc7MYrXR2bJfYd0DfwXpWMeXE5coh2uleGe1uEj-7C937tPgpXq2tdWWbnMSGBnPVmlnUM7SoSDW-zsYVqknw8eNdigpXQYdJAKcQSnaEEPXcq0tmT6EUcqlLoTJKjOa6g15mTyj7-9kNq2PdNEJ-r9vT_FFCsX4lxePlsl7vONKhtyHH8j_4ndiKiVfgOYzhd-NF6w:1wRQ1f:EAKvHyqnVXqSKpHUQZYLcrtyHIbw1dvk7qHqQ7zLtI4	2026-05-25 08:17:03.79311+00
1ga547568in0qyl7cou3c6lb9o6l75ul	.eJxVj8FqwzAMhl9l-DxC7AQr6a1lt7FnMLLk1l5be8TOYJS--5TRw3oQ_Pr160O6KYdri26tYXGJ1U5po17_mx7pHPI24U_Mp9JRyW1Jvtsi3WNau4_C4XJ4ZJ8AEWuUbSLbo_V21MTes-n7iT2T9sdhktYgwMBmmg1tnUeNBEeexwHIwwijQBvGNTs54oQLZmGa3ljxa6g1lezKF__9YODZy3hFSR-QMb-8h1UIIt6k9jU0EWHBKJwL1uaQWvpO7UftNMCsLRht77-IqWGP:1wPCfQ:Ga-zdafHzGe29QAQq5j4GiYaoLWXxULwu-k6tgTzEnM	2026-05-19 05:36:56.310632+00
fb5yeddtz3vqq5f382hn16qcqmztt5b6	.eJxVj8FOwzAMhl8F5YyqJK3qdDcmbohniBw7WwJbgpoUCSHeHRftwA6Wfv_-_cn-Vh63nvzW4uozq4MyVj3-NwPSeyz7hN-wnOtAtfQ1h2GPDLdpG14rx8vxlr0DJGxJtolmjXOYJ0McAlutHQcmE06jk9YiwMjWLZb2LqBBghMv0wgUYIJJoB3TVrwcccYVizCttrP4LbaWa_H1g_9-sHDvFbyipI_IWB5e4iYEEc9STy12EXHFJJwLtu6Rev7M_UsdDMBiwIHTP7-I0WGX:1wPFfw:FwWSNf08w_8fXJ8NuByRhNqq1lRS_ZAKwlQp33AfGhA	2026-05-19 08:49:40.917531+00
s1lmx2munyq0w8gvbn2bp4hl7trxr3p5	.eJxVj0tuAjEQRK8SeR2N7Ma4x-zIHokbWO0PjJPBjvyJFKHcPQaxgO2rqqfuKzPU22J6DcVEz3ZMsPdnZsl9hXQL_Celc55cTq1EO90q0yOt0yH7sH48ui-Cheoy1lZZPksksFJvrNLOoRUc4eRmKz1sZu7lyaMGGzTnDoMOXCEKcIpm9DCkjZaezDjiTIXScAIHNXgNtcacTP729xdSX9dXmuhCo7_3l5hibYVaLm_HXqmN-Uq1GXIt_sT2y3YCUUtA2Iq_f34LXqo:1wQIJY:F-rykLeEVvX-K9Y4VBISPB6PhVqU3-c4yxkbef0rh98	2026-05-22 05:50:52.004875+00
3v1zn5hxy4wjkp3ryy18ek7zj2gf4t8y	.eJxVj8FOwzAMhl8F5YyqJo3qZjcmbohniBw7WwJbgpoUCSHeHRftwA6Wfv_-_cn-Vh63nvzW4uozq4PSRj3-NwPSeyz7hN-wnOtAtfQ1h2GPDLdpG14rx8vxlr0DJGxJtonmEecwW00cAptxXDgw6XCaFmkNAkxsFmdo7wJqJDixsxNQAAtWoB3TVrwcccYVizDNaGbxW2wt1-LrB__9YODeK3hFSR-RsTy8xE0IIp6lnlrsIuKKSTgXbN0j9fyZ-5c6aACnwTltf34BiNFhlw:1wPFyE:NKEGHXqkoJbTYu4TIA4kuqQgYvEx40UZYdJ_GeKERrc	2026-05-19 09:08:34.510137+00
\.


--
-- Data for Name: menus_menu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menus_menu (id, nama, icon, urutan) FROM stdin;
1	Umum	ti-settings	2
3	Peraturan	ti-shield-lock	1
2	Admin	ti-settings-automation	0
4	Perjalanan Dinas	ti-settings	3
5	SPJ	ti ti-receipt	40
\.


--
-- Data for Name: menus_rolepermission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menus_rolepermission (id, can_view, can_add, can_edit, can_delete, role_id, submenu_id) FROM stdin;
29	t	f	f	f	1	21
30	t	f	f	f	1	22
33	f	f	f	f	2	8
32	f	f	f	f	2	13
31	t	f	f	f	2	24
4	t	f	t	f	2	1
6	f	f	f	f	2	3
34	f	f	f	f	2	14
5	f	f	f	f	2	2
35	t	f	f	f	2	26
56	t	t	t	t	2	28
36	f	f	f	f	2	7
38	f	f	f	f	2	6
37	f	f	f	f	2	12
39	f	f	f	f	2	15
40	f	f	f	f	2	4
41	f	f	f	f	2	9
43	f	f	f	f	2	5
42	f	f	f	f	2	10
44	f	f	f	f	2	20
45	f	f	f	f	2	16
46	f	f	f	f	2	11
47	f	f	f	f	2	23
48	f	f	f	f	2	17
50	f	f	f	f	2	25
49	f	f	f	f	2	18
52	f	f	f	f	2	27
51	f	f	f	f	2	19
53	f	f	f	f	2	21
54	f	f	f	f	2	22
57	t	t	t	t	1	29
58	t	t	t	t	1	30
59	t	t	t	t	1	31
60	t	t	t	t	1	32
61	t	t	t	t	1	33
62	t	t	t	t	1	34
63	t	t	t	f	1	35
64	t	t	t	t	2	29
65	t	t	t	t	2	30
66	t	t	t	t	2	31
67	t	t	t	t	2	32
68	t	t	t	t	2	33
69	t	t	t	t	2	34
70	t	t	t	f	2	35
9	t	t	t	f	1	8
8	t	f	f	f	1	13
7	t	t	t	t	1	24
1	t	t	t	t	1	1
3	f	f	f	f	1	3
10	t	f	f	f	1	14
2	t	t	t	t	1	2
11	t	t	t	t	1	26
55	t	t	t	t	1	28
12	f	f	f	f	1	7
14	t	f	f	f	1	6
13	t	f	f	f	1	12
15	t	f	f	f	1	15
16	f	f	f	f	1	4
17	t	f	f	f	1	9
19	f	f	f	f	1	5
18	t	f	f	f	1	10
20	t	f	f	f	1	20
21	t	f	f	f	1	16
22	t	f	f	f	1	11
23	t	f	f	f	1	23
24	t	f	f	f	1	17
26	t	t	t	t	1	25
25	t	f	f	f	1	18
28	t	t	t	t	1	27
27	t	f	f	f	1	19
\.


--
-- Data for Name: menus_submenu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menus_submenu (id, nama, url, urutan, menu_id) FROM stdin;
3	Role	permission_page	1	2
8	User Profile	userprofile_list	0	2
7	Hak Akses	role_list	2	2
6	OPD	opd_list	2	1
9	Pangkat	pangkat_list	3	1
10	Jenis Jabatan	jenis_jabatan_list	4	1
4	Menu	menu_list	3	2
5	Sub Menu	submenu_list	4	2
11	Status ASN	status_asn_list	5	1
13	Peraturan	dasar_peraturan_list	0	3
12	Tingkat SPD	tingkat_list	2	3
14	Jenis SPD	jenis_spd_list	1	3
15	Jenis Kegiatan	jenis_kegiatan_list	3	3
21	Transport	standard_transportasi_list	9	3
22	Uang Representasi	standard_representasi_list	10	3
20	Jenis Transport	jenis_transportasi_list	4	3
16	Lokasi	lokasi_kegiatan_list	5	3
17	Penginapan	standard_penginapan_list	6	3
18	Pesawat	standard_pesawat_list	7	3
19	Uang Harian	standard_uang_harian_list	8	3
23	Eselon	eselon_list	6	1
25	Identitas Pemda	pemda_list	7	1
27	Kop Surat	kop_surat_list	8	1
2	Pejabat Penandatangan	penandatangan_list	1	1
1	Data Pegawai	pegawai_list	0	1
24	SPT	spt_list	0	4
26	Penandatangan/ Cetak	pemberi_tugas_list	1	4
28	Berkas PDF	ttd_spt_spd_list	2	4
29	Jenis SPJ	jenis_spj_list	1	5
30	Penginapan	penginapan_list	2	5
31	Pesawat	pesawat_list	3	5
32	Uang Harian	uang_harian_list	4	5
33	Transport	transport_list	5	5
34	Uang Representasi	uang_representasi_list	6	5
35	Laporan SPJ	spj_report	7	5
\.


--
-- Data for Name: perintah_pelaksana; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.perintah_pelaksana (id, nama_id, spt_id) FROM stdin;
25	3	8
26	25	8
27	22	9
28	25	9
29	26	9
30	35	9
37	48	8
42	25	13
45	48	16
46	51	16
47	52	16
48	48	17
50	52	17
51	10	18
52	34	18
53	41	18
\.


--
-- Data for Name: perintah_pemberitugas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.perintah_pemberitugas (id, nama, nip, pangkat, tugas, jenis_jabatan, opd, penandatangan_id, spt_id, nomor_spt, tanggal_spt, nomor_spd, nomor_urut) FROM stdin;
14	Sri Lusi Masdiany, S.I.P.	197305071992032001	Pembina Tk.  I	Kepala	Plt.	Badan Keuangan Dan Aset Daerah	3	8		2026-05-06		
15	Sri Lusi Masdiany, S.I.P.	197305071992032001	Pembina Tk.  I	Kepala	Plt.	Badan Keuangan Dan Aset Daerah	3	9	0446	2026-05-06	055	
19	Sri Lusi Masdiany, S.I.P.	197305071992032001	Pembina Tk.  I	Kepala	Plt.	Badan Keuangan Dan Aset Daerah	3	13	0467	2026-05-18	060	
21	Sri Lusi Masdiany, S.I.P.	197305071992032001	Pembina Tk.  I	Kepala	Plt.	Badan Keuangan Dan Aset Daerah	3	16	0481	2026-05-21	062	
23	Sri Lusi Masdiany, S.I.P.	197305071992032001	Pembina Tk.  I	Kepala	Plt.	Badan Keuangan Dan Aset Daerah	3	17	0482	2026-05-21	063	
24	Zainal Aripin Sinaga	196703071993031010	Pembina Utama Muda	Sekretaris Daerah	Defenitif	Sekretariat Daerah	6	16		2026-05-21		
25	Zainal Aripin Sinaga	196703071993031010	Pembina Utama Muda	Sekretaris Daerah	Defenitif	Sekretariat Daerah	6	17		2026-05-21		
17	Zainal Aripin Sinaga	196703071993031010	Pembina Utama Muda	Sekretaris Daerah	Defenitif	Sekretariat Daerah	6	8		2026-05-06		
26	Sri Lusi Masdiany, S.I.P.	197305071992032001	Pembina Tk.  I	Kepala	Plt.	Badan Keuangan Dan Aset Daerah	3	18		\N		
\.


--
-- Data for Name: perintah_spt; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.perintah_spt (id, dasar, berita, lama_perjalanan, tgl_berangkat, tgl_kembali, kendaraan, jenis_kegiatan_id, kota_tujuan_id, tempat_tujuan) FROM stdin;
9		Menyampaikan Nota Kredit Pengembalian Temuan BPK - RI atas Pemeriksaan LKPD Pemerintah Kabupaten Asahan Tahun Angaran 2025	2	2026-05-07	2026-05-08	transport_umum	1	65	BPK RI Perwakilan Provinsi Sumatera Utara
8	Surat Kepala KPPN Tanjungbalai No. S-291/KPN.0206/2026 Tanggal 30 April 2026 Hal : Press Release Kinerja APBN, Evaluasi Pelaksana Anggaran, Forum Konsultasi Publik dan KPPN Tanjungbalai Award Semester II Tahun 2025	Menghadiri Acara Sosialisasi Anti Gratifikasi, Press Release Kinerja APBN s.d April 2026, Evaluasi Pelaksana Anggaran s.d April 2026, Forum Konsultasi Publik/ Stakeholders Day dan KPPN Tanjungbalai Award atas Kinerja Semester II Tahun 2025	1	2026-05-06	2026-05-06	kendaraan_dinas	2	69	Aula KPPN Tanjungbalai Jl. Jenderal Sudirman No. 101
13		Revisi Laporan Keuangan Pemerintah Daerah (LKPD) Kabupaten Asahan Tahun Anggaran 2025	5	2026-05-18	2026-05-22	transport_umum	1	65	Kantor Badan Pemeriksa Keuangan (BPK) RI Perwakilan Provinsi Sumatera Utara
16	Surat Dewan Perwakilan Rakyat Daerah Kabupaten Asahan Nomor : 00.1.5/0797/KEU-DPRD/V/2026, Tanggal 18 Mei 2026 Hal Undangan	Menghadiri Undangan Rapat Penyusunan Program Kerja DPRD Tahun 2027	3	2026-05-22	2026-05-24	kendaraan_dinas	1	65	Hotel Grand Mercure Medan Angkasa Jalan Sutomo No. 1
17		Koreksi atas Laporan Keuangan (LKPD) Kabupaten Asahan dan Penyerahan Opini atas Laporan Hasil Pemeriksaan (LHP) BPK RI Pemerintah Kabupaten Asahan Tahun Anggaran 2025	3	2026-05-24	2026-05-26		1	65	Badan Pemeriksa Keuangan (BPK) RI Perwakilan Sumatera Utara
18		Koreksi atas Laporan Keuangan (LKPD) Kabupaten Asahan dan Penyerahan Opini atas Laporan Hasil Pemeriksaan (LHP) BPK RI Pemerintah Kabupaten Asahan Tahun Anggaran 2025	2	2026-05-25	2026-05-26	transport_umum	1	2	Kantor BPK-RI Perwakilan Provsu
\.


--
-- Data for Name: perintah_spt_kota_tujuan_tambahan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.perintah_spt_kota_tujuan_tambahan (id, spt_id, lokasi_id) FROM stdin;
\.


--
-- Data for Name: perintah_ttdsptspd; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.perintah_ttdsptspd (id, hardcopy, pemberi_tugas_id) FROM stdin;
1		23
3		21
4		24
6		15
7		17
8		14
9		25
5	hardcopy/ST_tgl._18-22_mei_2026.pdf	19
10		26
\.


--
-- Data for Name: profiles_opd; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.profiles_opd (id, nama) FROM stdin;
1	Dinas Pendidikan
2	Dinas Kesehatan
3	UPTD Rumah Sakit Umum Daerah H. Abdul Manan Simatupang
4	Dinas Pekerjaan Umum Dan Tata Ruang
5	Dinas Perumahan Dan Kawasan Permukiman
6	Badan Penanggulangan Bencana Daerah
7	Satuan Polisi Pamong Praja
8	Dinas Sosial
9	Dinas Ketenagakerjaan
10	Dinas Ketahanan Pangan
11	Dinas Lingkungan Hidup
12	Dinas Kependudukan Dan Pencatatan Sipil
13	Dinas Pemberdayaan Masyarakat Dan Desa
14	Dinas Pengendalian Penduduk, Keluarga Berencana, Pemberdayaan Perempuan Dan Perlindungan Anak
15	Dinas Perhubungan
16	Dinas Komunikasi Dan Informatika
17	Dinas Koperasi, Perdagangan Dan Perindustrian
18	Dinas Penanaman Modal Dan Pelayanan Terpadu Satu Pintu
19	Dinas Pemuda, Olahraga Dan Pariwisata
20	Dinas Perpustakaan Dan Arsip
21	Dinas Perikanan
22	Dinas Pertanian
23	Dinas Peternakan Dan Kesehatan Hewan
24	Sekretariat Daerah
25	Sekretariat DPRD
26	Badan Perencanaan Pembangunan Riset dan Inovasi Daerah
27	Badan Keuangan Dan Aset Daerah
28	Badan Pendapatan Daerah
29	Badan Kepegawaian Dan Pengembangan Sumber Daya Manusia
30	Inspektorat
31	Badan Kesatuan Bangsa Dan Politik
32	Kecamatan Aek Kuasan
33	Kecamatan Aek Ledong
34	Kecamatan Aek Songsongan
35	Kecamatan Air Batu
36	Kecamatan Air Joman
37	Kecamatan Bandar Pulau
38	Kecamatan Bandar Pasir Mandoge
39	Kecamatan Buntu Pane
40	Kecamatan Kota Kisaran Barat
41	Kecamatan Kota Kisaran Timur
42	Kecamatan Meranti
43	Kecamatan Pulau Rakyat
44	Kecamatan Pulo Bandring
45	Kecamatan Rahuning
46	Kecamatan Rawang Panca Arga
47	Kecamatan Sei Dadap
48	Kecamatan Sei Kepayang
49	Kecamatan Sei Kepayang Barat
50	Kecamatan Sei Kepayang Timur
51	Kecamatan Setia Janji
52	Kecamatan Silau Laut
53	Kecamatan Simpang Empat
54	Kecamatan Tanjung Balai
55	Kecamatan Teluk Dalam
56	Kecamatan Tinggi Raja
57	Bupati Asahan
58	Wakil Bupati Asahan
\.


--
-- Data for Name: profiles_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.profiles_role (id, nama) FROM stdin;
1	Administrator
2	Pengguna
\.


--
-- Data for Name: profiles_userprofile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.profiles_userprofile (id, opd_id, role_id, user_id, foto) FROM stdin;
2	27	2	9	\N
5	27	1	12	\N
6	27	2	13	\N
\.


--
-- Data for Name: spd_dasarperaturan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_dasarperaturan (id, nama_peraturan, nomor_peraturan, tanggal_peraturan, keterangan, aktif, created_at, updated_at) FROM stdin;
1	Peraturan Bupati Asahan	4 Tahun 2026	2026-12-02	Perjalanan Dinas dalam Negeri Bagi Pejabat Negara, Pejabat Daerah, Aparatur Sipil Negara, dan Pihak Lain	t	2026-04-23 09:39:46.786136+00	2026-04-23 09:40:50.42632+00
\.


--
-- Data for Name: spd_jeniskegiatan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_jeniskegiatan (id, nama) FROM stdin;
3	Diklat
4	Fullboard
5	Fullday/ Halfday di dalam kota
6	Residence di dalam kota
2	Konsultasi/ Koordinasi/ Kunjungan Dalam Kabupaten
1	Konsultasi/ Koordinasi/ Kunjungan Luar Kabupaten
\.


--
-- Data for Name: spd_jenisspd; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_jenisspd (id, nama) FROM stdin;
1	Luar Daerah Luar Provinsi
2	Luar Daerah Dalam Provinsi
3	Dalam Daerah
\.


--
-- Data for Name: spd_jenistransportasi; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_jenistransportasi (id, nama) FROM stdin;
1	Taksi
2	Transportasi Darat
3	Sewa Kendaraan
\.


--
-- Data for Name: spd_lokasi; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_lokasi (id, lokasi, jenis_spd_id, kota) FROM stdin;
1	Aceh	1	Banda Aceh
2	Sumatera Utara	1	Medan
3	Riau	1	Pekanbaru
4	Kepulauan Riau	1	Tanjungpinang
5	Jambi	1	Jambi
6	Sumatera Barat	1	Padang
7	Sumatera Selatan	1	Palembang
8	Lampung	1	Bandar Lampung
9	Bengkulu	1	Bengkulu
10	Bangka Belitung	1	Pangkalpinang
11	Banten	1	Serang
12	Jawa Barat	1	Bandung
13	D.K.I Jakarta	1	Jakarta
14	Jawa Tengah	1	Semarang
15	D.I. Yogyakarta	1	Yogyakarta
16	Jawa Timur	1	Surabaya
17	Bali	1	Denpasar
18	Nusa Tenggara Barat	1	Mataram
19	Nusa Tenggara Timur	1	Kupang
20	Kalimantan Barat	1	Pontianak
21	Kalimantan Tengah	1	Palangka Raya
22	Kalimantan Selatan	1	Banjarbaru
23	Kalimantan Timur	1	Samarinda
24	Kalimantan Utara	1	Tanjung Selor
25	Sulawesi Utara	1	Manado
26	Gorontalo	1	Gorontalo
27	Sulawesi Barat	1	Mamuju
28	Sulawesi Selatan	1	Makassar
29	Sulawesi Tengah	1	Palu
30	Sulawesi Tenggara	1	Kendari
31	Maluku	1	Ambon
32	Maluku Utara	1	Sofifi
33	Papua	1	Jayapura
34	Papua Barat	1	Manokwari
35	Papua Barat Daya	1	Sorong
36	Papua Tengah	1	Nabire
37	Papua Selatan	1	Merauke
38	Papua Pegunungan	1	Jayawijaya
39	Kabupaten Batubara	2	Limapuluh
40	Kabupaten Dairi	2	Sidikalang
41	Kabupaten Deli Serdang	2	Lubuk Pakam
42	Kabupaten Humbang Hasundutan	2	Dolok Sanggul
43	Kabupaten Karo	2	Kabanjahe
44	Kabupaten Labuhan Batu	2	Rantau Prapat
45	Kabupaten Labuhan Batu Selatan	2	Kota Pinang
46	Kabupaten Labuhan Batu Utara	2	Aek Kanopan
47	Kabupaten Langkat	2	Stabat
48	Kabupaten Mandailing Natal	2	Panyabungan
49	Kabupaten Nias	2	Gido
50	Kabupaten Nias Barat	2	Lahomi
51	Kabupaten Nias Selatan	2	Teluk Dalam
52	Kabupaten Nias Utara	2	Lotu
53	Kabupaten Padang Lawas	2	Sibuhuan
54	Kabupaten Padang Lawas Utara	2	Gunung Tua
55	Kabupaten Pakpak Barat	2	Salak
56	Kabupaten Samosir	2	Pangururan
57	Kabupaten Serdang Bedagai	2	Sei Rampah
58	Kabupaten Simalungun	2	Raya
59	Kabupaten Tapanuli Selatan	2	Sipirok
60	Kabupaten Tapanuli Tengah	2	Pandan
61	Kabupaten Tapanuli Utara	2	Tarutung
62	Kabupaten Toba Samosir	2	Balige
63	Kota Binjai	2	Binjai
64	Kota Gunung Sitoli	2	Gunung Sitoli
65	Kota Medan	2	Medan
66	Kota Padangsidimpuan	2	Padangsidempuan
67	Kota Pematang Siantar	2	Siantar
68	Kota Sibolga	2	Sibolga
69	Kota Tanjung Balai	2	Tanjung Balai
70	Kota Tebing Tinggi	2	Tebing Tinggi
71	Kecamatan Meranti	3	Meranti
72	Kecamatan Pulo Bandring	3	Pulo Bandring
73	Kecamatan Air Joman	3	Air Joman
74	Kecamatan Sei Dadap	3	Sei Dadap
75	Kecamatan Rawang Panca Arga	3	Rawang Panca Arga
76	Kecamatan  Tanjung Balai	3	Tanjung Balai
77	Kecamatan Buntu Pane	3	Buntu Pane
78	Kecamatan Setia Janji	3	Setia Janji
79	Kecamatan Tinggi Raja	3	Tinggi Raja
80	Kecamatan Silau Laut	3	Silau Laut
81	Kecamatan Simpang Empat	3	Simpang Empat
82	Kecamatan Air Batu	3	Air Batu
83	Kecamatan Teluk Dalam	3	Teluk Dalam
84	Kecamatan Bandar Pasir Mandoge	3	Bandar Pasir Mandoge
85	Kecamatan Bandar Pulau	3	Bandar Pulau
86	Kecamatan Aek Kuasan	3	Aek Kuasan
87	Kecamatan Aek Ledong	3	Aek Ledong
88	Kecamatan Aek Songsongan	3	Aek Songsongan
89	Kecamatan Rahuning	3	Rahuning
90	Kecamatan Pulau Rakyat	3	Pulau Rakyat
91	Kecamatan Sei Kepayang	3	Sei Kepayang
92	Kecamatan Sei Kepayang Barat	3	Sei Kepayang Barat
93	Kecamatan Sei Kepayang Timur	3	Sei Kepayang Timur
\.


--
-- Data for Name: spd_standardpenginapan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_standardpenginapan (id, created_at, updated_at, biaya, dasar_peraturan_id, lokasi_id, tingkat_id, satuan) FROM stdin;
2	2026-04-24 09:05:04.480508+00	2026-04-24 09:05:04.480534+00	4420000.00	1	1	1	OH
3	2026-04-24 09:05:04.525999+00	2026-04-24 09:05:04.526034+00	4960000.00	1	2	1	OH
4	2026-04-24 09:05:04.543703+00	2026-04-24 09:05:04.543743+00	3820000.00	1	3	1	OH
5	2026-04-24 09:05:04.563362+00	2026-04-24 09:05:04.563396+00	5344000.00	1	4	1	OH
6	2026-04-24 09:05:04.577413+00	2026-04-24 09:05:04.577452+00	5000000.00	1	5	1	OH
7	2026-04-24 09:05:04.59577+00	2026-04-24 09:05:04.595813+00	5236000.00	1	6	1	OH
8	2026-04-24 09:05:04.612324+00	2026-04-24 09:05:04.612371+00	5850000.00	1	7	1	OH
9	2026-04-24 09:05:04.628774+00	2026-04-24 09:05:04.628812+00	4491000.00	1	8	1	OH
10	2026-04-24 09:05:04.644095+00	2026-04-24 09:05:04.644135+00	2140000.00	1	9	1	OH
11	2026-04-24 09:05:04.661054+00	2026-04-24 09:05:04.661091+00	3827000.00	1	10	1	OH
12	2026-04-24 09:05:04.678279+00	2026-04-24 09:05:04.678368+00	5725000.00	1	11	1	OH
13	2026-04-24 09:05:04.697792+00	2026-04-24 09:05:04.697857+00	5381000.00	1	12	1	OH
14	2026-04-24 09:05:04.72052+00	2026-04-24 09:05:04.720563+00	8720000.00	1	13	1	OH
15	2026-04-24 09:05:04.736994+00	2026-04-24 09:05:04.737036+00	5303000.00	1	14	1	OH
16	2026-04-24 09:05:04.753577+00	2026-04-24 09:05:04.753618+00	5017000.00	1	15	1	OH
17	2026-04-24 09:05:04.770066+00	2026-04-24 09:05:04.770108+00	4449000.00	1	16	1	OH
18	2026-04-24 09:05:04.787336+00	2026-04-24 09:05:04.78738+00	6848000.00	1	17	1	OH
19	2026-04-24 09:05:04.80271+00	2026-04-24 09:05:04.802751+00	4375000.00	1	18	1	OH
20	2026-04-24 09:05:04.820366+00	2026-04-24 09:05:04.82041+00	3750000.00	1	19	1	OH
21	2026-04-24 09:05:04.83775+00	2026-04-24 09:05:04.837799+00	2654000.00	1	20	1	OH
22	2026-04-24 09:05:04.854601+00	2026-04-24 09:05:04.854643+00	4901000.00	1	21	1	OH
23	2026-04-24 09:05:04.870809+00	2026-04-24 09:05:04.87085+00	4797000.00	1	22	1	OH
24	2026-04-24 09:05:04.887688+00	2026-04-24 09:05:04.88773+00	4000000.00	1	23	1	OH
25	2026-04-24 09:05:04.904725+00	2026-04-24 09:05:04.904766+00	4000000.00	1	24	1	OH
26	2026-04-24 09:05:04.920815+00	2026-04-24 09:05:04.920856+00	4919000.00	1	25	1	OH
27	2026-04-24 09:05:04.937793+00	2026-04-24 09:05:04.937837+00	4168000.00	1	26	1	OH
28	2026-04-24 09:05:04.953773+00	2026-04-24 09:05:04.953819+00	4076000.00	1	27	1	OH
29	2026-04-24 09:05:04.970465+00	2026-04-24 09:05:04.97051+00	4820000.00	1	28	1	OH
30	2026-04-24 09:05:04.987107+00	2026-04-24 09:05:04.987149+00	2309000.00	1	29	1	OH
31	2026-04-24 09:05:05.003663+00	2026-04-24 09:05:05.003704+00	3088800.00	1	30	1	OH
32	2026-04-24 09:05:05.020933+00	2026-04-24 09:05:05.020975+00	3467000.00	1	31	1	OH
33	2026-04-24 09:05:05.037205+00	2026-04-24 09:05:05.037247+00	4611600.00	1	32	1	OH
34	2026-04-24 09:05:05.053637+00	2026-04-24 09:05:05.053679+00	3859000.00	1	33	1	OH
35	2026-04-24 09:05:05.070433+00	2026-04-24 09:05:05.070476+00	3872000.00	1	34	1	OH
36	2026-04-24 09:05:05.087611+00	2026-04-24 09:05:05.087678+00	3872000.00	1	35	1	OH
37	2026-04-24 09:05:05.103346+00	2026-04-24 09:05:05.103392+00	3859000.00	1	36	1	OH
38	2026-04-24 09:05:05.120436+00	2026-04-24 09:05:05.120478+00	5673000.00	1	37	1	OH
39	2026-04-24 09:05:05.137114+00	2026-04-24 09:05:05.137156+00	5711000.00	1	38	1	OH
40	2026-04-24 09:05:05.153994+00	2026-04-24 09:05:05.154035+00	3526000.00	1	1	2	OH
41	2026-04-24 09:05:05.174228+00	2026-04-24 09:05:05.174257+00	2195000.00	1	2	2	OH
42	2026-04-24 09:05:05.19081+00	2026-04-24 09:05:05.190842+00	3119000.00	1	3	2	OH
43	2026-04-24 09:05:05.206109+00	2026-04-24 09:05:05.206129+00	2318000.00	1	4	2	OH
44	2026-04-24 09:05:05.214034+00	2026-04-24 09:05:05.214054+00	4102000.00	1	5	2	OH
45	2026-04-24 09:05:05.221973+00	2026-04-24 09:05:05.221992+00	3332000.00	1	6	2	OH
46	2026-04-24 09:05:05.230154+00	2026-04-24 09:05:05.230173+00	3083000.00	1	7	2	OH
47	2026-04-24 09:05:05.241298+00	2026-04-24 09:05:05.24135+00	2488000.00	1	8	2	OH
48	2026-04-24 09:05:05.257294+00	2026-04-24 09:05:05.257339+00	1628000.00	1	9	2	OH
49	2026-04-24 09:05:05.274026+00	2026-04-24 09:05:05.274052+00	2838000.00	1	10	2	OH
50	2026-04-24 09:05:05.290708+00	2026-04-24 09:05:05.290729+00	2373000.00	1	11	2	OH
51	2026-04-24 09:05:05.305769+00	2026-04-24 09:05:05.305789+00	2755000.00	1	12	2	OH
52	2026-04-24 09:05:05.314479+00	2026-04-24 09:05:05.3145+00	2063000.00	1	13	2	OH
53	2026-04-24 09:05:05.324775+00	2026-04-24 09:05:05.324796+00	1850000.00	1	14	2	OH
54	2026-04-24 09:05:05.394687+00	2026-04-24 09:05:05.394728+00	2695000.00	1	15	2	OH
55	2026-04-24 09:05:05.411694+00	2026-04-24 09:05:05.411737+00	2007000.00	1	16	2	OH
56	2026-04-24 09:05:05.428032+00	2026-04-24 09:05:05.428074+00	2433000.00	1	17	2	OH
57	2026-04-24 09:05:05.44523+00	2026-04-24 09:05:05.445273+00	2648000.00	1	18	2	OH
58	2026-04-24 09:05:05.465721+00	2026-04-24 09:05:05.46578+00	2133000.00	1	19	2	OH
59	2026-04-24 09:05:05.487501+00	2026-04-24 09:05:05.487543+00	1923000.00	1	20	2	OH
60	2026-04-24 09:05:05.503584+00	2026-04-24 09:05:05.503626+00	3391000.00	1	21	2	OH
61	2026-04-24 09:05:05.520597+00	2026-04-24 09:05:05.520638+00	3316000.00	1	22	2	OH
62	2026-04-24 09:05:05.536213+00	2026-04-24 09:05:05.536256+00	2188000.00	1	23	2	OH
63	2026-04-24 09:05:05.552631+00	2026-04-24 09:05:05.552672+00	2735000.00	1	24	2	OH
64	2026-04-24 09:05:05.601227+00	2026-04-24 09:05:05.601268+00	2290000.00	1	25	2	OH
65	2026-04-24 09:05:05.629338+00	2026-04-24 09:05:05.629381+00	3107000.00	1	26	2	OH
66	2026-04-24 09:05:05.645898+00	2026-04-24 09:05:05.64594+00	3098000.00	1	27	2	OH
67	2026-04-24 09:05:05.661348+00	2026-04-24 09:05:05.661391+00	1938000.00	1	28	2	OH
68	2026-04-24 09:05:05.678625+00	2026-04-24 09:05:05.678667+00	2027000.00	1	29	2	OH
69	2026-04-24 09:05:05.696827+00	2026-04-24 09:05:05.696871+00	2574000.00	1	30	2	OH
70	2026-04-24 09:05:05.71119+00	2026-04-24 09:05:05.711233+00	3240000.00	1	31	2	OH
71	2026-04-24 09:05:05.727878+00	2026-04-24 09:05:05.727919+00	3843000.00	1	32	2	OH
72	2026-04-24 09:05:05.745243+00	2026-04-24 09:05:05.745286+00	3318000.00	1	33	2	OH
73	2026-04-24 09:05:05.762142+00	2026-04-24 09:05:05.762183+00	3341000.00	1	34	2	OH
74	2026-04-24 09:05:05.778887+00	2026-04-24 09:05:05.778931+00	3341000.00	1	35	2	OH
75	2026-04-24 09:05:05.795979+00	2026-04-24 09:05:05.796022+00	3318000.00	1	36	2	OH
76	2026-04-24 09:05:05.812486+00	2026-04-24 09:05:05.812528+00	4877000.00	1	37	2	OH
77	2026-04-24 09:05:05.829194+00	2026-04-24 09:05:05.829235+00	4911000.00	1	38	2	OH
78	2026-04-24 09:05:05.846342+00	2026-04-24 09:05:05.846387+00	1533000.00	1	1	3	OH
79	2026-04-24 09:05:05.861196+00	2026-04-24 09:05:05.861238+00	1100000.00	1	2	3	OH
80	2026-04-24 09:05:05.87815+00	2026-04-24 09:05:05.878191+00	1650000.00	1	3	3	OH
81	2026-04-24 09:05:05.897416+00	2026-04-24 09:05:05.897459+00	1297000.00	1	4	3	OH
82	2026-04-24 09:05:05.921152+00	2026-04-24 09:05:05.921194+00	1225000.00	1	5	3	OH
83	2026-04-24 09:05:05.938237+00	2026-04-24 09:05:05.938279+00	1353000.00	1	6	3	OH
84	2026-04-24 09:05:05.954194+00	2026-04-24 09:05:05.954236+00	1955000.00	1	7	3	OH
85	2026-04-24 09:05:05.971214+00	2026-04-24 09:05:05.971257+00	1425000.00	1	8	3	OH
86	2026-04-24 09:05:05.987722+00	2026-04-24 09:05:05.987766+00	1546000.00	1	9	3	OH
87	2026-04-24 09:05:06.004362+00	2026-04-24 09:05:06.004406+00	1957000.00	1	10	3	OH
88	2026-04-24 09:05:06.021018+00	2026-04-24 09:05:06.021067+00	1204000.00	1	11	3	OH
89	2026-04-24 09:05:06.036652+00	2026-04-24 09:05:06.036694+00	1201000.00	1	12	3	OH
90	2026-04-24 09:05:06.054188+00	2026-04-24 09:05:06.054232+00	992000.00	1	13	3	OH
91	2026-04-24 09:05:06.071285+00	2026-04-24 09:05:06.071377+00	1201000.00	1	14	3	OH
92	2026-04-24 09:05:06.087905+00	2026-04-24 09:05:06.087948+00	1384000.00	1	15	3	OH
93	2026-04-24 09:05:06.103221+00	2026-04-24 09:05:06.103263+00	1153000.00	1	16	3	OH
94	2026-04-24 09:05:06.119731+00	2026-04-24 09:05:06.119773+00	1685000.00	1	17	3	OH
95	2026-04-24 09:05:06.136663+00	2026-04-24 09:05:06.136705+00	1418000.00	1	18	3	OH
96	2026-04-24 09:05:06.154279+00	2026-04-24 09:05:06.154363+00	1355000.00	1	19	3	OH
97	2026-04-24 09:05:06.170613+00	2026-04-24 09:05:06.170656+00	1125000.00	1	20	3	OH
98	2026-04-24 09:05:06.187441+00	2026-04-24 09:05:06.187485+00	1160000.00	1	21	3	OH
99	2026-04-24 09:05:06.204207+00	2026-04-24 09:05:06.204249+00	1500000.00	1	22	3	OH
100	2026-04-24 09:05:06.220882+00	2026-04-24 09:05:06.220922+00	1507000.00	1	23	3	OH
101	2026-04-24 09:05:06.237463+00	2026-04-24 09:05:06.237505+00	1507000.00	1	24	3	OH
102	2026-04-24 09:05:06.253247+00	2026-04-24 09:05:06.253289+00	1207000.00	1	25	3	OH
103	2026-04-24 09:05:06.26996+00	2026-04-24 09:05:06.270003+00	1606000.00	1	26	3	OH
104	2026-04-24 09:05:06.286805+00	2026-04-24 09:05:06.286848+00	1344000.00	1	27	3	OH
105	2026-04-24 09:05:06.304175+00	2026-04-24 09:05:06.304216+00	1423000.00	1	28	3	OH
106	2026-04-24 09:05:06.320934+00	2026-04-24 09:05:06.320976+00	1679000.00	1	29	3	OH
107	2026-04-24 09:05:06.3377+00	2026-04-24 09:05:06.337743+00	1297000.00	1	30	3	OH
108	2026-04-24 09:05:06.353526+00	2026-04-24 09:05:06.353567+00	1059000.00	1	31	3	OH
109	2026-04-24 09:05:06.371259+00	2026-04-24 09:05:06.3713+00	1160000.00	1	32	3	OH
110	2026-04-24 09:05:06.387403+00	2026-04-24 09:05:06.387446+00	2521000.00	1	33	3	OH
111	2026-04-24 09:05:06.404467+00	2026-04-24 09:05:06.404509+00	2056000.00	1	34	3	OH
112	2026-04-24 09:05:06.420691+00	2026-04-24 09:05:06.420734+00	2056000.00	1	35	3	OH
113	2026-04-24 09:05:06.437685+00	2026-04-24 09:05:06.437725+00	2521000.00	1	36	3	OH
114	2026-04-24 09:05:06.454109+00	2026-04-24 09:05:06.45415+00	3706000.00	1	37	3	OH
115	2026-04-24 09:05:06.469595+00	2026-04-24 09:05:06.469637+00	3731000.00	1	38	3	OH
116	2026-04-24 09:05:06.486529+00	2026-04-24 09:05:06.486571+00	770000.00	1	1	4	OH
117	2026-04-24 09:05:06.503707+00	2026-04-24 09:05:06.50375+00	699000.00	1	2	4	OH
118	2026-04-24 09:05:06.519939+00	2026-04-24 09:05:06.519982+00	852000.00	1	3	4	OH
119	2026-04-24 09:05:06.536566+00	2026-04-24 09:05:06.536608+00	792000.00	1	4	4	OH
120	2026-04-24 09:05:06.553146+00	2026-04-24 09:05:06.553188+00	580000.00	1	5	4	OH
121	2026-04-24 09:05:06.569737+00	2026-04-24 09:05:06.569778+00	701000.00	1	6	4	OH
122	2026-04-24 09:05:06.587572+00	2026-04-24 09:05:06.587614+00	861000.00	1	7	4	OH
123	2026-04-24 09:05:06.603054+00	2026-04-24 09:05:06.603096+00	580000.00	1	8	4	OH
124	2026-04-24 09:05:06.620999+00	2026-04-24 09:05:06.62104+00	692000.00	1	9	4	OH
125	2026-04-24 09:05:06.637752+00	2026-04-24 09:05:06.637792+00	649000.00	1	10	4	OH
126	2026-04-24 09:05:06.653533+00	2026-04-24 09:05:06.653576+00	724000.00	1	11	4	OH
127	2026-04-24 09:05:06.669971+00	2026-04-24 09:05:06.670013+00	686000.00	1	12	4	OH
128	2026-04-24 09:05:06.686499+00	2026-04-24 09:05:06.68654+00	730000.00	1	13	4	OH
129	2026-04-24 09:05:06.705908+00	2026-04-24 09:05:06.705952+00	750000.00	1	14	4	OH
130	2026-04-24 09:05:06.729215+00	2026-04-24 09:05:06.729255+00	845000.00	1	15	4	OH
131	2026-04-24 09:05:06.745241+00	2026-04-24 09:05:06.745284+00	814000.00	1	16	4	OH
132	2026-04-24 09:05:06.762002+00	2026-04-24 09:05:06.762043+00	1138000.00	1	17	4	OH
133	2026-04-24 09:05:06.779149+00	2026-04-24 09:05:06.779189+00	907000.00	1	18	4	OH
134	2026-04-24 09:05:06.795073+00	2026-04-24 09:05:06.795115+00	688000.00	1	19	4	OH
135	2026-04-24 09:05:06.812857+00	2026-04-24 09:05:06.812899+00	538000.00	1	20	4	OH
136	2026-04-24 09:05:06.82962+00	2026-04-24 09:05:06.829662+00	659000.00	1	21	4	OH
137	2026-04-24 09:05:06.845332+00	2026-04-24 09:05:06.845372+00	697000.00	1	22	4	OH
138	2026-04-24 09:05:06.860787+00	2026-04-24 09:05:06.860824+00	804000.00	1	23	4	OH
139	2026-04-24 09:05:06.878196+00	2026-04-24 09:05:06.878237+00	904000.00	1	24	4	OH
140	2026-04-24 09:05:06.897283+00	2026-04-24 09:05:06.897365+00	978000.00	1	25	4	OH
141	2026-04-24 09:05:06.912139+00	2026-04-24 09:05:06.912182+00	955000.00	1	26	4	OH
142	2026-04-24 09:05:06.929337+00	2026-04-24 09:05:06.92938+00	704000.00	1	27	4	OH
143	2026-04-24 09:05:06.946479+00	2026-04-24 09:05:06.946546+00	745000.00	1	28	4	OH
144	2026-04-24 09:05:06.962537+00	2026-04-24 09:05:06.962579+00	951000.00	1	29	4	OH
145	2026-04-24 09:05:06.979137+00	2026-04-24 09:05:06.97918+00	786000.00	1	30	4	OH
146	2026-04-24 09:05:06.995723+00	2026-04-24 09:05:06.995765+00	667000.00	1	31	4	OH
147	2026-04-24 09:05:07.012039+00	2026-04-24 09:05:07.012079+00	605000.00	1	32	4	OH
148	2026-04-24 09:05:07.028491+00	2026-04-24 09:05:07.028532+00	1038000.00	1	33	4	OH
149	2026-04-24 09:05:07.045137+00	2026-04-24 09:05:07.04518+00	967000.00	1	34	4	OH
150	2026-04-24 09:05:07.061679+00	2026-04-24 09:05:07.061724+00	967000.00	1	35	4	OH
151	2026-04-24 09:05:07.079239+00	2026-04-24 09:05:07.079281+00	1308000.00	1	36	4	OH
152	2026-04-24 09:05:07.09551+00	2026-04-24 09:05:07.095553+00	1526000.00	1	37	4	OH
153	2026-04-24 09:05:07.111224+00	2026-04-24 09:05:07.111266+00	1536000.00	1	38	4	OH
154	2026-04-24 09:05:07.128235+00	2026-04-24 09:05:07.128275+00	750000.00	1	39	1	OH
155	2026-04-24 09:05:07.145219+00	2026-04-24 09:05:07.145262+00	4960000.00	1	40	1	OH
156	2026-04-24 09:05:07.162506+00	2026-04-24 09:05:07.162548+00	4960000.00	1	41	1	OH
157	2026-04-24 09:05:07.178707+00	2026-04-24 09:05:07.178748+00	4960000.00	1	42	1	OH
158	2026-04-24 09:05:07.196863+00	2026-04-24 09:05:07.196925+00	4960000.00	1	43	1	OH
159	2026-04-24 09:05:07.221233+00	2026-04-24 09:05:07.221276+00	4960000.00	1	44	1	OH
160	2026-04-24 09:05:07.23815+00	2026-04-24 09:05:07.23819+00	4960000.00	1	45	1	OH
161	2026-04-24 09:05:07.254793+00	2026-04-24 09:05:07.254835+00	750000.00	1	46	1	OH
162	2026-04-24 09:05:07.288131+00	2026-04-24 09:05:07.288173+00	4960000.00	1	47	1	OH
163	2026-04-24 09:05:07.30402+00	2026-04-24 09:05:07.304061+00	4960000.00	1	48	1	OH
164	2026-04-24 09:05:07.320112+00	2026-04-24 09:05:07.320155+00	4960000.00	1	49	1	OH
165	2026-04-24 09:05:07.345842+00	2026-04-24 09:05:07.345884+00	4960000.00	1	50	1	OH
166	2026-04-24 09:05:07.361894+00	2026-04-24 09:05:07.361936+00	4960000.00	1	51	1	OH
167	2026-04-24 09:05:07.378566+00	2026-04-24 09:05:07.378608+00	4960000.00	1	52	1	OH
168	2026-04-24 09:05:07.403534+00	2026-04-24 09:05:07.403575+00	4960000.00	1	53	1	OH
169	2026-04-24 09:05:07.422004+00	2026-04-24 09:05:07.422047+00	4960000.00	1	54	1	OH
170	2026-04-24 09:05:07.438197+00	2026-04-24 09:05:07.43824+00	4960000.00	1	55	1	OH
171	2026-04-24 09:05:07.454005+00	2026-04-24 09:05:07.454048+00	4960000.00	1	56	1	OH
172	2026-04-24 09:05:07.470162+00	2026-04-24 09:05:07.470204+00	4960000.00	1	57	1	OH
173	2026-04-24 09:05:07.488221+00	2026-04-24 09:05:07.488263+00	4960000.00	1	58	1	OH
174	2026-04-24 09:05:07.505336+00	2026-04-24 09:05:07.505379+00	4960000.00	1	59	1	OH
175	2026-04-24 09:05:07.52112+00	2026-04-24 09:05:07.521163+00	4960000.00	1	60	1	OH
176	2026-04-24 09:05:07.53773+00	2026-04-24 09:05:07.537772+00	4960000.00	1	61	1	OH
177	2026-04-24 09:05:07.554375+00	2026-04-24 09:05:07.554419+00	4960000.00	1	62	1	OH
178	2026-04-24 09:05:07.57116+00	2026-04-24 09:05:07.571203+00	4960000.00	1	63	1	OH
179	2026-04-24 09:05:07.587909+00	2026-04-24 09:05:07.587951+00	4960000.00	1	64	1	OH
180	2026-04-24 09:05:07.620115+00	2026-04-24 09:05:07.620156+00	4960000.00	1	65	1	OH
181	2026-04-24 09:05:07.636878+00	2026-04-24 09:05:07.636921+00	4960000.00	1	66	1	OH
182	2026-04-24 09:05:07.654087+00	2026-04-24 09:05:07.654131+00	4960000.00	1	67	1	OH
183	2026-04-24 09:05:07.67992+00	2026-04-24 09:05:07.679961+00	4960000.00	1	68	1	OH
184	2026-04-24 09:05:07.696472+00	2026-04-24 09:05:07.696513+00	750000.00	1	69	1	OH
185	2026-04-24 09:05:07.712413+00	2026-04-24 09:05:07.712457+00	4960000.00	1	70	1	OH
186	2026-04-24 09:05:07.747949+00	2026-04-24 09:05:07.748009+00	700000.00	1	39	2	OH
187	2026-04-24 09:05:07.778648+00	2026-04-24 09:05:07.77869+00	2195000.00	1	40	2	OH
188	2026-04-24 09:05:07.829535+00	2026-04-24 09:05:07.829579+00	2195000.00	1	41	2	OH
189	2026-04-24 09:05:07.889474+00	2026-04-24 09:05:07.889537+00	2195000.00	1	42	2	OH
190	2026-04-24 09:05:07.91177+00	2026-04-24 09:05:07.911807+00	2195000.00	1	43	2	OH
191	2026-04-24 09:05:07.929358+00	2026-04-24 09:05:07.9294+00	2195000.00	1	44	2	OH
192	2026-04-24 09:05:07.946396+00	2026-04-24 09:05:07.946439+00	2195000.00	1	45	2	OH
193	2026-04-24 09:05:07.963702+00	2026-04-24 09:05:07.963741+00	700000.00	1	46	2	OH
194	2026-04-24 09:05:07.981049+00	2026-04-24 09:05:07.981092+00	2195000.00	1	47	2	OH
195	2026-04-24 09:05:07.996715+00	2026-04-24 09:05:07.996758+00	2195000.00	1	48	2	OH
196	2026-04-24 09:05:08.013148+00	2026-04-24 09:05:08.013189+00	2195000.00	1	49	2	OH
197	2026-04-24 09:05:08.029155+00	2026-04-24 09:05:08.029196+00	2195000.00	1	50	2	OH
198	2026-04-24 09:05:08.046677+00	2026-04-24 09:05:08.04672+00	2195000.00	1	51	2	OH
199	2026-04-24 09:05:08.063225+00	2026-04-24 09:05:08.063267+00	2195000.00	1	52	2	OH
200	2026-04-24 09:05:08.080077+00	2026-04-24 09:05:08.08012+00	2195000.00	1	53	2	OH
201	2026-04-24 09:05:08.097489+00	2026-04-24 09:05:08.097536+00	2195000.00	1	54	2	OH
202	2026-04-24 09:05:08.112771+00	2026-04-24 09:05:08.112814+00	2195000.00	1	55	2	OH
203	2026-04-24 09:05:08.129648+00	2026-04-24 09:05:08.12969+00	2195000.00	1	56	2	OH
204	2026-04-24 09:05:08.146718+00	2026-04-24 09:05:08.146761+00	2195000.00	1	57	2	OH
205	2026-04-24 09:05:08.163166+00	2026-04-24 09:05:08.163207+00	2195000.00	1	58	2	OH
206	2026-04-24 09:05:08.179908+00	2026-04-24 09:05:08.179949+00	2195000.00	1	59	2	OH
207	2026-04-24 09:05:08.19653+00	2026-04-24 09:05:08.196574+00	2195000.00	1	60	2	OH
208	2026-04-24 09:05:08.213201+00	2026-04-24 09:05:08.213244+00	2195000.00	1	61	2	OH
209	2026-04-24 09:05:08.229715+00	2026-04-24 09:05:08.229757+00	2195000.00	1	62	2	OH
210	2026-04-24 09:05:08.246248+00	2026-04-24 09:05:08.246289+00	2195000.00	1	63	2	OH
211	2026-04-24 09:05:08.262668+00	2026-04-24 09:05:08.26271+00	2195000.00	1	64	2	OH
212	2026-04-24 09:05:08.279859+00	2026-04-24 09:05:08.279901+00	2195000.00	1	65	2	OH
213	2026-04-24 09:05:08.29689+00	2026-04-24 09:05:08.296933+00	2195000.00	1	66	2	OH
214	2026-04-24 09:05:08.311925+00	2026-04-24 09:05:08.311967+00	2195000.00	1	67	2	OH
215	2026-04-24 09:05:08.332862+00	2026-04-24 09:05:08.333396+00	2195000.00	1	68	2	OH
216	2026-04-24 09:05:08.355221+00	2026-04-24 09:05:08.355264+00	700000.00	1	69	2	OH
217	2026-04-24 09:05:08.371646+00	2026-04-24 09:05:08.371689+00	2195000.00	1	70	2	OH
218	2026-04-24 09:05:08.390706+00	2026-04-24 09:05:08.390748+00	500000.00	1	39	3	OH
219	2026-04-24 09:05:08.413064+00	2026-04-24 09:05:08.413106+00	1100000.00	1	40	3	OH
220	2026-04-24 09:05:08.429947+00	2026-04-24 09:05:08.42999+00	1100000.00	1	41	3	OH
221	2026-04-24 09:05:08.446149+00	2026-04-24 09:05:08.446189+00	1100000.00	1	42	3	OH
222	2026-04-24 09:05:08.462182+00	2026-04-24 09:05:08.462225+00	1100000.00	1	43	3	OH
223	2026-04-24 09:05:08.478797+00	2026-04-24 09:05:08.478839+00	1100000.00	1	44	3	OH
224	2026-04-24 09:05:08.495554+00	2026-04-24 09:05:08.495598+00	1100000.00	1	45	3	OH
225	2026-04-24 09:05:08.512773+00	2026-04-24 09:05:08.512814+00	500000.00	1	46	3	OH
226	2026-04-24 09:05:08.528852+00	2026-04-24 09:05:08.528893+00	1100000.00	1	47	3	OH
227	2026-04-24 09:05:08.545899+00	2026-04-24 09:05:08.545943+00	1100000.00	1	48	3	OH
228	2026-04-24 09:05:08.563717+00	2026-04-24 09:05:08.563759+00	1100000.00	1	49	3	OH
229	2026-04-24 09:05:08.588806+00	2026-04-24 09:05:08.588848+00	1100000.00	1	50	3	OH
230	2026-04-24 09:05:08.605987+00	2026-04-24 09:05:08.606031+00	1100000.00	1	51	3	OH
231	2026-04-24 09:05:08.620926+00	2026-04-24 09:05:08.620967+00	1100000.00	1	52	3	OH
232	2026-04-24 09:05:08.663717+00	2026-04-24 09:05:08.66376+00	1100000.00	1	53	3	OH
233	2026-04-24 09:05:08.680728+00	2026-04-24 09:05:08.680771+00	1100000.00	1	54	3	OH
234	2026-04-24 09:05:08.697519+00	2026-04-24 09:05:08.697561+00	1100000.00	1	55	3	OH
235	2026-04-24 09:05:08.71502+00	2026-04-24 09:05:08.715063+00	1100000.00	1	56	3	OH
236	2026-04-24 09:05:08.729825+00	2026-04-24 09:05:08.729867+00	1100000.00	1	57	3	OH
237	2026-04-24 09:05:08.747235+00	2026-04-24 09:05:08.747277+00	1100000.00	1	58	3	OH
238	2026-04-24 09:05:08.763995+00	2026-04-24 09:05:08.764037+00	1100000.00	1	59	3	OH
239	2026-04-24 09:05:08.780348+00	2026-04-24 09:05:08.780391+00	1100000.00	1	60	3	OH
240	2026-04-24 09:05:08.797456+00	2026-04-24 09:05:08.7975+00	1100000.00	1	61	3	OH
241	2026-04-24 09:05:08.813717+00	2026-04-24 09:05:08.81376+00	1100000.00	1	62	3	OH
242	2026-04-24 09:05:08.830351+00	2026-04-24 09:05:08.830395+00	1100000.00	1	63	3	OH
243	2026-04-24 09:05:08.846945+00	2026-04-24 09:05:08.846988+00	1100000.00	1	64	3	OH
244	2026-04-24 09:05:08.86307+00	2026-04-24 09:05:08.863113+00	1100000.00	1	65	3	OH
245	2026-04-24 09:05:08.881477+00	2026-04-24 09:05:08.88152+00	1100000.00	1	66	3	OH
246	2026-04-24 09:05:08.905259+00	2026-04-24 09:05:08.905336+00	1100000.00	1	67	3	OH
247	2026-04-24 09:05:08.921638+00	2026-04-24 09:05:08.921678+00	1100000.00	1	68	3	OH
248	2026-04-24 09:05:08.938195+00	2026-04-24 09:05:08.938236+00	500000.00	1	69	3	OH
249	2026-04-24 09:05:08.954276+00	2026-04-24 09:05:08.95436+00	1100000.00	1	70	3	OH
250	2026-04-24 09:05:08.97089+00	2026-04-24 09:05:08.970929+00	500000.00	1	39	4	OH
251	2026-04-24 09:05:08.988927+00	2026-04-24 09:05:08.98897+00	699000.00	1	40	4	OH
252	2026-04-24 09:05:09.004756+00	2026-04-24 09:05:09.004798+00	699000.00	1	41	4	OH
253	2026-04-24 09:05:09.020937+00	2026-04-24 09:05:09.020978+00	699000.00	1	42	4	OH
254	2026-04-24 09:05:09.037285+00	2026-04-24 09:05:09.037356+00	699000.00	1	43	4	OH
255	2026-04-24 09:05:09.052411+00	2026-04-24 09:05:09.052443+00	699000.00	1	44	4	OH
256	2026-04-24 09:05:09.070837+00	2026-04-24 09:05:09.070877+00	699000.00	1	45	4	OH
257	2026-04-24 09:05:09.088246+00	2026-04-24 09:05:09.08829+00	500000.00	1	46	4	OH
258	2026-04-24 09:05:09.105062+00	2026-04-24 09:05:09.1051+00	699000.00	1	47	4	OH
259	2026-04-24 09:05:09.120875+00	2026-04-24 09:05:09.120912+00	699000.00	1	48	4	OH
260	2026-04-24 09:05:09.137516+00	2026-04-24 09:05:09.137553+00	699000.00	1	49	4	OH
261	2026-04-24 09:05:09.155292+00	2026-04-24 09:05:09.155388+00	699000.00	1	50	4	OH
262	2026-04-24 09:05:09.1721+00	2026-04-24 09:05:09.17214+00	699000.00	1	51	4	OH
263	2026-04-24 09:05:09.188892+00	2026-04-24 09:05:09.188934+00	699000.00	1	52	4	OH
264	2026-04-24 09:05:09.205372+00	2026-04-24 09:05:09.205414+00	699000.00	1	53	4	OH
265	2026-04-24 09:05:09.22206+00	2026-04-24 09:05:09.222101+00	699000.00	1	54	4	OH
266	2026-04-24 09:05:09.238396+00	2026-04-24 09:05:09.238438+00	699000.00	1	55	4	OH
267	2026-04-24 09:05:09.255296+00	2026-04-24 09:05:09.255369+00	699000.00	1	56	4	OH
268	2026-04-24 09:05:09.27196+00	2026-04-24 09:05:09.272002+00	699000.00	1	57	4	OH
269	2026-04-24 09:05:09.288563+00	2026-04-24 09:05:09.288606+00	699000.00	1	58	4	OH
270	2026-04-24 09:05:09.305735+00	2026-04-24 09:05:09.305779+00	699000.00	1	59	4	OH
271	2026-04-24 09:05:09.321967+00	2026-04-24 09:05:09.32201+00	699000.00	1	60	4	OH
272	2026-04-24 09:05:09.338174+00	2026-04-24 09:05:09.338216+00	699000.00	1	61	4	OH
273	2026-04-24 09:05:09.354467+00	2026-04-24 09:05:09.35451+00	699000.00	1	62	4	OH
274	2026-04-24 09:05:09.371837+00	2026-04-24 09:05:09.371879+00	699000.00	1	63	4	OH
275	2026-04-24 09:05:09.389006+00	2026-04-24 09:05:09.389048+00	699000.00	1	64	4	OH
276	2026-04-24 09:05:09.404086+00	2026-04-24 09:05:09.404129+00	699000.00	1	65	4	OH
277	2026-04-24 09:05:09.421017+00	2026-04-24 09:05:09.421058+00	699000.00	1	66	4	OH
278	2026-04-24 09:05:09.437131+00	2026-04-24 09:05:09.437172+00	699000.00	1	67	4	OH
279	2026-04-24 09:05:09.455555+00	2026-04-24 09:05:09.455598+00	699000.00	1	68	4	OH
280	2026-04-24 09:05:09.471754+00	2026-04-24 09:05:09.471798+00	500000.00	1	69	4	OH
281	2026-04-24 09:05:09.488496+00	2026-04-24 09:05:09.488539+00	699000.00	1	70	4	OH
\.


--
-- Data for Name: spd_standardpesawat; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_standardpesawat (id, created_at, updated_at, biaya, dasar_peraturan_id, kota_asal_id, kota_tujuan_id, tingkat_id) FROM stdin;
\.


--
-- Data for Name: spd_standardrepresentasi; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_standardrepresentasi (id, created_at, updated_at, biaya, dasar_peraturan_id, tingkat_spd_id, jenis_spd_id) FROM stdin;
\.


--
-- Data for Name: spd_standardtransportasi; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_standardtransportasi (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_transportasi_id, kota_tujuan_id) FROM stdin;
1	2026-04-24 10:15:59.984585+00	2026-04-24 10:15:59.984608+00	Per Hari	962000.00	1	3	1
2	2026-04-24 10:16:00.021794+00	2026-04-24 10:16:00.021823+00	Per Hari	978000.00	1	3	3
3	2026-04-24 10:16:00.040784+00	2026-04-24 10:16:00.040816+00	Per Hari	1049000.00	1	3	4
4	2026-04-24 10:16:00.057408+00	2026-04-24 10:16:00.057441+00	Per Hari	1152000.00	1	3	5
5	2026-04-24 10:16:00.075846+00	2026-04-24 10:16:00.075901+00	Per Hari	922000.00	1	3	6
6	2026-04-24 10:16:00.08764+00	2026-04-24 10:16:00.087668+00	Per Hari	1507000.00	1	3	7
7	2026-04-24 10:16:00.107272+00	2026-04-24 10:16:00.107328+00	Per Hari	897000.00	1	3	8
8	2026-04-24 10:16:00.125894+00	2026-04-24 10:16:00.125924+00	Per Hari	985000.00	1	3	9
9	2026-04-24 10:16:00.143097+00	2026-04-24 10:16:00.143129+00	Per Hari	1258000.00	1	3	10
10	2026-04-24 10:16:00.156856+00	2026-04-24 10:16:00.156886+00	Per Hari	1017000.00	1	3	11
11	2026-04-24 10:16:00.174716+00	2026-04-24 10:16:00.174752+00	Per Hari	988000.00	1	3	12
12	2026-04-24 10:16:00.190118+00	2026-04-24 10:16:00.190149+00	Per Hari	1305000.00	1	3	13
13	2026-04-24 10:16:00.206381+00	2026-04-24 10:16:00.206437+00	Per Hari	1347000.00	1	3	14
14	2026-04-24 10:16:00.224212+00	2026-04-24 10:16:00.224248+00	Per Hari	978000.00	1	3	15
15	2026-04-24 10:16:00.240287+00	2026-04-24 10:16:00.240344+00	Per Hari	1212000.00	1	3	16
16	2026-04-24 10:16:00.257234+00	2026-04-24 10:16:00.257263+00	Per Hari	1275000.00	1	3	17
17	2026-04-24 10:16:00.274454+00	2026-04-24 10:16:00.274482+00	Per Hari	1103000.00	1	3	18
18	2026-04-24 10:16:00.292618+00	2026-04-24 10:16:00.292655+00	Per Hari	926000.00	1	3	19
19	2026-04-24 10:16:00.310121+00	2026-04-24 10:16:00.310158+00	Per Hari	921000.00	1	3	20
20	2026-04-24 10:16:00.326216+00	2026-04-24 10:16:00.326255+00	Per Hari	1177000.00	1	3	21
21	2026-04-24 10:16:00.341883+00	2026-04-24 10:16:00.341922+00	Per Hari	921000.00	1	3	22
22	2026-04-24 10:16:00.360248+00	2026-04-24 10:16:00.360285+00	Per Hari	1100000.00	1	3	23
23	2026-04-24 10:16:00.3738+00	2026-04-24 10:16:00.373843+00	Per Hari	1188000.00	1	3	24
24	2026-04-24 10:16:00.39296+00	2026-04-24 10:16:00.393003+00	Per Hari	1195000.00	1	3	25
25	2026-04-24 10:16:00.410009+00	2026-04-24 10:16:00.410052+00	Per Hari	908000.00	1	3	26
26	2026-04-24 10:16:00.425043+00	2026-04-24 10:16:00.425081+00	Per Hari	914000.00	1	3	27
27	2026-04-24 10:16:00.441828+00	2026-04-24 10:16:00.441872+00	Per Hari	938000.00	1	3	28
28	2026-04-24 10:16:00.45897+00	2026-04-24 10:16:00.459013+00	Per Hari	824000.00	1	3	29
29	2026-04-24 10:16:00.475686+00	2026-04-24 10:16:00.475729+00	Per Hari	945000.00	1	3	30
30	2026-04-24 10:16:00.492945+00	2026-04-24 10:16:00.492987+00	Per Hari	1241000.00	1	3	31
31	2026-04-24 10:16:00.509556+00	2026-04-24 10:16:00.509599+00	Per Hari	1095000.00	1	3	32
32	2026-04-24 10:16:00.526915+00	2026-04-24 10:16:00.526979+00	Per Hari	1204000.00	1	3	33
33	2026-04-24 10:16:00.542851+00	2026-04-24 10:16:00.542894+00	Per Hari	1171000.00	1	3	34
34	2026-04-24 10:16:00.558363+00	2026-04-24 10:16:00.558402+00	Per Hari	1171000.00	1	3	35
35	2026-04-24 10:16:00.575672+00	2026-04-24 10:16:00.575739+00	Per Hari	1204000.00	1	3	36
36	2026-04-24 10:16:00.592062+00	2026-04-24 10:16:00.592104+00	Per Hari	1638000.00	1	3	37
37	2026-04-24 10:16:00.610857+00	2026-04-24 10:16:00.6109+00	Per Hari	1649000.00	1	3	38
38	2026-04-24 10:16:00.625942+00	2026-04-24 10:16:00.625979+00	Orang/Kali	127000.00	1	1	1
39	2026-04-24 10:16:00.642702+00	2026-04-24 10:16:00.642763+00	Orang/Kali	308000.00	1	1	2
40	2026-04-24 10:16:00.657919+00	2026-04-24 10:16:00.657962+00	Orang/Kali	101000.00	1	1	3
41	2026-04-24 10:16:00.676888+00	2026-04-24 10:16:00.676926+00	Orang/Kali	165000.00	1	1	4
42	2026-04-24 10:16:00.691555+00	2026-04-24 10:16:00.691576+00	Orang/Kali	147000.00	1	1	5
43	2026-04-24 10:16:00.708288+00	2026-04-24 10:16:00.70836+00	Orang/Kali	190000.00	1	1	6
44	2026-04-24 10:16:00.725599+00	2026-04-24 10:16:00.725638+00	Orang/Kali	179000.00	1	1	7
45	2026-04-24 10:16:00.741856+00	2026-04-24 10:16:00.741889+00	Orang/Kali	168000.00	1	1	8
46	2026-04-24 10:16:00.75913+00	2026-04-24 10:16:00.75916+00	Orang/Kali	109000.00	1	1	9
47	2026-04-24 10:16:00.774915+00	2026-04-24 10:16:00.774956+00	Orang/Kali	97000.00	1	1	10
48	2026-04-24 10:16:00.79282+00	2026-04-24 10:16:00.792858+00	Orang/Kali	536000.00	1	1	11
49	2026-04-24 10:16:00.8091+00	2026-04-24 10:16:00.809137+00	Orang/Kali	200000.00	1	1	12
50	2026-04-24 10:16:00.825371+00	2026-04-24 10:16:00.825415+00	Orang/Kali	256000.00	1	1	13
51	2026-04-24 10:16:00.84209+00	2026-04-24 10:16:00.842131+00	Orang/Kali	108000.00	1	1	14
52	2026-04-24 10:16:00.858741+00	2026-04-24 10:16:00.858784+00	Orang/Kali	267000.00	1	1	15
53	2026-04-24 10:16:00.875365+00	2026-04-24 10:16:00.875407+00	Orang/Kali	233000.00	1	1	16
54	2026-04-24 10:16:00.892052+00	2026-04-24 10:16:00.892093+00	Orang/Kali	227000.00	1	1	17
55	2026-04-24 10:16:00.908918+00	2026-04-24 10:16:00.908959+00	Orang/Kali	231000.00	1	1	18
56	2026-04-24 10:16:00.926148+00	2026-04-24 10:16:00.92619+00	Orang/Kali	116000.00	1	1	19
57	2026-04-24 10:16:00.943389+00	2026-04-24 10:16:00.943434+00	Orang/Kali	171000.00	1	1	20
58	2026-04-24 10:16:00.960338+00	2026-04-24 10:16:00.960382+00	Orang/Kali	134000.00	1	1	21
59	2026-04-24 10:16:00.976936+00	2026-04-24 10:16:00.976978+00	Orang/Kali	180000.00	1	1	22
60	2026-04-24 10:16:00.993405+00	2026-04-24 10:16:00.993448+00	Orang/Kali	533000.00	1	1	23
61	2026-04-24 10:16:01.010397+00	2026-04-24 10:16:01.01044+00	Orang/Kali	218000.00	1	1	24
62	2026-04-24 10:16:01.02678+00	2026-04-24 10:16:01.026823+00	Orang/Kali	138000.00	1	1	25
63	2026-04-24 10:16:01.04327+00	2026-04-24 10:16:01.043341+00	Orang/Kali	265000.00	1	1	26
64	2026-04-24 10:16:01.06007+00	2026-04-24 10:16:01.060113+00	Orang/Kali	313000.00	1	1	27
65	2026-04-24 10:16:01.07727+00	2026-04-24 10:16:01.077337+00	Orang/Kali	187000.00	1	1	28
66	2026-04-24 10:16:01.093189+00	2026-04-24 10:16:01.093231+00	Orang/Kali	165000.00	1	1	29
67	2026-04-24 10:16:01.109115+00	2026-04-24 10:16:01.109158+00	Orang/Kali	171000.00	1	1	30
68	2026-04-24 10:16:01.126771+00	2026-04-24 10:16:01.126814+00	Orang/Kali	288000.00	1	1	31
69	2026-04-24 10:16:01.143816+00	2026-04-24 10:16:01.143858+00	Orang/Kali	215000.00	1	1	32
70	2026-04-24 10:16:01.159519+00	2026-04-24 10:16:01.159562+00	Orang/Kali	513000.00	1	1	33
71	2026-04-24 10:16:01.17585+00	2026-04-24 10:16:01.175893+00	Orang/Kali	236000.00	1	1	34
72	2026-04-24 10:16:01.193362+00	2026-04-24 10:16:01.193405+00	Orang/Kali	236000.00	1	1	35
73	2026-04-24 10:16:01.209562+00	2026-04-24 10:16:01.209604+00	Orang/Kali	513000.00	1	1	36
74	2026-04-24 10:16:01.225971+00	2026-04-24 10:16:01.226013+00	Orang/Kali	513000.00	1	1	37
75	2026-04-24 10:16:01.242187+00	2026-04-24 10:16:01.242228+00	Orang/Kali	513000.00	1	1	38
76	2026-04-24 10:16:01.262667+00	2026-04-24 10:16:01.262709+00	Orang/Kali	150000.00	1	2	39
77	2026-04-24 10:16:01.286598+00	2026-04-24 10:16:01.286619+00	Orang/Kali	350000.00	1	2	40
78	2026-04-24 10:16:01.300796+00	2026-04-24 10:16:01.300835+00	Orang/Kali	250000.00	1	2	41
79	2026-04-24 10:16:01.317693+00	2026-04-24 10:16:01.317735+00	Orang/Kali	350000.00	1	2	42
80	2026-04-24 10:16:01.334062+00	2026-04-24 10:16:01.334106+00	Orang/Kali	350000.00	1	2	43
81	2026-04-24 10:16:01.349668+00	2026-04-24 10:16:01.349706+00	Orang/Kali	200000.00	1	2	44
82	2026-04-24 10:16:01.365675+00	2026-04-24 10:16:01.365702+00	Orang/Kali	200000.00	1	2	45
83	2026-04-24 10:16:01.38246+00	2026-04-24 10:16:01.382487+00	Orang/Kali	150000.00	1	2	46
84	2026-04-24 10:16:01.399981+00	2026-04-24 10:16:01.400014+00	Orang/Kali	350000.00	1	2	47
85	2026-04-24 10:16:01.443183+00	2026-04-24 10:16:01.443233+00	Orang/Kali	350000.00	1	2	48
86	2026-04-24 10:16:01.461744+00	2026-04-24 10:16:01.461783+00	Orang/Kali	350000.00	1	2	53
87	2026-04-24 10:16:01.483908+00	2026-04-24 10:16:01.48395+00	Orang/Kali	350000.00	1	2	54
88	2026-04-24 10:16:01.501082+00	2026-04-24 10:16:01.501124+00	Orang/Kali	350000.00	1	2	55
89	2026-04-24 10:16:01.516962+00	2026-04-24 10:16:01.517005+00	Orang/Kali	350000.00	1	2	56
90	2026-04-24 10:16:01.534917+00	2026-04-24 10:16:01.534954+00	Orang/Kali	200000.00	1	2	57
91	2026-04-24 10:16:01.551742+00	2026-04-24 10:16:01.551785+00	Orang/Kali	250000.00	1	2	58
92	2026-04-24 10:16:01.567794+00	2026-04-24 10:16:01.567833+00	Orang/Kali	350000.00	1	2	59
93	2026-04-24 10:16:01.58402+00	2026-04-24 10:16:01.584056+00	Orang/Kali	350000.00	1	2	60
94	2026-04-24 10:16:01.599042+00	2026-04-24 10:16:01.599081+00	Orang/Kali	300000.00	1	2	61
95	2026-04-24 10:16:01.619914+00	2026-04-24 10:16:01.619949+00	Orang/Kali	350000.00	1	2	62
96	2026-04-24 10:16:01.634418+00	2026-04-24 10:16:01.63448+00	Orang/Kali	300000.00	1	2	63
97	2026-04-24 10:16:01.650411+00	2026-04-24 10:16:01.650448+00	Orang/Kali	250000.00	1	2	65
98	2026-04-24 10:16:01.668737+00	2026-04-24 10:16:01.668776+00	Orang/Kali	350000.00	1	2	66
99	2026-04-24 10:16:01.684697+00	2026-04-24 10:16:01.684739+00	Orang/Kali	150000.00	1	2	67
100	2026-04-24 10:16:01.699246+00	2026-04-24 10:16:01.699274+00	Orang/Kali	350000.00	1	2	68
101	2026-04-24 10:16:01.717369+00	2026-04-24 10:16:01.717404+00	Orang/Kali	100000.00	1	2	69
102	2026-04-24 10:16:01.733014+00	2026-04-24 10:16:01.733049+00	Orang/Kali	200000.00	1	2	70
\.


--
-- Data for Name: spd_standarduangharian; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spd_standarduangharian (id, created_at, updated_at, satuan, biaya, dasar_peraturan_id, jenis_kegiatan_id, lokasi_id) FROM stdin;
2	2026-04-24 09:51:11.089147+00	2026-04-24 09:51:11.089181+00	OH	360000.00	1	1	1
3	2026-04-24 09:51:11.145041+00	2026-04-24 09:51:11.145086+00	OH	370000.00	1	1	2
4	2026-04-24 09:51:11.16128+00	2026-04-24 09:51:11.161349+00	OH	370000.00	1	1	3
5	2026-04-24 09:51:11.177607+00	2026-04-24 09:51:11.177652+00	OH	370000.00	1	1	4
6	2026-04-24 09:51:11.193424+00	2026-04-24 09:51:11.193469+00	OH	370000.00	1	1	5
7	2026-04-24 09:51:11.2103+00	2026-04-24 09:51:11.210376+00	OH	380000.00	1	1	6
8	2026-04-24 09:51:11.226838+00	2026-04-24 09:51:11.226882+00	OH	380000.00	1	1	7
9	2026-04-24 09:51:11.245064+00	2026-04-24 09:51:11.245109+00	OH	380000.00	1	1	8
10	2026-04-24 09:51:11.261262+00	2026-04-24 09:51:11.261329+00	OH	380000.00	1	1	9
11	2026-04-24 09:51:11.278292+00	2026-04-24 09:51:11.278365+00	OH	410000.00	1	1	10
12	2026-04-24 09:51:11.295702+00	2026-04-24 09:51:11.295747+00	OH	370000.00	1	1	11
13	2026-04-24 09:51:11.311437+00	2026-04-24 09:51:11.311482+00	OH	430000.00	1	1	12
14	2026-04-24 09:51:11.328001+00	2026-04-24 09:51:11.328045+00	OH	530000.00	1	1	13
15	2026-04-24 09:51:11.344701+00	2026-04-24 09:51:11.344745+00	OH	370000.00	1	1	14
16	2026-04-24 09:51:11.361104+00	2026-04-24 09:51:11.361148+00	OH	420000.00	1	1	15
17	2026-04-24 09:51:11.377992+00	2026-04-24 09:51:11.378037+00	OH	410000.00	1	1	16
18	2026-04-24 09:51:11.394555+00	2026-04-24 09:51:11.3946+00	OH	480000.00	1	1	17
19	2026-04-24 09:51:11.411468+00	2026-04-24 09:51:11.411514+00	OH	440000.00	1	1	18
20	2026-04-24 09:51:11.428052+00	2026-04-24 09:51:11.428094+00	OH	430000.00	1	1	19
21	2026-04-24 09:51:11.445006+00	2026-04-24 09:51:11.445048+00	OH	380000.00	1	1	20
22	2026-04-24 09:51:11.460064+00	2026-04-24 09:51:11.460106+00	OH	360000.00	1	1	21
23	2026-04-24 09:51:11.476716+00	2026-04-24 09:51:11.476758+00	OH	380000.00	1	1	22
24	2026-04-24 09:51:11.492977+00	2026-04-24 09:51:11.493021+00	OH	430000.00	1	1	23
25	2026-04-24 09:51:11.512213+00	2026-04-24 09:51:11.512255+00	OH	430000.00	1	1	24
26	2026-04-24 09:51:11.529357+00	2026-04-24 09:51:11.5294+00	OH	370000.00	1	1	25
27	2026-04-24 09:51:11.545971+00	2026-04-24 09:51:11.546014+00	OH	370000.00	1	1	26
28	2026-04-24 09:51:11.561109+00	2026-04-24 09:51:11.561151+00	OH	410000.00	1	1	27
29	2026-04-24 09:51:11.576599+00	2026-04-24 09:51:11.576641+00	OH	430000.00	1	1	28
30	2026-04-24 09:51:11.595461+00	2026-04-24 09:51:11.59552+00	OH	370000.00	1	1	29
31	2026-04-24 09:51:11.607895+00	2026-04-24 09:51:11.607932+00	OH	380000.00	1	1	30
32	2026-04-24 09:51:11.623207+00	2026-04-24 09:51:11.623229+00	OH	380000.00	1	1	31
33	2026-04-24 09:51:11.638471+00	2026-04-24 09:51:11.6385+00	OH	430000.00	1	1	32
34	2026-04-24 09:51:11.646903+00	2026-04-24 09:51:11.646924+00	OH	580000.00	1	1	33
35	2026-04-24 09:51:11.654969+00	2026-04-24 09:51:11.65499+00	OH	480000.00	1	1	34
36	2026-04-24 09:51:11.663248+00	2026-04-24 09:51:11.663269+00	OH	480000.00	1	1	35
37	2026-04-24 09:51:11.672516+00	2026-04-24 09:51:11.672537+00	OH	580000.00	1	1	36
38	2026-04-24 09:51:11.688196+00	2026-04-24 09:51:11.688217+00	OH	580000.00	1	1	37
39	2026-04-24 09:51:11.696544+00	2026-04-24 09:51:11.696566+00	OH	580000.00	1	1	38
40	2026-04-24 09:51:11.706506+00	2026-04-24 09:51:11.706538+00	OH	110000.00	1	3	1
41	2026-04-24 09:51:11.721625+00	2026-04-24 09:51:11.721647+00	OH	110000.00	1	3	2
42	2026-04-24 09:51:11.729844+00	2026-04-24 09:51:11.729865+00	OH	110000.00	1	3	3
43	2026-04-24 09:51:11.738025+00	2026-04-24 09:51:11.738046+00	OH	110000.00	1	3	4
44	2026-04-24 09:51:11.746653+00	2026-04-24 09:51:11.746674+00	OH	110000.00	1	3	5
45	2026-04-24 09:51:11.756445+00	2026-04-24 09:51:11.756624+00	OH	110000.00	1	3	6
46	2026-04-24 09:51:11.773821+00	2026-04-24 09:51:11.773841+00	OH	110000.00	1	3	7
47	2026-04-24 09:51:11.790408+00	2026-04-24 09:51:11.790428+00	OH	110000.00	1	3	8
48	2026-04-24 09:51:11.809607+00	2026-04-24 09:51:11.809651+00	OH	110000.00	1	3	9
49	2026-04-24 09:51:11.82813+00	2026-04-24 09:51:11.828172+00	OH	120000.00	1	3	10
50	2026-04-24 09:51:11.844358+00	2026-04-24 09:51:11.844394+00	OH	110000.00	1	3	11
51	2026-04-24 09:51:11.85906+00	2026-04-24 09:51:11.859095+00	OH	130000.00	1	3	12
52	2026-04-24 09:51:11.876079+00	2026-04-24 09:51:11.876117+00	OH	160000.00	1	3	13
53	2026-04-24 09:51:11.894413+00	2026-04-24 09:51:11.894456+00	OH	110000.00	1	3	14
54	2026-04-24 09:51:11.910405+00	2026-04-24 09:51:11.910449+00	OH	130000.00	1	3	15
55	2026-04-24 09:51:11.927784+00	2026-04-24 09:51:11.927827+00	OH	120000.00	1	3	16
56	2026-04-24 09:51:11.943817+00	2026-04-24 09:51:11.943856+00	OH	140000.00	1	3	17
57	2026-04-24 09:51:11.959479+00	2026-04-24 09:51:11.959517+00	OH	130000.00	1	3	18
58	2026-04-24 09:51:11.977718+00	2026-04-24 09:51:11.977762+00	OH	130000.00	1	3	19
59	2026-04-24 09:51:11.995001+00	2026-04-24 09:51:11.995046+00	OH	110000.00	1	3	20
60	2026-04-24 09:51:12.010696+00	2026-04-24 09:51:12.010738+00	OH	110000.00	1	3	21
61	2026-04-24 09:51:12.027044+00	2026-04-24 09:51:12.027088+00	OH	110000.00	1	3	22
62	2026-04-24 09:51:12.0444+00	2026-04-24 09:51:12.044448+00	OH	130000.00	1	3	23
63	2026-04-24 09:51:12.060713+00	2026-04-24 09:51:12.060756+00	OH	130000.00	1	3	24
64	2026-04-24 09:51:12.077155+00	2026-04-24 09:51:12.077197+00	OH	110000.00	1	3	25
65	2026-04-24 09:51:12.094459+00	2026-04-24 09:51:12.094503+00	OH	110000.00	1	3	26
66	2026-04-24 09:51:12.110337+00	2026-04-24 09:51:12.110385+00	OH	120000.00	1	3	27
67	2026-04-24 09:51:12.131624+00	2026-04-24 09:51:12.131669+00	OH	130000.00	1	3	28
68	2026-04-24 09:51:12.153243+00	2026-04-24 09:51:12.153287+00	OH	110000.00	1	3	29
69	2026-04-24 09:51:12.16998+00	2026-04-24 09:51:12.170024+00	OH	110000.00	1	3	30
70	2026-04-24 09:51:12.187278+00	2026-04-24 09:51:12.187374+00	OH	110000.00	1	3	31
71	2026-04-24 09:51:12.204406+00	2026-04-24 09:51:12.204449+00	OH	130000.00	1	3	32
72	2026-04-24 09:51:12.220041+00	2026-04-24 09:51:12.220086+00	OH	170000.00	1	3	33
73	2026-04-24 09:51:12.236669+00	2026-04-24 09:51:12.236714+00	OH	140000.00	1	3	34
74	2026-04-24 09:51:12.252593+00	2026-04-24 09:51:12.252635+00	OH	140000.00	1	3	35
75	2026-04-24 09:51:12.269026+00	2026-04-24 09:51:12.269069+00	OH	170000.00	1	3	36
76	2026-04-24 09:51:12.286693+00	2026-04-24 09:51:12.286734+00	OH	170000.00	1	3	37
77	2026-04-24 09:51:12.302993+00	2026-04-24 09:51:12.303037+00	OH	170000.00	1	3	38
78	2026-04-24 09:51:12.319527+00	2026-04-24 09:51:12.31957+00	OH	75000.00	1	2	71
79	2026-04-24 09:51:12.336496+00	2026-04-24 09:51:12.33654+00	OH	75000.00	1	2	72
80	2026-04-24 09:51:12.352975+00	2026-04-24 09:51:12.353018+00	OH	75000.00	1	2	73
81	2026-04-24 09:51:12.370026+00	2026-04-24 09:51:12.37007+00	OH	75000.00	1	2	74
82	2026-04-24 09:51:12.386426+00	2026-04-24 09:51:12.38647+00	OH	75000.00	1	2	75
83	2026-04-24 09:51:12.402962+00	2026-04-24 09:51:12.403005+00	OH	100000.00	1	2	76
84	2026-04-24 09:51:12.419618+00	2026-04-24 09:51:12.419661+00	OH	100000.00	1	2	77
85	2026-04-24 09:51:12.436355+00	2026-04-24 09:51:12.436398+00	OH	100000.00	1	2	78
86	2026-04-24 09:51:12.454651+00	2026-04-24 09:51:12.454693+00	OH	100000.00	1	2	79
87	2026-04-24 09:51:12.469961+00	2026-04-24 09:51:12.470003+00	OH	100000.00	1	2	80
88	2026-04-24 09:51:12.486283+00	2026-04-24 09:51:12.486353+00	OH	100000.00	1	2	81
89	2026-04-24 09:51:12.503032+00	2026-04-24 09:51:12.503075+00	OH	100000.00	1	2	82
90	2026-04-24 09:51:12.520227+00	2026-04-24 09:51:12.520271+00	OH	100000.00	1	2	83
91	2026-04-24 09:51:12.536118+00	2026-04-24 09:51:12.536161+00	OH	125000.00	1	2	84
92	2026-04-24 09:51:12.552342+00	2026-04-24 09:51:12.552389+00	OH	125000.00	1	2	85
93	2026-04-24 09:51:12.569965+00	2026-04-24 09:51:12.570008+00	OH	125000.00	1	2	86
94	2026-04-24 09:51:12.587007+00	2026-04-24 09:51:12.58705+00	OH	125000.00	1	2	87
95	2026-04-24 09:51:12.602735+00	2026-04-24 09:51:12.602778+00	OH	125000.00	1	2	88
96	2026-04-24 09:51:12.621641+00	2026-04-24 09:51:12.621687+00	OH	125000.00	1	2	89
97	2026-04-24 09:51:12.635714+00	2026-04-24 09:51:12.635758+00	OH	125000.00	1	2	90
98	2026-04-24 09:51:12.654029+00	2026-04-24 09:51:12.654072+00	OH	125000.00	1	2	91
99	2026-04-24 09:51:12.670297+00	2026-04-24 09:51:12.67037+00	OH	125000.00	1	2	92
100	2026-04-24 09:51:12.687059+00	2026-04-24 09:51:12.687103+00	OH	125000.00	1	2	93
101	2026-04-24 09:51:12.701142+00	2026-04-24 09:51:12.701175+00	OH	120000.00	1	4	1
102	2026-04-24 09:51:12.718603+00	2026-04-24 09:51:12.71864+00	OH	130000.00	1	4	2
103	2026-04-24 09:51:12.735231+00	2026-04-24 09:51:12.73527+00	OH	130000.00	1	4	3
104	2026-04-24 09:51:12.750434+00	2026-04-24 09:51:12.750474+00	OH	130000.00	1	4	4
105	2026-04-24 09:51:12.7696+00	2026-04-24 09:51:12.769642+00	OH	130000.00	1	4	5
106	2026-04-24 09:51:12.786157+00	2026-04-24 09:51:12.786195+00	OH	120000.00	1	4	6
107	2026-04-24 09:51:12.803825+00	2026-04-24 09:51:12.803864+00	OH	120000.00	1	4	7
108	2026-04-24 09:51:12.8168+00	2026-04-24 09:51:12.816824+00	OH	130000.00	1	4	8
109	2026-04-24 09:51:12.836693+00	2026-04-24 09:51:12.836739+00	OH	130000.00	1	4	9
110	2026-04-24 09:51:12.854899+00	2026-04-24 09:51:12.854943+00	OH	130000.00	1	4	10
111	2026-04-24 09:51:12.870913+00	2026-04-24 09:51:12.870956+00	OH	120000.00	1	4	11
112	2026-04-24 09:51:12.887094+00	2026-04-24 09:51:12.887137+00	OH	150000.00	1	4	12
113	2026-04-24 09:51:12.901669+00	2026-04-24 09:51:12.901708+00	OH	180000.00	1	4	13
114	2026-04-24 09:51:12.919968+00	2026-04-24 09:51:12.920009+00	OH	130000.00	1	4	14
115	2026-04-24 09:51:12.937021+00	2026-04-24 09:51:12.937063+00	OH	140000.00	1	4	15
116	2026-04-24 09:51:12.954013+00	2026-04-24 09:51:12.954055+00	OH	140000.00	1	4	16
117	2026-04-24 09:51:12.970101+00	2026-04-24 09:51:12.970143+00	OH	160000.00	1	4	17
118	2026-04-24 09:51:12.986997+00	2026-04-24 09:51:12.987039+00	OH	150000.00	1	4	18
119	2026-04-24 09:51:13.003597+00	2026-04-24 09:51:13.003642+00	OH	140000.00	1	4	19
120	2026-04-24 09:51:13.021217+00	2026-04-24 09:51:13.02126+00	OH	130000.00	1	4	20
121	2026-04-24 09:51:13.037078+00	2026-04-24 09:51:13.037121+00	OH	120000.00	1	4	21
122	2026-04-24 09:51:13.053856+00	2026-04-24 09:51:13.0539+00	OH	130000.00	1	4	22
123	2026-04-24 09:51:13.070169+00	2026-04-24 09:51:13.070213+00	OH	150000.00	1	4	23
124	2026-04-24 09:51:13.087033+00	2026-04-24 09:51:13.087084+00	OH	150000.00	1	4	24
125	2026-04-24 09:51:13.103959+00	2026-04-24 09:51:13.104002+00	OH	130000.00	1	4	25
126	2026-04-24 09:51:13.119541+00	2026-04-24 09:51:13.119584+00	OH	130000.00	1	4	26
127	2026-04-24 09:51:13.135982+00	2026-04-24 09:51:13.136024+00	OH	120000.00	1	4	27
128	2026-04-24 09:51:13.154288+00	2026-04-24 09:51:13.154417+00	OH	150000.00	1	4	28
129	2026-04-24 09:51:13.169083+00	2026-04-24 09:51:13.169126+00	OH	130000.00	1	4	29
130	2026-04-24 09:51:13.185831+00	2026-04-24 09:51:13.185874+00	OH	130000.00	1	4	30
131	2026-04-24 09:51:13.202239+00	2026-04-24 09:51:13.202281+00	OH	120000.00	1	4	31
132	2026-04-24 09:51:13.219195+00	2026-04-24 09:51:13.219238+00	OH	130000.00	1	4	32
133	2026-04-24 09:51:13.235668+00	2026-04-24 09:51:13.235711+00	OH	200000.00	1	4	33
134	2026-04-24 09:51:13.253139+00	2026-04-24 09:51:13.253181+00	OH	160000.00	1	4	34
135	2026-04-24 09:51:13.269851+00	2026-04-24 09:51:13.269894+00	OH	160000.00	1	4	35
136	2026-04-24 09:51:13.290694+00	2026-04-24 09:51:13.290756+00	OH	200000.00	1	4	36
137	2026-04-24 09:51:13.311899+00	2026-04-24 09:51:13.311943+00	OH	200000.00	1	4	37
138	2026-04-24 09:51:13.328587+00	2026-04-24 09:51:13.328629+00	OH	200000.00	1	4	38
139	2026-04-24 09:51:13.345094+00	2026-04-24 09:51:13.345138+00	OH	85000.00	1	5	1
140	2026-04-24 09:51:13.36242+00	2026-04-24 09:51:13.362462+00	OH	95000.00	1	5	2
141	2026-04-24 09:51:13.378498+00	2026-04-24 09:51:13.37854+00	OH	85000.00	1	5	3
142	2026-04-24 09:51:13.395267+00	2026-04-24 09:51:13.395298+00	OH	95000.00	1	5	4
143	2026-04-24 09:51:13.411036+00	2026-04-24 09:51:13.411099+00	OH	95000.00	1	5	5
144	2026-04-24 09:51:13.427505+00	2026-04-24 09:51:13.427548+00	OH	85000.00	1	5	6
145	2026-04-24 09:51:13.443642+00	2026-04-24 09:51:13.443697+00	OH	85000.00	1	5	7
146	2026-04-24 09:51:13.460226+00	2026-04-24 09:51:13.460263+00	OH	95000.00	1	5	8
147	2026-04-24 09:51:13.475149+00	2026-04-24 09:51:13.475186+00	OH	95000.00	1	5	9
148	2026-04-24 09:51:13.494141+00	2026-04-24 09:51:13.494186+00	OH	95000.00	1	5	10
149	2026-04-24 09:51:13.51197+00	2026-04-24 09:51:13.511992+00	OH	85000.00	1	5	11
150	2026-04-24 09:51:13.523714+00	2026-04-24 09:51:13.523783+00	OH	105000.00	1	5	12
151	2026-04-24 09:51:13.543652+00	2026-04-24 09:51:13.543704+00	OH	130000.00	1	5	13
152	2026-04-24 09:51:13.559953+00	2026-04-24 09:51:13.559992+00	OH	95000.00	1	5	14
153	2026-04-24 09:51:13.577481+00	2026-04-24 09:51:13.577526+00	OH	100000.00	1	5	15
154	2026-04-24 09:51:13.59424+00	2026-04-24 09:51:13.594282+00	OH	100000.00	1	5	16
155	2026-04-24 09:51:13.611888+00	2026-04-24 09:51:13.611929+00	OH	115000.00	1	5	17
156	2026-04-24 09:51:13.627442+00	2026-04-24 09:51:13.627486+00	OH	105000.00	1	5	18
157	2026-04-24 09:51:13.645236+00	2026-04-24 09:51:13.645279+00	OH	100000.00	1	5	19
158	2026-04-24 09:51:13.662038+00	2026-04-24 09:51:13.662082+00	OH	95000.00	1	5	20
159	2026-04-24 09:51:13.677513+00	2026-04-24 09:51:13.677555+00	OH	85000.00	1	5	21
160	2026-04-24 09:51:13.695133+00	2026-04-24 09:51:13.695176+00	OH	95000.00	1	5	22
161	2026-04-24 09:51:13.711774+00	2026-04-24 09:51:13.711819+00	OH	105000.00	1	5	23
162	2026-04-24 09:51:13.727958+00	2026-04-24 09:51:13.728001+00	OH	105000.00	1	5	24
163	2026-04-24 09:51:13.744223+00	2026-04-24 09:51:13.744265+00	OH	95000.00	1	5	25
164	2026-04-24 09:51:13.778428+00	2026-04-24 09:51:13.778472+00	OH	95000.00	1	5	26
165	2026-04-24 09:51:13.793937+00	2026-04-24 09:51:13.79398+00	OH	85000.00	1	5	27
166	2026-04-24 09:51:13.810609+00	2026-04-24 09:51:13.810651+00	OH	105000.00	1	5	28
167	2026-04-24 09:51:13.844184+00	2026-04-24 09:51:13.844228+00	OH	95000.00	1	5	29
168	2026-04-24 09:51:13.861607+00	2026-04-24 09:51:13.86165+00	OH	95000.00	1	5	30
169	2026-04-24 09:51:13.89443+00	2026-04-24 09:51:13.894474+00	OH	85000.00	1	5	31
170	2026-04-24 09:51:13.911377+00	2026-04-24 09:51:13.91142+00	OH	95000.00	1	5	32
171	2026-04-24 09:51:13.930013+00	2026-04-24 09:51:13.930057+00	OH	140000.00	1	5	33
172	2026-04-24 09:51:14.028767+00	2026-04-24 09:51:14.028809+00	OH	115000.00	1	5	34
173	2026-04-24 09:51:14.052787+00	2026-04-24 09:51:14.052835+00	OH	115000.00	1	5	35
174	2026-04-24 09:51:14.069243+00	2026-04-24 09:51:14.069285+00	OH	140000.00	1	5	36
175	2026-04-24 09:51:14.08596+00	2026-04-24 09:51:14.086003+00	OH	140000.00	1	5	37
176	2026-04-24 09:51:14.10262+00	2026-04-24 09:51:14.102664+00	OH	140000.00	1	5	38
177	2026-04-24 09:51:14.119266+00	2026-04-24 09:51:14.119358+00	OH	120000.00	1	6	1
178	2026-04-24 09:51:14.136152+00	2026-04-24 09:51:14.136196+00	OH	130000.00	1	6	2
179	2026-04-24 09:51:14.152637+00	2026-04-24 09:51:14.15268+00	OH	130000.00	1	6	3
180	2026-04-24 09:51:14.169233+00	2026-04-24 09:51:14.169276+00	OH	130000.00	1	6	4
181	2026-04-24 09:51:14.186199+00	2026-04-24 09:51:14.186241+00	OH	130000.00	1	6	5
182	2026-04-24 09:51:14.202715+00	2026-04-24 09:51:14.202758+00	OH	120000.00	1	6	6
183	2026-04-24 09:51:14.219494+00	2026-04-24 09:51:14.219538+00	OH	120000.00	1	6	7
184	2026-04-24 09:51:14.236102+00	2026-04-24 09:51:14.236145+00	OH	130000.00	1	6	8
185	2026-04-24 09:51:14.269399+00	2026-04-24 09:51:14.269443+00	OH	130000.00	1	6	9
186	2026-04-24 09:51:14.286104+00	2026-04-24 09:51:14.286148+00	OH	130000.00	1	6	10
187	2026-04-24 09:51:14.302642+00	2026-04-24 09:51:14.302684+00	OH	120000.00	1	6	11
188	2026-04-24 09:51:14.327856+00	2026-04-24 09:51:14.3279+00	OH	150000.00	1	6	12
189	2026-04-24 09:51:14.344741+00	2026-04-24 09:51:14.344785+00	OH	180000.00	1	6	13
190	2026-04-24 09:51:14.361517+00	2026-04-24 09:51:14.36156+00	OH	130000.00	1	6	14
191	2026-04-24 09:51:14.386041+00	2026-04-24 09:51:14.386084+00	OH	140000.00	1	6	15
192	2026-04-24 09:51:14.402779+00	2026-04-24 09:51:14.40282+00	OH	140000.00	1	6	16
193	2026-04-24 09:51:14.41811+00	2026-04-24 09:51:14.418151+00	OH	160000.00	1	6	17
194	2026-04-24 09:51:14.444837+00	2026-04-24 09:51:14.44488+00	OH	150000.00	1	6	18
195	2026-04-24 09:51:14.461913+00	2026-04-24 09:51:14.461958+00	OH	140000.00	1	6	19
196	2026-04-24 09:51:14.478805+00	2026-04-24 09:51:14.478846+00	OH	130000.00	1	6	20
197	2026-04-24 09:51:14.495418+00	2026-04-24 09:51:14.495463+00	OH	120000.00	1	6	21
198	2026-04-24 09:51:14.512338+00	2026-04-24 09:51:14.512383+00	OH	130000.00	1	6	22
199	2026-04-24 09:51:14.528695+00	2026-04-24 09:51:14.528738+00	OH	150000.00	1	6	23
200	2026-04-24 09:51:14.545353+00	2026-04-24 09:51:14.545399+00	OH	150000.00	1	6	24
201	2026-04-24 09:51:14.561847+00	2026-04-24 09:51:14.56189+00	OH	130000.00	1	6	25
202	2026-04-24 09:51:14.578815+00	2026-04-24 09:51:14.578855+00	OH	130000.00	1	6	26
203	2026-04-24 09:51:14.595632+00	2026-04-24 09:51:14.595676+00	OH	120000.00	1	6	27
204	2026-04-24 09:51:14.612825+00	2026-04-24 09:51:14.612868+00	OH	150000.00	1	6	28
205	2026-04-24 09:51:14.628269+00	2026-04-24 09:51:14.628365+00	OH	130000.00	1	6	29
206	2026-04-24 09:51:14.652952+00	2026-04-24 09:51:14.652995+00	OH	130000.00	1	6	30
207	2026-04-24 09:51:14.668571+00	2026-04-24 09:51:14.668614+00	OH	120000.00	1	6	31
208	2026-04-24 09:51:14.686223+00	2026-04-24 09:51:14.686265+00	OH	130000.00	1	6	32
209	2026-04-24 09:51:14.711357+00	2026-04-24 09:51:14.7114+00	OH	200000.00	1	6	33
210	2026-04-24 09:51:14.728039+00	2026-04-24 09:51:14.728082+00	OH	160000.00	1	6	34
211	2026-04-24 09:51:14.744497+00	2026-04-24 09:51:14.74454+00	OH	160000.00	1	6	35
212	2026-04-24 09:51:14.769538+00	2026-04-24 09:51:14.76958+00	OH	200000.00	1	6	36
213	2026-04-24 09:51:14.787405+00	2026-04-24 09:51:14.787448+00	OH	200000.00	1	6	37
214	2026-04-24 09:51:14.804058+00	2026-04-24 09:51:14.804102+00	OH	200000.00	1	6	38
215	2026-05-11 12:18:56.083752+00	2026-05-11 12:18:56.083775+00	OH	370000.00	1	1	39
216	2026-05-11 12:18:56.138534+00	2026-05-11 12:18:56.138554+00	OH	370000.00	1	1	40
217	2026-05-11 12:18:56.156134+00	2026-05-11 12:18:56.156156+00	OH	370000.00	1	1	41
218	2026-05-11 12:18:56.172894+00	2026-05-11 12:18:56.172916+00	OH	370000.00	1	1	42
219	2026-05-11 12:18:56.189653+00	2026-05-11 12:18:56.189675+00	OH	370000.00	1	1	43
220	2026-05-11 12:18:56.206275+00	2026-05-11 12:18:56.206297+00	OH	370000.00	1	1	44
221	2026-05-11 12:18:56.222976+00	2026-05-11 12:18:56.222999+00	OH	370000.00	1	1	45
222	2026-05-11 12:18:56.247929+00	2026-05-11 12:18:56.247952+00	OH	370000.00	1	1	46
223	2026-05-11 12:18:56.264608+00	2026-05-11 12:18:56.264631+00	OH	370000.00	1	1	47
224	2026-05-11 12:18:56.281319+00	2026-05-11 12:18:56.281342+00	OH	370000.00	1	1	48
225	2026-05-11 12:18:56.297998+00	2026-05-11 12:18:56.29802+00	OH	370000.00	1	1	49
226	2026-05-11 12:18:56.314586+00	2026-05-11 12:18:56.314608+00	OH	370000.00	1	1	50
227	2026-05-11 12:18:56.33127+00	2026-05-11 12:18:56.331292+00	OH	370000.00	1	1	51
228	2026-05-11 12:18:56.347958+00	2026-05-11 12:18:56.347981+00	OH	370000.00	1	1	52
229	2026-05-11 12:18:56.364586+00	2026-05-11 12:18:56.364607+00	OH	370000.00	1	1	53
230	2026-05-11 12:18:56.381296+00	2026-05-11 12:18:56.381319+00	OH	370000.00	1	1	54
231	2026-05-11 12:18:56.397946+00	2026-05-11 12:18:56.397969+00	OH	370000.00	1	1	55
232	2026-05-11 12:18:56.414215+00	2026-05-11 12:18:56.414239+00	OH	370000.00	1	1	56
233	2026-05-11 12:18:56.430425+00	2026-05-11 12:18:56.430447+00	OH	370000.00	1	1	57
234	2026-05-11 12:18:56.448044+00	2026-05-11 12:18:56.448057+00	OH	370000.00	1	1	58
235	2026-05-11 12:18:56.464563+00	2026-05-11 12:18:56.464585+00	OH	370000.00	1	1	59
236	2026-05-11 12:18:56.480656+00	2026-05-11 12:18:56.480678+00	OH	370000.00	1	1	60
237	2026-05-11 12:18:56.498178+00	2026-05-11 12:18:56.49822+00	OH	370000.00	1	1	61
238	2026-05-11 12:18:56.514296+00	2026-05-11 12:18:56.514332+00	OH	370000.00	1	1	62
239	2026-05-11 12:18:56.531281+00	2026-05-11 12:18:56.531305+00	OH	370000.00	1	1	63
240	2026-05-11 12:18:56.547878+00	2026-05-11 12:18:56.5479+00	OH	370000.00	1	1	64
241	2026-05-11 12:18:56.564434+00	2026-05-11 12:18:56.564455+00	OH	370000.00	1	1	65
242	2026-05-11 12:18:56.581364+00	2026-05-11 12:18:56.581377+00	OH	370000.00	1	1	66
243	2026-05-11 12:18:56.597953+00	2026-05-11 12:18:56.597975+00	OH	370000.00	1	1	67
244	2026-05-11 12:18:56.614413+00	2026-05-11 12:18:56.614426+00	OH	370000.00	1	1	68
245	2026-05-11 12:18:56.631317+00	2026-05-11 12:18:56.631339+00	OH	370000.00	1	1	69
246	2026-05-11 12:18:56.648476+00	2026-05-11 12:18:56.648499+00	OH	370000.00	1	1	70
247	2026-05-11 12:18:56.673315+00	2026-05-11 12:18:56.673337+00	OH	110000.00	1	3	39
248	2026-05-11 12:18:56.690222+00	2026-05-11 12:18:56.690246+00	OH	110000.00	1	3	40
249	2026-05-11 12:18:56.706621+00	2026-05-11 12:18:56.706643+00	OH	110000.00	1	3	41
250	2026-05-11 12:18:56.72328+00	2026-05-11 12:18:56.723303+00	OH	110000.00	1	3	42
251	2026-05-11 12:18:56.739865+00	2026-05-11 12:18:56.739888+00	OH	110000.00	1	3	43
252	2026-05-11 12:18:56.756573+00	2026-05-11 12:18:56.756594+00	OH	110000.00	1	3	44
253	2026-05-11 12:18:56.773273+00	2026-05-11 12:18:56.773296+00	OH	110000.00	1	3	45
254	2026-05-11 12:18:56.789945+00	2026-05-11 12:18:56.789967+00	OH	110000.00	1	3	46
255	2026-05-11 12:18:56.806559+00	2026-05-11 12:18:56.806581+00	OH	110000.00	1	3	47
256	2026-05-11 12:18:56.823322+00	2026-05-11 12:18:56.823344+00	OH	110000.00	1	3	48
257	2026-05-11 12:18:56.839884+00	2026-05-11 12:18:56.839907+00	OH	110000.00	1	3	49
258	2026-05-11 12:18:56.856517+00	2026-05-11 12:18:56.856539+00	OH	110000.00	1	3	50
259	2026-05-11 12:18:56.873302+00	2026-05-11 12:18:56.873324+00	OH	110000.00	1	3	51
260	2026-05-11 12:18:56.889918+00	2026-05-11 12:18:56.889941+00	OH	110000.00	1	3	52
261	2026-05-11 12:18:56.90663+00	2026-05-11 12:18:56.906653+00	OH	110000.00	1	3	53
262	2026-05-11 12:18:56.923294+00	2026-05-11 12:18:56.923317+00	OH	110000.00	1	3	54
263	2026-05-11 12:18:56.939928+00	2026-05-11 12:18:56.93995+00	OH	110000.00	1	3	55
264	2026-05-11 12:18:56.956592+00	2026-05-11 12:18:56.956615+00	OH	110000.00	1	3	56
265	2026-05-11 12:18:56.973258+00	2026-05-11 12:18:56.973281+00	OH	110000.00	1	3	57
266	2026-05-11 12:18:56.989881+00	2026-05-11 12:18:56.989902+00	OH	110000.00	1	3	58
267	2026-05-11 12:18:57.006523+00	2026-05-11 12:18:57.006546+00	OH	110000.00	1	3	59
268	2026-05-11 12:18:57.023183+00	2026-05-11 12:18:57.023231+00	OH	110000.00	1	3	60
269	2026-05-11 12:18:57.039803+00	2026-05-11 12:18:57.039825+00	OH	110000.00	1	3	61
270	2026-05-11 12:18:57.056416+00	2026-05-11 12:18:57.056438+00	OH	110000.00	1	3	62
271	2026-05-11 12:18:57.07325+00	2026-05-11 12:18:57.073274+00	OH	110000.00	1	3	63
272	2026-05-11 12:18:57.089947+00	2026-05-11 12:18:57.089968+00	OH	110000.00	1	3	64
273	2026-05-11 12:18:57.10652+00	2026-05-11 12:18:57.106543+00	OH	110000.00	1	3	65
274	2026-05-11 12:18:57.123253+00	2026-05-11 12:18:57.123275+00	OH	110000.00	1	3	66
275	2026-05-11 12:18:57.139838+00	2026-05-11 12:18:57.139861+00	OH	110000.00	1	3	67
276	2026-05-11 12:18:57.156525+00	2026-05-11 12:18:57.156547+00	OH	110000.00	1	3	68
277	2026-05-11 12:18:57.173217+00	2026-05-11 12:18:57.173241+00	OH	110000.00	1	3	69
278	2026-05-11 12:18:57.189727+00	2026-05-11 12:18:57.18975+00	OH	110000.00	1	3	70
\.


--
-- Data for Name: spj_jenisspj; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spj_jenisspj (id, jenis_spj) FROM stdin;
1	Berangkat
2	Kembali
\.


--
-- Data for Name: spj_laporanperjalanan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spj_laporanperjalanan (id, created_at, updated_at, verif_status, verif_catatan, verified_at, judul, dasar_pelaksanaan, maksud_perjalanan, instansi_dikunjungi, waktu_pelaksanaan, hasil, penutup, foto_1, foto_2, foto_3, foto_4, pelaksana_id, spt_id, verified_by_id) FROM stdin;
\.


--
-- Data for Name: spj_penginapan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spj_penginapan (id, created_at, updated_at, nama_hotel, alamat_hotel, lama_menginap, harga_per_malam, bukti, pelaksana_id, spt_id, foto_hotel, latitude, longitude, nomor_kamar, tanggal_checkin, tanggal_checkout, tipe_kamar, verif_catatan, verif_status, verified_at, verified_by_id) FROM stdin;
\.


--
-- Data for Name: spj_pesawat; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spj_pesawat (id, created_at, updated_at, harga_tiket, bukti, jenis_spj_id, lokasi_bandara_id, pelaksana_id, spt_id, tujuan_bandara_id, kode_booking, nama_maskapai, nomor_tiket, tanggal_penerbangan, verif_catatan, verif_status, verified_at, verified_by_id) FROM stdin;
\.


--
-- Data for Name: spj_transport; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spj_transport (id, created_at, updated_at, biaya, bukti, jenis_spj_id, jenis_transportasi_id, lokasi_berangkat_id, pelaksana_id, spt_id, tujuan_id, verif_catatan, verif_status, verified_at, verified_by_id) FROM stdin;
\.


--
-- Data for Name: spj_uangharian; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spj_uangharian (id, created_at, updated_at, uang_harian_per_hari, total_uang_harian, pelaksana_id, spt_id, verif_catatan, verif_status, verified_at, verified_by_id) FROM stdin;
\.


--
-- Data for Name: spj_uangrepresentasi; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spj_uangrepresentasi (id, created_at, updated_at, biaya, pelaksana_id, spt_id, verif_catatan, verif_status, verified_at, verified_by_id) FROM stdin;
\.


--
-- Data for Name: umum_eselon; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_eselon (id, eselon, keterangan) FROM stdin;
1	I	Eselon I
2	II	Eselon II
3	III	Eselon III
4	IV	Eselon IV
5	Non Eselon	Staf
\.


--
-- Data for Name: umum_jenisjabatan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_jenisjabatan (id, nama, fungsi, keterangan) FROM stdin;
1	Defenitif	pejabat yang memegang jabatan secara tetap dan sah	Jabatan Tetap
2	Plt.	pejabat yang melaksanakan tugas rutin dari pejabat definitif yang berhalangan tetap	Pelaksana Tugas
3	Plh.	pejabat yang melaksanakan tugas rutin dari pejabat definitif yang berhalangan sementara	Pelaksana Harian
4	Pj.	menggantikan pejabat definitif kepala daerah yang berhalangan tetap	Penjabat
5	Pjs.	menggantikan pejabat definitif kepala daerah yang berhalangan sementara karena menjalankan cuti di luar tanggungan negara	Penjabat Sementara
\.


--
-- Data for Name: umum_kopsurat; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_kopsurat (id, font_family, region_font_size_pt, office_font_size_pt, address_font_size_pt, contact_font_size_pt, logo_width_px, logo_height_px, print_scale_percent, pemda_id, default_spd_number_format, default_spt_number_format, margin_bottom_mm, margin_left_mm, margin_right_mm, margin_top_mm) FROM stdin;
4	Arial, sans-serif	14	20	12	10	80	80	96	4	800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}	800.1.11.1/{nomor_urut}/SEKDA/{bulan}/{tahun}	1	1	1	1
1	Arial, sans-serif	14	20	12	10	160	0	90	2	800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}	800.1.11.1/{nomor_urut}/BKAD/{bulan}/{tahun}	1	1	1	1
2	Arial, sans-serif	14	20	10	10	160	0	96	3	800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}	800.1.11.1/{nomor_urut}/{bulan}/{tahun}	1	1	1	1
3	Arial, sans-serif	16	20	10	10	80	80	100	1	800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}	800.1.11.1/{nomor_urut}/BKAD/{bulan}/{tahun}	15	15	10	15
\.


--
-- Data for Name: umum_pangkat; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_pangkat (id, pangkat, golongan, ruang) FROM stdin;
1	Juru Muda	I	a
2	Juru Muda Tk.  I	I	b
3	Juru	I	c
4	Juru Tk.  I	I	d
5	Pengatur Muda	II	a
6	Pengatur Muda Tk.  I	II	b
7	Pengatur	II	c
8	Pengatur Tk. I	II	d
9	Penata Muda	III	a
10	Penata Muda Tk.  I	III	b
11	Penata	III	c
12	Penata Tk.  I	III	d
13	Pembina	IV	a
14	Pembina Tk.  I	IV	b
15	Pembina Utama Muda	IV	c
16	Pembina Utama Madya	IV	d
17	Pembina Utama	IV	e
18	Pemula	V	
19	Terampil	VI	
20	Terampil	VII	
21	Mahir	IX	
22	Penyelia	X	
23	Ahli Muda	XI	
24	Lektor	XII	
25	Ahli Madya	XIII	
26	Lektor Kepala	XIV	
27	Ahli Utama	XVI	
28	-	-	-
\.


--
-- Data for Name: umum_pegawai; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_pegawai (id, nip, nama, jabatan, tgl_lahir, jenis_jabatan_id, opd_id, pangkat_id, status_id, tingkat_id, eselon_id, foto) FROM stdin;
1	197305071992032001	Sri Lusi Masdiany, S.I.P.                                            	Sekretaris Badan Keuangan dan Aset Daerah	1973-05-07	1	27	14	1	3	3	\N
2	198004212009011002	M. Idris S.Pd.I, M.Si.	Kabid Aset	1980-04-21	1	27	12	1	3	3	\N
3	197604072009031002	Chairun Nasri Hutagaol, S.E.	Kabid Perbendaharaan	1976-04-07	1	27	13	1	3	3	\N
4	199408012018081001	Ashdillah Putra, S.Stp.	Kabid Anggaran	1994-08-01	1	27	11	1	3	3	\N
5	198302172002121004	Herdi Siagian, S.H.                                 	Kabid Akuntansi dan Pelaporan	1983-02-17	1	27	13	1	3	3	\N
6	196904241989032005	Nilawati, S.H.                                          	Analis Perencana Muda	1969-04-24	1	27	12	1	4	4	\N
7	197210301993032004	Sumarmiati, S.E.                                    	Kasubbid Perbendaharaan	1972-10-30	1	27	12	1	4	4	\N
8	197902232000032002	Elvirawati,  S.E.                                          	Kasubbid Akuntansi dan Pelaporan Penerimaan	1979-02-23	1	27	12	1	4	4	\N
9	197807152009011004	Budi Syahriza, S.H.                  	Kasubbid Akuntansi dan Pelaporan Pengeluaran	1978-07-15	1	27	11	1	4	4	\N
10	197807222009032003	Dwi Priyayi Sugesti, S.E.                       	Kasubbid Pencatatan, Pelaporan dan Analisa Kebutuhan Barang Daerah	1978-07-22	1	27	12	1	4	4	\N
11	196806011993032002	Vera Yuninda                                	Kasubbag Umum Dan Kepegawaian	1968-06-01	1	27	12	1	4	4	\N
12	197604142009032002	Erna Komalasari, S.T.                                     	Kasubbid Pemeliharaan dan Penghapusan	1976-04-14	1	27	11	1	4	4	\N
13	198309142005022001	Lusy Elidha, S.E.                                  	Kasubbid Pengelolaan Kas	1983-09-14	1	27	12	1	4	4	\N
14	198004132009011003	Afri Chandra Kirana, S.E.                               	Kasubbid Anggaran I	1980-04-13	1	27	11	1	4	4	\N
15	198405182010012008	Kusuma Aprina Siagian, S.E.                                 	Kasubbid Anggaran II	1984-05-18	1	27	10	1	4	4	\N
17	198112072009011004	Guslan Harahap, S.M.	Penelaah Teknis Kebijakan	1981-12-07	1	27	8	1	4	5	\N
18	196806031992032004	Nurhamidah Siregar	Pengelola Data Dan Informasi	1968-06-03	1	27	10	1	4	5	\N
19	198105062010011004	Irvan Syahputra, S.M.	Pengelola Data Dan Informasi	1981-05-06	1	27	9	1	4	5	\N
20	198606082009032007	Nasiah, S.E.	Penelaah Teknis Kebijakan	1986-06-08	1	27	12	1	4	5	\N
21	198404292010011002	Firmansyah Tarigan S	Administrasi Perkantoran	1984-04-29	1	27	8	1	4	5	\N
22	197507212009012003	Nuraini, S. Sos	Penelaah Teknis Kebijakan	1975-07-21	1	27	12	1	4	5	\N
23	197806052009012003	Yulita Elfika Siregar, S.E.	Penelaah Teknis Kebijakan	1978-06-05	1	27	11	1	4	5	\N
24	197410282008012002	Rosdawaty, S.E.	Pengelola Data Dan Informasi	1974-10-28	1	27	11	1	4	5	\N
16	198109022009012004	Kamis Riati	Pengelola Data Dan Informasi	1981-09-02	1	27	9	1	4	5	\N
48	197305071992032001	Sri Lusi Masdiany, S.I.P.	Plt. Kepala Badan Keuangan dan Aset Daerah	1973-05-07	2	27	14	1	2	2	\N
26	198010262009011002	Hendrik , S.M.	Administrasi Perkantoran	1980-10-26	1	27	9	1	4	5	\N
27	197210262008011001	Muh. Arfi	Administrasi Perkantoran	1972-10-26	1	27	5	1	4	5	\N
47	199501172025212059	Thivani Amanda Tanjung	Operator Layanan Operasional	1995-01-17	1	27	\N	3	4	5	\N
46	199009292025212132	Lisa Maya Sarie	Operator Layanan Operasional	1990-09-29	1	27	\N	3	4	5	\N
45	198703072025211140	M.Yusuf Butar Butar	Penata Layanan Operasional	1987-03-07	1	27	\N	3	4	5	\N
28	197811012005022001	Herlin Tanujaya, S.E.	Penelaah Teknis Kebijakan	1978-11-01	1	27	12	1	4	5	\N
29	197009122002122004	Rosmidawati, S.E.	Penelaah Teknis Kebijakan	1970-09-12	1	27	12	1	4	5	\N
44	198208112025211058	Muhammad.Arif Effendi, S.E.	Penata Layanan Operasional	1982-08-11	1	27	\N	3	4	5	\N
43	198303262025212016	Tuti Mulyani	Pengadministrasi Pekantoran	1983-03-26	1	27	18	2	4	5	\N
39	197403092025212002	Nani Susanti	Pengadministrasi Pekantoran	1974-03-09	1	27	18	2	4	5	\N
30	198206262010012001	T. Dhani Vaulina	Penelaah Teknis Kebijakan	1982-06-26	1	27	10	1	4	5	\N
31	198101122009011004	Muhammad Syafri	Pengelola Data Dan Informasi	1981-01-12	1	27	9	1	4	5	\N
32	196812061989032005	Heryanti, S.H.	Penelaah Teknis Kebijakan	1968-12-06	1	27	12	1	4	5	\N
33	197808142005022002	Rubiah, S.S.	Pengelola Data Dan Informasi	1978-08-14	1	27	11	1	4	5	\N
34	198805202022031001	Eddy Haris Siregar, S.E.	Penelaah Teknis Kebijakan	1988-05-20	1	27	9	1	4	5	\N
35	199611242025062003	Dessy Permatasari, S.Ak.	Analis Keuangan Pusat Dan Daerah Ahli Pertama	1996-11-24	1	27	9	1	4	5	\N
36	200203022025062003	Pratiwi, S.Ak.	Analis Keuangan Pusat Dan Daerah Ahli Pertama	2002-03-02	1	27	9	1	4	5	\N
37	197303262006041006	Irwan	Administrasi Perkantoran	1973-03-26	1	27	7	1	4	5	\N
38	197903252008011002	Oman Surahman	Pengelola Data Dan Informasi	1979-03-25	1	27	5	1	4	5	\N
41	199612312025212019	Dinda Khofifah, A.Md	Pengelola Layanan Operasional	1996-12-31	1	27	20	2	4	5	\N
42	198404142025211024	Tri Agung Anugrah, S. Kom	Penata Layanan Operasional	1984-04-14	1	27	21	2	4	5	\N
49	196703071993031020	Budi Sianturi	Kepala Dinas Pendidikan	1967-03-07	1	1	13	1	2	2	\N
50	197305071992032023	Helana Hutasoit	Kepala Bidang Sekolah Dasar	1973-05-07	1	1	12	1	3	3	\N
25	198309292011011013	Rahmad Saleh Sitorus, S.Kom.	Pengelola Data Dan Informasi	1983-09-29	1	27	10	1	4	5	\N
40	198508312025212011	Tri Eva Yanti	Pengadministrasi Pekantoran	1985-08-31	1	27	18	2	4	5	\N
51	196612261991031003	Drs. Supriyanto, M.Pd	Kepala Badan Perencanaan Pembangunan Riset dan Inovasi Daerah	1966-12-26	1	26	15	1	2	2	\N
52	-	M. Hasan Asyari	Supir	1972-11-07	1	27	28	4	4	5	\N
\.


--
-- Data for Name: umum_pemda; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_pemda (id, nama_pemda, nama_dinas_id, alamat, telepon, email, logo, website, ibukota, nama_kabupaten, password_standar) FROM stdin;
2	PEMERINTAH KABUPATEN ASAHAN	57	\N	\N	\N	pemda_logos/lambang-burung-garuda-333_ratio-16x9.webp	\N	Kisaran	\N	
3	PEMERINTAH KABUPATEN ASAHAN	58	\N	\N	\N	pemda_logos/lambang-burung-garuda-333_ratio-16x9_OjzwZoG.webp	\N	Kisaran	\N	
4	PEMERINTAH KABUPATEN ASAHAN	24	Jalan Jenderal Sudirman No. 5 Telepon 41928	K I S A R A N - 2 1 2 1 6	\N	pemda_logos/Logo_kabupaten_asahan_HQ7aNku.gif	\N	Kisaran	Asahan	
1	PEMERINTAH KABUPATEN ASAHAN	27	JALAN TURI NO. 7 KISARAN - 2 1 2 1 6	\N	asahanbkad@gmail.com	pemda_logos/Logo_kabupaten_asahan.gif	https://bpkad.asahankab.go.id/	Kisaran	Asahan	bkadasahan
\.


--
-- Data for Name: umum_penandatangan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_penandatangan (id, nama, nip, tugas, jenis_jabatan_id, opd_id, pangkat_id) FROM stdin;
1	Taufik Zainal Abidin	\N	Bupati	1	57	\N
2	Rianto	\N	Wakil Bupati	1	58	\N
3	Sri Lusi Masdiany, S.I.P.	197305071992032001	Kepala	2	27	14
4	M. Idris, S.Pd.I.,M.Si.	198004212009011002	PPK	1	27	13
6	Zainal Aripin Sinaga	196703071993031010	Sekretaris Daerah	1	24	15
\.


--
-- Data for Name: umum_statusasn; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_statusasn (id, nama) FROM stdin;
1	PNS
2	PPPK
3	PPPKPW
4	Non ASN
\.


--
-- Data for Name: umum_tingkat; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umum_tingkat (id, tingkat, ket, kapal, keretaapian, lainnya, pesawat) FROM stdin;
1	A	Bupati/ Wakil Bupati dan Pimpinan DPRD	Vip/ Kelas I A	Eksekutif	Sesuai Kenyataan	Bisnis
2	B	Pejabat Eselon II (Pejabat Pimpinan Tinggi Pratama) dan Anggota DPRD	Kelas I B	Eksekutif	Sesuai Kenyataan	Ekonomi
3	C	Pejabat Eselon III (Pejabat Administrator), Pejabat Fungsional Ahli Utama, Pejabat Fungsional Ahli Madya, dan PNS Golongan IV (Jabatan Pelaksana)	Kelas I B	Eksekutif	Sesuai Kenyataan	Ekonomi
4	D	Pejabat Eselon IV (Pejabat Pengawas), Jafung Ahli Muda, Jafung Ahli Pratama, Jafung Mahir, Jafung Penyelia, ASN Gol. III (JP), Jafung Terampil, ASN Gol. II dan Gol. I (JP), PPPK	Kelas I B	Eksekutif	Sesuai Kenyataan	Ekonomi
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 194, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 13, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 43, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 65, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 115, true);


--
-- Name: menus_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menus_menu_id_seq', 5, true);


--
-- Name: menus_rolepermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menus_rolepermission_id_seq', 70, true);


--
-- Name: menus_submenu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menus_submenu_id_seq', 35, true);


--
-- Name: perintah_pelaksana_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.perintah_pelaksana_id_seq', 56, true);


--
-- Name: perintah_pemberitugas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.perintah_pemberitugas_id_seq', 27, true);


--
-- Name: perintah_spt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.perintah_spt_id_seq', 19, true);


--
-- Name: perintah_spt_kota_tujuan_tambahan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.perintah_spt_kota_tujuan_tambahan_id_seq', 1, false);


--
-- Name: perintah_ttdsptspd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.perintah_ttdsptspd_id_seq', 10, true);


--
-- Name: profiles_opd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profiles_opd_id_seq', 58, true);


--
-- Name: profiles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profiles_role_id_seq', 2, true);


--
-- Name: profiles_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profiles_userprofile_id_seq', 6, true);


--
-- Name: spd_dasarperaturan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_dasarperaturan_id_seq', 1, true);


--
-- Name: spd_jeniskegiatan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_jeniskegiatan_id_seq', 6, true);


--
-- Name: spd_jenisspd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_jenisspd_id_seq', 3, true);


--
-- Name: spd_jenistransportasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_jenistransportasi_id_seq', 3, true);


--
-- Name: spd_lokasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_lokasi_id_seq', 93, true);


--
-- Name: spd_standardpenginapan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_standardpenginapan_id_seq', 281, true);


--
-- Name: spd_standardpesawat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_standardpesawat_id_seq', 1, false);


--
-- Name: spd_standardrepresentasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_standardrepresentasi_id_seq', 1, false);


--
-- Name: spd_standardtransportasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_standardtransportasi_id_seq', 102, true);


--
-- Name: spd_standarduangharian_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spd_standarduangharian_id_seq', 278, true);


--
-- Name: spj_jenisspj_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spj_jenisspj_id_seq', 2, true);


--
-- Name: spj_laporanperjalanan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spj_laporanperjalanan_id_seq', 1, false);


--
-- Name: spj_penginapan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spj_penginapan_id_seq', 1, false);


--
-- Name: spj_pesawat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spj_pesawat_id_seq', 1, false);


--
-- Name: spj_transport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spj_transport_id_seq', 1, false);


--
-- Name: spj_uangharian_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spj_uangharian_id_seq', 1, false);


--
-- Name: spj_uangrepresentasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spj_uangrepresentasi_id_seq', 1, false);


--
-- Name: umum_eselon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_eselon_id_seq', 5, true);


--
-- Name: umum_jenisjabatan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_jenisjabatan_id_seq', 5, true);


--
-- Name: umum_kopsurat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_kopsurat_id_seq', 5, true);


--
-- Name: umum_pangkat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_pangkat_id_seq', 28, true);


--
-- Name: umum_pegawai_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_pegawai_id_seq', 52, true);


--
-- Name: umum_pemda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_pemda_id_seq', 5, true);


--
-- Name: umum_penandatangan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_penandatangan_id_seq', 8, true);


--
-- Name: umum_statusasn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_statusasn_id_seq', 4, true);


--
-- Name: umum_tingkat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umum_tingkat_id_seq', 4, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: menus_menu menus_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus_menu
    ADD CONSTRAINT menus_menu_pkey PRIMARY KEY (id);


--
-- Name: menus_rolepermission menus_rolepermission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus_rolepermission
    ADD CONSTRAINT menus_rolepermission_pkey PRIMARY KEY (id);


--
-- Name: menus_rolepermission menus_rolepermission_role_id_submenu_id_c26af5f6_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus_rolepermission
    ADD CONSTRAINT menus_rolepermission_role_id_submenu_id_c26af5f6_uniq UNIQUE (role_id, submenu_id);


--
-- Name: menus_submenu menus_submenu_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus_submenu
    ADD CONSTRAINT menus_submenu_pkey PRIMARY KEY (id);


--
-- Name: perintah_pelaksana perintah_pelaksana_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_pelaksana
    ADD CONSTRAINT perintah_pelaksana_pkey PRIMARY KEY (id);


--
-- Name: perintah_pemberitugas perintah_pemberitugas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_pemberitugas
    ADD CONSTRAINT perintah_pemberitugas_pkey PRIMARY KEY (id);


--
-- Name: perintah_spt_kota_tujuan_tambahan perintah_spt_kota_tujuan_spt_id_lokasi_id_fa6c345c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_spt_kota_tujuan_tambahan
    ADD CONSTRAINT perintah_spt_kota_tujuan_spt_id_lokasi_id_fa6c345c_uniq UNIQUE (spt_id, lokasi_id);


--
-- Name: perintah_spt_kota_tujuan_tambahan perintah_spt_kota_tujuan_tambahan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_spt_kota_tujuan_tambahan
    ADD CONSTRAINT perintah_spt_kota_tujuan_tambahan_pkey PRIMARY KEY (id);


--
-- Name: perintah_spt perintah_spt_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_spt
    ADD CONSTRAINT perintah_spt_pkey PRIMARY KEY (id);


--
-- Name: perintah_ttdsptspd perintah_ttdsptspd_pemberi_tugas_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_ttdsptspd
    ADD CONSTRAINT perintah_ttdsptspd_pemberi_tugas_id_key UNIQUE (pemberi_tugas_id);


--
-- Name: perintah_ttdsptspd perintah_ttdsptspd_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_ttdsptspd
    ADD CONSTRAINT perintah_ttdsptspd_pkey PRIMARY KEY (id);


--
-- Name: profiles_opd profiles_opd_nama_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_opd
    ADD CONSTRAINT profiles_opd_nama_key UNIQUE (nama);


--
-- Name: profiles_opd profiles_opd_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_opd
    ADD CONSTRAINT profiles_opd_pkey PRIMARY KEY (id);


--
-- Name: profiles_role profiles_role_nama_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_role
    ADD CONSTRAINT profiles_role_nama_key UNIQUE (nama);


--
-- Name: profiles_role profiles_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_role
    ADD CONSTRAINT profiles_role_pkey PRIMARY KEY (id);


--
-- Name: profiles_userprofile profiles_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_userprofile
    ADD CONSTRAINT profiles_userprofile_pkey PRIMARY KEY (id);


--
-- Name: profiles_userprofile profiles_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_userprofile
    ADD CONSTRAINT profiles_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: spd_dasarperaturan spd_dasarperaturan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_dasarperaturan
    ADD CONSTRAINT spd_dasarperaturan_pkey PRIMARY KEY (id);


--
-- Name: spd_jeniskegiatan spd_jeniskegiatan_nama_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_jeniskegiatan
    ADD CONSTRAINT spd_jeniskegiatan_nama_key UNIQUE (nama);


--
-- Name: spd_jeniskegiatan spd_jeniskegiatan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_jeniskegiatan
    ADD CONSTRAINT spd_jeniskegiatan_pkey PRIMARY KEY (id);


--
-- Name: spd_jenisspd spd_jenisspd_nama_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_jenisspd
    ADD CONSTRAINT spd_jenisspd_nama_key UNIQUE (nama);


--
-- Name: spd_jenisspd spd_jenisspd_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_jenisspd
    ADD CONSTRAINT spd_jenisspd_pkey PRIMARY KEY (id);


--
-- Name: spd_jenistransportasi spd_jenistransportasi_nama_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_jenistransportasi
    ADD CONSTRAINT spd_jenistransportasi_nama_key UNIQUE (nama);


--
-- Name: spd_jenistransportasi spd_jenistransportasi_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_jenistransportasi
    ADD CONSTRAINT spd_jenistransportasi_pkey PRIMARY KEY (id);


--
-- Name: spd_lokasi spd_lokasi_lokasi_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_lokasi
    ADD CONSTRAINT spd_lokasi_lokasi_key UNIQUE (lokasi);


--
-- Name: spd_lokasi spd_lokasi_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_lokasi
    ADD CONSTRAINT spd_lokasi_pkey PRIMARY KEY (id);


--
-- Name: spd_standardpenginapan spd_standardpenginapan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpenginapan
    ADD CONSTRAINT spd_standardpenginapan_pkey PRIMARY KEY (id);


--
-- Name: spd_standardpesawat spd_standardpesawat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpesawat
    ADD CONSTRAINT spd_standardpesawat_pkey PRIMARY KEY (id);


--
-- Name: spd_standardrepresentasi spd_standardrepresentasi_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardrepresentasi
    ADD CONSTRAINT spd_standardrepresentasi_pkey PRIMARY KEY (id);


--
-- Name: spd_standardtransportasi spd_standardtransportasi_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardtransportasi
    ADD CONSTRAINT spd_standardtransportasi_pkey PRIMARY KEY (id);


--
-- Name: spd_standarduangharian spd_standarduangharian_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standarduangharian
    ADD CONSTRAINT spd_standarduangharian_pkey PRIMARY KEY (id);


--
-- Name: spj_jenisspj spj_jenisspj_jenis_spj_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_jenisspj
    ADD CONSTRAINT spj_jenisspj_jenis_spj_key UNIQUE (jenis_spj);


--
-- Name: spj_jenisspj spj_jenisspj_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_jenisspj
    ADD CONSTRAINT spj_jenisspj_pkey PRIMARY KEY (id);


--
-- Name: spj_laporanperjalanan spj_laporanperjalanan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_laporanperjalanan
    ADD CONSTRAINT spj_laporanperjalanan_pkey PRIMARY KEY (id);


--
-- Name: spj_laporanperjalanan spj_laporanperjalanan_spt_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_laporanperjalanan
    ADD CONSTRAINT spj_laporanperjalanan_spt_id_key UNIQUE (spt_id);


--
-- Name: spj_penginapan spj_penginapan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_penginapan
    ADD CONSTRAINT spj_penginapan_pkey PRIMARY KEY (id);


--
-- Name: spj_pesawat spj_pesawat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_pesawat
    ADD CONSTRAINT spj_pesawat_pkey PRIMARY KEY (id);


--
-- Name: spj_transport spj_transport_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_transport
    ADD CONSTRAINT spj_transport_pkey PRIMARY KEY (id);


--
-- Name: spj_uangharian spj_uangharian_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_uangharian
    ADD CONSTRAINT spj_uangharian_pkey PRIMARY KEY (id);


--
-- Name: spj_uangrepresentasi spj_uangrepresentasi_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_uangrepresentasi
    ADD CONSTRAINT spj_uangrepresentasi_pkey PRIMARY KEY (id);


--
-- Name: umum_eselon umum_eselon_eselon_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_eselon
    ADD CONSTRAINT umum_eselon_eselon_key UNIQUE (eselon);


--
-- Name: umum_eselon umum_eselon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_eselon
    ADD CONSTRAINT umum_eselon_pkey PRIMARY KEY (id);


--
-- Name: umum_jenisjabatan umum_jenisjabatan_nama_bcb554f6_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_jenisjabatan
    ADD CONSTRAINT umum_jenisjabatan_nama_bcb554f6_uniq UNIQUE (nama);


--
-- Name: umum_jenisjabatan umum_jenisjabatan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_jenisjabatan
    ADD CONSTRAINT umum_jenisjabatan_pkey PRIMARY KEY (id);


--
-- Name: umum_kopsurat umum_kopsurat_pemda_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_kopsurat
    ADD CONSTRAINT umum_kopsurat_pemda_id_key UNIQUE (pemda_id);


--
-- Name: umum_kopsurat umum_kopsurat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_kopsurat
    ADD CONSTRAINT umum_kopsurat_pkey PRIMARY KEY (id);


--
-- Name: umum_pangkat umum_pangkat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pangkat
    ADD CONSTRAINT umum_pangkat_pkey PRIMARY KEY (id);


--
-- Name: umum_pegawai umum_pegawai_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pegawai
    ADD CONSTRAINT umum_pegawai_pkey PRIMARY KEY (id);


--
-- Name: umum_pemda umum_pemda_nama_dinas_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pemda
    ADD CONSTRAINT umum_pemda_nama_dinas_key UNIQUE (nama_dinas_id);


--
-- Name: umum_pemda umum_pemda_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pemda
    ADD CONSTRAINT umum_pemda_pkey PRIMARY KEY (id);


--
-- Name: umum_penandatangan umum_penandatangan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_penandatangan
    ADD CONSTRAINT umum_penandatangan_pkey PRIMARY KEY (id);


--
-- Name: umum_statusasn umum_statusasn_nama_818a149d_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_statusasn
    ADD CONSTRAINT umum_statusasn_nama_818a149d_uniq UNIQUE (nama);


--
-- Name: umum_statusasn umum_statusasn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_statusasn
    ADD CONSTRAINT umum_statusasn_pkey PRIMARY KEY (id);


--
-- Name: umum_tingkat umum_tingkat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_tingkat
    ADD CONSTRAINT umum_tingkat_pkey PRIMARY KEY (id);


--
-- Name: umum_tingkat umum_tingkat_tingkat_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_tingkat
    ADD CONSTRAINT umum_tingkat_tingkat_key UNIQUE (tingkat);


--
-- Name: umum_penandatangan uniq_penandatangan_nama_tugas_jenis_jabatan_opd; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_penandatangan
    ADD CONSTRAINT uniq_penandatangan_nama_tugas_jenis_jabatan_opd UNIQUE (nama, tugas, jenis_jabatan_id, opd_id);


--
-- Name: umum_pangkat unique_pangkat_golongan_ruang; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pangkat
    ADD CONSTRAINT unique_pangkat_golongan_ruang UNIQUE (pangkat, golongan, ruang);


--
-- Name: umum_pegawai unique_pegawai_nip_eselon_jenis_jabatan; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pegawai
    ADD CONSTRAINT unique_pegawai_nip_eselon_jenis_jabatan UNIQUE (nip, eselon_id, jenis_jabatan_id);


--
-- Name: perintah_pemberitugas unique_pemberi_tugas_spt_penandatangan; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_pemberitugas
    ADD CONSTRAINT unique_pemberi_tugas_spt_penandatangan UNIQUE (spt_id, penandatangan_id);


--
-- Name: spd_standardpenginapan unique_penginapan_lokasi_tingkat_dasar_peraturan; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpenginapan
    ADD CONSTRAINT unique_penginapan_lokasi_tingkat_dasar_peraturan UNIQUE (lokasi_id, tingkat_id, dasar_peraturan_id);


--
-- Name: spd_standardpesawat unique_pesawat_asal_tujuan_tingkat_dasar_peraturan; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpesawat
    ADD CONSTRAINT unique_pesawat_asal_tujuan_tingkat_dasar_peraturan UNIQUE (kota_asal_id, kota_tujuan_id, tingkat_id, dasar_peraturan_id);


--
-- Name: spd_standardrepresentasi unique_representasi_tingkat_spd_dasar_peraturan; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardrepresentasi
    ADD CONSTRAINT unique_representasi_tingkat_spd_dasar_peraturan UNIQUE (tingkat_spd_id, jenis_spd_id, dasar_peraturan_id);


--
-- Name: spd_standardtransportasi unique_transportasi_jenis_kota_dasar_peraturan; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardtransportasi
    ADD CONSTRAINT unique_transportasi_jenis_kota_dasar_peraturan UNIQUE (jenis_transportasi_id, kota_tujuan_id, dasar_peraturan_id);


--
-- Name: spd_standarduangharian unique_uang_harian_lokasi_kegiatan_dasar_peraturan; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standarduangharian
    ADD CONSTRAINT unique_uang_harian_lokasi_kegiatan_dasar_peraturan UNIQUE (lokasi_id, jenis_kegiatan_id, dasar_peraturan_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: menus_rolepermission_role_id_e75d12b7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX menus_rolepermission_role_id_e75d12b7 ON public.menus_rolepermission USING btree (role_id);


--
-- Name: menus_rolepermission_submenu_id_16f03829; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX menus_rolepermission_submenu_id_16f03829 ON public.menus_rolepermission USING btree (submenu_id);


--
-- Name: menus_submenu_menu_id_160cb379; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX menus_submenu_menu_id_160cb379 ON public.menus_submenu USING btree (menu_id);


--
-- Name: perintah_pelaksana_nama_id_4e3b5fe4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX perintah_pelaksana_nama_id_4e3b5fe4 ON public.perintah_pelaksana USING btree (nama_id);


--
-- Name: perintah_pelaksana_spt_id_d06c47a0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX perintah_pelaksana_spt_id_d06c47a0 ON public.perintah_pelaksana USING btree (spt_id);


--
-- Name: perintah_pemberitugas_penandatangan_id_8de52a83; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX perintah_pemberitugas_penandatangan_id_8de52a83 ON public.perintah_pemberitugas USING btree (penandatangan_id);


--
-- Name: perintah_pemberitugas_spt_id_5dac4e73; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX perintah_pemberitugas_spt_id_5dac4e73 ON public.perintah_pemberitugas USING btree (spt_id);


--
-- Name: perintah_spt_jenis_kegiatan_id_5633ddcd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX perintah_spt_jenis_kegiatan_id_5633ddcd ON public.perintah_spt USING btree (jenis_kegiatan_id);


--
-- Name: perintah_spt_kota_tujuan_id_44be4bdc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX perintah_spt_kota_tujuan_id_44be4bdc ON public.perintah_spt USING btree (kota_tujuan_id);


--
-- Name: perintah_spt_kota_tujuan_tambahan_lokasi_id_b8b1010b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX perintah_spt_kota_tujuan_tambahan_lokasi_id_b8b1010b ON public.perintah_spt_kota_tujuan_tambahan USING btree (lokasi_id);


--
-- Name: perintah_spt_kota_tujuan_tambahan_spt_id_e5374b99; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX perintah_spt_kota_tujuan_tambahan_spt_id_e5374b99 ON public.perintah_spt_kota_tujuan_tambahan USING btree (spt_id);


--
-- Name: profiles_opd_nama_5050e697_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX profiles_opd_nama_5050e697_like ON public.profiles_opd USING btree (nama varchar_pattern_ops);


--
-- Name: profiles_role_nama_be00b652_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX profiles_role_nama_be00b652_like ON public.profiles_role USING btree (nama varchar_pattern_ops);


--
-- Name: profiles_userprofile_opd_id_92cf6435; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX profiles_userprofile_opd_id_92cf6435 ON public.profiles_userprofile USING btree (opd_id);


--
-- Name: profiles_userprofile_role_id_05631c9c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX profiles_userprofile_role_id_05631c9c ON public.profiles_userprofile USING btree (role_id);


--
-- Name: spd_jeniskegiatan_nama_5be3d9d0_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_jeniskegiatan_nama_5be3d9d0_like ON public.spd_jeniskegiatan USING btree (nama varchar_pattern_ops);


--
-- Name: spd_jenisspd_nama_cd359412_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_jenisspd_nama_cd359412_like ON public.spd_jenisspd USING btree (nama varchar_pattern_ops);


--
-- Name: spd_jenistransportasi_nama_4eff6df1_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_jenistransportasi_nama_4eff6df1_like ON public.spd_jenistransportasi USING btree (nama varchar_pattern_ops);


--
-- Name: spd_lokasi_jenis_spd_id_986735bc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_lokasi_jenis_spd_id_986735bc ON public.spd_lokasi USING btree (jenis_spd_id);


--
-- Name: spd_lokasi_lokasi_a1486dc6_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_lokasi_lokasi_a1486dc6_like ON public.spd_lokasi USING btree (lokasi varchar_pattern_ops);


--
-- Name: spd_standardpenginapan_dasar_peraturan_id_0bfe7347; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardpenginapan_dasar_peraturan_id_0bfe7347 ON public.spd_standardpenginapan USING btree (dasar_peraturan_id);


--
-- Name: spd_standardpenginapan_lokasi_id_ebff99ab; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardpenginapan_lokasi_id_ebff99ab ON public.spd_standardpenginapan USING btree (lokasi_id);


--
-- Name: spd_standardpenginapan_tingkat_id_227cbcc0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardpenginapan_tingkat_id_227cbcc0 ON public.spd_standardpenginapan USING btree (tingkat_id);


--
-- Name: spd_standardpesawat_dasar_peraturan_id_81f2291b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardpesawat_dasar_peraturan_id_81f2291b ON public.spd_standardpesawat USING btree (dasar_peraturan_id);


--
-- Name: spd_standardpesawat_kota_asal_id_3ecfa369; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardpesawat_kota_asal_id_3ecfa369 ON public.spd_standardpesawat USING btree (kota_asal_id);


--
-- Name: spd_standardpesawat_kota_tujuan_id_282f3121; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardpesawat_kota_tujuan_id_282f3121 ON public.spd_standardpesawat USING btree (kota_tujuan_id);


--
-- Name: spd_standardpesawat_tingkat_id_b55f4198; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardpesawat_tingkat_id_b55f4198 ON public.spd_standardpesawat USING btree (tingkat_id);


--
-- Name: spd_standardrepresentasi_dasar_peraturan_id_317cdf7b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardrepresentasi_dasar_peraturan_id_317cdf7b ON public.spd_standardrepresentasi USING btree (dasar_peraturan_id);


--
-- Name: spd_standardrepresentasi_jenis_spd_id_d975ab10; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardrepresentasi_jenis_spd_id_d975ab10 ON public.spd_standardrepresentasi USING btree (jenis_spd_id);


--
-- Name: spd_standardrepresentasi_tingkat_spd_id_40a75aba; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardrepresentasi_tingkat_spd_id_40a75aba ON public.spd_standardrepresentasi USING btree (tingkat_spd_id);


--
-- Name: spd_standardtransportasi_dasar_peraturan_id_9956d460; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardtransportasi_dasar_peraturan_id_9956d460 ON public.spd_standardtransportasi USING btree (dasar_peraturan_id);


--
-- Name: spd_standardtransportasi_jenis_transportasi_id_6b515fb4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardtransportasi_jenis_transportasi_id_6b515fb4 ON public.spd_standardtransportasi USING btree (jenis_transportasi_id);


--
-- Name: spd_standardtransportasi_kota_tujuan_id_b7a6a2e7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standardtransportasi_kota_tujuan_id_b7a6a2e7 ON public.spd_standardtransportasi USING btree (kota_tujuan_id);


--
-- Name: spd_standarduangharian_dasar_peraturan_id_472e4728; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standarduangharian_dasar_peraturan_id_472e4728 ON public.spd_standarduangharian USING btree (dasar_peraturan_id);


--
-- Name: spd_standarduangharian_jenis_kegiatan_id_034ff9c4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standarduangharian_jenis_kegiatan_id_034ff9c4 ON public.spd_standarduangharian USING btree (jenis_kegiatan_id);


--
-- Name: spd_standarduangharian_lokasi_id_efa10a7a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spd_standarduangharian_lokasi_id_efa10a7a ON public.spd_standarduangharian USING btree (lokasi_id);


--
-- Name: spj_jenisspj_jenis_spj_3f362204_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_jenisspj_jenis_spj_3f362204_like ON public.spj_jenisspj USING btree (jenis_spj varchar_pattern_ops);


--
-- Name: spj_laporanperjalanan_pelaksana_id_03e49a6c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_laporanperjalanan_pelaksana_id_03e49a6c ON public.spj_laporanperjalanan USING btree (pelaksana_id);


--
-- Name: spj_laporanperjalanan_verified_by_id_191d54c5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_laporanperjalanan_verified_by_id_191d54c5 ON public.spj_laporanperjalanan USING btree (verified_by_id);


--
-- Name: spj_penginapan_pelaksana_id_674df12e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_penginapan_pelaksana_id_674df12e ON public.spj_penginapan USING btree (pelaksana_id);


--
-- Name: spj_penginapan_spt_id_5fc25b62; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_penginapan_spt_id_5fc25b62 ON public.spj_penginapan USING btree (spt_id);


--
-- Name: spj_penginapan_verified_by_id_e731e455; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_penginapan_verified_by_id_e731e455 ON public.spj_penginapan USING btree (verified_by_id);


--
-- Name: spj_pesawat_jenis_spj_id_2f0a30db; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_pesawat_jenis_spj_id_2f0a30db ON public.spj_pesawat USING btree (jenis_spj_id);


--
-- Name: spj_pesawat_lokasi_bandara_id_7d836592; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_pesawat_lokasi_bandara_id_7d836592 ON public.spj_pesawat USING btree (lokasi_bandara_id);


--
-- Name: spj_pesawat_pelaksana_id_47433962; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_pesawat_pelaksana_id_47433962 ON public.spj_pesawat USING btree (pelaksana_id);


--
-- Name: spj_pesawat_spt_id_e2dec9ae; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_pesawat_spt_id_e2dec9ae ON public.spj_pesawat USING btree (spt_id);


--
-- Name: spj_pesawat_tujuan_bandara_id_ed085db5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_pesawat_tujuan_bandara_id_ed085db5 ON public.spj_pesawat USING btree (tujuan_bandara_id);


--
-- Name: spj_pesawat_verified_by_id_9b22df6b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_pesawat_verified_by_id_9b22df6b ON public.spj_pesawat USING btree (verified_by_id);


--
-- Name: spj_transport_jenis_spj_id_d687964b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_transport_jenis_spj_id_d687964b ON public.spj_transport USING btree (jenis_spj_id);


--
-- Name: spj_transport_jenis_transportasi_id_678611a3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_transport_jenis_transportasi_id_678611a3 ON public.spj_transport USING btree (jenis_transportasi_id);


--
-- Name: spj_transport_lokasi_berangkat_id_df1e12f8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_transport_lokasi_berangkat_id_df1e12f8 ON public.spj_transport USING btree (lokasi_berangkat_id);


--
-- Name: spj_transport_pelaksana_id_5847adb6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_transport_pelaksana_id_5847adb6 ON public.spj_transport USING btree (pelaksana_id);


--
-- Name: spj_transport_spt_id_2c70cf40; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_transport_spt_id_2c70cf40 ON public.spj_transport USING btree (spt_id);


--
-- Name: spj_transport_tujuan_id_af6b34d8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_transport_tujuan_id_af6b34d8 ON public.spj_transport USING btree (tujuan_id);


--
-- Name: spj_transport_verified_by_id_fb53c6ea; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_transport_verified_by_id_fb53c6ea ON public.spj_transport USING btree (verified_by_id);


--
-- Name: spj_uangharian_pelaksana_id_81e2f85d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_uangharian_pelaksana_id_81e2f85d ON public.spj_uangharian USING btree (pelaksana_id);


--
-- Name: spj_uangharian_spt_id_fa993f0a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_uangharian_spt_id_fa993f0a ON public.spj_uangharian USING btree (spt_id);


--
-- Name: spj_uangharian_verified_by_id_045cf338; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_uangharian_verified_by_id_045cf338 ON public.spj_uangharian USING btree (verified_by_id);


--
-- Name: spj_uangrepresentasi_pelaksana_id_8aaef51e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_uangrepresentasi_pelaksana_id_8aaef51e ON public.spj_uangrepresentasi USING btree (pelaksana_id);


--
-- Name: spj_uangrepresentasi_spt_id_b4e03078; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_uangrepresentasi_spt_id_b4e03078 ON public.spj_uangrepresentasi USING btree (spt_id);


--
-- Name: spj_uangrepresentasi_verified_by_id_4a005d5a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spj_uangrepresentasi_verified_by_id_4a005d5a ON public.spj_uangrepresentasi USING btree (verified_by_id);


--
-- Name: umum_eselon_eselon_30743a78_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_eselon_eselon_30743a78_like ON public.umum_eselon USING btree (eselon varchar_pattern_ops);


--
-- Name: umum_jenisjabatan_nama_bcb554f6_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_jenisjabatan_nama_bcb554f6_like ON public.umum_jenisjabatan USING btree (nama varchar_pattern_ops);


--
-- Name: umum_pegawai_eselon_id_c16ef4a4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_pegawai_eselon_id_c16ef4a4 ON public.umum_pegawai USING btree (eselon_id);


--
-- Name: umum_pegawai_jenis_jabatan_id_b1a5b8a1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_pegawai_jenis_jabatan_id_b1a5b8a1 ON public.umum_pegawai USING btree (jenis_jabatan_id);


--
-- Name: umum_pegawai_opd_id_b8e98922; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_pegawai_opd_id_b8e98922 ON public.umum_pegawai USING btree (opd_id);


--
-- Name: umum_pegawai_pangkat_id_7e4f60c0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_pegawai_pangkat_id_7e4f60c0 ON public.umum_pegawai USING btree (pangkat_id);


--
-- Name: umum_pegawai_status_id_8ea6d472; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_pegawai_status_id_8ea6d472 ON public.umum_pegawai USING btree (status_id);


--
-- Name: umum_pegawai_tingkat_id_bb65036c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_pegawai_tingkat_id_bb65036c ON public.umum_pegawai USING btree (tingkat_id);


--
-- Name: umum_penandatangan_jenis_jabatan_id_d115c405; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_penandatangan_jenis_jabatan_id_d115c405 ON public.umum_penandatangan USING btree (jenis_jabatan_id);


--
-- Name: umum_penandatangan_opd_id_30339ea1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_penandatangan_opd_id_30339ea1 ON public.umum_penandatangan USING btree (opd_id);


--
-- Name: umum_penandatangan_pangkat_id_697cc8a5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_penandatangan_pangkat_id_697cc8a5 ON public.umum_penandatangan USING btree (pangkat_id);


--
-- Name: umum_statusasn_nama_818a149d_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_statusasn_nama_818a149d_like ON public.umum_statusasn USING btree (nama varchar_pattern_ops);


--
-- Name: umum_tingkat_tingkat_3eb7ce42_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX umum_tingkat_tingkat_3eb7ce42_like ON public.umum_tingkat USING btree (tingkat varchar_pattern_ops);


--
-- Name: unique_nomor_spd_not_blank; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_nomor_spd_not_blank ON public.perintah_pemberitugas USING btree (nomor_spd) WHERE ((nomor_spd IS NOT NULL) AND (NOT (((nomor_spd)::text = ''::text) AND (nomor_spd IS NOT NULL))));


--
-- Name: unique_nomor_spt_not_blank; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_nomor_spt_not_blank ON public.perintah_pemberitugas USING btree (nomor_spt) WHERE ((nomor_spt IS NOT NULL) AND (NOT (((nomor_spt)::text = ''::text) AND (nomor_spt IS NOT NULL))));


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: menus_rolepermission menus_rolepermission_role_id_e75d12b7_fk_profiles_role_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus_rolepermission
    ADD CONSTRAINT menus_rolepermission_role_id_e75d12b7_fk_profiles_role_id FOREIGN KEY (role_id) REFERENCES public.profiles_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: menus_rolepermission menus_rolepermission_submenu_id_16f03829_fk_menus_submenu_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus_rolepermission
    ADD CONSTRAINT menus_rolepermission_submenu_id_16f03829_fk_menus_submenu_id FOREIGN KEY (submenu_id) REFERENCES public.menus_submenu(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: menus_submenu menus_submenu_menu_id_160cb379_fk_menus_menu_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus_submenu
    ADD CONSTRAINT menus_submenu_menu_id_160cb379_fk_menus_menu_id FOREIGN KEY (menu_id) REFERENCES public.menus_menu(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_pelaksana perintah_pelaksana_nama_id_4e3b5fe4_fk_umum_pegawai_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_pelaksana
    ADD CONSTRAINT perintah_pelaksana_nama_id_4e3b5fe4_fk_umum_pegawai_id FOREIGN KEY (nama_id) REFERENCES public.umum_pegawai(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_pelaksana perintah_pelaksana_spt_id_d06c47a0_fk_perintah_spt_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_pelaksana
    ADD CONSTRAINT perintah_pelaksana_spt_id_d06c47a0_fk_perintah_spt_id FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_pemberitugas perintah_pemberituga_penandatangan_id_8de52a83_fk_umum_pena; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_pemberitugas
    ADD CONSTRAINT perintah_pemberituga_penandatangan_id_8de52a83_fk_umum_pena FOREIGN KEY (penandatangan_id) REFERENCES public.umum_penandatangan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_pemberitugas perintah_pemberitugas_spt_id_5dac4e73_fk_perintah_spt_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_pemberitugas
    ADD CONSTRAINT perintah_pemberitugas_spt_id_5dac4e73_fk_perintah_spt_id FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_spt perintah_spt_jenis_kegiatan_id_5633ddcd_fk_spd_jeniskegiatan_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_spt
    ADD CONSTRAINT perintah_spt_jenis_kegiatan_id_5633ddcd_fk_spd_jeniskegiatan_id FOREIGN KEY (jenis_kegiatan_id) REFERENCES public.spd_jeniskegiatan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_spt_kota_tujuan_tambahan perintah_spt_kota_tu_lokasi_id_b8b1010b_fk_spd_lokas; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_spt_kota_tujuan_tambahan
    ADD CONSTRAINT perintah_spt_kota_tu_lokasi_id_b8b1010b_fk_spd_lokas FOREIGN KEY (lokasi_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_spt_kota_tujuan_tambahan perintah_spt_kota_tu_spt_id_e5374b99_fk_perintah_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_spt_kota_tujuan_tambahan
    ADD CONSTRAINT perintah_spt_kota_tu_spt_id_e5374b99_fk_perintah_ FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_spt perintah_spt_kota_tujuan_id_44be4bdc_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_spt
    ADD CONSTRAINT perintah_spt_kota_tujuan_id_44be4bdc_fk_spd_lokasi_id FOREIGN KEY (kota_tujuan_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: perintah_ttdsptspd perintah_ttdsptspd_pemberi_tugas_id_55a595eb_fk_perintah_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perintah_ttdsptspd
    ADD CONSTRAINT perintah_ttdsptspd_pemberi_tugas_id_55a595eb_fk_perintah_ FOREIGN KEY (pemberi_tugas_id) REFERENCES public.perintah_pemberitugas(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_userprofile profiles_userprofile_opd_id_92cf6435_fk_profiles_opd_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_userprofile
    ADD CONSTRAINT profiles_userprofile_opd_id_92cf6435_fk_profiles_opd_id FOREIGN KEY (opd_id) REFERENCES public.profiles_opd(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_userprofile profiles_userprofile_role_id_05631c9c_fk_profiles_role_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_userprofile
    ADD CONSTRAINT profiles_userprofile_role_id_05631c9c_fk_profiles_role_id FOREIGN KEY (role_id) REFERENCES public.profiles_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_userprofile profiles_userprofile_user_id_616bed88_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles_userprofile
    ADD CONSTRAINT profiles_userprofile_user_id_616bed88_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_lokasi spd_lokasi_jenis_spd_id_986735bc_fk_spd_jenisspd_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_lokasi
    ADD CONSTRAINT spd_lokasi_jenis_spd_id_986735bc_fk_spd_jenisspd_id FOREIGN KEY (jenis_spd_id) REFERENCES public.spd_jenisspd(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardpenginapan spd_standardpenginap_dasar_peraturan_id_0bfe7347_fk_spd_dasar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpenginapan
    ADD CONSTRAINT spd_standardpenginap_dasar_peraturan_id_0bfe7347_fk_spd_dasar FOREIGN KEY (dasar_peraturan_id) REFERENCES public.spd_dasarperaturan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardpenginapan spd_standardpenginapan_lokasi_id_ebff99ab_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpenginapan
    ADD CONSTRAINT spd_standardpenginapan_lokasi_id_ebff99ab_fk_spd_lokasi_id FOREIGN KEY (lokasi_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardpenginapan spd_standardpenginapan_tingkat_id_227cbcc0_fk_umum_tingkat_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpenginapan
    ADD CONSTRAINT spd_standardpenginapan_tingkat_id_227cbcc0_fk_umum_tingkat_id FOREIGN KEY (tingkat_id) REFERENCES public.umum_tingkat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardpesawat spd_standardpesawat_dasar_peraturan_id_81f2291b_fk_spd_dasar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpesawat
    ADD CONSTRAINT spd_standardpesawat_dasar_peraturan_id_81f2291b_fk_spd_dasar FOREIGN KEY (dasar_peraturan_id) REFERENCES public.spd_dasarperaturan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardpesawat spd_standardpesawat_kota_asal_id_3ecfa369_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpesawat
    ADD CONSTRAINT spd_standardpesawat_kota_asal_id_3ecfa369_fk_spd_lokasi_id FOREIGN KEY (kota_asal_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardpesawat spd_standardpesawat_kota_tujuan_id_282f3121_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpesawat
    ADD CONSTRAINT spd_standardpesawat_kota_tujuan_id_282f3121_fk_spd_lokasi_id FOREIGN KEY (kota_tujuan_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardpesawat spd_standardpesawat_tingkat_id_b55f4198_fk_umum_tingkat_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardpesawat
    ADD CONSTRAINT spd_standardpesawat_tingkat_id_b55f4198_fk_umum_tingkat_id FOREIGN KEY (tingkat_id) REFERENCES public.umum_tingkat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardrepresentasi spd_standardrepresen_dasar_peraturan_id_317cdf7b_fk_spd_dasar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardrepresentasi
    ADD CONSTRAINT spd_standardrepresen_dasar_peraturan_id_317cdf7b_fk_spd_dasar FOREIGN KEY (dasar_peraturan_id) REFERENCES public.spd_dasarperaturan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardrepresentasi spd_standardrepresen_jenis_spd_id_d975ab10_fk_spd_jenis; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardrepresentasi
    ADD CONSTRAINT spd_standardrepresen_jenis_spd_id_d975ab10_fk_spd_jenis FOREIGN KEY (jenis_spd_id) REFERENCES public.spd_jenisspd(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardrepresentasi spd_standardrepresen_tingkat_spd_id_40a75aba_fk_umum_ting; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardrepresentasi
    ADD CONSTRAINT spd_standardrepresen_tingkat_spd_id_40a75aba_fk_umum_ting FOREIGN KEY (tingkat_spd_id) REFERENCES public.umum_tingkat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardtransportasi spd_standardtranspor_dasar_peraturan_id_9956d460_fk_spd_dasar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardtransportasi
    ADD CONSTRAINT spd_standardtranspor_dasar_peraturan_id_9956d460_fk_spd_dasar FOREIGN KEY (dasar_peraturan_id) REFERENCES public.spd_dasarperaturan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardtransportasi spd_standardtranspor_jenis_transportasi_i_6b515fb4_fk_spd_jenis; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardtransportasi
    ADD CONSTRAINT spd_standardtranspor_jenis_transportasi_i_6b515fb4_fk_spd_jenis FOREIGN KEY (jenis_transportasi_id) REFERENCES public.spd_jenistransportasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standardtransportasi spd_standardtranspor_kota_tujuan_id_b7a6a2e7_fk_spd_lokas; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standardtransportasi
    ADD CONSTRAINT spd_standardtranspor_kota_tujuan_id_b7a6a2e7_fk_spd_lokas FOREIGN KEY (kota_tujuan_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standarduangharian spd_standarduanghari_dasar_peraturan_id_472e4728_fk_spd_dasar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standarduangharian
    ADD CONSTRAINT spd_standarduanghari_dasar_peraturan_id_472e4728_fk_spd_dasar FOREIGN KEY (dasar_peraturan_id) REFERENCES public.spd_dasarperaturan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standarduangharian spd_standarduanghari_jenis_kegiatan_id_034ff9c4_fk_spd_jenis; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standarduangharian
    ADD CONSTRAINT spd_standarduanghari_jenis_kegiatan_id_034ff9c4_fk_spd_jenis FOREIGN KEY (jenis_kegiatan_id) REFERENCES public.spd_jeniskegiatan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spd_standarduangharian spd_standarduangharian_lokasi_id_efa10a7a_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spd_standarduangharian
    ADD CONSTRAINT spd_standarduangharian_lokasi_id_efa10a7a_fk_spd_lokasi_id FOREIGN KEY (lokasi_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_laporanperjalanan spj_laporanperjalana_pelaksana_id_03e49a6c_fk_perintah_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_laporanperjalanan
    ADD CONSTRAINT spj_laporanperjalana_pelaksana_id_03e49a6c_fk_perintah_ FOREIGN KEY (pelaksana_id) REFERENCES public.perintah_pelaksana(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_laporanperjalanan spj_laporanperjalanan_spt_id_1f901426_fk_perintah_spt_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_laporanperjalanan
    ADD CONSTRAINT spj_laporanperjalanan_spt_id_1f901426_fk_perintah_spt_id FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_laporanperjalanan spj_laporanperjalanan_verified_by_id_191d54c5_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_laporanperjalanan
    ADD CONSTRAINT spj_laporanperjalanan_verified_by_id_191d54c5_fk_auth_user_id FOREIGN KEY (verified_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_penginapan spj_penginapan_pelaksana_id_674df12e_fk_perintah_pelaksana_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_penginapan
    ADD CONSTRAINT spj_penginapan_pelaksana_id_674df12e_fk_perintah_pelaksana_id FOREIGN KEY (pelaksana_id) REFERENCES public.perintah_pelaksana(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_penginapan spj_penginapan_spt_id_5fc25b62_fk_perintah_spt_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_penginapan
    ADD CONSTRAINT spj_penginapan_spt_id_5fc25b62_fk_perintah_spt_id FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_penginapan spj_penginapan_verified_by_id_e731e455_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_penginapan
    ADD CONSTRAINT spj_penginapan_verified_by_id_e731e455_fk_auth_user_id FOREIGN KEY (verified_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_pesawat spj_pesawat_jenis_spj_id_2f0a30db_fk_spj_jenisspj_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_pesawat
    ADD CONSTRAINT spj_pesawat_jenis_spj_id_2f0a30db_fk_spj_jenisspj_id FOREIGN KEY (jenis_spj_id) REFERENCES public.spj_jenisspj(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_pesawat spj_pesawat_lokasi_bandara_id_7d836592_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_pesawat
    ADD CONSTRAINT spj_pesawat_lokasi_bandara_id_7d836592_fk_spd_lokasi_id FOREIGN KEY (lokasi_bandara_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_pesawat spj_pesawat_pelaksana_id_47433962_fk_perintah_pelaksana_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_pesawat
    ADD CONSTRAINT spj_pesawat_pelaksana_id_47433962_fk_perintah_pelaksana_id FOREIGN KEY (pelaksana_id) REFERENCES public.perintah_pelaksana(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_pesawat spj_pesawat_spt_id_e2dec9ae_fk_perintah_spt_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_pesawat
    ADD CONSTRAINT spj_pesawat_spt_id_e2dec9ae_fk_perintah_spt_id FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_pesawat spj_pesawat_tujuan_bandara_id_ed085db5_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_pesawat
    ADD CONSTRAINT spj_pesawat_tujuan_bandara_id_ed085db5_fk_spd_lokasi_id FOREIGN KEY (tujuan_bandara_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_pesawat spj_pesawat_verified_by_id_9b22df6b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_pesawat
    ADD CONSTRAINT spj_pesawat_verified_by_id_9b22df6b_fk_auth_user_id FOREIGN KEY (verified_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_transport spj_transport_jenis_spj_id_d687964b_fk_spj_jenisspj_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_transport
    ADD CONSTRAINT spj_transport_jenis_spj_id_d687964b_fk_spj_jenisspj_id FOREIGN KEY (jenis_spj_id) REFERENCES public.spj_jenisspj(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_transport spj_transport_jenis_transportasi_i_678611a3_fk_spd_jenis; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_transport
    ADD CONSTRAINT spj_transport_jenis_transportasi_i_678611a3_fk_spd_jenis FOREIGN KEY (jenis_transportasi_id) REFERENCES public.spd_jenistransportasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_transport spj_transport_lokasi_berangkat_id_df1e12f8_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_transport
    ADD CONSTRAINT spj_transport_lokasi_berangkat_id_df1e12f8_fk_spd_lokasi_id FOREIGN KEY (lokasi_berangkat_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_transport spj_transport_pelaksana_id_5847adb6_fk_perintah_pelaksana_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_transport
    ADD CONSTRAINT spj_transport_pelaksana_id_5847adb6_fk_perintah_pelaksana_id FOREIGN KEY (pelaksana_id) REFERENCES public.perintah_pelaksana(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_transport spj_transport_spt_id_2c70cf40_fk_perintah_spt_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_transport
    ADD CONSTRAINT spj_transport_spt_id_2c70cf40_fk_perintah_spt_id FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_transport spj_transport_tujuan_id_af6b34d8_fk_spd_lokasi_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_transport
    ADD CONSTRAINT spj_transport_tujuan_id_af6b34d8_fk_spd_lokasi_id FOREIGN KEY (tujuan_id) REFERENCES public.spd_lokasi(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_transport spj_transport_verified_by_id_fb53c6ea_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_transport
    ADD CONSTRAINT spj_transport_verified_by_id_fb53c6ea_fk_auth_user_id FOREIGN KEY (verified_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_uangharian spj_uangharian_pelaksana_id_81e2f85d_fk_perintah_pelaksana_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_uangharian
    ADD CONSTRAINT spj_uangharian_pelaksana_id_81e2f85d_fk_perintah_pelaksana_id FOREIGN KEY (pelaksana_id) REFERENCES public.perintah_pelaksana(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_uangharian spj_uangharian_spt_id_fa993f0a_fk_perintah_spt_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_uangharian
    ADD CONSTRAINT spj_uangharian_spt_id_fa993f0a_fk_perintah_spt_id FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_uangharian spj_uangharian_verified_by_id_045cf338_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_uangharian
    ADD CONSTRAINT spj_uangharian_verified_by_id_045cf338_fk_auth_user_id FOREIGN KEY (verified_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_uangrepresentasi spj_uangrepresentasi_pelaksana_id_8aaef51e_fk_perintah_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_uangrepresentasi
    ADD CONSTRAINT spj_uangrepresentasi_pelaksana_id_8aaef51e_fk_perintah_ FOREIGN KEY (pelaksana_id) REFERENCES public.perintah_pelaksana(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_uangrepresentasi spj_uangrepresentasi_spt_id_b4e03078_fk_perintah_spt_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_uangrepresentasi
    ADD CONSTRAINT spj_uangrepresentasi_spt_id_b4e03078_fk_perintah_spt_id FOREIGN KEY (spt_id) REFERENCES public.perintah_spt(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spj_uangrepresentasi spj_uangrepresentasi_verified_by_id_4a005d5a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spj_uangrepresentasi
    ADD CONSTRAINT spj_uangrepresentasi_verified_by_id_4a005d5a_fk_auth_user_id FOREIGN KEY (verified_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_kopsurat umum_kopsurat_pemda_id_bfe75c1c_fk_umum_pemda_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_kopsurat
    ADD CONSTRAINT umum_kopsurat_pemda_id_bfe75c1c_fk_umum_pemda_id FOREIGN KEY (pemda_id) REFERENCES public.umum_pemda(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_pegawai umum_pegawai_eselon_id_c16ef4a4_fk_umum_eselon_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pegawai
    ADD CONSTRAINT umum_pegawai_eselon_id_c16ef4a4_fk_umum_eselon_id FOREIGN KEY (eselon_id) REFERENCES public.umum_eselon(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_pegawai umum_pegawai_jenis_jabatan_id_b1a5b8a1_fk_umum_jenisjabatan_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pegawai
    ADD CONSTRAINT umum_pegawai_jenis_jabatan_id_b1a5b8a1_fk_umum_jenisjabatan_id FOREIGN KEY (jenis_jabatan_id) REFERENCES public.umum_jenisjabatan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_pegawai umum_pegawai_opd_id_b8e98922_fk_profiles_opd_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pegawai
    ADD CONSTRAINT umum_pegawai_opd_id_b8e98922_fk_profiles_opd_id FOREIGN KEY (opd_id) REFERENCES public.profiles_opd(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_pegawai umum_pegawai_pangkat_id_7e4f60c0_fk_umum_pangkat_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pegawai
    ADD CONSTRAINT umum_pegawai_pangkat_id_7e4f60c0_fk_umum_pangkat_id FOREIGN KEY (pangkat_id) REFERENCES public.umum_pangkat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_pegawai umum_pegawai_status_id_8ea6d472_fk_umum_statusasn_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pegawai
    ADD CONSTRAINT umum_pegawai_status_id_8ea6d472_fk_umum_statusasn_id FOREIGN KEY (status_id) REFERENCES public.umum_statusasn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_pegawai umum_pegawai_tingkat_id_bb65036c_fk_umum_tingkat_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pegawai
    ADD CONSTRAINT umum_pegawai_tingkat_id_bb65036c_fk_umum_tingkat_id FOREIGN KEY (tingkat_id) REFERENCES public.umum_tingkat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_pemda umum_pemda_nama_dinas_id_be26a2f6_fk_profiles_opd_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_pemda
    ADD CONSTRAINT umum_pemda_nama_dinas_id_be26a2f6_fk_profiles_opd_id FOREIGN KEY (nama_dinas_id) REFERENCES public.profiles_opd(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_penandatangan umum_penandatangan_jenis_jabatan_id_d115c405_fk_umum_jeni; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_penandatangan
    ADD CONSTRAINT umum_penandatangan_jenis_jabatan_id_d115c405_fk_umum_jeni FOREIGN KEY (jenis_jabatan_id) REFERENCES public.umum_jenisjabatan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_penandatangan umum_penandatangan_opd_id_30339ea1_fk_profiles_opd_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_penandatangan
    ADD CONSTRAINT umum_penandatangan_opd_id_30339ea1_fk_profiles_opd_id FOREIGN KEY (opd_id) REFERENCES public.profiles_opd(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: umum_penandatangan umum_penandatangan_pangkat_id_697cc8a5_fk_umum_pangkat_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umum_penandatangan
    ADD CONSTRAINT umum_penandatangan_pangkat_id_697cc8a5_fk_umum_pangkat_id FOREIGN KEY (pangkat_id) REFERENCES public.umum_pangkat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

