import 'package:core/core.dart';

class InfoPajakModel {
  String? code;
  bool? success;
  DataInfoPajak? data;
  String? message;

  InfoPajakModel({this.code, this.success, this.data, this.message});

  InfoPajakModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? DataInfoPajak.fromJson(json['data']) : null;
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

class DataInfoPajak {
  String? noPolisi1;
  String? noPolisi2;
  String? noPolisi3;
  String? noIdentitas;
  String? jenisIdentitas;
  String? noMesin;
  String? noRangka;
  String? nilaiJual;
  String? bobot;
  String? nmJenisKb;
  String? milikKe;
  String? nmPemilik;
  String? alPemilik;
  String? kdMerekKb;
  String? nmMerekKb;
  String? nmModelKb;
  String? tgAkhirPajak;
  String? tgAkhirStnk;
  String? thBuatan;
  String? kdWil;
  String? nmWil;
  String? nmFungsiKb;
  String? kdFungsiKb;
  String? warnaKb;
  String? tgProsesTetap;
  bool? ableBayarPajak;
  bool? ableBayarEsamsat;
  DataHitungPajak? dataHitungPajak;

  DataInfoPajak(
      {this.noPolisi1,
      this.noPolisi2,
      this.noPolisi3,
      this.noIdentitas,
      this.jenisIdentitas,
      this.noMesin,
      this.noRangka,
      this.nilaiJual,
      this.bobot,
      this.nmJenisKb,
      this.milikKe,
      this.nmPemilik,
      this.alPemilik,
      this.kdMerekKb,
      this.nmMerekKb,
      this.nmModelKb,
      this.tgAkhirPajak,
      this.tgAkhirStnk,
      this.thBuatan,
      this.kdWil,
      this.nmWil,
      this.nmFungsiKb,
      this.kdFungsiKb,
      this.warnaKb,
      this.tgProsesTetap,
      this.ableBayarPajak,
      this.ableBayarEsamsat,
      this.dataHitungPajak});

