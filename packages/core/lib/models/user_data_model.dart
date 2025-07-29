import 'package:core/core.dart';

part 'user_data_model.g.dart';

@HiveType(typeId: 12)
class UserDataModel {
  @HiveField(0)
  String? code;
  @HiveField(1)
  bool? success;
  @HiveField(2)
  DataUser? data;
  @HiveField(3)
  String? message;

  UserDataModel({this.code, this.success, this.data, this.message});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? DataUser.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

@HiveType(typeId: 13)
class DataUser {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? username;
  @HiveField(4)
  String? emailVerifiedAt;
  @HiveField(5)
  String? password;
  @HiveField(6)
  String? userData;
  @HiveField(7)
  String? rememberToken;
  @HiveField(8)
  String? createdAt;
  @HiveField(9)
  String? updatedAt;
  @HiveField(10)
  String? idWiluppdKerja;
  @HiveField(11)
  String? kdWil;
  @HiveField(12)
  String? idJenisLayanan;
  @HiveField(13)
  String? idLoket;
  @HiveField(14)
  String? idTapping;
  @HiveField(15)
  String? noWa;
  @HiveField(16)
  String? bayarQris;
  @HiveField(17)
  String? bayarVa;
  @HiveField(18)
  String? bayarEdc;
  @HiveField(19)
  String? bayarTunai;
  @HiveField(20)
  String? idRole;
  @HiveField(21)
  String? layanan1;
  @HiveField(22)
  String? layanan2;
  @HiveField(23)
  String? layanan3;
  @HiveField(24)
  String? layanan4;
  @HiveField(25)
  String? layanan5;
  @HiveField(26)
  String? layanan6;
  @HiveField(27)
  String? layanan7;
  @HiveField(28)
  String? idEdc;
  @HiveField(29)
  String? roleIdRole;
  @HiveField(30)
  String? roleNmRole;
  @HiveField(31)
  String? roleMenuProgresifNopol;
  @HiveField(32)
  String? roleMenuProgresifNoidentitas;
  @HiveField(33)
  String? roleMenuProgresifTapping;
  @HiveField(34)
  String? roleMenuProgresifNamaalamat;
  @HiveField(35)
  String? roleMenuPendaftaranTahunanLuarInduk;
  @HiveField(36)
  String? roleMenuPendaftaranKurangBayar;
  @HiveField(37)
  String? roleMenuPendaftaranMutasiKeluar;
  @HiveField(38)
  String? roleMenuLaporanHarian;
  @HiveField(39)
  String? roleMenuLaporanBulanan;
  @HiveField(40)
  String? roleMenuLaporanStsOnline;
  @HiveField(41)
  String? roleMenuNjkb;
  @HiveField(42)
  String? roleMenuRiwayatPembayaran;
  @HiveField(43)
  String? roleMenuVerifikasi;
  @HiveField(44)
  String? roleMenuHistoris;
  @HiveField(45)
  String? roleMenuTabelPembayaran;
  @HiveField(46)
  String? roleMenuTabelPembayaranCrud;
  @HiveField(47)
  String? roleMenuTabelUser;
  @HiveField(48)
  String? roleMenuTabelUserCrud;
  @HiveField(49)
  String? roleMenuTabelRole;
  @HiveField(50)
  String? roleMenuTabelRoleCrud;
  @HiveField(51)
  String? roleMenuTabelTapping;
  @HiveField(52)
  String? roleMenuTabelTappingCrud;
  @HiveField(53)
  String? roleMenuTabelLoket;
  @HiveField(54)
  String? roleMenuTabelLoketCrud;
  @HiveField(55)
  String? roleMenuTabelObjekPajak;
  @HiveField(56)
  String? roleMenuTabelObjekPajakCrud;
  @HiveField(57)
  String? roleMenuTabelSubjekPajak;
  @HiveField(58)
  String? roleMenuTabelSubjekPajakCrud;
  @HiveField(59)
  String? roleMenuSuperAdmin;
  @HiveField(60)
  String? wiluppdIdWiluppd;
  @HiveField(61)
  String? wiluppdKdWil;
  @HiveField(62)
  String? wiluppdKdWil1;
  @HiveField(63)
  String? wiluppdNmWil;
  @HiveField(64)
  String? wiluppdAlUppd;
  @HiveField(65)
  String? wiluppdKabKota;
  @HiveField(66)
  String? wiluppdPropinsi;
  @HiveField(67)
  String? wiluppdTelp;
  @HiveField(68)
  String? wiluppdNmWilEri;
  @HiveField(69)
  String? wiluppdKdKotaEri;
  @HiveField(70)
  String? wiluppdKdSubmarkasEri;
  @HiveField(71)
  String? wiluppdKdWilInduk;
  @HiveField(72)
  String? wiluppdSubKdWil;
  @HiveField(73)
  String? wiluppdKdWilLama;
  @HiveField(74)
  String? wiluppdDefaultNoPolisi1;
  @HiveField(75)
  String? wiluppdPoldaType;
  @HiveField(76)
  String? wiluppdIsKasirAvail;
  @HiveField(77)
  String? wiluppdKdKabKota;
  @HiveField(78)
  String? wiluppdJudulDip1;
  @HiveField(79)
  String? wiluppdJudulDip2;
  @HiveField(80)
  String? wiluppdJudulDip3;
  @HiveField(81)
  String? wiluppdJudulDip4;
  @HiveField(82)
  String? wiluppdJudulDip5;
  @HiveField(83)
  String? wiluppdJudulDip6;
  @HiveField(84)
  String? wiluppdJudulDip7;
  @HiveField(85)
  String? wiluppdJudulDip8;
  @HiveField(86)
  String? wiluppdJudulPol1;
  @HiveField(87)
  String? wiluppdJudulPol2;
  @HiveField(88)
  String? wiluppdJudulPol3;
  @HiveField(89)
  String? wiluppdIndukKdWil;
  @HiveField(90)
  String? wiluppdIndukNmWil;
  @HiveField(91)
  String? wiluppdDefaultKdKabKota;
  @HiveField(92)
  String? loketIdLoket;
  @HiveField(93)
  String? loketNmLoket;
  @HiveField(94)
  String? loketIpPrinter;
  @HiveField(95)
  String? loketFullname;
  @HiveField(96)
  String? loketNamaPrinter;
  @HiveField(97)
  String? loketPrintType;
  @HiveField(98)
  String? loketProductCode;
  @HiveField(99)
  String? loketNumerator;
  @HiveField(100)
  String? loketKeterangan;
  @HiveField(101)
  bool? loketIsActive;
  @HiveField(102)
  String? loketUsername;
  @HiveField(103)
  String? loketApiKey;
  @HiveField(104)
  String? loketIdWiluppdProses;
  @HiveField(105)
  String? tappingIdWiluppdProses;
  @HiveField(106)
  String? tappingIpPerangkat;
  @HiveField(107)
  String? tappingKeterangan;
  @HiveField(108)
  String? tappingNmTapping;
  @HiveField(109)
  String? tappingIdTapping;
  @HiveField(110)
  String? roleMenuInfoPajak;
  @HiveField(111)
  String? roleMenuPembayaran;
  @HiveField(112)
  String? roleMenuKoreksi;
  @HiveField(113)
  String? roleMenuNjkbCrud;
  @HiveField(114)
  String? roleMenuCetakSkkp;
  @HiveField(115)
  String? roleMenuKirimSkkp;
  @HiveField(116)
  String? roleMenuPembatalan;
  @HiveField(117)
  String? roleMenuProteksi;
  @HiveField(118)
  String? roleMenuUpdateDataWp;
  @HiveField(119)
  String? roleMenuAwalAkhirLayanan;
  @HiveField(120)
  String? roleMenuKonfigurasiCetak;
  @HiveField(121)
  String? roleMenuKonfigurasiPing;
  @HiveField(122)
  String? roleMenuTabelTransaksi;
  @HiveField(123)
  String? roleMenuTabelTransaksiCrud;
  @HiveField(124)
  String? roleMenuAksesSelectAdmin;
  @HiveField(125)
  String? roleMenuAksesSelectControl;
  @HiveField(126)
  String? roleMenuAkhirHariSys;
  @HiveField(127)
  String? roleMenuCeknokanosinnopol;
  @HiveField(128)
  String? roleMenuAdminLayanan;
  @HiveField(129)
  String? roleMenuAdminLayananEdit;
  @HiveField(130)
  String? wiluppdIndukDefaultKdKabKota;
  @HiveField(131)
  String? wiluppdIndukDefaultNoRek;
  @HiveField(132)
  String? wiluppdIndukNmKabKota;
  @HiveField(133)
  String? roleMenuHistTabelUser;
  @HiveField(134)
  String? roleMenuHistTabelRole;
  @HiveField(135)
  String? roleMenuHistTabelPembayaran;
  @HiveField(136)
  String? roleMenuHistTabelTransaksi;
  @HiveField(137)
  String? roleMenuHistStsOnline;
  @HiveField(138)
  String? roleMenuHistPembatalan;
  @HiveField(139)
  String? roleMenuHistTabelObjekPajak;
  @HiveField(140)
  String? roleMenuHistTabelSubjekPajak;
  @HiveField(141)
  String? roleAksesTroubleshoot;
  @HiveField(142)
  String? roleMenuUpdateObjekPajak;
  @HiveField(143)
  String? roleMenuPendaftaranPolri;
  @HiveField(144)
  String? roleMenuCetakStnk;
  @HiveField(145)
  String? roleAksesToubleshoot;
  @HiveField(146)
  String? roleMenuTutorialPembayaran;
  @HiveField(147)
  String? roleMenuBayarDigital;
  @HiveField(148)
  String? roleMenuBayarDigital5thn;
  @HiveField(149)
  String? roleMenuTabelProteksi;
  @HiveField(150)
  String? roleMenuTabelBlokir;
  @HiveField(151)
  String? roleMenuTabelPembayaranLampau;
  @HiveField(152)
  String? roleMenuTuPolri;
  @HiveField(153)
  String? roleMenuTabelUserC;
  @HiveField(154)
  String? roleMenuTabelUserU;
  @HiveField(155)
  String? roleMenuTabelUserD;
  @HiveField(156)
  String? roleMenuTabelMutasikel;
  @HiveField(157)
  String? roleMenuLaporanBulanan2;
  @HiveField(158)
  String? roleMenuLogKoreksi;
  @HiveField(159)
  String? wiluppdIsBlocked;
  @HiveField(160)
  String? wiluppdIndukIsSingleKabKota;
  @HiveField(161)
  String? roleMenuAbleLoginMobile;
  @HiveField(162)
  String? roleMenuVerfikasiReservasi;
  @HiveField(163)
  String? roleMenuLoketMutasikel;
  @HiveField(164)
  String? roleMenuLoketMutasikelCrud;
  @HiveField(165)
  String? roleMenuHitungUlangDev;
  @HiveField(166)
  String? roleMenuTabelReservasiSamsatDigital;
  @HiveField(167)
  String? roleMenuTabelReservasiAntrian;
  @HiveField(168)
  String? roleMenuPendingNopol;
  @HiveField(169)
  String? roleMenuCms;
  @HiveField(170)
  String? roleMenuManajemenKuota;
  @HiveField(171)
  String? roleMenuManajemenKuotaCf;
  @HiveField(172)
  String? roleMenuRekonEsamsat;

