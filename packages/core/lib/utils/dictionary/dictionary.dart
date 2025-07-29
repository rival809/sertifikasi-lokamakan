import 'package:core/core.dart';

class Dictionary {
  static List<Map<String, dynamic>> tarifToMilikKe = [
    {
      "milik_ke": "1",
      "tarif": 1.75,
    },
    {
      "milik_ke": "2",
      "tarif": 2.25,
    },
    {
      "milik_ke": "3",
      "tarif": 2.75,
    },
    {
      "milik_ke": "4",
      "tarif": 3.25,
    },
    {
      "milik_ke": "5",
      "tarif": 3.75,
    }
  ];

  static List<Map<String, dynamic>> kodeMohonToKode = [
    {
      "kd_mohon1": "1",
      "kd_singkat": "P.U",
    },
    {
      "kd_mohon1": "2",
      "kd_singkat": "P.U.2",
    },
    {
      "kd_mohon1": "3",
      "kd_singkat": "B.R",
    },
    {
      "kd_mohon1": "4",
      "kd_singkat": "M.M",
    },
    {
      "kd_mohon1": "5",
      "kd_singkat": "P.U",
    },
    {
      "kd_mohon1": "6",
      "kd_singkat": "M.K",
    }
  ];

  static List<Map<String, dynamic>> kodeStatus = [
    {
      "value": "1",
      "label": "1 - Daftar",
    },
    {
      "value": "2",
      "label": "2 - Penetapan",
    },
    {
      "value": "3",
      "label": "3 - Bayar",
    },
    {
      "value": "4",
      "label": "4 - Sudah Cetak STNK",
    },
  ];

  static List<String> warnaTNKB = ["Hitam / Putih", "Merah", "Kuning"];
  static List<String> kdPlat = ["1", "2", "3"];
  static List<String> warnaTNKBBaru = ["HITAM", "PUTIH", "MERAH", "KUNING"];
  static List<String> statusCetak = ["SUDAH CETAK", "BELUM CETAK"];
  static List<String> yT = ["Y", "T"];

  static List<Map<String, dynamic>> namaStatus = [
    {
      "kd_status": "1",
      "nm_status": "Belum Dikoreksi",
      "cardColor": red50,
      "cardTitleColor": red800,
      "cardBorderColor": red200,
    },
    {
      "kd_status": "2",
      "nm_status": "Sudah Dikoreksi",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
  ];
  static List<Map<String, dynamic>> namaLayanan = [
    {
      "kd_mohon": "100000",
      "nm_mohon": "Daftar Ulang",
      "nm_mohon_eri": "TELITI ULANG",
      "cardColor": blue50,
      "cardTitleColor": blue800,
      "cardBorderColor": blue600,
    },
    {
      "kd_mohon": "210000",
      "nm_mohon": "Perubahan (Ubah Bentuk)",
      "nm_mohon_eri": "RUBAH BENTUK",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "220000",
      "nm_mohon": "Perubahan (Ubah Status)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "230000",
      "nm_mohon": "Perubahan (Ganti Nama)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "241000",
      "nm_mohon": "Perubahan (BBN-II -> Jual Beli)",
      "nm_mohon_eri": "GANTI PEMILIK",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "242000",
      "nm_mohon": "Perubahan (BBN-II -> Waris)",
      "nm_mohon_eri": "GANTI PEMILIK",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "243000",
      "nm_mohon": "Perubahan (BBN-II -> Hibah)",
      "nm_mohon_eri": "GANTI PEMILIK",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "250000",
      "nm_mohon": "Perubahan (Ganti Alamat)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "260000",
      "nm_mohon": "Perubahan (Ganti Warna)",
      "nm_mohon_eri": "RUBAH BENTUK",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "270000",
      "nm_mohon": "Perubahan (Ganti Nomor Polisi)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "280000",
      "nm_mohon": "Perubahan (Ganti Mesin)",
      "nm_mohon_eri": "RUBAH BENTUK",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "291000",
      "nm_mohon": "Perubahan (Duplikat -> STNK Hilang)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "292000",
      "nm_mohon": "Perubahan (Duplikat -> STNK Rusak)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "293000",
      "nm_mohon": "Perubahan (Ganti - TNKB)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "310000",
      "nm_mohon": "Kendaraan Baru (CKD)",
      "nm_mohon_eri": "KENDARAAN BARU",
      "cardColor": green50,
      "cardTitleColor": green800,
      "cardBorderColor": green200,
    },
    {
      "kd_mohon": "320000",
      "nm_mohon": "Kendaraan Baru (Build Up)",
      "nm_mohon_eri": "KENDARAAN BARU",
      "cardColor": green50,
      "cardTitleColor": green800,
      "cardBorderColor": green200,
    },
    {
      "kd_mohon": "330000",
      "nm_mohon": "EX Dump (TNI-POLRI)",
      "nm_mohon_eri": "KENDARAAN BARU DUMP TNI POLRI",
      "cardColor": green50,
      "cardTitleColor": green800,
      "cardBorderColor": green200,
    },
    {
      "kd_mohon": "411000",
      "nm_mohon": "Mutasi Masuk (Dalam Provinsi -> Pemilik Tetap)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": red50,
      "cardTitleColor": red800,
      "cardBorderColor": red200,
    },
    {
      "kd_mohon": "412000",
      "nm_mohon": "Mutasi Masuk (Dalam Provinsi -> Ganti Pemilik)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": red50,
      "cardTitleColor": red800,
      "cardBorderColor": red200,
    },
    {
      "kd_mohon": "421000",
      "nm_mohon": "Mutasi Masuk (Luar Provinsi -> Pemilik Tetap)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": red50,
      "cardTitleColor": red800,
      "cardBorderColor": red200,
    },
    {
      "kd_mohon": "422000",
      "nm_mohon": "Mutasi Masuk (Luar Provinsi -> Ganti Pemilik)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": red50,
      "cardTitleColor": red800,
      "cardBorderColor": red200,
    },
    {
      "kd_mohon": "500000",
      "nm_mohon": "Kurang Bayar",
      "nm_mohon_eri": "TELITI ULANG",
      "cardColor": yellow50,
      "cardTitleColor": yellow900,
      "cardBorderColor": yellow200,
    },
    {
      "kd_mohon": "611000",
      "nm_mohon": "Mutasi Keluar (Dalam Provinsi -> Pemilik Tetap)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": purple50,
      "cardTitleColor": purple800,
      "cardBorderColor": purple200,
    },
    {
      "kd_mohon": "612000",
      "nm_mohon": "Mutasi Keluar (Dalam Provinsi -> Ganti Pemilik)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": purple50,
      "cardTitleColor": purple800,
      "cardBorderColor": purple200,
    },
    {
      "kd_mohon": "621000",
      "nm_mohon": "Mutasi Keluar (Luar Provinsi -> Pemilik Tetap)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": purple50,
      "cardTitleColor": purple800,
      "cardBorderColor": purple200,
    },
    {
      "kd_mohon": "622000",
      "nm_mohon": "Mutasi Keluar (Luar Provinsi -> Ganti Pemilik)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": purple50,
      "cardTitleColor": purple800,
      "cardBorderColor": purple200,
    },
  ];
}
