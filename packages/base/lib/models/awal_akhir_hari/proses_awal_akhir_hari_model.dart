import 'package:core/core.dart';

class ProsesAwalAkhirHariModel {
  String? code;
  bool? success;
  DataProsesAwalAkhirHari? data;
  String? message;
  ParamProsesAwalAkhirHari? param;

  ProsesAwalAkhirHariModel(
      {this.code, this.success, this.data, this.message, this.param});

  ProsesAwalAkhirHariModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'] != null
        ? DataProsesAwalAkhirHari.fromJson(json['data'])
        : null;
    message = json['message'];
    param = json['param'] != null
        ? ParamProsesAwalAkhirHari.fromJson(json['param'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    if (param != null) {
      data['param'] = param!.toJson();
    }
    return data;
  }
}

class DataProsesAwalAkhirHari {
  String? layananIdLayanan;
  String? layananSesiKe;
  String? layananIdUserProsesAwl;
  String? layananJamProsesAwl;
  String? layananLatProsesAwl;
  String? layananLonProsesAwl;
  String? layananKetProsesAwl;
  String? layananIdUserProsesAkh;
  String? layananJamProsesAkh;
  String? layananLatProsesAkh;
  String? layananLonProsesAkh;
  String? layananKetProsesAkh;
  String? layananTgProses;
  String? layananIdWiluppd;

  DataProsesAwalAkhirHari(
      {this.layananIdLayanan,
      this.layananSesiKe,
      this.layananIdUserProsesAwl,
      this.layananJamProsesAwl,
      this.layananLatProsesAwl,
      this.layananLonProsesAwl,
      this.layananKetProsesAwl,
      this.layananIdUserProsesAkh,
      this.layananJamProsesAkh,
      this.layananLatProsesAkh,
      this.layananLonProsesAkh,
      this.layananKetProsesAkh,
      this.layananTgProses,
      this.layananIdWiluppd});

  DataProsesAwalAkhirHari.fromJson(Map<String, dynamic> json) {
    layananIdLayanan = StringUtils.checkModel(json['layanan_id_layanan']);
    layananSesiKe = StringUtils.checkModel(json['layanan_sesi_ke']);
    layananIdUserProsesAwl =
        StringUtils.checkModel(json['layanan_id_user_proses_awl']);
    layananJamProsesAwl = json['layanan_jam_proses_awl'];
    layananLatProsesAwl = json['layanan_lat_proses_awl'];
    layananLonProsesAwl = json['layanan_lon_proses_awl'];
    layananKetProsesAwl = json['layanan_ket_proses_awl'];
    layananIdUserProsesAkh =
        StringUtils.checkModel(json['layanan_id_user_proses_akh']);
    layananJamProsesAkh = json['layanan_jam_proses_akh'];
    layananLatProsesAkh = json['layanan_lat_proses_akh'];
    layananLonProsesAkh = json['layanan_lon_proses_akh'];
    layananKetProsesAkh = json['layanan_ket_proses_akh'];
    layananTgProses = json['layanan_tg_proses'];
    layananIdWiluppd = json['layanan_id_wiluppd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['layanan_id_layanan'] = layananIdLayanan;
    data['layanan_sesi_ke'] = layananSesiKe;
    data['layanan_id_user_proses_awl'] = layananIdUserProsesAwl;
    data['layanan_jam_proses_awl'] = layananJamProsesAwl;
    data['layanan_lat_proses_awl'] = layananLatProsesAwl;
    data['layanan_lon_proses_awl'] = layananLonProsesAwl;
    data['layanan_ket_proses_awl'] = layananKetProsesAwl;
    data['layanan_id_user_proses_akh'] = layananIdUserProsesAkh;
    data['layanan_jam_proses_akh'] = layananJamProsesAkh;
    data['layanan_lat_proses_akh'] = layananLatProsesAkh;
    data['layanan_lon_proses_akh'] = layananLonProsesAkh;
    data['layanan_ket_proses_akh'] = layananKetProsesAkh;
    data['layanan_tg_proses'] = layananTgProses;
    data['layanan_id_wiluppd'] = layananIdWiluppd;
    return data;
  }
}

class ParamProsesAwalAkhirHari {
  String? ket;
  String? lat;
  String? lon;

  ParamProsesAwalAkhirHari({this.ket, this.lat, this.lon});

  ParamProsesAwalAkhirHari.fromJson(Map<String, dynamic> json) {
    ket = json['ket'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ket'] = ket;
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
