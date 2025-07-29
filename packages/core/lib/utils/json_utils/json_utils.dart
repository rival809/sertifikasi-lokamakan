import 'dart:convert';
import 'dart:developer';

import 'package:logger/logger.dart';

class JsonUtils {
  static void prettyPrint(
    Map<String, dynamic>? jsonData, [
    bool printNull = false,
  ]) {
    Logger logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 75,
        colors: true,
        printEmojis: true,
        // dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
    );

    const encoder = JsonEncoder.withIndent('  '); // Indent with 2 spaces

    final jsonToEncode =
        printNull ? jsonData : removeNullEntries(jsonData ?? {});
    final prettyJson = encoder.convert(jsonToEncode);
    logger.v(prettyJson);
  }

  static dynamic handleDecode({
    required String? value,
    required dynamic defaultValue,
  }) {
    dynamic jsonData = defaultValue;

    try {
      if (value == null) {
        throw Exception("Version data is null");
      }
      jsonData = json.decode(value);
    } on FormatException catch (fe) {
      log("Error parsing JSON data: ${fe.message}");
    } catch (e) {
      log("An unexpected error occurred: ${e.toString()}");
    }

    return jsonData;
  }

  static Map<String, dynamic> removeNullEntries(Map<String, dynamic> map) {
    // Membuat salinan dari map yang diberikan untuk menghindari modifikasi langsung
    Map<String, dynamic> cleanedMap = Map<String, dynamic>.from(map);

    // Menghapus pasangan kunci-nilai dimana nilainya null
    cleanedMap.removeWhere((key, value) => value == null);

    return cleanedMap;
  }
}
