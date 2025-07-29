import 'dart:convert';

import 'package:base/models/awal_akhir_hari/proses_awal_akhir_hari_model.dart';
import 'package:base/models/awal_akhir_hari/status_all_layanan_model.dart';
import 'package:base/models/awal_akhir_hari/status_awal_akhir_hari_model.dart';
import 'package:base/models/info_pkb/info_pajak_model.dart';
import 'package:base/models/monitoring_akhir_hari_laporan/list_akhir_hari_laporan.dart';
import 'package:core/core.dart';

class ApiServiceBase {
  DioClient client = DioClient();
  CancelToken cancelToken = CancelToken();

  void resetCancelToken() {
    cancelToken = CancelToken();
  }

  Future<InfoPajakModel> infoPajak({
    required String noPolisi1,
    required String noPolisi2,
    required String noPolisi3,
    required String kodePlat,
    required bool isBayarKedepan,
  }) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.infoPajak,
        requestType: RequestType.post,
        body: {
          "where": [
            ["objek_pajak_no_polisi1", "=", noPolisi1],
            ["objek_pajak_no_polisi2", "=", noPolisi2],
            ["objek_pajak_no_polisi3", "=", noPolisi3],
            ["objek_pajak_kd_plat", "=", kodePlat]
          ],
          "bayar_kedepan": isBayarKedepan ? "Y" : "T",
        },
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return InfoPajakModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get inquiry objek pajak");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<Map> cekBayarKedepan({
    required String tgProsesTetap,
    required String tgAkhirPajak,
  }) async {
    try {
      final response = await client.apiCall(
        url:
            "${Endpoints.cekBayarKedepan}?tg_proses_tetap=$tgProsesTetap&tg_akhir_pajak=$tgAkhirPajak",
        requestType: RequestType.get,
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return response.data;
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get inquiry objek pajak");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<StatusAwalAkhiHariModel> cekStatusLayanan({
    required String idWilayah,
  }) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.statusAwalAkhirHari,
        requestType: RequestType.get,
        queryParameters: {
          "id_wiluppd": idWilayah,
        },
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return StatusAwalAkhiHariModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get status awal akhir hari");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<ProsesAwalAkhirHariModel> prosesAwalHari({
    required String ket,
    required String lat,
    required String lon,
    required String idWilayah,
  }) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.prosesAwalHari,
        requestType: RequestType.post,
        body: {
          "ket": ket,
          "lat": lat,
          "lon": lon,
          "layanan_id_wiluppd": idWilayah,
        },
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return ProsesAwalAkhirHariModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get proses awal hari");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<ProsesAwalAkhirHariModel> prosesAkhirHari({
    required String ket,
    required String lat,
    required String lon,
    required String idWilayah,
  }) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.prosesAkhirHari,
        requestType: RequestType.post,
        body: {
          "ket": ket,
          "lat": lat,
          "lon": lon,
          "layanan_id_wiluppd": idWilayah,
        },
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return ProsesAwalAkhirHariModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get proses akhir hari");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<VersioningModel> checkVersion({required String type}) async {
    try {
      final response = await client.apiCall(
        url: "${Endpoints.versionCurrent}?type=$type",
        requestType: RequestType.get,
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return VersioningModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get version data");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<StatusAllLayananModel> getStatusAllLayanan() async {
    try {
      final response = await client.apiCall(
        url: Endpoints.statusAllLayanan,
        requestType: RequestType.get,
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return StatusAllLayananModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get version data");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<ListAkhirHariLaporanModel> listAkhirHariLaporan({
    required String tgAwal,
    required String tgAkhir,
    required String status,
  }) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.monitoringAkhirHariLaporan,
        requestType: RequestType.get,
        queryParameters: {
          "tg_awal": tgAwal,
          "tg_akhir": tgAkhir,
          "status": status,
        },
      );

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return ListAkhirHariLaporanModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get listAkhirHariLaporan data");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<Map> prosesAkhirHariUlangDpdb({
    required String noDpdb,
    required String tgProsAwal,
    required String tgProsAkhir,
  }) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.prosesAkhirHariLaporanDpdb + noDpdb,
        requestType: RequestType.post,
        body: {
          "tg_pros_awal": tgProsAwal,
          "tg_pros_akhir": tgProsAkhir,
        },
        cancelToken: cancelToken,
      );

      // Response response = Response(
      //   requestOptions: RequestOptions(cancelToken: cancelToken),
      //   data: {
      //     "code": "0000",
      //     "success": false,
      //     "data": [],
      //     "message": "Gagal gagal",
      //     "param": {"tg_pros_awal": "2025-02-01", "tg_pros_akhir": "2025-02-02"}
      //   },
      //   statusCode: 200,
      // );

      // Response response = Response(
      //   requestOptions: RequestOptions(cancelToken: cancelToken),
      //   data: {
      //     "code": "0000",
      //     "success": noDpdb == "2" ? false : true,
      //     "data": [],
      //     "message": "Sukses",
      //     "param": {"tg_pros_awal": "2025-02-01", "tg_pros_akhir": "2025-02-02"}
      //   },
      //   statusCode: 200,
      // );

      // await Future.delayed(const Duration(seconds: 2));

      Map data = response.data;

      if (response.statusCode == 200) {
        if (response.data["code"] == "0000") {
          return data;
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to do prosesAkhirHariUlangDpdb");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }
}
