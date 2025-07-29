// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataModelAdapter extends TypeAdapter<UserDataModel> {
  @override
  final int typeId = 12;

  @override
  UserDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataModel(
      code: fields[0] as String?,
      success: fields[1] as bool?,
      data: fields[2] as DataUser?,
      message: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.success)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataUserAdapter extends TypeAdapter<DataUser> {
  @override
  final int typeId = 13;

  @override
  DataUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataUser(
      id: fields[0] as String?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      username: fields[3] as String?,
      emailVerifiedAt: fields[4] as String?,
      password: fields[5] as String?,
      userData: fields[6] as String?,
      rememberToken: fields[7] as String?,
      createdAt: fields[8] as String?,
      updatedAt: fields[9] as String?,
      idWiluppdKerja: fields[10] as String?,
      kdWil: fields[11] as String?,
      idJenisLayanan: fields[12] as String?,
      idLoket: fields[13] as String?,
      idTapping: fields[14] as String?,
      noWa: fields[15] as String?,
      bayarQris: fields[16] as String?,
      bayarVa: fields[17] as String?,
      bayarEdc: fields[18] as String?,
      bayarTunai: fields[19] as String?,
      idRole: fields[20] as String?,
      layanan1: fields[21] as String?,
      layanan2: fields[22] as String?,
      layanan3: fields[23] as String?,
      layanan4: fields[24] as String?,
      layanan5: fields[25] as String?,
      layanan6: fields[26] as String?,
      layanan7: fields[27] as String?,
      idEdc: fields[28] as String?,
      roleIdRole: fields[29] as String?,
      roleNmRole: fields[30] as String?,
      roleMenuProgresifNopol: fields[31] as String?,
      roleMenuProgresifNoidentitas: fields[32] as String?,
      roleMenuProgresifTapping: fields[33] as String?,
      roleMenuProgresifNamaalamat: fields[34] as String?,
      roleMenuPendaftaranTahunanLuarInduk: fields[35] as String?,
      roleMenuPendaftaranKurangBayar: fields[36] as String?,
      roleMenuPendaftaranMutasiKeluar: fields[37] as String?,
      roleMenuLaporanHarian: fields[38] as String?,
      roleMenuLaporanBulanan: fields[39] as String?,
      roleMenuLaporanStsOnline: fields[40] as String?,
      roleMenuNjkb: fields[41] as String?,
      roleMenuRiwayatPembayaran: fields[42] as String?,
      roleMenuVerifikasi: fields[43] as String?,
      roleMenuHistoris: fields[44] as String?,
      roleMenuTabelPembayaran: fields[45] as String?,
      roleMenuTabelPembayaranCrud: fields[46] as String?,
      roleMenuTabelUser: fields[47] as String?,
      roleMenuTabelUserCrud: fields[48] as String?,
      roleMenuTabelRole: fields[49] as String?,
      roleMenuTabelRoleCrud: fields[50] as String?,
      roleMenuTabelTapping: fields[51] as String?,
      roleMenuTabelTappingCrud: fields[52] as String?,
      roleMenuTabelLoket: fields[53] as String?,
      roleMenuTabelLoketCrud: fields[54] as String?,
      roleMenuTabelObjekPajak: fields[55] as String?,
      roleMenuTabelObjekPajakCrud: fields[56] as String?,
      roleMenuTabelSubjekPajak: fields[57] as String?,
      roleMenuTabelSubjekPajakCrud: fields[58] as String?,
      roleMenuSuperAdmin: fields[59] as String?,
      roleMenuInfoPajak: fields[110] as String?,
      roleMenuPembayaran: fields[111] as String?,
      roleMenuKoreksi: fields[112] as String?,
      roleMenuNjkbCrud: fields[113] as String?,
      roleMenuCetakSkkp: fields[114] as String?,
      roleMenuKirimSkkp: fields[115] as String?,
      roleMenuPembatalan: fields[116] as String?,
      roleMenuProteksi: fields[117] as String?,
      roleMenuUpdateDataWp: fields[118] as String?,
      roleMenuAwalAkhirLayanan: fields[119] as String?,
      roleMenuKonfigurasiCetak: fields[120] as String?,
      roleMenuKonfigurasiPing: fields[121] as String?,
      wiluppdIdWiluppd: fields[60] as String?,
      wiluppdKdWil: fields[61] as String?,
      wiluppdKdWil1: fields[62] as String?,
      wiluppdNmWil: fields[63] as String?,
      wiluppdAlUppd: fields[64] as String?,
      wiluppdKabKota: fields[65] as String?,
      wiluppdPropinsi: fields[66] as String?,
      wiluppdTelp: fields[67] as String?,
      wiluppdNmWilEri: fields[68] as String?,
      wiluppdKdKotaEri: fields[69] as String?,
      wiluppdKdSubmarkasEri: fields[70] as String?,
      wiluppdKdWilInduk: fields[71] as String?,
      wiluppdSubKdWil: fields[72] as String?,
      wiluppdKdWilLama: fields[73] as String?,
      wiluppdDefaultNoPolisi1: fields[74] as String?,
      wiluppdPoldaType: fields[75] as String?,
      wiluppdIsKasirAvail: fields[76] as String?,
      wiluppdKdKabKota: fields[77] as String?,
      wiluppdJudulDip1: fields[78] as String?,
      wiluppdJudulDip2: fields[79] as String?,
      wiluppdJudulDip3: fields[80] as String?,
      wiluppdJudulDip4: fields[81] as String?,
      wiluppdJudulDip5: fields[82] as String?,
      wiluppdJudulDip6: fields[83] as String?,
      wiluppdJudulDip7: fields[84] as String?,
      wiluppdJudulDip8: fields[85] as String?,
      wiluppdJudulPol1: fields[86] as String?,
      wiluppdJudulPol2: fields[87] as String?,
      wiluppdJudulPol3: fields[88] as String?,
      wiluppdIndukKdWil: fields[89] as String?,
      wiluppdIndukNmWil: fields[90] as String?,
      wiluppdDefaultKdKabKota: fields[91] as String?,
      loketIdLoket: fields[92] as String?,
      loketNmLoket: fields[93] as String?,
      loketIpPrinter: fields[94] as String?,
      loketFullname: fields[95] as String?,
      loketNamaPrinter: fields[96] as String?,
      loketPrintType: fields[97] as String?,
      loketProductCode: fields[98] as String?,
      loketNumerator: fields[99] as String?,
      loketKeterangan: fields[100] as String?,
      loketIsActive: fields[101] as bool?,
      loketUsername: fields[102] as String?,
      loketApiKey: fields[103] as String?,
      loketIdWiluppdProses: fields[104] as String?,
      tappingIdWiluppdProses: fields[105] as String?,
      tappingIpPerangkat: fields[106] as String?,
      tappingKeterangan: fields[107] as String?,
      tappingNmTapping: fields[108] as String?,
      tappingIdTapping: fields[109] as String?,
      roleMenuTabelTransaksi: fields[122] as String?,
      roleMenuTabelTransaksiCrud: fields[123] as String?,
      roleMenuAksesSelectAdmin: fields[124] as String?,
      roleMenuAksesSelectControl: fields[125] as String?,
      roleMenuAkhirHariSys: fields[126] as String?,
      roleMenuCeknokanosinnopol: fields[127] as String?,
      roleMenuAdminLayanan: fields[128] as String?,
      roleMenuAdminLayananEdit: fields[129] as String?,
      wiluppdIndukDefaultKdKabKota: fields[130] as String?,
      wiluppdIndukDefaultNoRek: fields[131] as String?,
      wiluppdIndukNmKabKota: fields[132] as String?,
      roleMenuHistPembatalan: fields[138] as String?,
      roleMenuHistStsOnline: fields[137] as String?,
      roleMenuHistTabelPembayaran: fields[135] as String?,
      roleMenuHistTabelRole: fields[134] as String?,
      roleMenuHistTabelTransaksi: fields[136] as String?,
      roleMenuHistTabelUser: fields[133] as String?,
      roleMenuHistTabelObjekPajak: fields[139] as String?,
      roleMenuHistTabelSubjekPajak: fields[140] as String?,
      roleAksesTroubleshoot: fields[141] as String?,
      roleMenuUpdateObjekPajak: fields[142] as String?,
      roleMenuPendaftaranPolri: fields[143] as String?,
      roleMenuCetakStnk: fields[144] as String?,
      roleAksesToubleshoot: fields[145] as String?,
      roleMenuTutorialPembayaran: fields[146] as String?,
      roleMenuBayarDigital: fields[147] as String?,
      roleMenuBayarDigital5thn: fields[148] as String?,
      roleMenuTabelProteksi: fields[149] as String?,
      roleMenuTabelBlokir: fields[150] as String?,
      roleMenuTabelPembayaranLampau: fields[151] as String?,
      roleMenuTuPolri: fields[152] as String?,
      roleMenuTabelUserC: fields[153] as String?,
      roleMenuTabelUserU: fields[154] as String?,
      roleMenuTabelUserD: fields[155] as String?,
      roleMenuTabelMutasikel: fields[156] as String?,
      roleMenuLaporanBulanan2: fields[157] as String?,
      roleMenuLogKoreksi: fields[158] as String?,
      wiluppdIsBlocked: fields[159] as String?,
      wiluppdIndukIsSingleKabKota: fields[160] as String?,
      roleMenuAbleLoginMobile: fields[161] as String?,
      roleMenuVerfikasiReservasi: fields[162] as String?,
      roleMenuLoketMutasikel: fields[163] as String?,
      roleMenuLoketMutasikelCrud: fields[164] as String?,
      roleMenuHitungUlangDev: fields[165] as String?,
      roleMenuTabelReservasiSamsatDigital: fields[166] as String?,
      roleMenuTabelReservasiAntrian: fields[167] as String?,
      roleMenuPendingNopol: fields[168] as String?,
      roleMenuCms: fields[169] as String?,
      roleMenuManajemenKuota: fields[170] as String?,
      roleMenuManajemenKuotaCf: fields[171] as String?,
      roleMenuRekonEsamsat: fields[172] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataUser obj) {
    writer
      ..writeByte(173)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.emailVerifiedAt)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.userData)
      ..writeByte(7)
      ..write(obj.rememberToken)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.idWiluppdKerja)
      ..writeByte(11)
      ..write(obj.kdWil)
      ..writeByte(12)
      ..write(obj.idJenisLayanan)
      ..writeByte(13)
      ..write(obj.idLoket)
      ..writeByte(14)
      ..write(obj.idTapping)
      ..writeByte(15)
      ..write(obj.noWa)
      ..writeByte(16)
      ..write(obj.bayarQris)
      ..writeByte(17)
      ..write(obj.bayarVa)
      ..writeByte(18)
      ..write(obj.bayarEdc)
      ..writeByte(19)
      ..write(obj.bayarTunai)
      ..writeByte(20)
      ..write(obj.idRole)
      ..writeByte(21)
      ..write(obj.layanan1)
      ..writeByte(22)
      ..write(obj.layanan2)
      ..writeByte(23)
      ..write(obj.layanan3)
      ..writeByte(24)
      ..write(obj.layanan4)
      ..writeByte(25)
      ..write(obj.layanan5)
      ..writeByte(26)
      ..write(obj.layanan6)
      ..writeByte(27)
      ..write(obj.layanan7)
      ..writeByte(28)
      ..write(obj.idEdc)
      ..writeByte(29)
      ..write(obj.roleIdRole)
      ..writeByte(30)
      ..write(obj.roleNmRole)
      ..writeByte(31)
      ..write(obj.roleMenuProgresifNopol)
      ..writeByte(32)
      ..write(obj.roleMenuProgresifNoidentitas)
      ..writeByte(33)
      ..write(obj.roleMenuProgresifTapping)
      ..writeByte(34)
      ..write(obj.roleMenuProgresifNamaalamat)
      ..writeByte(35)
      ..write(obj.roleMenuPendaftaranTahunanLuarInduk)
      ..writeByte(36)
      ..write(obj.roleMenuPendaftaranKurangBayar)
      ..writeByte(37)
      ..write(obj.roleMenuPendaftaranMutasiKeluar)
      ..writeByte(38)
      ..write(obj.roleMenuLaporanHarian)
      ..writeByte(39)
      ..write(obj.roleMenuLaporanBulanan)
      ..writeByte(40)
      ..write(obj.roleMenuLaporanStsOnline)
      ..writeByte(41)
      ..write(obj.roleMenuNjkb)
      ..writeByte(42)
      ..write(obj.roleMenuRiwayatPembayaran)
      ..writeByte(43)
      ..write(obj.roleMenuVerifikasi)
      ..writeByte(44)
      ..write(obj.roleMenuHistoris)
      ..writeByte(45)
      ..write(obj.roleMenuTabelPembayaran)
      ..writeByte(46)
      ..write(obj.roleMenuTabelPembayaranCrud)
      ..writeByte(47)
      ..write(obj.roleMenuTabelUser)
      ..writeByte(48)
      ..write(obj.roleMenuTabelUserCrud)
      ..writeByte(49)
      ..write(obj.roleMenuTabelRole)
      ..writeByte(50)
      ..write(obj.roleMenuTabelRoleCrud)
      ..writeByte(51)
      ..write(obj.roleMenuTabelTapping)
      ..writeByte(52)
      ..write(obj.roleMenuTabelTappingCrud)
      ..writeByte(53)
      ..write(obj.roleMenuTabelLoket)
      ..writeByte(54)
      ..write(obj.roleMenuTabelLoketCrud)
      ..writeByte(55)
      ..write(obj.roleMenuTabelObjekPajak)
      ..writeByte(56)
      ..write(obj.roleMenuTabelObjekPajakCrud)
      ..writeByte(57)
      ..write(obj.roleMenuTabelSubjekPajak)
      ..writeByte(58)
      ..write(obj.roleMenuTabelSubjekPajakCrud)
      ..writeByte(59)
      ..write(obj.roleMenuSuperAdmin)
      ..writeByte(60)
      ..write(obj.wiluppdIdWiluppd)
      ..writeByte(61)
      ..write(obj.wiluppdKdWil)
      ..writeByte(62)
      ..write(obj.wiluppdKdWil1)
      ..writeByte(63)
      ..write(obj.wiluppdNmWil)
      ..writeByte(64)
      ..write(obj.wiluppdAlUppd)
      ..writeByte(65)
      ..write(obj.wiluppdKabKota)
      ..writeByte(66)
      ..write(obj.wiluppdPropinsi)
      ..writeByte(67)
      ..write(obj.wiluppdTelp)
      ..writeByte(68)
      ..write(obj.wiluppdNmWilEri)
      ..writeByte(69)
      ..write(obj.wiluppdKdKotaEri)
      ..writeByte(70)
      ..write(obj.wiluppdKdSubmarkasEri)
      ..writeByte(71)
      ..write(obj.wiluppdKdWilInduk)
      ..writeByte(72)
      ..write(obj.wiluppdSubKdWil)
      ..writeByte(73)
      ..write(obj.wiluppdKdWilLama)
      ..writeByte(74)
      ..write(obj.wiluppdDefaultNoPolisi1)
      ..writeByte(75)
      ..write(obj.wiluppdPoldaType)
      ..writeByte(76)
      ..write(obj.wiluppdIsKasirAvail)
      ..writeByte(77)
      ..write(obj.wiluppdKdKabKota)
      ..writeByte(78)
      ..write(obj.wiluppdJudulDip1)
      ..writeByte(79)
      ..write(obj.wiluppdJudulDip2)
      ..writeByte(80)
      ..write(obj.wiluppdJudulDip3)
      ..writeByte(81)
      ..write(obj.wiluppdJudulDip4)
      ..writeByte(82)
      ..write(obj.wiluppdJudulDip5)
      ..writeByte(83)
      ..write(obj.wiluppdJudulDip6)
      ..writeByte(84)
      ..write(obj.wiluppdJudulDip7)
      ..writeByte(85)
      ..write(obj.wiluppdJudulDip8)
      ..writeByte(86)
      ..write(obj.wiluppdJudulPol1)
      ..writeByte(87)
      ..write(obj.wiluppdJudulPol2)
      ..writeByte(88)
      ..write(obj.wiluppdJudulPol3)
      ..writeByte(89)
      ..write(obj.wiluppdIndukKdWil)
      ..writeByte(90)
      ..write(obj.wiluppdIndukNmWil)
      ..writeByte(91)
      ..write(obj.wiluppdDefaultKdKabKota)
      ..writeByte(92)
      ..write(obj.loketIdLoket)
      ..writeByte(93)
      ..write(obj.loketNmLoket)
      ..writeByte(94)
      ..write(obj.loketIpPrinter)
      ..writeByte(95)
      ..write(obj.loketFullname)
      ..writeByte(96)
      ..write(obj.loketNamaPrinter)
      ..writeByte(97)
      ..write(obj.loketPrintType)
      ..writeByte(98)
      ..write(obj.loketProductCode)
      ..writeByte(99)
      ..write(obj.loketNumerator)
      ..writeByte(100)
      ..write(obj.loketKeterangan)
      ..writeByte(101)
      ..write(obj.loketIsActive)
      ..writeByte(102)
      ..write(obj.loketUsername)
      ..writeByte(103)
      ..write(obj.loketApiKey)
      ..writeByte(104)
      ..write(obj.loketIdWiluppdProses)
      ..writeByte(105)
      ..write(obj.tappingIdWiluppdProses)
      ..writeByte(106)
      ..write(obj.tappingIpPerangkat)
      ..writeByte(107)
      ..write(obj.tappingKeterangan)
      ..writeByte(108)
      ..write(obj.tappingNmTapping)
      ..writeByte(109)
      ..write(obj.tappingIdTapping)
      ..writeByte(110)
      ..write(obj.roleMenuInfoPajak)
      ..writeByte(111)
      ..write(obj.roleMenuPembayaran)
      ..writeByte(112)
      ..write(obj.roleMenuKoreksi)
      ..writeByte(113)
      ..write(obj.roleMenuNjkbCrud)
      ..writeByte(114)
      ..write(obj.roleMenuCetakSkkp)
      ..writeByte(115)
      ..write(obj.roleMenuKirimSkkp)
      ..writeByte(116)
      ..write(obj.roleMenuPembatalan)
      ..writeByte(117)
      ..write(obj.roleMenuProteksi)
      ..writeByte(118)
      ..write(obj.roleMenuUpdateDataWp)
      ..writeByte(119)
      ..write(obj.roleMenuAwalAkhirLayanan)
      ..writeByte(120)
      ..write(obj.roleMenuKonfigurasiCetak)
      ..writeByte(121)
      ..write(obj.roleMenuKonfigurasiPing)
      ..writeByte(122)
      ..write(obj.roleMenuTabelTransaksi)
      ..writeByte(123)
      ..write(obj.roleMenuTabelTransaksiCrud)
      ..writeByte(124)
      ..write(obj.roleMenuAksesSelectAdmin)
      ..writeByte(125)
      ..write(obj.roleMenuAksesSelectControl)
      ..writeByte(126)
      ..write(obj.roleMenuAkhirHariSys)
      ..writeByte(127)
      ..write(obj.roleMenuCeknokanosinnopol)
      ..writeByte(128)
      ..write(obj.roleMenuAdminLayanan)
      ..writeByte(129)
      ..write(obj.roleMenuAdminLayananEdit)
      ..writeByte(130)
      ..write(obj.wiluppdIndukDefaultKdKabKota)
      ..writeByte(131)
      ..write(obj.wiluppdIndukDefaultNoRek)
      ..writeByte(132)
      ..write(obj.wiluppdIndukNmKabKota)
      ..writeByte(133)
      ..write(obj.roleMenuHistTabelUser)
      ..writeByte(134)
      ..write(obj.roleMenuHistTabelRole)
      ..writeByte(135)
      ..write(obj.roleMenuHistTabelPembayaran)
      ..writeByte(136)
      ..write(obj.roleMenuHistTabelTransaksi)
      ..writeByte(137)
      ..write(obj.roleMenuHistStsOnline)
      ..writeByte(138)
      ..write(obj.roleMenuHistPembatalan)
      ..writeByte(139)
      ..write(obj.roleMenuHistTabelObjekPajak)
      ..writeByte(140)
      ..write(obj.roleMenuHistTabelSubjekPajak)
      ..writeByte(141)
      ..write(obj.roleAksesTroubleshoot)
      ..writeByte(142)
      ..write(obj.roleMenuUpdateObjekPajak)
      ..writeByte(143)
      ..write(obj.roleMenuPendaftaranPolri)
      ..writeByte(144)
      ..write(obj.roleMenuCetakStnk)
      ..writeByte(145)
      ..write(obj.roleAksesToubleshoot)
      ..writeByte(146)
      ..write(obj.roleMenuTutorialPembayaran)
      ..writeByte(147)
      ..write(obj.roleMenuBayarDigital)
      ..writeByte(148)
      ..write(obj.roleMenuBayarDigital5thn)
      ..writeByte(149)
      ..write(obj.roleMenuTabelProteksi)
      ..writeByte(150)
      ..write(obj.roleMenuTabelBlokir)
      ..writeByte(151)
      ..write(obj.roleMenuTabelPembayaranLampau)
      ..writeByte(152)
      ..write(obj.roleMenuTuPolri)
      ..writeByte(153)
      ..write(obj.roleMenuTabelUserC)
      ..writeByte(154)
      ..write(obj.roleMenuTabelUserU)
      ..writeByte(155)
      ..write(obj.roleMenuTabelUserD)
      ..writeByte(156)
      ..write(obj.roleMenuTabelMutasikel)
      ..writeByte(157)
      ..write(obj.roleMenuLaporanBulanan2)
      ..writeByte(158)
      ..write(obj.roleMenuLogKoreksi)
      ..writeByte(159)
      ..write(obj.wiluppdIsBlocked)
      ..writeByte(160)
      ..write(obj.wiluppdIndukIsSingleKabKota)
      ..writeByte(161)
      ..write(obj.roleMenuAbleLoginMobile)
      ..writeByte(162)
      ..write(obj.roleMenuVerfikasiReservasi)
      ..writeByte(163)
      ..write(obj.roleMenuLoketMutasikel)
      ..writeByte(164)
      ..write(obj.roleMenuLoketMutasikelCrud)
      ..writeByte(165)
      ..write(obj.roleMenuHitungUlangDev)
      ..writeByte(166)
      ..write(obj.roleMenuTabelReservasiSamsatDigital)
      ..writeByte(167)
      ..write(obj.roleMenuTabelReservasiAntrian)
      ..writeByte(168)
      ..write(obj.roleMenuPendingNopol)
      ..writeByte(169)
      ..write(obj.roleMenuCms)
      ..writeByte(170)
      ..write(obj.roleMenuManajemenKuota)
      ..writeByte(171)
      ..write(obj.roleMenuManajemenKuotaCf)
      ..writeByte(172)
      ..write(obj.roleMenuRekonEsamsat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