  DataUser({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.password,
    this.userData,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.idWiluppdKerja,
    this.kdWil,
    this.idJenisLayanan,
    this.idLoket,
    this.idTapping,
    this.noWa,
    this.bayarQris,
    this.bayarVa,
    this.bayarEdc,
    this.bayarTunai,
    this.idRole,
    this.layanan1,
    this.layanan2,
    this.layanan3,
    this.layanan4,
    this.layanan5,
    this.layanan6,
    this.layanan7,
    this.idEdc,
    this.roleIdRole,
    this.roleNmRole,
    this.roleMenuProgresifNopol,
    this.roleMenuProgresifNoidentitas,
    this.roleMenuProgresifTapping,
    this.roleMenuProgresifNamaalamat,
    this.roleMenuPendaftaranTahunanLuarInduk,
    this.roleMenuPendaftaranKurangBayar,
    this.roleMenuPendaftaranMutasiKeluar,
    this.roleMenuLaporanHarian,
    this.roleMenuLaporanBulanan,
    this.roleMenuLaporanStsOnline,
    this.roleMenuNjkb,
    this.roleMenuRiwayatPembayaran,
    this.roleMenuVerifikasi,
    this.roleMenuHistoris,
    this.roleMenuTabelPembayaran,
    this.roleMenuTabelPembayaranCrud,
    this.roleMenuTabelUser,
    this.roleMenuTabelUserCrud,
    this.roleMenuTabelRole,
    this.roleMenuTabelRoleCrud,
    this.roleMenuTabelTapping,
    this.roleMenuTabelTappingCrud,
    this.roleMenuTabelLoket,
    this.roleMenuTabelLoketCrud,
    this.roleMenuTabelObjekPajak,
    this.roleMenuTabelObjekPajakCrud,
    this.roleMenuTabelSubjekPajak,
    this.roleMenuTabelSubjekPajakCrud,
    this.roleMenuSuperAdmin,
    this.roleMenuInfoPajak,
    this.roleMenuPembayaran,
    this.roleMenuKoreksi,
    this.roleMenuNjkbCrud,
    this.roleMenuCetakSkkp,
    this.roleMenuKirimSkkp,
    this.roleMenuPembatalan,
    this.roleMenuProteksi,
    this.roleMenuUpdateDataWp,
    this.roleMenuAwalAkhirLayanan,
    this.roleMenuKonfigurasiCetak,
    this.roleMenuKonfigurasiPing,
    this.wiluppdIdWiluppd,
    this.wiluppdKdWil,
    this.wiluppdKdWil1,
    this.wiluppdNmWil,
    this.wiluppdAlUppd,
    this.wiluppdKabKota,
    this.wiluppdPropinsi,
    this.wiluppdTelp,
    this.wiluppdNmWilEri,
    this.wiluppdKdKotaEri,
    this.wiluppdKdSubmarkasEri,
    this.wiluppdKdWilInduk,
    this.wiluppdSubKdWil,
    this.wiluppdKdWilLama,
    this.wiluppdDefaultNoPolisi1,
    this.wiluppdPoldaType,
    this.wiluppdIsKasirAvail,
    this.wiluppdKdKabKota,
    this.wiluppdJudulDip1,
    this.wiluppdJudulDip2,
    this.wiluppdJudulDip3,
    this.wiluppdJudulDip4,
    this.wiluppdJudulDip5,
    this.wiluppdJudulDip6,
    this.wiluppdJudulDip7,
    this.wiluppdJudulDip8,
    this.wiluppdJudulPol1,
    this.wiluppdJudulPol2,
    this.wiluppdJudulPol3,
    this.wiluppdIndukKdWil,
    this.wiluppdIndukNmWil,
    this.wiluppdDefaultKdKabKota,
    this.loketIdLoket,
    this.loketNmLoket,
    this.loketIpPrinter,
    this.loketFullname,
    this.loketNamaPrinter,
    this.loketPrintType,
    this.loketProductCode,
    this.loketNumerator,
    this.loketKeterangan,
    this.loketIsActive,
    this.loketUsername,
    this.loketApiKey,
    this.loketIdWiluppdProses,
    this.tappingIdWiluppdProses,
    this.tappingIpPerangkat,
    this.tappingKeterangan,
    this.tappingNmTapping,
    this.tappingIdTapping,
    this.roleMenuTabelTransaksi,
    this.roleMenuTabelTransaksiCrud,
    this.roleMenuAksesSelectAdmin,
    this.roleMenuAksesSelectControl,
    this.roleMenuAkhirHariSys,
    this.roleMenuCeknokanosinnopol,
    this.roleMenuAdminLayanan,
    this.roleMenuAdminLayananEdit,
    this.wiluppdIndukDefaultKdKabKota,
    this.wiluppdIndukDefaultNoRek,
    this.wiluppdIndukNmKabKota,
    this.roleMenuHistPembatalan,
    this.roleMenuHistStsOnline,
    this.roleMenuHistTabelPembayaran,
    this.roleMenuHistTabelRole,
    this.roleMenuHistTabelTransaksi,
    this.roleMenuHistTabelUser,
    this.roleMenuHistTabelObjekPajak,
    this.roleMenuHistTabelSubjekPajak,
    this.roleAksesTroubleshoot,
    this.roleMenuUpdateObjekPajak,
    this.roleMenuPendaftaranPolri,
    this.roleMenuCetakStnk,
    this.roleAksesToubleshoot,
    this.roleMenuTutorialPembayaran,
    this.roleMenuBayarDigital,
    this.roleMenuBayarDigital5thn,
    this.roleMenuTabelProteksi,
    this.roleMenuTabelBlokir,
    this.roleMenuTabelPembayaranLampau,
    this.roleMenuTuPolri,
    this.roleMenuTabelUserC,
    this.roleMenuTabelUserU,
    this.roleMenuTabelUserD,
    this.roleMenuTabelMutasikel,
    this.roleMenuLaporanBulanan2,
    this.roleMenuLogKoreksi,
    this.wiluppdIsBlocked,
    this.wiluppdIndukIsSingleKabKota,
    this.roleMenuAbleLoginMobile,
    this.roleMenuVerfikasiReservasi,
    this.roleMenuLoketMutasikel,
    this.roleMenuLoketMutasikelCrud,
    this.roleMenuHitungUlangDev,
    this.roleMenuTabelReservasiSamsatDigital,
    this.roleMenuTabelReservasiAntrian,
    this.roleMenuPendingNopol,
    this.roleMenuCms,
    this.roleMenuManajemenKuota,
    this.roleMenuManajemenKuotaCf,
    this.roleMenuRekonEsamsat,
  });

