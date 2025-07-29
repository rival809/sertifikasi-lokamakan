import 'package:core/core.dart';

class DioInterceptors extends Interceptor {
  final bool isUseLogger;

  DioInterceptors({
    this.isUseLogger = false,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;

    final requestPath = '${options.baseUrl}${options.path}';
    if (isUseLogger) {
      LoggerService.logger.e('${options.method} request => $requestPath');
      LoggerService.logger.d('Error: ${err.error}, Message: ${err.message}');
    }

    if (err.response?.statusCode == 401) {
      await showInfoDialog("Sesi Anda telah habis, silakan login ulang!");
      await globalLogout();
      return;
    }

    DioException newError = err; // Default to the original error

    // Kustomisasi pesan berdasarkan jenis error
    if (err.type == DioExceptionType.connectionTimeout) {
      newError = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        message:
            'Tidak mendapatkan respon dari server. Mohon coba beberapa saat lagi.',
      );
    } else if (err.type == DioExceptionType.sendTimeout) {
      newError = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        message: 'Gagal mengirim data ke server. Silakan periksa koneksi Anda.',
      );
    } else if (err.type == DioExceptionType.receiveTimeout) {
      newError = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        message: 'Gagal menerima respon dari server. Mohon coba lagi.',
      );
    } else if (err.type == DioExceptionType.connectionError) {
      newError = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        message:
            'Gagal terhubung ke server. Mohon periksa koneksi internet Anda.',
      );
    }

    // Teruskan error baru
    handler.next(newError);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.path = options.path;
    final requestPath = '${options.baseUrl}${options.path}}';
    if (isUseLogger) {
      LoggerService.logger.i('${options.method} request => $requestPath');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (isUseLogger) {
      LoggerService.logger
          .d('StatusCode: ${response.statusCode}, Data: ${response.data}');
    }

    return super.onResponse(response, handler);
  }
}
