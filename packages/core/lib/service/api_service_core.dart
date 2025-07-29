import 'dart:convert';

import 'package:core/core.dart';

class ApiServiceCore {
  DioClient client = DioClient();

  Future<Map> logout() async {
    try {
      final response = await client.apiCall(
        url: Endpoints.logout,
        requestType: RequestType.post,
      );

      if (response.statusCode == 200) {
        if (response.data["success"]) {
          return response.data;
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to logout");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<KirimWaModel> kirimPdf({required ParamKirimWa paramKirimWa}) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.kirimWa,
        requestType: RequestType.post,
        body: paramKirimWa.toJson(),
      );

      if (response.statusCode == 200) {
        if (response.data["success"]) {
          return KirimWaModel.fromJson(response.data);
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to logout");
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
}
