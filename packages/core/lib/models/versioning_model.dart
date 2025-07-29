import 'package:core/core.dart';

part 'versioning_model.g.dart';

@HiveType(typeId: 41)
class VersioningModel {
  @HiveField(0)
  String? code;
  @HiveField(1)
  bool? success;
  @HiveField(2)
  DataVersioning? data;
  @HiveField(3)
  String? message;

  VersioningModel({this.code, this.success, this.data, this.message});

  VersioningModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? DataVersioning.fromJson(json['data']) : null;
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

@HiveType(typeId: 42)
class DataVersioning {
  @HiveField(0)
  String? versionIdVersion;
  @HiveField(1)
  String? versionDatetimeVersion;
  @HiveField(2)
  String? versionTypeVersion;
  @HiveField(3)
  String? versionLinkUrlVersion;
  @HiveField(4)
  String? versionKet1Version;
  @HiveField(5)
  String? versionKet2Version;
  @HiveField(6)
  String? versionKet3Version;
  @HiveField(7)
  String? versionActiveVersion;
  @HiveField(8)
  String? versionVerVersion;

  DataVersioning(
      {this.versionIdVersion,
      this.versionDatetimeVersion,
      this.versionTypeVersion,
      this.versionLinkUrlVersion,
      this.versionKet1Version,
      this.versionKet2Version,
      this.versionKet3Version,
      this.versionActiveVersion,
      this.versionVerVersion});

  DataVersioning.fromJson(Map<String, dynamic> json) {
    versionIdVersion = json['version_id_version'];
    versionDatetimeVersion = json['version_datetime_version'];
    versionTypeVersion = json['version_type_version'];
    versionLinkUrlVersion = json['version_link_url_version'];
    versionKet1Version = json['version_ket1_version'];
    versionKet2Version = json['version_ket2_version'];
    versionKet3Version = json['version_ket3_version'];
    versionActiveVersion = json['version_active_version'];
    versionVerVersion = json['version_ver_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version_id_version'] = versionIdVersion;
    data['version_datetime_version'] = versionDatetimeVersion;
    data['version_type_version'] = versionTypeVersion;
    data['version_link_url_version'] = versionLinkUrlVersion;
    data['version_ket1_version'] = versionKet1Version;
    data['version_ket2_version'] = versionKet2Version;
    data['version_ket3_version'] = versionKet3Version;
    data['version_active_version'] = versionActiveVersion;
    data['version_ver_version'] = versionVerVersion;
    return data;
  }
}
