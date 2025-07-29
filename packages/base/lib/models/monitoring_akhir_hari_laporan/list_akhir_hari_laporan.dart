class ListAkhirHariLaporanModel {
  String? code;
  bool? success;
  List<DataListAkhirHariLaporan>? data;
  String? message;

  ListAkhirHariLaporanModel({this.code, this.success, this.data, this.message});

  ListAkhirHariLaporanModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    if (json['data'] != null) {
      data = <DataListAkhirHariLaporan>[];
      json['data'].forEach((v) {
        data!.add(DataListAkhirHariLaporan.fromJson(v));
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

class DataListAkhirHariLaporan {
  String? tanggalProses;
  String? status;
  String? kolomBerbeda;
  List<ListData>? listData;

  DataListAkhirHariLaporan({this.tanggalProses, this.status, this.kolomBerbeda, this.listData});

  DataListAkhirHariLaporan.fromJson(Map<String, dynamic> json) {
    tanggalProses = json['tanggal_proses'];
    status = json['status'];
    kolomBerbeda = json['kolom_berbeda'];
    if (json['list_data'] != null) {
      listData = <ListData>[];
      json['list_data'].forEach((v) {
        listData!.add(ListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tanggal_proses'] = tanggalProses;
    data['status'] = status;
    data['kolom_berbeda'] = kolomBerbeda;
    if (listData != null) {
      data['list_data'] = listData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  String? namaTabel;
  int? pkbDendaRupiah;
  int? pkbPokokRupiah;
  int? bbnkbDendaRupiah;
  int? bbnkbPokokRupiah;
  int? opsenPkbDendaRupiah;
  int? opsenPkbPokokRupiah;
  int? opsenBbnkbDendaRupiah;
  int? opsenBbnkbPokokRupiah;

  ListData(
      {this.namaTabel,
      this.pkbDendaRupiah,
      this.pkbPokokRupiah,
      this.bbnkbDendaRupiah,
      this.bbnkbPokokRupiah,
      this.opsenPkbDendaRupiah,
      this.opsenPkbPokokRupiah,
      this.opsenBbnkbDendaRupiah,
      this.opsenBbnkbPokokRupiah});

  ListData.fromJson(Map<String, dynamic> json) {
    namaTabel = json['nama_tabel'];
    pkbDendaRupiah = json['pkb_denda_rupiah'];
    pkbPokokRupiah = json['pkb_pokok_rupiah'];
    bbnkbDendaRupiah = json['bbnkb_denda_rupiah'];
    bbnkbPokokRupiah = json['bbnkb_pokok_rupiah'];
    opsenPkbDendaRupiah = json['opsen_pkb_denda_rupiah'];
    opsenPkbPokokRupiah = json['opsen_pkb_pokok_rupiah'];
    opsenBbnkbDendaRupiah = json['opsen_bbnkb_denda_rupiah'];
    opsenBbnkbPokokRupiah = json['opsen_bbnkb_pokok_rupiah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_tabel'] = namaTabel;
    data['pkb_denda_rupiah'] = pkbDendaRupiah;
    data['pkb_pokok_rupiah'] = pkbPokokRupiah;
    data['bbnkb_denda_rupiah'] = bbnkbDendaRupiah;
    data['bbnkb_pokok_rupiah'] = bbnkbPokokRupiah;
    data['opsen_pkb_denda_rupiah'] = opsenPkbDendaRupiah;
    data['opsen_pkb_pokok_rupiah'] = opsenPkbPokokRupiah;
    data['opsen_bbnkb_denda_rupiah'] = opsenBbnkbDendaRupiah;
    data['opsen_bbnkb_pokok_rupiah'] = opsenBbnkbPokokRupiah;
    return data;
  }
}
