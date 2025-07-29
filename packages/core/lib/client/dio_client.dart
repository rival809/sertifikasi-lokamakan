import 'package:core/core.dart';

enum RequestType { get, post, put, patch, delete, postForm }

class DioClient {
  final String? baseUrl;
  DioClient({this.baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? IpDatabase.host,
        sendTimeout: Endpoints.connectionTimeout,
        connectTimeout: Endpoints.connectionTimeout,
        receiveTimeout: Endpoints.receiveTimeout,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([DioInterceptors()]);
  }

  late final Dio _dio;

  Future<Response<dynamic>> apiCall({
    required String url,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? header,
    RequestOptions? requestOptions,
    CancelToken? cancelToken,
  }) async {
    late Response result;
    String token = SessionService.token;

    switch (requestType) {
      case RequestType.get:
        {
          Options options = Options(
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $token',
            },
          );
          result = await _dio.get(url,
              queryParameters: queryParameters, options: options, cancelToken: cancelToken);
          break;
        }
      case RequestType.post:
        {
          Options options = Options(
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $token',
            },
          );
          result = await _dio.post(url, data: body, options: options, cancelToken: cancelToken);
          break;
        }
      case RequestType.delete:
        {
          Options options = Options(headers: header);
          result = await _dio.delete(url,
              data: queryParameters, options: options, cancelToken: cancelToken);
          break;
        }
      case RequestType.put:
        {
          Options options = Options(headers: header);
          result = await _dio.put(url, data: body, options: options, cancelToken: cancelToken);
          break;
        }
      case RequestType.patch:
        {
          Options options = Options(headers: header);
          result = await _dio.put(url, data: body, options: options, cancelToken: cancelToken);
          break;
        }
      case RequestType.postForm:
        break;
    }
    return result;
  }
}
