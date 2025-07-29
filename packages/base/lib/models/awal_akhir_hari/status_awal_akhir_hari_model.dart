import 'package:base/models/awal_akhir_hari/proses_awal_akhir_hari_model.dart';

class StatusAwalAkhiHariModel {
  String? code;
  bool? success;
  DataProsesAwalAkhirHari? data;
  String? message;

  StatusAwalAkhiHariModel({this.code, this.success, this.data, this.message});

  StatusAwalAkhiHariModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'] != null
        ? DataProsesAwalAkhirHari.fromJson(json['data'])
        : null;
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
