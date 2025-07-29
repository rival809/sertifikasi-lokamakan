class RouterUtils {
  //BASE ROUTE
  static const String root = '/';
  static const String beranda = '/beranda';
  static const String informasiPkb = '/informasi-pkb';
  static const String awalAkhirHari = '/awal-akhir-hari';
  static const String detailAwalAkhirHari = '/detail-awal-akhir-hari';
  static const String profile = '/profile';
  static const String notFound = '/404';
  static const String monitoringAkhirHari = '/monitoring-akhir-hari';

  //Auth Route
  static const String login = '/login';
  static const String ubahKataSandi = '/ubah-kata-sandi';

  //KEUANGAN ROUTE
  static const String stsOnlineKeuangan = '/sts-online-keuangan';
  static const String suplemenStsOnlineKeuangan = '/suplemen-sts-online-keuangan';
  static const String rekonEsamsat = '/rekon-esamsat';

  // Manajemen Route
  static const String petugasManajemen = '/manajemen-petugas';
  static const String petugasManajemenDetail = '/manajemen-petugas/detail';
  static const String roleManajemen = '/role-manajemen';
  static const String loketManajemen = '/loket-manajemen';
  static const String loketManajemenDetail = '/loket-manajemen/detail';
  static const String tappingManajemen = '/tapping-manajemen';
  static const String manajemenNjkb = '/manajemen-njkb';
  static const String detailNjkb = '/detail-njkb';

  // Tabel Operasional Route
  static const String tabelOperasional = '/tabel-operasional';

  // Tabel Operasional Route - Objek Pajak
  static const String objekPajak = '/tabel-operasional/objek-pajak';
  static const String objekPajakDetail = '/tabel-operasional/objek-pajak/detail';

  // Tabel Operasional Route - Subjek Pajak
  static const String subjekPajak = '/tabel-operasional/subjek-pajak';
  static const String subjekPajakCreate = '/tabel-operasional/subjek-pajak/create';
  static const String subjekPajakDetail = '/tabel-operasional/subjek-pajak/detail';

  // Tabel Operasional Route - Transaksi
  static const String transaksiTabel = '/tabel-operasional/transaksi';
  static const String transaksiTabelDetail = '/tabel-operasional/transaksi/detail';

  // Tabel Operasional Route - Report
  static const String reportTabel = '/tabel-operasional/report';
  static const String reportTabelDetail = '/tabel-operasional/report/detail';

  // Tabel Operasional Route - Report Lampau
  static const String reportLampauTabel = '/tabel-operasional/report-lampau';
  static const String reportLampauTabelDetail = '/tabel-operasional/report-lampau/detail';

  //Verifikasi Route
  ///Verifikasi Proteksi
  static const String verifikasiProteksi = '/verifikasi-proteksi';
  static const String detailVerifikasiProteksi = '/detail-verifikasi-proteksi';

  ///Verifikasi Pembatalan
  static const String verifikasiPembatalan = '/verifikasi-pembatalan';
  static const String detailVerifikasiPembatalan = '/detail-verifikasi-pembatalan';

  ///Verifikasi STS Online
  static const String verifikasiStsOnline = '/verifikasi-sts-online';
  static const String detailVerifikasiStsOnline = '/detail-verifikasi-sts-online';

  ///Verifikasi Suplemen STS Online
  static const String verifikasiSuplemenStsOnline = '/verifikasi-suplemen-sts-online';
  static const String detailVerifikasiSuplemenStsOnline = '/detail-verifikasi-suplemen-sts-online';

  ///Verifikasi Tabel Operasional
  static const String verifikasiTabelOperasional = '/verifikasi-tabel-operasional';
  static const String detailVerifikasiTabelOperasional = '/detail-verifikasi-tabel-operasional';

  ///Verifikasi Reservasi
  static const String verifikasiReservasi = '/verifikasi-reservasi';
  static const String detailVerifikasiReservasi = '/detail-verifikasi-reservasi';

  ///Verifikasi Reservasi
  static const String verifikasiPrioritas = '/verifikasi-prioritas';
  static const String detailVerifikasiPrioritas = '/detail-verifikasi-prioritas';
  //End Verifikasi Route

  //Riwayat Route
  static const String riwayatTabelSubjekPajak = '/riwayat-tabel-subjek-pajak';
  static const String riwayatTabelObjekPajak = '/riwayat-tabel-objek-pajak';
  static const String riwayatTabelTransaksi = '/riwayat-tabel-transaksi';
  static const String riwayatTabelReport = '/riwayat-tabel-report';
  static const String riwayatStsOnline = '/riwayat-sts-online';
  static const String riwayatProteksi = '/riwayat-proteksi';

  //Riwayat Batal Transaksi
  static const String riwayatBatalTransaksi = '/riwayat-batal-transaksi';

  //laporan harian
  static const String laporanHarian = '/laporan-harian';
  static const String detailLaporanHarian = '/detail-laporan-harian';
  static const String laporanBulanan = '/laporan-bulanan';
  static const String detailLaporanBulanan = '/detail-laporan-bulanan';

  //CMS Route
  static const String listCmsAntrean = '/cms-antrean/list';
  static const String detailCmsAntrean = '/cms-antrean/detail';
  static const String listCmsCekFisik = '/cms-cek-fisik/list';
  static const String detailCmsCekFisik = '/cms-cek-fisik/detail';
  static const String listCmsReservasiAntrean = '/cms-reservasi-antrean/list';
  static const String detailCmsReservasiAntrean = '/cms-reservasi-antrean/detail';

  //laporan harian
  static const String pendaftaranProses = '/pendaftaran-proses';
  static const String listPermohonanProses = '/list-permohonan-proses';
  static const String detailPermohonanProses = '/detail-permohonan-proses';
  static const String cekStatusProses = '/cek-status-proses';
}