  DataUser.fromJson(Map<String, dynamic> json) {
    id = StringUtils.checkModel(json['id']);
    name = StringUtils.checkModel(json['name']);
    email = StringUtils.checkModel(json['email']);
    username = StringUtils.checkModel(json['username']);
    emailVerifiedAt = StringUtils.checkModel(json['email_verified_at']);
    password = StringUtils.checkModel(json['password']);
    userData = StringUtils.checkModel(json['user_data']);
    rememberToken = StringUtils.checkModel(json['remember_token']);
    createdAt = StringUtils.checkModel(json['created_at']);
    updatedAt = StringUtils.checkModel(json['updated_at']);
    idWiluppdKerja = StringUtils.checkModel(json['id_wiluppd_kerja']);
    kdWil = StringUtils.checkModel(json['kd_wil']);
    idJenisLayanan = StringUtils.checkModel(json['id_jenis_layanan']);
    idLoket = StringUtils.checkModel(json['id_loket']);
    idTapping = StringUtils.checkModel(json['id_tapping']);
    noWa = StringUtils.checkModel(json['no_wa']);
    bayarQris = StringUtils.checkModel(json['bayar_qris']);
    bayarVa = StringUtils.checkModel(json['bayar_va']);
    bayarEdc = StringUtils.checkModel(json['bayar_edc']);
    bayarTunai = StringUtils.checkModel(json['bayar_tunai']);
    idRole = StringUtils.checkModel(json['id_role']);
    layanan1 = StringUtils.checkModel(json['layanan1']);
    layanan2 = StringUtils.checkModel(json['layanan2']);
    layanan3 = StringUtils.checkModel(json['layanan3']);
    layanan4 = StringUtils.checkModel(json['layanan4']);
    layanan5 = StringUtils.checkModel(json['layanan5']);
    layanan6 = StringUtils.checkModel(json['layanan6']);
    layanan7 = StringUtils.checkModel(json['layanan7']);
    idEdc = StringUtils.checkModel(json['id_edc']);
    roleIdRole = StringUtils.checkModel(json['role_id_role']);
    roleNmRole = StringUtils.checkModel(json['role_nm_role']);
    roleMenuProgresifNopol = StringUtils.checkModel(json['role_menu_progresif_nopol']);
    roleMenuProgresifNoidentitas = StringUtils.checkModel(json['role_menu_progresif_noidentitas']);
    roleMenuProgresifTapping = StringUtils.checkModel(json['role_menu_progresif_tapping']);
    roleMenuProgresifNamaalamat = StringUtils.checkModel(json['role_menu_progresif_namaalamat']);
    roleMenuPendaftaranTahunanLuarInduk =
        StringUtils.checkModel(json['role_menu_pendaftaran_tahunan_luar_induk']);
    roleMenuPendaftaranKurangBayar =
        StringUtils.checkModel(json['role_menu_pendaftaran_kurang_bayar']);
    roleMenuPendaftaranMutasiKeluar =
        StringUtils.checkModel(json['role_menu_pendaftaran_mutasi_keluar']);
    roleMenuLaporanHarian = StringUtils.checkModel(json['role_menu_laporan_harian']);
    roleMenuLaporanBulanan = StringUtils.checkModel(json['role_menu_laporan_bulanan']);
    roleMenuLaporanStsOnline = StringUtils.checkModel(json['role_menu_laporan_sts_online']);
    roleMenuNjkb = StringUtils.checkModel(json['role_menu_njkb']);
    roleMenuRiwayatPembayaran = StringUtils.checkModel(json['role_menu_riwayat_pembayaran']);
    roleMenuVerifikasi = StringUtils.checkModel(json['role_menu_verifikasi']);
    roleMenuHistoris = StringUtils.checkModel(json['role_menu_historis']);
    roleMenuTabelPembayaran = StringUtils.checkModel(json['role_menu_tabel_pembayaran']);
    roleMenuTabelPembayaranCrud = StringUtils.checkModel(json['role_menu_tabel_pembayaran_crud']);
    roleMenuTabelUser = StringUtils.checkModel(json['role_menu_tabel_user']);
    roleMenuTabelUserCrud = StringUtils.checkModel(json['role_menu_tabel_user_crud']);
    roleMenuTabelRole = StringUtils.checkModel(json['role_menu_tabel_role']);
    roleMenuTabelRoleCrud = StringUtils.checkModel(json['role_menu_tabel_role_crud']);
    roleMenuTabelTapping = StringUtils.checkModel(json['role_menu_tabel_tapping']);
    roleMenuTabelTappingCrud = StringUtils.checkModel(json['role_menu_tabel_tapping_crud']);
    roleMenuTabelLoket = StringUtils.checkModel(json['role_menu_tabel_loket']);
    roleMenuTabelLoketCrud = StringUtils.checkModel(json['role_menu_tabel_loket_crud']);
    roleMenuTabelObjekPajak = StringUtils.checkModel(json['role_menu_tabel_objek_pajak']);
    roleMenuTabelObjekPajakCrud = StringUtils.checkModel(json['role_menu_tabel_objek_pajak_crud']);
    roleMenuTabelSubjekPajak = StringUtils.checkModel(json['role_menu_tabel_subjek_pajak']);
    roleMenuTabelSubjekPajakCrud =
        StringUtils.checkModel(json['role_menu_tabel_subjek_pajak_crud']);
    roleMenuSuperAdmin = StringUtils.checkModel(json['role_menu_super_admin']);
    wiluppdIdWiluppd = StringUtils.checkModel(json['wiluppd_id_wiluppd']);
    wiluppdKdWil = StringUtils.checkModel(json['wiluppd_kd_wil']);
    wiluppdKdWil1 = StringUtils.checkModel(json['wiluppd_kd_wil1']);
    wiluppdNmWil = StringUtils.checkModel(json['wiluppd_nm_wil']);
    wiluppdAlUppd = StringUtils.checkModel(json['wiluppd_al_uppd']);
    wiluppdKabKota = StringUtils.checkModel(json['wiluppd_kab_kota']);
    wiluppdPropinsi = StringUtils.checkModel(json['wiluppd_propinsi']);
    wiluppdTelp = StringUtils.checkModel(json['wiluppd_telp']);
    wiluppdNmWilEri = StringUtils.checkModel(json['wiluppd_nm_wil_eri']);
    wiluppdKdKotaEri = StringUtils.checkModel(json['wiluppd_kd_kota_eri']);
    wiluppdKdSubmarkasEri = StringUtils.checkModel(json['wiluppd_kd_submarkas_eri']);
    wiluppdKdWilInduk = StringUtils.checkModel(json['wiluppd_kd_wil_induk']);
    wiluppdSubKdWil = StringUtils.checkModel(json['wiluppd_sub_kd_wil']);
    wiluppdKdWilLama = StringUtils.checkModel(json['wiluppd_kd_wil_lama']);
    wiluppdDefaultNoPolisi1 = StringUtils.checkModel(json['wiluppd_default_no_polisi1']);
    wiluppdPoldaType = StringUtils.checkModel(json['wiluppd_polda_type']);
    wiluppdIsKasirAvail = StringUtils.checkModel(json['wiluppd_is_kasir_avail']);
    wiluppdKdKabKota = StringUtils.checkModel(json['wiluppd_kd_kab_kota']);
    wiluppdJudulDip1 = StringUtils.checkModel(json['wiluppd_judul_dip1']);
    wiluppdJudulDip2 = StringUtils.checkModel(json['wiluppd_judul_dip2']);
    wiluppdJudulDip3 = StringUtils.checkModel(json['wiluppd_judul_dip3']);
    wiluppdJudulDip4 = StringUtils.checkModel(json['wiluppd_judul_dip4']);
    wiluppdJudulDip5 = StringUtils.checkModel(json['wiluppd_judul_dip5']);
    wiluppdJudulDip6 = StringUtils.checkModel(json['wiluppd_judul_dip6']);
    wiluppdJudulDip7 = StringUtils.checkModel(json['wiluppd_judul_dip7']);
    wiluppdJudulDip8 = StringUtils.checkModel(json['wiluppd_judul_dip8']);
    wiluppdJudulPol1 = StringUtils.checkModel(json['wiluppd_judul_pol1']);
    wiluppdJudulPol2 = StringUtils.checkModel(json['wiluppd_judul_pol2']);
    wiluppdJudulPol3 = StringUtils.checkModel(json['wiluppd_judul_pol3']);
    wiluppdIndukKdWil = StringUtils.checkModel(json['wiluppd_induk_kd_wil']);
    wiluppdIndukNmWil = StringUtils.checkModel(json['wiluppd_induk_nm_wil']);
    wiluppdDefaultKdKabKota = StringUtils.checkModel(json['wiluppd_default_kd_kab_kota']);
    loketIdLoket = StringUtils.checkModel(json['loket_id_loket']);
    loketNmLoket = StringUtils.checkModel(json['loket_nm_loket']);
    loketIpPrinter = StringUtils.checkModel(json['loket_ip_printer']);
    loketFullname = StringUtils.checkModel(json['loket_fullname']);
    loketNamaPrinter = StringUtils.checkModel(json['loket_nama_printer']);
    loketPrintType = StringUtils.checkModel(json['loket_print_type']);
    loketProductCode = StringUtils.checkModel(json['loket_product_code']);
    loketNumerator = StringUtils.checkModel(json['loket_numerator']);
    loketKeterangan = StringUtils.checkModel(json['loket_keterangan']);
    loketIsActive = StringUtils.checkModel(json['loket_is_active']);
    loketUsername = StringUtils.checkModel(json['loket_username']);
    loketApiKey = StringUtils.checkModel(json['loket_api_key']);
    loketIdWiluppdProses = StringUtils.checkModel(json['loket_id_wiluppd_proses']);
    tappingIdWiluppdProses = StringUtils.checkModel(json['tapping_id_wiluppd_proses']);
    tappingIpPerangkat = StringUtils.checkModel(json['tapping_ip_perangkat']);
    tappingKeterangan = StringUtils.checkModel(json['tapping_keterangan']);
    tappingNmTapping = StringUtils.checkModel(json['tapping_nm_tapping']);
    tappingIdTapping = StringUtils.checkModel(json['tapping_id_tapping']);
    roleMenuInfoPajak = StringUtils.checkModel(json['role_menu_info_pajak']);
    roleMenuPembayaran = StringUtils.checkModel(json['role_menu_pembayaran']);
    roleMenuKoreksi = StringUtils.checkModel(json['role_menu_koreksi']);
    roleMenuNjkbCrud = StringUtils.checkModel(json['role_menu_njkb_crud']);
    roleMenuCetakSkkp = StringUtils.checkModel(json['role_menu_cetak_skkp']);
    roleMenuKirimSkkp = StringUtils.checkModel(json['role_menu_kirim_skkp']);
    roleMenuPembatalan = StringUtils.checkModel(json['role_menu_pembatalan']);
    roleMenuProteksi = StringUtils.checkModel(json['role_menu_proteksi']);
    roleMenuUpdateDataWp = StringUtils.checkModel(json['role_menu_update_data_wp']);
    roleMenuAwalAkhirLayanan = StringUtils.checkModel(json['role_menu_awal_akhir_layanan']);
    roleMenuKonfigurasiCetak = StringUtils.checkModel(json['role_menu_konfigurasi_cetak']);
    roleMenuKonfigurasiPing = StringUtils.checkModel(json['role_menu_konfigurasi_ping']);
    roleMenuTabelTransaksi = StringUtils.checkModel(json['role_menu_tabel_transaksi']);
    roleMenuTabelTransaksiCrud = StringUtils.checkModel(json['role_menu_tabel_transaksi_crud']);
    roleMenuAksesSelectAdmin = StringUtils.checkModel(json['role_menu_akses_select_sdmin']);
    roleMenuAksesSelectControl = StringUtils.checkModel(json['role_menu_akses_select_control']);
    roleMenuAkhirHariSys = StringUtils.checkModel(json['role_menu_akhir_hari_sys']);
    roleMenuCeknokanosinnopol = StringUtils.checkModel(json['role_menu_ceknokanosinnopol']);
    roleMenuAdminLayanan = StringUtils.checkModel(json['role_menu_admin_layanan']);
    roleMenuAdminLayananEdit = StringUtils.checkModel(json['role_menu_admin_layanan_edit']);
    wiluppdIndukDefaultKdKabKota =
        StringUtils.checkModel(json['wiluppd_induk_default_kd_kab_kota']);
    wiluppdIndukDefaultNoRek = StringUtils.checkModel(json['wiluppd_induk_default_no_rek']);
    wiluppdIndukNmKabKota = StringUtils.checkModel(json['wiluppd_induk_nm_kab_kota']);
    roleMenuHistPembatalan = StringUtils.checkModel(json['role_menu_hist_pembatalan']);
    roleMenuHistStsOnline = StringUtils.checkModel(json['role_menu_hist_sts_online']);
    roleMenuHistTabelPembayaran = StringUtils.checkModel(json['role_menu_hist_tabel_pembayaran']);
    roleMenuHistTabelRole = StringUtils.checkModel(json['role_menu_hist_tabel_role']);
    roleMenuHistTabelTransaksi = StringUtils.checkModel(json['role_menu_hist_tabel_transaksi']);
    roleMenuHistTabelUser = StringUtils.checkModel(json['role_menu_hist_tabel_user']);
    roleMenuHistTabelObjekPajak = StringUtils.checkModel(json['role_menu_hist_tabel_objek_pajak']);
    roleMenuHistTabelSubjekPajak =
        StringUtils.checkModel(json['role_menu_hist_tabel_subjek_pajak']);
    roleAksesTroubleshoot = StringUtils.checkModel(json['role_akses_toubleshoot']);
    roleMenuUpdateObjekPajak = StringUtils.checkModel(json['role_menu_update_objek_pajak']);
    roleMenuPendaftaranPolri = StringUtils.checkModel(json['role_menu_pendaftaran_polri']);
    roleMenuCetakStnk = StringUtils.checkModel(json['role_menu_cetak_stnk']);
    roleAksesToubleshoot = StringUtils.checkModel(json['role_akses_toubleshoot']);
    roleMenuTutorialPembayaran = StringUtils.checkModel(json['role_menu_tutorial_pembayaran']);
    roleMenuBayarDigital = StringUtils.checkModel(json['role_menu_bayar_digital']);
    roleMenuBayarDigital5thn = StringUtils.checkModel(json['role_menu_bayar_digital_5thn']);
    roleMenuTabelProteksi = StringUtils.checkModel(json['role_menu_tabel_proteksi']);
    roleMenuTabelBlokir = StringUtils.checkModel(json['role_menu_tabel_blokir']);
    roleMenuTabelPembayaranLampau =
        StringUtils.checkModel(json['role_menu_tabel_pembayaran_lampau']);
    roleMenuTuPolri = StringUtils.checkModel(json['role_menu_tu_polri']);
    roleMenuTabelUserC = StringUtils.checkModel(json['role_menu_tabel_user_c']);
    roleMenuTabelUserU = StringUtils.checkModel(json['role_menu_tabel_user_u']);
    roleMenuTabelUserD = StringUtils.checkModel(json['role_menu_tabel_user_d']);
    roleMenuTabelMutasikel = StringUtils.checkModel(json['role_menu_tabel_mutasikel']);
    roleMenuLaporanBulanan2 = StringUtils.checkModel(json['role_menu_laporan_bulanan_2']);
    roleMenuLogKoreksi = StringUtils.checkModel(json['role_menu_log_koreksi']);
    wiluppdIsBlocked = StringUtils.checkModel(json['wiluppd_is_blocked']);
    wiluppdIndukIsSingleKabKota = StringUtils.checkModel(json['wiluppd_induk_is_single_kab_kota']);
    roleMenuAbleLoginMobile = StringUtils.checkModel(json['role_menu_able_login_mobile']);
    roleMenuVerfikasiReservasi = StringUtils.checkModel(json['role_menu_verifikasi_reservasi']);
    roleMenuLoketMutasikel = StringUtils.checkModel(json['role_menu_loket_mutasikel']);
    roleMenuLoketMutasikelCrud = StringUtils.checkModel(json['role_menu_loket_mutasikel_crud']);
    roleMenuHitungUlangDev = StringUtils.checkModel(json['role_menu_hitung_ulang_dev']);
    roleMenuTabelReservasiSamsatDigital =
        StringUtils.checkModel(json['role_menu_tabel_reservasi_samsat_digital']);
    roleMenuTabelReservasiAntrian =
        StringUtils.checkModel(json['role_menu_tabel_reservasi_antrian']);
    roleMenuPendingNopol = StringUtils.checkModel(json['role_menu_pending_nopol']);
    roleMenuCms = StringUtils.checkModel(json['role_menu_cms']);
    roleMenuManajemenKuota = StringUtils.checkModel(json['role_menu_manajemen_kuota']);
    roleMenuManajemenKuotaCf = StringUtils.checkModel(json['role_menu_manajemen_kuota_cf']);
    roleMenuRekonEsamsat = StringUtils.checkModel(json['role_menu_rekon_esamsat']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['user_data'] = userData;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['id_wiluppd_kerja'] = idWiluppdKerja;
    data['kd_wil'] = kdWil;
    data['id_jenis_layanan'] = idJenisLayanan;
    data['id_loket'] = idLoket;
    data['id_tapping'] = idTapping;
    data['no_wa'] = noWa;
    data['bayar_qris'] = bayarQris;
    data['bayar_va'] = bayarVa;
    data['bayar_edc'] = bayarEdc;
    data['bayar_tunai'] = bayarTunai;
    data['id_role'] = idRole;
    data['layanan1'] = layanan1;
    data['layanan2'] = layanan2;
    data['layanan3'] = layanan3;
    data['layanan4'] = layanan4;
    data['layanan5'] = layanan5;
    data['layanan6'] = layanan6;
    data['layanan7'] = layanan7;
    data['id_edc'] = idEdc;
    data['role_id_role'] = roleIdRole;
    data['role_nm_role'] = roleNmRole;
    data['role_menu_progresif_nopol'] = roleMenuProgresifNopol;
    data['role_menu_progresif_noidentitas'] = roleMenuProgresifNoidentitas;
    data['role_menu_progresif_tapping'] = roleMenuProgresifTapping;
    data['role_menu_progresif_namaalamat'] = roleMenuProgresifNamaalamat;
    data['role_menu_pendaftaran_tahunan_luar_induk'] = roleMenuPendaftaranTahunanLuarInduk;
    data['role_menu_pendaftaran_kurang_bayar'] = roleMenuPendaftaranKurangBayar;
    data['role_menu_pendaftaran_mutasi_keluar'] = roleMenuPendaftaranMutasiKeluar;
    data['role_menu_laporan_harian'] = roleMenuLaporanHarian;
    data['role_menu_laporan_bulanan'] = roleMenuLaporanBulanan;
    data['role_menu_laporan_sts_online'] = roleMenuLaporanStsOnline;
    data['role_menu_njkb'] = roleMenuNjkb;
    data['role_menu_riwayat_pembayaran'] = roleMenuRiwayatPembayaran;
    data['role_menu_verifikasi'] = roleMenuVerifikasi;
    data['role_menu_historis'] = roleMenuHistoris;
    data['role_menu_tabel_pembayaran'] = roleMenuTabelPembayaran;
    data['role_menu_tabel_pembayaran_crud'] = roleMenuTabelPembayaranCrud;
    data['role_menu_tabel_user'] = roleMenuTabelUser;
    data['role_menu_tabel_user_crud'] = roleMenuTabelUserCrud;
    data['role_menu_tabel_role'] = roleMenuTabelRole;
    data['role_menu_tabel_role_crud'] = roleMenuTabelRoleCrud;
    data['role_menu_tabel_tapping'] = roleMenuTabelTapping;
    data['role_menu_tabel_tapping_crud'] = roleMenuTabelTappingCrud;
    data['role_menu_tabel_loket'] = roleMenuTabelLoket;
    data['role_menu_tabel_loket_crud'] = roleMenuTabelLoketCrud;
    data['role_menu_tabel_objek_pajak'] = roleMenuTabelObjekPajak;
    data['role_menu_tabel_objek_pajak_crud'] = roleMenuTabelObjekPajakCrud;
    data['role_menu_tabel_subjek_pajak'] = roleMenuTabelSubjekPajak;
    data['role_menu_tabel_subjek_pajak_crud'] = roleMenuTabelSubjekPajakCrud;
    data['role_menu_super_admin'] = roleMenuSuperAdmin;
    data['wiluppd_id_wiluppd'] = wiluppdIdWiluppd;
    data['wiluppd_kd_wil'] = wiluppdKdWil;
    data['wiluppd_kd_wil1'] = wiluppdKdWil1;
    data['wiluppd_nm_wil'] = wiluppdNmWil;
    data['wiluppd_al_uppd'] = wiluppdAlUppd;
    data['wiluppd_kab_kota'] = wiluppdKabKota;
    data['wiluppd_propinsi'] = wiluppdPropinsi;
    data['wiluppd_telp'] = wiluppdTelp;
    data['wiluppd_nm_wil_eri'] = wiluppdNmWilEri;
    data['wiluppd_kd_kota_eri'] = wiluppdKdKotaEri;
    data['wiluppd_kd_submarkas_eri'] = wiluppdKdSubmarkasEri;
    data['wiluppd_kd_wil_induk'] = wiluppdKdWilInduk;
    data['wiluppd_sub_kd_wil'] = wiluppdSubKdWil;
    data['wiluppd_kd_wil_lama'] = wiluppdKdWilLama;
    data['wiluppd_default_no_polisi1'] = wiluppdDefaultNoPolisi1;
    data['wiluppd_polda_type'] = wiluppdPoldaType;
    data['wiluppd_is_kasir_avail'] = wiluppdIsKasirAvail;
    data['wiluppd_kd_kab_kota'] = wiluppdKdKabKota;
    data['wiluppd_judul_dip1'] = wiluppdJudulDip1;
    data['wiluppd_judul_dip2'] = wiluppdJudulDip2;
    data['wiluppd_judul_dip3'] = wiluppdJudulDip3;
    data['wiluppd_judul_dip4'] = wiluppdJudulDip4;
    data['wiluppd_judul_dip5'] = wiluppdJudulDip5;
    data['wiluppd_judul_dip6'] = wiluppdJudulDip6;
    data['wiluppd_judul_dip7'] = wiluppdJudulDip7;
    data['wiluppd_judul_dip8'] = wiluppdJudulDip8;
    data['wiluppd_judul_pol1'] = wiluppdJudulPol1;
    data['wiluppd_judul_pol2'] = wiluppdJudulPol2;
    data['wiluppd_judul_pol3'] = wiluppdJudulPol3;
    data['wiluppd_induk_kd_wil'] = wiluppdIndukKdWil;
    data['wiluppd_induk_nm_wil'] = wiluppdIndukNmWil;
    data['wiluppd_default_kd_kab_kota'] = wiluppdDefaultKdKabKota;
    data['loket_id_loket'] = loketIdLoket;
    data['loket_nm_loket'] = loketNmLoket;
    data['loket_ip_printer'] = loketIpPrinter;
    data['loket_fullname'] = loketFullname;
    data['loket_nama_printer'] = loketNamaPrinter;
    data['loket_print_type'] = loketPrintType;
    data['loket_product_code'] = loketProductCode;
    data['loket_numerator'] = loketNumerator;
    data['loket_keterangan'] = loketKeterangan;
    data['loket_is_active'] = loketIsActive;
    data['loket_username'] = loketUsername;
    data['loket_api_key'] = loketApiKey;
    data['loket_id_wiluppd_proses'] = loketIdWiluppdProses;
    data['tapping_id_wiluppd_proses'] = tappingIdWiluppdProses;
    data['tapping_ip_perangkat'] = tappingIpPerangkat;
    data['tapping_keterangan'] = tappingKeterangan;
    data['tapping_nm_tapping'] = tappingNmTapping;
    data['tapping_id_tapping'] = tappingIdTapping;
    data['role_menu_info_pajak'] = roleMenuInfoPajak;
    data['role_menu_pembayaran'] = roleMenuPembayaran;
    data['role_menu_koreksi'] = roleMenuKoreksi;
    data['role_menu_njkb_crud'] = roleMenuNjkbCrud;
    data['role_menu_cetak_skkp'] = roleMenuCetakSkkp;
    data['role_menu_kirim_skkp'] = roleMenuKirimSkkp;
    data['role_menu_pembatalan'] = roleMenuPembatalan;
    data['role_menu_proteksi'] = roleMenuProteksi;
    data['role_menu_update_data_wp'] = roleMenuUpdateDataWp;
    data['role_menu_awal_akhir_layanan'] = roleMenuAwalAkhirLayanan;
    data['role_menu_konfigurasi_cetak'] = roleMenuKonfigurasiCetak;
    data['role_menu_konfigurasi_ping'] = roleMenuKonfigurasiPing;
    data['role_menu_update_data_wp'] = roleMenuUpdateDataWp;
    data['role_menu_awal_akhir_layanan'] = roleMenuAwalAkhirLayanan;
    data['role_menu_konfigurasi_cetak'] = roleMenuKonfigurasiCetak;
    data['role_menu_konfigurasi_ping'] = roleMenuKonfigurasiPing;
    data['role_menu_tabel_transaksi'] = roleMenuTabelTransaksi;
    data['role_menu_tabel_transaksi_crud'] = roleMenuTabelTransaksiCrud;
    data['role_menu_akses_select_sdmin'] = roleMenuAksesSelectAdmin;
    data['role_menu_akses_select_control'] = roleMenuAksesSelectControl;
    data['role_menu_akhirHari_sys'] = roleMenuAkhirHariSys;
    data['role_menu_ceknokanosinnopol'] = roleMenuCeknokanosinnopol;
    data['role_menu_admin_layanan'] = roleMenuAdminLayanan;
    data['role_menu_admin_layanan_edit'] = roleMenuAdminLayananEdit;
    data['wiluppd_induk_default_kd_kab_kota'] = wiluppdIndukDefaultKdKabKota;
    data['wiluppd_induk_default_no_rek'] = wiluppdIndukDefaultNoRek;
    data['wiluppd_induk_nm_kab_kota'] = wiluppdIndukNmKabKota;
    data['role_menu_hist_pembatalan'] = roleMenuHistPembatalan;
    data['role_menu_hist_sts_online'] = roleMenuHistStsOnline;
    data['role_menu_hist_tabel_pembayaran'] = roleMenuHistTabelPembayaran;
    data['role_menu_hist_tabel_role'] = roleMenuHistTabelRole;
    data['role_menu_hist_tabel_transaksi'] = roleMenuHistTabelTransaksi;
    data['role_menu_hist_tabel_user'] = roleMenuHistTabelUser;
    data['role_menu_hist_tabel_objek_pajak'] = roleMenuHistTabelObjekPajak;
    data['role_menu_hist_tabel_subjek_pajak'] = roleMenuHistTabelSubjekPajak;
    data['role_akses_toubleshoot'] = roleAksesTroubleshoot;
    data['role_menu_update_objek_pajak'] = roleMenuUpdateObjekPajak;
    data['role_menu_pendaftaran_polri'] = roleMenuPendaftaranPolri;
    data['role_menu_cetak_stnk'] = roleMenuCetakStnk;
    data['role_akses_toubleshoot'] = roleAksesToubleshoot;
    data['role_menu_tutorial_pembayaran'] = roleMenuTutorialPembayaran;
    data['role_menu_bayar_digital'] = roleMenuBayarDigital;
    data['role_menu_bayar_digital_5thn'] = roleMenuBayarDigital5thn;
    data['role_menu_tabel_proteksi'] = roleMenuTabelProteksi;
    data['role_menu_tabel_blokir'] = roleMenuTabelBlokir;
    data['role_menu_tabel_pembayaran_lampau'] = roleMenuTabelPembayaranLampau;
    data['role_menu_tu_polri'] = roleMenuTuPolri;
    data['role_menu_tabel_user_c'] = roleMenuTabelUserC;
    data['role_menu_tabel_user_u'] = roleMenuTabelUserU;
    data['role_menu_tabel_user_d'] = roleMenuTabelUserD;
    data['role_menu_tabel_mutasikel'] = roleMenuTabelMutasikel;
    data['role_menu_laporan_bulanan2'] = roleMenuLaporanBulanan2;
    data['role_menu_log_koreksi'] = roleMenuLogKoreksi;
    data['wiluppd_is_blocked'] = wiluppdIsBlocked;
    data['wiluppd_induk_is_single_kab_kota'] = wiluppdIndukIsSingleKabKota;
    data['role_menu_able_login_mobile'] = roleMenuAbleLoginMobile;
    data['role_menu_verifikasi_reservasi'] = roleMenuVerfikasiReservasi;
    data['role_menu_loket_mutasikel'] = roleMenuLoketMutasikel;
    data['role_menu_loket_mutasikel_crud'] = roleMenuLoketMutasikelCrud;
    data['role_menu_hitung_ulang_dev'] = roleMenuHitungUlangDev;
    data['role_menu_tabel_reservasi_samsat_digital'] = roleMenuTabelReservasiSamsatDigital;
    data['role_menu_tabel_reservasi_antrian'] = roleMenuTabelReservasiAntrian;
    data['role_menu_pending_nopol'] = roleMenuPendingNopol;
    data['role_menu_cms'] = roleMenuCms;
    data['role_menu_manajemen_kuota'] = roleMenuManajemenKuota;
    data['role_menu_manajemen_kuota_cf'] = roleMenuManajemenKuotaCf;
    data['role_menu_rekon_esamsat'] = roleMenuRekonEsamsat;

    return data;
  }

  String dataPicAsString() {
    return '${StringUtils.trimString(name)} - ${StringUtils.trimString(noWa)}';
  }
}
