class Endpoints {
  Endpoints._();

  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 30);

  //Auth
  static const String login = "/api/login";
  static const String logout = "/api/logout";

  //Utilities
  static const String reference = "/api/reference";
  static const String userListReference = "/api/utilities/reference/user/get-all";
  static const String getUserData = "/api/utilities/user/get-data";
  static const String updatePassword = "/api/utilities/user/update-my-password";
  static const String versionCurrent = "/api/utilities/version/current";
  static const String kirimWa = "/api/utilities/kirim-file-via-wa";

  //Korektor
  static const String inquiryKorektor = "/api/penetapan/inquiry-pendaftaran";
  static const String resetPenetapan = "/api/penetapan/reset-penetapan";
  static const String prosesPenetapanKorektor = "/api/penetapan/proses-penetapan";
  static const String needCheckData = "/api/penetapan/is-need-cek-data-from-pendaftaran";

  //Pendaftaran
  static const String inquiryCekData = "/api/objek-pajak/inquiry-cek-data";
  static const String inquiryObjekPajak = "/api/objek-pajak/inquiry";
  static const String inquirySubjekPajak = "/api/subjek-pajak/inquiry";
  static const String getSubjekPajakFromObjekPajak =
      "/api/samsat-pembantu/subjek-pajak/get-subjek-pajak-from-objek-pajak";
  static const String updateObjekPajak = "/api/samsat-pembantu/objek-pajak/update";
  static const String updateSubjekPajak = "/api/samsat-pembantu/subjek-pajak/update";
  static const String prosesPendaftaran = "/api/samsat-pembantu/pendaftaran/proses";
  static const String prosesPenetapan = "/api/samsat-pembantu/penetapan/proses";
  static const String prosesPendaftaranKurangBayar =
      "/api/samsat-pembantu/pendaftaran/proses-kurang-bayar";

  //Pembayaran
  static const String metodeBayar = "/api/samsat-pembantu/bayar/get-method-bayar";
  static const String bayarTunai = "/api/samsat-pembantu/bayar/bayar-tunai";
  static const String getNomorSkkp = "/api/samsat-pembantu/bayar/cetak-skkp/get-nomor-skkp";
  static const String cetakSkkp = "/api/samsat-pembantu/bayar/cetak-skkp/cetak";

  // Progresif
  static const String progresifByNikInduk = "/api/progresif";
  static const String progresifByNik = "/api/samsat-pembantu/progresif";
  static const String progresifByNamaAlamat = "/api/samsat-pembantu/progresif/nama-alamat";
  static const String requestProteksi = "/api/samsat-pembantu/progresif/proteksi/request";

  //Info Pajak
  static const String infoPajak = "/api/utilities/info-pajak";
  static const String cekBayarKedepan = "/api/utilities/info-pajak/cek-bisa-bayar-kedepan";

  //Penetapan
  static const String hitungUlang = "/api/samsat-pembantu/penetapan/hitung-ulang";
  static const String simpanKoreksi = "/api/samsat-pembantu/penetapan/simpan-koreksi";
  static const String selesaiKoreksi = "/api/samsat-pembantu/penetapan/selesai-koreksi";
  static const String refreshProgresif = "/api/penetapan/refresh";
  static const String cekPendaftaran = "/api/tabel/pendaftaran/get-detail";
  static const String simpanKoreksiInduk = "/api/penetapan/simpan-koreksi";
  static const String hitungUlangInduk = "/api/penetapan/hitung-ulang";
  static const String selesaiKoreksiInduk = "/api/penetapan/selesai-koreksi";
  static const String refreshProgresifInduk = "/api/penetapan/refresh-progresif-induk";

  //Percetakkan
  static const String inquiryCetakSkkp = "/api/samsat-pembantu/bayar/cetak-skkp/inquiry";
  static const String inquiryCetakSkkpEsamsat =
      "/api/samsat-pembantu/bayar/cetak-skkp/e-samsat/inquiry";
  static const String cetakSkkpEsamsat = "/api/samsat-pembantu/bayar/cetak-skkp/e-samsat/cetak";
  static const String inquiryCetakSkkpSamsatDigital =
      "/api/samsat-pembantu/bayar/cetak-skkp/samsat-digital/inquiry";
  static const String cetakSkkpSamsatDigital =
      "/api/samsat-pembantu/bayar/cetak-skkp/samsat-digital/cetak";

  //Test Cetak
  static const String testPrint = "/api/utilities/printer/test-print";
  static const String testPrintFromUserLoket = "/api/utilities/printer/test-print-from-loket";

  //Kirim SKKP Elektronik
  static const String kirimSkkpElektronik =
      "/api/samsat-pembantu/bayar/cetak-skkp/cetak-elektronik";

  //Pembatalan
  static const String inquiryPembatalan = "/api/samsat-pembantu/bayar/inquiry";
  static const String requestPembatalan = "/api/samsat-pembantu/bayar/pembatalan-transaksi";

  //Awal Akhir Hari
  static const String statusAllLayanan = "/api/utilities/layanan/get-all-status";
  static const String statusAwalAkhirHari = "/api/utilities/layanan/status";
  static const String prosesAwalHari = "/api/utilities/layanan/proses-awal-hari";
  static const String prosesAkhirHari = "/api/utilities/layanan/proses-akhir-hari";
  static const String monitoringAkhirHariLaporan =
      "/api/monitoring/get-monitoring-akhir-hari-laporan";
  static const String prosesAkhirHariLaporanDpdb =
      "/api/laporan/bulanan/proses-akhir-hari-ulang-dpdb";

  //NJKB
  static const String kodeMerek = "/api/utilities/njkb/get-kd-merek";
  static const String kodeModel = "/api/utilities/njkb/get-kd-model";
  static const String nilaiJual = "/api/utilities/njkb/get-nilai-jual";
  static const String editMerekKb = "/api/utilities/njkb/merek-kb/edit";
  static const String nmMerekModel = "/api/utilities/njkb/get-nm-merek-model?merekkb_kd_merek_kb=";
  static const String editNilaiJual = "/api/utilities/njkb/nilai-jual/edit";

  //Riwayat Bayar
  static const String riwayatBayar = "/api/utilities/riwayat-bayar?no_polisi1=";

  //Riwayat Batal Transaksi
  static const String getListRiwayatBatalTransaksi = "/api/historis/pembatalan-transaksi/get-list";
  static const String getDetailRiwayatBatalTransaksi =
      "/api/historis/pembatalan-transaksi/get-detail";

  // User Manajemen
  static const String getListUser = "/api/tabel/user/get-list";
  static const String getDetailUser = "/api/tabel/user/get-detail";
  static const String editUser = "/api/tabel/user/edit";
  static const String deleteUser = "/api/tabel/user/edit";
  static const String resetPassword = "/api/utilities/user/reset-password";

  // Role
  static const String getListRole = "/api/tabel/role/get-list";
  static const String getDetailRole = "/api/tabel/role/get-detail";
  static const String editRole = "/api/tabel/role/edit";

  // Loket
  static const String getListLoket = "/api/tabel/loket/get-list";
  static const String getDetailLoket = "/api/tabel/loket/get-detail";
  static const String createLoket = "/api/tabel/loket/edit";
  static const String testPrintLoket = "/api/utilities/printer/test-print-loket";

  // Tapping
  static const String getListTapping = "/api/tabel/tapping/get-list";
  static const String getDetailTapping = "/api/tabel/tapping/get-detail";
  static const String editTapping = "/api/tabel/tapping/edit";

  //Sts Online
  static const String listStsOnline = "/api/tabel/sts-online/current/get-list";
  static const String detailStsOnline = "/api/tabel/sts-online/current/get-detail";
  static const String rekapKasir = "/api/laporan/harian/rekap-kasir";
  static const String sam32 = "/api/laporan/harian/sam32";
  static const String slipSetoran = "/api/laporan/harian/slip-setoran";
  static const String suratTandaSetoran = "/api/laporan/harian/sts";
  static const String akhirHariStsOnline = "/api/laporan/harian/sts-online/proses-akhir-hari";
  static const String mutasiKeluar = "/api/laporan/harian/cetak-fiskal";
  static const String laporanSam32StnkTnkb = "/api/laporan/harian/sam32-stnk-tnkb";
  static const String laporanDaftarPesananStnk = "/api/laporan/harian/daftar-pesanan-cetak-stnk";
  static const String laporanDaftarPesananTnkb = "/api/laporan/harian/daftar-pesanan-cetak-tnkb";
  static const String beaAdmStnkTnkb = "/api/laporan/harian/rekap-stnk-tnkb";
  static const String pejabatLaporan = "/api/laporan/get-pejabat-laporan";
  static const String kirimLaporan = "/api/utilities/kirim-file-via-wa";
  static const String getBatalJurnal = "/api/laporan/harian/jurnal-batal";

  //Daftar Suplemen Sts Online
  static const String listSuplemenStsOnline = "/api/laporan/harian/sts-online/suplemen/get-list";
  static const String detailSuplemenStsOnline =
      "/api/laporan/harian/sts-online/suplemen/get-detail";

  //Verifikasi Pembatalan
  static const String getListRequestVerifikasiPembatalan =
      "/api/verifikasi/pembatalan-transaksi/get-list-request";
  static const String getDetailRequestVerifikasiPembatalan =
      "/api/verifikasi/pembatalan-transaksi/get-detail-request";
  static const String prosesRequestVerifikasiPembatalan =
      "/api/verifikasi/pembatalan-transaksi/proses-request";

  //Verifikasi STS Online
  static const String listVerifikasiStsOnline = "/api/verifikasi/sts-online/get-list";
  static const String getDetailVerifikasiStsOnline = "/api/verifikasi/sts-online/get-detail";
  static const String prosesVerifikasiStsOnline = "/api/verifikasi/sts-online/proses-verifikasi";

  //Verifikasi Suplemen STS
  static const String listVerifikasiSuplemenSTS = "/api/verifikasi/sts-suplemen-online/get-list";
  static const String getDetailVerifikasiSuplemenSTS =
      "/api/verifikasi/sts-suplemen-online/get-detail";
  static const String prosesVerifikasiSuplemenSTS =
      "/api/verifikasi/sts-suplemen-online/proses-verifikasi";

  //Verifikasi Proteksi
  static const String getListRequestVerifikasiProteksi =
      "/api/verifikasi/proteksi/get-list-request";
  static const String getDetailRequestVerifikasiProteksi =
      "/api/verifikasi/proteksi/get-detail-request";
  static const String prosesRequestVerifikasiProteksi = "/api/verifikasi/proteksi/proses-request";

  //Pejabat Pengawas
  static const String getMyPejabatPengawas = "/api/utilities/user/get-my-pejabat-pengawas";

  // Tabel Operasional - Objek Pajak
  static const String getListObjekPajak = "/api/tabel/objek-pajak/get-list";
  static const String getDetailObjekPajak = "/api/tabel/objek-pajak/get-detail?id=";
  static const String editObjekPajak = "/api/tabel/objek-pajak/edit";

  // Tabel Operasional - Subjek Pajak
  static const String getListSubjekPajak = "/api/tabel/subjek-pajak/get-list";
  static const String getDetailSubjekPajak = "/api/tabel/subjek-pajak/get-detail?no_identitas=";
  static const String editSubjekPajak = "/api/tabel/subjek-pajak/edit";

  // Tabel Operasional - Transaksi
  static const String getListTransaksi = "/api/tabel/transaksi/get-list";
  static const String getDetailTransaksi = "/api/tabel/transaksi/get-detail?id=";
  static const String editTransaksi = "/api/tabel/transaksi/edit";

  // Tabel Operasional - Report
  static const String getListReport = "/api/tabel/report/get-list";
  static const String getDetailReport = "/api/tabel/report/get-detail?id=";
  static const String editReport = "/api/tabel/report/edit";

  // Tabel Operasional - Report Lampau
  static const String getListReportLampau = "/api/tabel/report-lampau/get-list";
  static const String getDetailReportLampau = "/api/tabel/report-lampau/get-detail?id=";

  //Verifikasi Data Master
  static const String getListVerifikasiTableOperasional = "/api/verifikasi/tabel/get-list";
  static const String getDetailVerifikasiTableOperasional = "/api/verifikasi/tabel/get-detail";
  static const String prosesVerifikasiTableOperasional = "/api/verifikasi/tabel/proses-verifikasi";

  //Verifikasi Reservasi
  static const String getDetailReservasi = "/api/samsat-digital/reservasi/get-detail";
  static const String prosesVerifikasiReservasi =
      "/api/samsat-digital/reservasi/verifikasi-kehadiran";

  //Riwayat Tabel Operasional
  static const String getListRiwayatTabelOperasional = "/api/historis/crud/get-list";
  static const String getDetailRiwayatTabelOperasional = "/api/historis/crud/get-detail";

  //Riwayat Riwayat STS Online
  static const String getListRiwayatSTSOnline = "/api/tabel/sts-online/current/get-list";
  static const String getDetailRiwayatSTSOnline = "/api/tabel/sts-online/current/get-detail";
  static const String getDaftarDataTransaksi = "/api/tabel/report/get-list";

  // Kode Pos
  static const String getKdPos = "/api/utilities/kdpos/kd-pos?kd_pos_kd_wil=";
  static const String getKecamatan = "/api/utilities/kdpos/kd-kecamatan?kd_pos_kd_wil=";

  //Laporan Bulanan
  static const String bpdb = "/api/laporan/bulanan/bpdb/bpdb";
  static const String satuA = "/api/laporan/bulanan/bpdb/bpdb1a";
  static const String empatA = "/api/laporan/bulanan/bpdb/bpdb4a";
  static const String empatA1 = "/api/laporan/bulanan/bpdb/bpdb4a1";
  static const String empatA2 = "/api/laporan/bulanan/bpdb/bpdb4a2";
  static const String bpdb5 = "/api/laporan/bulanan/bpdb/bpdb5";
  static const String bpdb6 = "/api/laporan/bulanan/bpdb/bpdb6";
  static const String bpdb6a = "/api/laporan/bulanan/bpdb/bpdb6a";
  static const String satuCD = "/api/laporan/bulanan/bpdb/bpdb1cd";
  static const String duaA = "/api/laporan/bulanan/bpdb/bpdb2a";
  static const String duaB = "/api/laporan/bulanan/bpdb/bpdb2b";
  static const String limaA = "/api/laporan/bulanan/bpdb/bpdb5a";
  static const String limaB = "/api/laporan/bulanan/bpdb/bpdb5b";

  // Cms Kuota
  static const String getListAntreanCf = "/api/cms/antrian-base-cf/get-list";
  static const String getDetailAntreanCf = "/api/cms/antrian-base-cf/get-detail";
  static const String getEditAntreanCf = "/api/cms/antrian-base-cf/edit";
  static const String getListAntrean = "/api/cms/antrian-wil-base/get-list";
  static const String getDetailAntrean = "/api/cms/antrian-wil-base/get-detail";
  static const String getEditAntrean = "/api/cms/antrian-wil-base/edit";
  static const String getListReservasiAntrean = "/api/cms/antrian-res-base/get-list";
  static const String getDetailReservasiAntrean = "/api/cms/antrian-res-base/get-detail";
  static const String getEditReservasiAntrean = "/api/cms/antrian-res-base/edit";

  //Rekon Esamsat
  static const String getDataRekonEsamsatNopol = "/api/rekon/esamsat/get-data-by-no-polisi";
  static const String getDataRekonEsamsatKdBayar = "/api/rekon/esamsat/get-data-by-kode-bayar";
  static const String forceFlagRekonEsamsat = "/api/rekon/esamsat/force-flag-rekon";
  static const String forceReversalRekonEsamsat = "/api/rekon/esamsat/reversal-rekon";

  //Riwayat Proteksi
  static const String getRiwayatProteksi = "/api/tabel/proteksi/inquiry";

  //Nasabah Prioritas
  static const String listWiluppdLayanan = "/api/samsat-prioritas/bjb-prioritas/get-list-wiluppd";
  static const String listLayanan = "/api/samsat-prioritas/bjb-prioritas/get-layanan";
  static const String listPic = "/api/samsat-prioritas/bjb-prioritas/get-pic";
}