  DataInfoPajak.fromJson(Map<String, dynamic> json) {
    noPolisi1 = StringUtils.checkModel(json['no_polisi1']);
    noPolisi2 = StringUtils.checkModel(json['no_polisi2']);
    noPolisi3 = StringUtils.checkModel(json['no_polisi3']);
    noIdentitas = StringUtils.checkModel(json['no_identitas']);
    jenisIdentitas = StringUtils.checkModel(json['jenis_identitas']);
    noMesin = StringUtils.checkModel(json['no_mesin']);
    noRangka = StringUtils.checkModel(json['no_rangka']);
    nilaiJual = StringUtils.checkModel(json['nilai_jual']);
    bobot = StringUtils.checkModel(json['bobot']);
    nmJenisKb = StringUtils.checkModel(json['nm_jenis_kb']);
    milikKe = StringUtils.checkModel(json['milik_ke']);
    nmPemilik = StringUtils.checkModel(json['nm_pemilik']);
    alPemilik = StringUtils.checkModel(json['al_pemilik']);
    kdMerekKb = StringUtils.checkModel(json['kd_merek_kb']);
    nmMerekKb = StringUtils.checkModel(json['nm_merek_kb']);
    nmModelKb = StringUtils.checkModel(json['nm_model_kb']);
    tgAkhirPajak = StringUtils.checkModel(json['tg_akhir_pajak']);
    tgAkhirStnk = StringUtils.checkModel(json['tg_akhir_stnk']);
    thBuatan = StringUtils.checkModel(json['th_buatan']);
    kdWil = StringUtils.checkModel(json['kd_wil']);
    nmWil = StringUtils.checkModel(json['nm_wil']);
    nmFungsiKb = StringUtils.checkModel(json['nm_fungsi_kb']);
    kdFungsiKb = StringUtils.checkModel(json['kd_fungsi_kb']);
    warnaKb = StringUtils.checkModel(json['warna_kb']);
    tgProsesTetap = StringUtils.checkModel(json['tg_proses_tetap']);
    ableBayarPajak = StringUtils.checkModel(json['able_bayar_pajak']);
    ableBayarEsamsat = StringUtils.checkModel(json['able_bayar_esamsat']);
    dataHitungPajak = json['data_hitung_pajak'] != null
        ? DataHitungPajak.fromJson(json['data_hitung_pajak'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no_polisi1'] = noPolisi1;
    data['no_polisi2'] = noPolisi2;
    data['no_polisi3'] = noPolisi3;
    data['no_identitas'] = noIdentitas;
    data['jenis_identitas'] = jenisIdentitas;
    data['no_mesin'] = noMesin;
    data['no_rangka'] = noRangka;
    data['nilai_jual'] = nilaiJual;
    data['bobot'] = bobot;
    data['nm_jenis_kb'] = nmJenisKb;
    data['milik_ke'] = milikKe;
    data['nm_pemilik'] = nmPemilik;
    data['al_pemilik'] = alPemilik;
    data['kd_merek_kb'] = kdMerekKb;
    data['nm_merek_kb'] = nmMerekKb;
    data['nm_model_kb'] = nmModelKb;
    data['tg_akhir_pajak'] = tgAkhirPajak;
    data['tg_akhir_stnk'] = tgAkhirStnk;
    data['th_buatan'] = thBuatan;
    data['kd_wil'] = kdWil;
    data['nm_wil'] = nmWil;
    data['nm_fungsi_kb'] = nmFungsiKb;
    data['kd_fungsi_kb'] = kdFungsiKb;
    data['warna_kb'] = warnaKb;
    data['tg_proses_tetap'] = tgProsesTetap;
    data['able_bayar_pajak'] = ableBayarPajak;
    data['able_bayar_esamsat'] = ableBayarEsamsat;
    if (dataHitungPajak != null) {
      data['data_hitung_pajak'] = dataHitungPajak!.toJson();
    }
    return data;
  }
}

class DataHitungPajak {
  String? tgAkhirStnkBaru;
  String? tgAkhirPajakBaru;
  String? beaBbnkb1Pok;
  String? beaBbnkb1Den;
  String? beaBbnkb1Ops;
  String? beaBbnkb1OpsDen;
  String? beaBbnkb2Pok;
  String? beaBbnkb2Den;
  String? beaBbnkb2Ops;
  String? beaBbnkb2OpsDen;
  String? beaPkbPok0;
  String? beaPkbDen0;
  String? beaPkbOps0;
  String? beaPkbOpsDen0;
  String? beaPkbPok1;
  String? beaPkbDen1;
  String? beaPkbOps1;
  String? beaPkbOpsDen1;
  String? beaPkbPok2;
  String? beaPkbDen2;
  String? beaPkbOps2;
  String? beaPkbOpsDen2;
  String? beaPkbPok3;
  String? beaPkbDen3;
  String? beaPkbOps3;
  String? beaPkbOpsDen3;
  String? beaPkbPok4;
  String? beaPkbDen4;
  String? beaPkbOps4;
  String? beaPkbOpsDen4;
  String? beaPkbPok5;
  String? beaPkbDen5;
  String? beaPkbOps5;
  String? beaPkbOpsDen5;
  String? beaSwdklljPok0;
  String? beaSwdklljDen0;
  String? beaSwdklljPok1;
  String? beaSwdklljDen1;
  String? beaSwdklljPok2;
  String? beaSwdklljDen2;
  String? beaSwdklljPok3;
  String? beaSwdklljDen3;
  String? beaSwdklljPok4;
  String? beaSwdklljDen4;
  String? beaSwdklljPok5;
  String? beaSwdklljDen5;
  String? beaAdmStnk;
  String? beaAdmTnkb;
  String? beaBbnkb1PokNonprog;
  String? beaBbnkb1DenNonprog;
  String? beaBbnkb1OpsNonprog;
  String? beaBbnkb1OpsDenNonprog;
  String? beaBbnkb2PokNonprog;
  String? beaBbnkb2DenNonprog;
  String? beaBbnkb2OpsNonprog;
  String? beaBbnkb2OpsDenNonprog;
  String? beaPkbPok0Nonprog;
  String? beaPkbDen0Nonprog;
  String? beaPkbOps0Nonprog;
  String? beaPkbOpsDen0Nonprog;
  String? beaPkbPok1Nonprog;
  String? beaPkbDen1Nonprog;
  String? beaPkbOps1Nonprog;
  String? beaPkbOpsDen1Nonprog;
  String? beaPkbPok2Nonprog;
  String? beaPkbDen2Nonprog;
  String? beaPkbOps2Nonprog;
  String? beaPkbOpsDen2Nonprog;
  String? beaPkbPok3Nonprog;
  String? beaPkbDen3Nonprog;
  String? beaPkbOps3Nonprog;
  String? beaPkbOpsDen3Nonprog;
  String? beaPkbPok4Nonprog;
  String? beaPkbDen4Nonprog;
  String? beaPkbOps4Nonprog;
  String? beaPkbOpsDen4Nonprog;
  String? beaPkbPok5Nonprog;
  String? beaPkbDen5Nonprog;
  String? beaPkbOps5Nonprog;
  String? beaPkbOpsDen5Nonprog;
  String? kodeGolJr;
  String? kodeJenisJr;
  String? jrRefId;
  String? nilaiJual;
  String? bobot;
  String? nilaiJualLama;
  String? bobotLama;
  String? ket1;
  String? ket2;
  String? ket3;
  String? selangHari;
  String? selangBulan;
  String? selangTahun;

  DataHitungPajak(
      {this.tgAkhirStnkBaru,
      this.tgAkhirPajakBaru,
      this.beaBbnkb1Pok,
      this.beaBbnkb1Den,
      this.beaBbnkb1Ops,
      this.beaBbnkb1OpsDen,
      this.beaBbnkb2Pok,
      this.beaBbnkb2Den,
      this.beaBbnkb2Ops,
      this.beaBbnkb2OpsDen,
      this.beaPkbPok0,
      this.beaPkbDen0,
      this.beaPkbOps0,
      this.beaPkbOpsDen0,
      this.beaPkbPok1,
      this.beaPkbDen1,
      this.beaPkbOps1,
      this.beaPkbOpsDen1,
      this.beaPkbPok2,
      this.beaPkbDen2,
      this.beaPkbOps2,
      this.beaPkbOpsDen2,
      this.beaPkbPok3,
      this.beaPkbDen3,
      this.beaPkbOps3,
      this.beaPkbOpsDen3,
      this.beaPkbPok4,
      this.beaPkbDen4,
      this.beaPkbOps4,
      this.beaPkbOpsDen4,
      this.beaPkbPok5,
      this.beaPkbDen5,
      this.beaPkbOps5,
      this.beaPkbOpsDen5,
      this.beaSwdklljPok0,
      this.beaSwdklljDen0,
      this.beaSwdklljPok1,
      this.beaSwdklljDen1,
      this.beaSwdklljPok2,
      this.beaSwdklljDen2,
      this.beaSwdklljPok3,
      this.beaSwdklljDen3,
      this.beaSwdklljPok4,
      this.beaSwdklljDen4,
      this.beaSwdklljPok5,
      this.beaSwdklljDen5,
      this.beaAdmStnk,
      this.beaAdmTnkb,
      this.beaBbnkb1PokNonprog,
      this.beaBbnkb1DenNonprog,
      this.beaBbnkb1OpsNonprog,
      this.beaBbnkb1OpsDenNonprog,
      this.beaBbnkb2PokNonprog,
      this.beaBbnkb2DenNonprog,
      this.beaBbnkb2OpsNonprog,
      this.beaBbnkb2OpsDenNonprog,
      this.beaPkbPok0Nonprog,
      this.beaPkbDen0Nonprog,
      this.beaPkbOps0Nonprog,
      this.beaPkbOpsDen0Nonprog,
      this.beaPkbPok1Nonprog,
      this.beaPkbDen1Nonprog,
      this.beaPkbOps1Nonprog,
      this.beaPkbOpsDen1Nonprog,
      this.beaPkbPok2Nonprog,
      this.beaPkbDen2Nonprog,
      this.beaPkbOps2Nonprog,
      this.beaPkbOpsDen2Nonprog,
      this.beaPkbPok3Nonprog,
      this.beaPkbDen3Nonprog,
      this.beaPkbOps3Nonprog,
      this.beaPkbOpsDen3Nonprog,
      this.beaPkbPok4Nonprog,
      this.beaPkbDen4Nonprog,
      this.beaPkbOps4Nonprog,
      this.beaPkbOpsDen4Nonprog,
      this.beaPkbPok5Nonprog,
      this.beaPkbDen5Nonprog,
      this.beaPkbOps5Nonprog,
      this.beaPkbOpsDen5Nonprog,
      this.kodeGolJr,
      this.kodeJenisJr,
      this.jrRefId,
      this.nilaiJual,
      this.bobot,
      this.nilaiJualLama,
      this.bobotLama,
      this.ket1,
      this.ket2,
      this.ket3,
      this.selangHari,
      this.selangBulan,
      this.selangTahun});

  DataHitungPajak.fromJson(Map<String, dynamic> json) {
    tgAkhirStnkBaru = StringUtils.checkModel(json['tg_akhir_stnk_baru']);
    tgAkhirPajakBaru = StringUtils.checkModel(json['tg_akhir_pajak_baru']);
    beaBbnkb1Pok = StringUtils.checkModel(json['bea_bbnkb1_pok']);
    beaBbnkb1Den = StringUtils.checkModel(json['bea_bbnkb1_den']);
    beaBbnkb1Ops = StringUtils.checkModel(json['bea_bbnkb1_ops']);
    beaBbnkb1OpsDen = StringUtils.checkModel(json['bea_bbnkb1_ops_den']);
    beaBbnkb2Pok = StringUtils.checkModel(json['bea_bbnkb2_pok']);
    beaBbnkb2Den = StringUtils.checkModel(json['bea_bbnkb2_den']);
    beaBbnkb2Ops = StringUtils.checkModel(json['bea_bbnkb2_ops']);
    beaBbnkb2OpsDen = StringUtils.checkModel(json['bea_bbnkb2_ops_den']);
    beaPkbPok0 = StringUtils.checkModel(json['bea_pkb_pok0']);
    beaPkbDen0 = StringUtils.checkModel(json['bea_pkb_den0']);
    beaPkbOps0 = StringUtils.checkModel(json['bea_pkb_ops0']);
    beaPkbOpsDen0 = StringUtils.checkModel(json['bea_pkb_ops_den0']);
    beaPkbPok1 = StringUtils.checkModel(json['bea_pkb_pok1']);
    beaPkbDen1 = StringUtils.checkModel(json['bea_pkb_den1']);
    beaPkbOps1 = StringUtils.checkModel(json['bea_pkb_ops1']);
    beaPkbOpsDen1 = StringUtils.checkModel(json['bea_pkb_ops_den1']);
    beaPkbPok2 = StringUtils.checkModel(json['bea_pkb_pok2']);
    beaPkbDen2 = StringUtils.checkModel(json['bea_pkb_den2']);
    beaPkbOps2 = StringUtils.checkModel(json['bea_pkb_ops2']);
    beaPkbOpsDen2 = StringUtils.checkModel(json['bea_pkb_ops_den2']);
    beaPkbPok3 = StringUtils.checkModel(json['bea_pkb_pok3']);
    beaPkbDen3 = StringUtils.checkModel(json['bea_pkb_den3']);
    beaPkbOps3 = StringUtils.checkModel(json['bea_pkb_ops3']);
    beaPkbOpsDen3 = StringUtils.checkModel(json['bea_pkb_ops_den3']);
    beaPkbPok4 = StringUtils.checkModel(json['bea_pkb_pok4']);
    beaPkbDen4 = StringUtils.checkModel(json['bea_pkb_den4']);
    beaPkbOps4 = StringUtils.checkModel(json['bea_pkb_ops4']);
    beaPkbOpsDen4 = StringUtils.checkModel(json['bea_pkb_ops_den4']);
    beaPkbPok5 = StringUtils.checkModel(json['bea_pkb_pok5']);
    beaPkbDen5 = StringUtils.checkModel(json['bea_pkb_den5']);
    beaPkbOps5 = StringUtils.checkModel(json['bea_pkb_ops5']);
    beaPkbOpsDen5 = StringUtils.checkModel(json['bea_pkb_ops_den5']);
    beaSwdklljPok0 = StringUtils.checkModel(json['bea_swdkllj_pok0']);
    beaSwdklljDen0 = StringUtils.checkModel(json['bea_swdkllj_den0']);
    beaSwdklljPok1 = StringUtils.checkModel(json['bea_swdkllj_pok1']);
    beaSwdklljDen1 = StringUtils.checkModel(json['bea_swdkllj_den1']);
    beaSwdklljPok2 = StringUtils.checkModel(json['bea_swdkllj_pok2']);
    beaSwdklljDen2 = StringUtils.checkModel(json['bea_swdkllj_den2']);
    beaSwdklljPok3 = StringUtils.checkModel(json['bea_swdkllj_pok3']);
    beaSwdklljDen3 = StringUtils.checkModel(json['bea_swdkllj_den3']);
    beaSwdklljPok4 = StringUtils.checkModel(json['bea_swdkllj_pok4']);
    beaSwdklljDen4 = StringUtils.checkModel(json['bea_swdkllj_den4']);
    beaSwdklljPok5 = StringUtils.checkModel(json['bea_swdkllj_pok5']);
    beaSwdklljDen5 = StringUtils.checkModel(json['bea_swdkllj_den5']);
    beaAdmStnk = StringUtils.checkModel(json['bea_adm_stnk']);
    beaAdmTnkb = StringUtils.checkModel(json['bea_adm_tnkb']);
    beaBbnkb1PokNonprog =
        StringUtils.checkModel(json['bea_bbnkb1_pok_nonprog']);
    beaBbnkb1DenNonprog =
        StringUtils.checkModel(json['bea_bbnkb1_den_nonprog']);
    beaBbnkb1OpsNonprog =
        StringUtils.checkModel(json['bea_bbnkb1_ops_nonprog']);
    beaBbnkb1OpsDenNonprog =
        StringUtils.checkModel(json['bea_bbnkb1_ops_den_nonprog']);
    beaBbnkb2PokNonprog =
        StringUtils.checkModel(json['bea_bbnkb2_pok_nonprog']);
    beaBbnkb2DenNonprog =
        StringUtils.checkModel(json['bea_bbnkb2_den_nonprog']);
    beaBbnkb2OpsNonprog =
        StringUtils.checkModel(json['bea_bbnkb2_ops_nonprog']);
    beaBbnkb2OpsDenNonprog =
        StringUtils.checkModel(json['bea_bbnkb2_ops_den_nonprog']);
    beaPkbPok0Nonprog = StringUtils.checkModel(json['bea_pkb_pok0_nonprog']);
    beaPkbDen0Nonprog = StringUtils.checkModel(json['bea_pkb_den0_nonprog']);
    beaPkbOps0Nonprog = StringUtils.checkModel(json['bea_pkb_ops0_nonprog']);
    beaPkbOpsDen0Nonprog =
        StringUtils.checkModel(json['bea_pkb_ops_den0_nonprog']);
    beaPkbPok1Nonprog = StringUtils.checkModel(json['bea_pkb_pok1_nonprog']);
    beaPkbDen1Nonprog = StringUtils.checkModel(json['bea_pkb_den1_nonprog']);
    beaPkbOps1Nonprog = StringUtils.checkModel(json['bea_pkb_ops1_nonprog']);
    beaPkbOpsDen1Nonprog =
        StringUtils.checkModel(json['bea_pkb_ops_den1_nonprog']);
    beaPkbPok2Nonprog = StringUtils.checkModel(json['bea_pkb_pok2_nonprog']);
    beaPkbDen2Nonprog = StringUtils.checkModel(json['bea_pkb_den2_nonprog']);
    beaPkbOps2Nonprog = StringUtils.checkModel(json['bea_pkb_ops2_nonprog']);
    beaPkbOpsDen2Nonprog =
        StringUtils.checkModel(json['bea_pkb_ops_den2_nonprog']);
    beaPkbPok3Nonprog = StringUtils.checkModel(json['bea_pkb_pok3_nonprog']);
    beaPkbDen3Nonprog = StringUtils.checkModel(json['bea_pkb_den3_nonprog']);
    beaPkbOps3Nonprog = StringUtils.checkModel(json['bea_pkb_ops3_nonprog']);
    beaPkbOpsDen3Nonprog =
        StringUtils.checkModel(json['bea_pkb_ops_den3_nonprog']);
    beaPkbPok4Nonprog = StringUtils.checkModel(json['bea_pkb_pok4_nonprog']);
    beaPkbDen4Nonprog = StringUtils.checkModel(json['bea_pkb_den4_nonprog']);
    beaPkbOps4Nonprog = StringUtils.checkModel(json['bea_pkb_ops4_nonprog']);
    beaPkbOpsDen4Nonprog =
        StringUtils.checkModel(json['bea_pkb_ops_den4_nonprog']);
    beaPkbPok5Nonprog = StringUtils.checkModel(json['bea_pkb_pok5_nonprog']);
    beaPkbDen5Nonprog = StringUtils.checkModel(json['bea_pkb_den5_nonprog']);
    beaPkbOps5Nonprog = StringUtils.checkModel(json['bea_pkb_ops5_nonprog']);
    beaPkbOpsDen5Nonprog =
        StringUtils.checkModel(json['bea_pkb_ops_den5_nonprog']);
    kodeGolJr = StringUtils.checkModel(json['kode_gol_jr']);
    kodeJenisJr = StringUtils.checkModel(json['kode_jenis_jr']);
    jrRefId = StringUtils.checkModel(json['jr_ref_id']);
    nilaiJual = StringUtils.checkModel(json['nilai_jual']);
    bobot = StringUtils.checkModel(json['bobot']);
    nilaiJualLama = StringUtils.checkModel(json['nilai_jual_lama']);
    bobotLama = StringUtils.checkModel(json['bobot_lama']);
    ket1 = StringUtils.checkModel(json['ket1']);
    ket2 = StringUtils.checkModel(json['ket2']);
    ket3 = StringUtils.checkModel(json['ket3']);
    selangHari = StringUtils.checkModel(json['selang_hari']);
    selangBulan = StringUtils.checkModel(json['selang_bulan']);
    selangTahun = StringUtils.checkModel(json['selang_tahun']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tg_akhir_stnk_baru'] = tgAkhirStnkBaru;
    data['tg_akhir_pajak_baru'] = tgAkhirPajakBaru;
    data['bea_bbnkb1_pok'] = beaBbnkb1Pok;
    data['bea_bbnkb1_den'] = beaBbnkb1Den;
    data['bea_bbnkb1_ops'] = beaBbnkb1Ops;
    data['bea_bbnkb1_ops_den'] = beaBbnkb1OpsDen;
    data['bea_bbnkb2_pok'] = beaBbnkb2Pok;
    data['bea_bbnkb2_den'] = beaBbnkb2Den;
    data['bea_bbnkb2_ops'] = beaBbnkb2Ops;
    data['bea_bbnkb2_ops_den'] = beaBbnkb2OpsDen;
    data['bea_pkb_pok0'] = beaPkbPok0;
    data['bea_pkb_den0'] = beaPkbDen0;
    data['bea_pkb_ops0'] = beaPkbOps0;
    data['bea_pkb_ops_den0'] = beaPkbOpsDen0;
    data['bea_pkb_pok1'] = beaPkbPok1;
    data['bea_pkb_den1'] = beaPkbDen1;
    data['bea_pkb_ops1'] = beaPkbOps1;
    data['bea_pkb_ops_den1'] = beaPkbOpsDen1;
    data['bea_pkb_pok2'] = beaPkbPok2;
    data['bea_pkb_den2'] = beaPkbDen2;
    data['bea_pkb_ops2'] = beaPkbOps2;
    data['bea_pkb_ops_den2'] = beaPkbOpsDen2;
    data['bea_pkb_pok3'] = beaPkbPok3;
    data['bea_pkb_den3'] = beaPkbDen3;
    data['bea_pkb_ops3'] = beaPkbOps3;
    data['bea_pkb_ops_den3'] = beaPkbOpsDen3;
    data['bea_pkb_pok4'] = beaPkbPok4;
    data['bea_pkb_den4'] = beaPkbDen4;
    data['bea_pkb_ops4'] = beaPkbOps4;
    data['bea_pkb_ops_den4'] = beaPkbOpsDen4;
    data['bea_pkb_pok5'] = beaPkbPok5;
    data['bea_pkb_den5'] = beaPkbDen5;
    data['bea_pkb_ops5'] = beaPkbOps5;
    data['bea_pkb_ops_den5'] = beaPkbOpsDen5;
    data['bea_swdkllj_pok0'] = beaSwdklljPok0;
    data['bea_swdkllj_den0'] = beaSwdklljDen0;
    data['bea_swdkllj_pok1'] = beaSwdklljPok1;
    data['bea_swdkllj_den1'] = beaSwdklljDen1;
    data['bea_swdkllj_pok2'] = beaSwdklljPok2;
    data['bea_swdkllj_den2'] = beaSwdklljDen2;
    data['bea_swdkllj_pok3'] = beaSwdklljPok3;
    data['bea_swdkllj_den3'] = beaSwdklljDen3;
    data['bea_swdkllj_pok4'] = beaSwdklljPok4;
    data['bea_swdkllj_den4'] = beaSwdklljDen4;
    data['bea_swdkllj_pok5'] = beaSwdklljPok5;
    data['bea_swdkllj_den5'] = beaSwdklljDen5;
    data['bea_adm_stnk'] = beaAdmStnk;
    data['bea_adm_tnkb'] = beaAdmTnkb;
    data['bea_bbnkb1_pok_nonprog'] = beaBbnkb1PokNonprog;
    data['bea_bbnkb1_den_nonprog'] = beaBbnkb1DenNonprog;
    data['bea_bbnkb1_ops_nonprog'] = beaBbnkb1OpsNonprog;
    data['bea_bbnkb1_ops_den_nonprog'] = beaBbnkb1OpsDenNonprog;
    data['bea_bbnkb2_pok_nonprog'] = beaBbnkb2PokNonprog;
    data['bea_bbnkb2_den_nonprog'] = beaBbnkb2DenNonprog;
    data['bea_bbnkb2_ops_nonprog'] = beaBbnkb2OpsNonprog;
    data['bea_bbnkb2_ops_den_nonprog'] = beaBbnkb2OpsDenNonprog;
    data['bea_pkb_pok0_nonprog'] = beaPkbPok0Nonprog;
    data['bea_pkb_den0_nonprog'] = beaPkbDen0Nonprog;
    data['bea_pkb_ops0_nonprog'] = beaPkbOps0Nonprog;
    data['bea_pkb_ops_den0_nonprog'] = beaPkbOpsDen0Nonprog;
    data['bea_pkb_pok1_nonprog'] = beaPkbPok1Nonprog;
    data['bea_pkb_den1_nonprog'] = beaPkbDen1Nonprog;
    data['bea_pkb_ops1_nonprog'] = beaPkbOps1Nonprog;
    data['bea_pkb_ops_den1_nonprog'] = beaPkbOpsDen1Nonprog;
    data['bea_pkb_pok2_nonprog'] = beaPkbPok2Nonprog;
    data['bea_pkb_den2_nonprog'] = beaPkbDen2Nonprog;
    data['bea_pkb_ops2_nonprog'] = beaPkbOps2Nonprog;
    data['bea_pkb_ops_den2_nonprog'] = beaPkbOpsDen2Nonprog;
    data['bea_pkb_pok3_nonprog'] = beaPkbPok3Nonprog;
    data['bea_pkb_den3_nonprog'] = beaPkbDen3Nonprog;
    data['bea_pkb_ops3_nonprog'] = beaPkbOps3Nonprog;
    data['bea_pkb_ops_den3_nonprog'] = beaPkbOpsDen3Nonprog;
    data['bea_pkb_pok4_nonprog'] = beaPkbPok4Nonprog;
    data['bea_pkb_den4_nonprog'] = beaPkbDen4Nonprog;
    data['bea_pkb_ops4_nonprog'] = beaPkbOps4Nonprog;
    data['bea_pkb_ops_den4_nonprog'] = beaPkbOpsDen4Nonprog;
    data['bea_pkb_pok5_nonprog'] = beaPkbPok5Nonprog;
    data['bea_pkb_den5_nonprog'] = beaPkbDen5Nonprog;
    data['bea_pkb_ops5_nonprog'] = beaPkbOps5Nonprog;
    data['bea_pkb_ops_den5_nonprog'] = beaPkbOpsDen5Nonprog;
    data['kode_gol_jr'] = kodeGolJr;
    data['kode_jenis_jr'] = kodeJenisJr;
    data['jr_ref_id'] = jrRefId;
    data['nilai_jual'] = nilaiJual;
    data['bobot'] = bobot;
    data['nilai_jual_lama'] = nilaiJualLama;
    data['bobot_lama'] = bobotLama;
    data['ket1'] = ket1;
    data['ket2'] = ket2;
    data['ket3'] = ket3;
    data['selang_hari'] = selangHari;
    data['selang_bulan'] = selangBulan;
    data['selang_tahun'] = selangTahun;
    return data;
  }
}
