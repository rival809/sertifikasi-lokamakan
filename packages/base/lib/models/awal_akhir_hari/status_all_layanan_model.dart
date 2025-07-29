import 'package:core/core.dart';

class StatusAllLayananModel {
  String? code;
  bool? success;
  List<DataStatusAllLayanan>? data;
  String? message;

  StatusAllLayananModel({this.code, this.success, this.data, this.message});

  StatusAllLayananModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    if (json['data'] != null) {
      data = <DataStatusAllLayanan>[];
      json['data'].forEach((v) {
        data!.add(DataStatusAllLayanan.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;

    return data;
  }
}

class DataStatusAllLayanan {
  String? wiluppdNmWil;
  String? layananIdWiluppd;
  String? sesiKe;
  String? layananJamProsesAwl;
  String? layananJamProsesAkh;
  String? layananStatusLayanan;
  String? stsOnlineHasilProvTot;
  String? stsOnlineHasilJrTot;
  String? stsOnlineHasilPolriTot;
  String? stsOnlineHasilKabKotaTot;
  String? stsOnlineStatus;
  String? stsOnlineKdStatus;
  String? stsOnlineIdUserAkhirHari;
  String? stsOnlineNamaAkhirHari;
  String? vrfKet1Vrf;
  String? vrfSurnameVrf;
  String? vrfTgProsesVrf;
  String? vrfStatusVrf;
  String? userAwalHariName;
  String? userAwalHariUsername;
  String? userAwalHariNoWa;
  String? userAkhirHariName;
  String? userAkhirHariUsername;
  String? userAkhirHariNoWa;

  DataStatusAllLayanan(
      {this.wiluppdNmWil,
      this.layananIdWiluppd,
      this.sesiKe,
      this.layananJamProsesAwl,
      this.layananJamProsesAkh,
      this.layananStatusLayanan,
      this.stsOnlineHasilProvTot,
      this.stsOnlineHasilJrTot,
      this.stsOnlineHasilPolriTot,
      this.stsOnlineHasilKabKotaTot,
      this.stsOnlineStatus,
      this.stsOnlineKdStatus,
      this.stsOnlineIdUserAkhirHari,
      this.stsOnlineNamaAkhirHari,
      this.vrfKet1Vrf,
      this.vrfSurnameVrf,
      this.vrfTgProsesVrf,
      this.vrfStatusVrf,
      this.userAwalHariName,
      this.userAwalHariUsername,
      this.userAwalHariNoWa,
      this.userAkhirHariName,
      this.userAkhirHariUsername,
      this.userAkhirHariNoWa});

  DataStatusAllLayanan.fromJson(Map<String, dynamic> json) {
    wiluppdNmWil = StringUtils.checkModel(json['wiluppd_nm_wil']);
    layananIdWiluppd = StringUtils.checkModel(json['layanan_id_wiluppd']);
    sesiKe = StringUtils.checkModel(json['sesi_ke']);
    layananJamProsesAwl = StringUtils.checkModel(json['layanan_jam_proses_awl']);
    layananJamProsesAkh = StringUtils.checkModel(json['layanan_jam_proses_akh']);
    layananStatusLayanan = StringUtils.checkModel(json['layanan_status_layanan']);
    stsOnlineHasilProvTot = StringUtils.checkModel(json['sts_online_hasil_prov_tot']);
    stsOnlineHasilJrTot = StringUtils.checkModel(json['sts_online_hasil_jr_tot']);
    stsOnlineHasilPolriTot = StringUtils.checkModel(json['sts_online_hasil_polri_tot']);
    stsOnlineHasilKabKotaTot = StringUtils.checkModel(json['sts_online_hasil_kab_kota_tot']);
    stsOnlineStatus = StringUtils.checkModel(json['sts_online_status']);
    stsOnlineKdStatus = StringUtils.checkModel(json['sts_online_kd_status']);
    stsOnlineIdUserAkhirHari = StringUtils.checkModel(json['sts_online_id_user_akhir_hari']);
    stsOnlineNamaAkhirHari = StringUtils.checkModel(json['sts_online_nama_akhir_hari']);
    vrfKet1Vrf = StringUtils.checkModel(json['vrf_ket1_vrf']);
    vrfSurnameVrf = StringUtils.checkModel(json['vrf_surname_vrf']);
    vrfTgProsesVrf = StringUtils.checkModel(json['vrf_tg_proses_vrf']);
    vrfStatusVrf = StringUtils.checkModel(json['vrf_status_vrf']);

    userAwalHariName = StringUtils.checkModel(json['user_awal_hari_name']);
    userAwalHariUsername = StringUtils.checkModel(json['user_awal_hari_username']);
    userAwalHariNoWa = StringUtils.checkModel(json['user_awal_hari_no_wa']);
    userAkhirHariName = StringUtils.checkModel(json['user_akhir_hari_name']);
    userAkhirHariUsername = StringUtils.checkModel(json['user_akhir_hari_username']);
    userAkhirHariNoWa = StringUtils.checkModel(json['user_akhir_hari_no_wa']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wiluppd_nm_wil'] = wiluppdNmWil;
    data['layanan_id_wiluppd'] = layananIdWiluppd;
    data['sesi_ke'] = sesiKe;
    data['layanan_jam_proses_awl'] = layananJamProsesAwl;
    data['layanan_jam_proses_akh'] = layananJamProsesAkh;
    data['layanan_status_layanan'] = layananStatusLayanan;
    data['sts_online_hasil_prov_tot'] = stsOnlineHasilProvTot;
    data['sts_online_hasil_jr_tot'] = stsOnlineHasilJrTot;
    data['sts_online_hasil_polri_tot'] = stsOnlineHasilPolriTot;
    data['sts_online_hasil_kab_kota_tot'] = stsOnlineHasilKabKotaTot;
    data['sts_online_status'] = stsOnlineStatus;
    data['sts_online_kd_status'] = stsOnlineKdStatus;
    data['sts_online_id_user_akhir_hari'] = stsOnlineIdUserAkhirHari;
    data['sts_online_nama_akhir_hari'] = stsOnlineNamaAkhirHari;
    data['vrf_ket1_vrf'] = vrfKet1Vrf;
    data['vrf_surname_vrf'] = vrfSurnameVrf;
    data['vrf_tg_proses_vrf'] = vrfTgProsesVrf;
    data['vrf_status_vrf'] = vrfStatusVrf;
    data['user_awal_hari_name'] = userAwalHariName;
    data['user_awal_hari_username'] = userAwalHariUsername;
    data['user_awal_hari_no_wa'] = userAwalHariNoWa;
    data['user_akhir_hari_name'] = userAkhirHariName;
    data['user_akhir_hari_username'] = userAkhirHariUsername;
    data['user_akhir_hari_no_wa'] = userAkhirHariNoWa;
    return data;
  }
}
