import 'dart:convert';

import 'package:base/models/detail_restaurant_model.dart';
import 'package:base/models/search_restaurant_model.dart';
import 'package:core/core.dart';

class ApiServiceBase {
  DioClient client = DioClient();
  CancelToken cancelToken = CancelToken();

  void resetCancelToken() {
    cancelToken = CancelToken();
  }

  Future<SearchRestaurantModel> getListResto() async {
    try {
      final response = await client.apiCall(
        url: Endpoints.listResto,
        requestType: RequestType.get,
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["error"] == false) {
          return SearchRestaurantModel.fromJson(
              json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to getListResto");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<DetailRestaurantModel> getDetailResto({
    required String idResto,
  }) async {
    try {
      final response = await client.apiCall(
        url: "${Endpoints.detailResto}/$idResto",
        requestType: RequestType.get,
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["error"] == false) {
          return DetailRestaurantModel.fromJson(
              json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to getDetailResto");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<SearchRestaurantModel> searchResto({
    required String query,
  }) async {
    try {
      final response = await client.apiCall(
        url: "${Endpoints.searchResto}?q=$query",
        requestType: RequestType.get,
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        if (response.data["error"] == false) {
          return SearchRestaurantModel.fromJson(
              json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to searchResto");
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
