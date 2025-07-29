import 'dart:math';

import 'package:core/core.dart';

class StringUtils {
  static bool compareStrings(String str1, String str2) {
    // Mengubah kedua string menjadi lowercase dan menghilangkan spasi ekstra
    String normalizedStr1 =
        str1.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
    String normalizedStr2 =
        str2.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();

    // Membandingkan kedua string
    return normalizedStr1 == normalizedStr2;
  }

  static trimString(String? string) {
    if (string == null) {
      return "";
    } else if (string == "         ") {
      return "";
    } else if (string.contains("null")) {
      return "";
    } else {
      final trimmedString = string.trim();
      return trimmedString.isEmpty ? "" : trimmedString;
    }
  }

  static String? trimStringNull(String? input) {
    if (input == null) return null;
    if (input.contains("null")) return null;
    if (input == "         ") return null;

    final trimmed = input.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static bool isEmptyString(String? string) {
    if (string == null) {
      return true;
    }
    final trimmedString = string.trim();
    return trimmedString.isEmpty || trimmedString == "null";
  }

  static String stringNumber(dynamic numbers) {
    if (numbers == null) {
      return "0";
    } else if (numbers.runtimeType == String) {
      return double.tryParse(numbers ?? "0")?.toInt().toString() ?? "0";
    } else if (numbers.runtimeType == bool) {
      return numbers ? "1" : "0";
    } else if (numbers.runtimeType == double) {
      return numbers.toInt().toString();
    } else {
      return numbers.toString();
    }
  }

  static String formatNumber(dynamic number) {
    try {
      if (number == null) return "0";

      if (number is int) {
        return number.toString();
      } else if (number is double) {
        return number.toInt().toString();
      } else if (number is String) {
        return (double.tryParse(number)?.toInt() ?? 0).toString();
      }

      return "0";
    } catch (e) {
      return "0";
    }
  }

  static String formatNopol(
      String? tnkbDaerah, String? tnkbSubDaerah, String? tnkbNomor) {
    return (trimString(tnkbDaerah).padRight(2, " ") +
            trimString(tnkbSubDaerah).padRight(3, " ") +
            trimString(tnkbNomor).padLeft(4, " "))
        .toUpperCase();
  }

  static String formatNopolForView(String? input) {
    List<String> groups = input.toString().split(" ");
    if (input.toString().isEmpty) {
      return "-";
    } else if (input.toString().contains("null")) {
      return "-";
    } else if (groups.length == 2) {
      String group1 = groups[0];
      String group2 = groups[1];

      String alphabeticPart = "";
      String numericPart = "";

      for (var char in group2.runes) {
        if (char >= 48 && char <= 57) {
          numericPart += String.fromCharCode(char);
        } else {
          alphabeticPart += String.fromCharCode(char);
        }
      }

      return "$group1 $numericPart $alphabeticPart";
    } else if (groups.length == 3) {
      String group1 = groups[0];
      String group2 = groups[1];
      String group3 = groups[2];
      return "$group1 $group3 $group2";
    } else if (groups.length > 3) {
      String group1 = groups[0];
      String group2 = groups[1];
      String group3 = groups[groups.length - 1];
      return "$group1 $group3 $group2";
    } else {
      return "-";
    }
  }

  static stringDouble(String? string) {
    var value = "";
    try {
      value = double.parse(string ?? "0").toInt().toString();
      return trimString(value);
    } catch (e) {
      return value;
    }
  }

  static parseTerdaftar(String? string) {
    if (string == null) {
      return "-";
    } else if (string.contains("null")) {
      return "-";
    } else {
      final trimmedString = string.trim().toLowerCase();
      return trimmedString == "terdaftar" ? "-" : trimmedString;
    }
  }

  static String numberToWords(dynamic number) {
    if (number == null) {
      return "-";
    }
    if (number.runtimeType == String) {
      number = int.tryParse(number) ?? 0;
    }
    if (number.runtimeType != int) {
      return "Bukan angka";
    }

    if (number == 0) return "nol";

    final units = [
      "",
      "satu",
      "dua",
      "tiga",
      "empat",
      "lima",
      "enam",
      "tujuh",
      "delapan",
      "sembilan"
    ];
    final tens = [
      "",
      "",
      "dua puluh",
      "tiga puluh",
      "empat puluh",
      "lima puluh",
      "enam puluh",
      "tujuh puluh",
      "delapan puluh",
      "sembilan puluh"
    ];
    final teens = [
      "sepuluh",
      "sebelas",
      "dua belas",
      "tiga belas",
      "empat belas",
      "lima belas",
      "enam belas",
      "tujuh belas",
      "delapan belas",
      "sembilan belas"
    ];

    final thousands = ["", "ribu", "juta", "miliar", "triliun"];

    // Convert the number into a list of thousands, millions, etc.
    String convertSection(int number, int index) {
      if (number == 0) return "";

      String result = "";
      int hundred = number ~/ 100;
      int ten = (number % 100) ~/ 10;
      int unit = number % 10;

      if (hundred > 0) {
        if (hundred == 1) {
          result += "seratus ";
        } else {
          result += "${units[hundred]} ratus ";
        }
      }

      if (ten > 1) {
        result += "${tens[ten]} ";
        if (unit > 0) {
          result += units[unit];
        }
      } else if (ten == 1) {
        result += teens[unit];
      } else if (unit > 0) {
        result += units[unit];
      }

      return result.trim();
    }

    List<String> parts = [];
    int sectionIndex = 0;

    while (number > 0) {
      int currentSection = number % 1000;
      if (currentSection > 0) {
        String sectionWord = convertSection(currentSection, sectionIndex);
        if (thousands[sectionIndex] != "") {
          sectionWord += " ${thousands[sectionIndex]}";
        }
        parts.insert(0, sectionWord); // Insert at the beginning
      }
      number ~/= 1000;
      sectionIndex++;
    }

    return parts.join(" ").toUpperCase();
  }

  static String capitalizeEachWord(String text) {
    return text
        .split(" ")
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : "")
        .join(" ");
  }

  static mergeNoPolisi(
    String? noPolisi1,
    String? noPolisi2,
    String? noPolisi3,
  ) {
    if (trimString(noPolisi1).isEmpty &&
        trimString(noPolisi2).isEmpty &&
        trimString(noPolisi3).isEmpty) {
      return "-";
    }
    return trimString(noPolisi1) +
        " " +
        trimString(noPolisi2) +
        " " +
        trimString(noPolisi3);
  }

  static removeSlash(String? string) {
    if (string == null) {
      return "";
    } else if (string.contains("/")) {
      return string.replaceAll("/", "");
    } else {
      return string;
    }
  }

  static convertTitle(String text) {
    if (text.isEmpty) {
      return text;
    }
    try {
      String data = text.split('_').map((word) {
        if (word.isEmpty) {
          return word;
        }
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
      if (text == "pab_dasar") {
        return "DASAR PENGENAAN PAJAK";
      }
      return data.toUpperCase();
    } catch (e) {
      return "";
    }
  }

  static trimStringStrip(String? string) {
    if (string == null) {
      return "-";
    } else if (string.contains("null")) {
      return "-";
    } else {
      final trimmedString = string.trim();
      return trimmedString.isEmpty ? "-" : trimmedString;
    }
  }

  static checkDate(String? date) {
    if (date == null) {
      return "";
    } else if (date.trim().contains("null")) {
      return "";
    } else {
      final trimmedString = date.trim();
      return trimmedString.isEmpty
          ? DateFormater.formatSelectedDate(DateTime.now())
          : trimmedString;
    }
  }

  static checkModel(dynamic data) {
    if (data == null) return null;
    if (data.runtimeType == String) return data;
    if (data.runtimeType == bool) return data;
    if (data.runtimeType == double) return data;

    return data.toString();
  }

  static int hitungDpp(String? nilaiJual, String bobot) {
    dynamic result = (((int.tryParse(nilaiJual ?? "0") ?? 0) *
                    (double.tryParse(bobot) ?? 0)) /
                1000)
            .round() *
        1000;
    return result;
  }

  static List<T> removeDuplicateList<T>(List<T> list) {
    Set<T> seen = {};
    List<T> result = [];

    for (var element in list) {
      if (seen.add(element)) {
        result.add(element);
      }
    }
    return result;
  }

  static List<String> parseFileExtensions(String extensions) {
    if (extensions.isNotEmpty) {
      return extensions
          .split(';')
          .map((ext) => ext.replaceAll('.', ''))
          .where((ext) => ext.isNotEmpty)
          .toList();
    }
    return [];
  }

  static String mimeTypeToExtension(String mimeType) {
    if (mimeType.contains(".")) {
      List<String> parts = mimeType.split('.');
      if (parts.length > 1) {
        return '.${parts.last}';
      } else {
        return mimeType;
      }
    } else {
      List<String> parts = mimeType.split('/');
      if (parts.length > 1) {
        return '.${parts.last}';
      } else {
        return mimeType;
      }
    }
  }

  static bool checkRole(String role, String reqRole) {
    bool isEnable = false;
    if (reqRole.contains(";")) {
      List<String> parts =
          reqRole.split(';').where((s) => (s).isNotEmpty).toList();
      if (parts.isNotEmpty) {
        for (var i = 0; i < parts.length; i++) {
          if (StringUtils.trimString(parts[i]) ==
              StringUtils.trimString(role)) {
            isEnable = true;
          }
        }
      }
    } else {
      if (StringUtils.trimString(role) == StringUtils.trimString(reqRole)) {
        isEnable = true;
      }
    }
    return isEnable;
  }

  static List<T?> createNullList<T>(int length) {
    return List<T?>.filled(length, null, growable: false);
  }

  static String toCamelCase(String input) {
    try {
      List<String> parts = input.split('_');
      String camelCase = parts.first +
          parts.skip(1).map((String part) {
            return part.isNotEmpty
                ? part[0].toUpperCase() + part.substring(1)
                : '';
          }).join('');
      return camelCase;
    } catch (e) {
      return input;
    }
  }

  static bool toBool({
    required String? value,
  }) {
    if (StringUtils.trimString(value) == "1") return true;

    return false;
  }

  static bool ytToBool(String? value) {
    if (StringUtils.trimString(value) == "Y") {
      return true;
    }

    return false;
  }

  static String boolToString(bool? value) {
    if (value ?? false) {
      return "1";
    }

    return "0";
  }

  static int calcStringNumber(List<dynamic> items) {
    int result = 0;
    for (var item in items) {
      if (item == null || item is num || item is String) {
        result += int.tryParse(item.toString()) ?? 0;
      } else {
        result += 0;
      }
    }
    return result;
  }

  static int calcStringNumberV2(List<dynamic> items) {
    return items.fold<int>(0, (sum, item) {
      if (item == null) return sum;

      // Handle numeric types directly
      if (item is int) return sum + item;
      if (item is double) return sum + item.toInt();

      // Handle string conversion
      if (item is String) {
        return sum + (double.tryParse(item)?.toInt() ?? 0);
      }

      return sum;
    });
  }

  static int calcStringNumberV3(List<dynamic> items) {
    return items.fold<int>(0, (sum, item) {
      if (item == null) return sum;

      // Handle numeric types directly
      if (item is int) return sum + item;
      if (item is double) return sum + item.toInt();

      // Handle string conversion
      if (item is String) {
        // Remove any thousand separators (dots)
        String cleanString = item.replaceAll('.', '');
        return sum + (double.tryParse(cleanString)?.toInt() ?? 0);
      }

      return sum;
    });
  }

  static String splitString(String? originalString, bool? isFirstString) {
    if (originalString != null ||
        StringUtils.trimString(originalString).isNotEmpty) {
      RegExp regExp = RegExp(r'^(.*?) - (.*?)$');
      Match? match = regExp.firstMatch(StringUtils.trimString(originalString));

      if (match != null) {
        String firstPart = match.group(1)!.trim();
        String secondPart = match.group(2)!.trim();
        if (isFirstString ?? true == true) {
          return StringUtils.trimString(firstPart);
        } else {
          return StringUtils.trimString(secondPart);
        }
      } else {
        return "-";
      }
    } else {
      return "-";
    }
  }

  static String mergeKdMohon(
    String? kdMohon1,
    String? kdMohon2,
    String? kdMohon3,
    String? kdMohon4,
    String? kdMohon5,
    String? kdMohon6,
  ) {
    return StringUtils.trimString(kdMohon1) +
        StringUtils.trimString(kdMohon2) +
        StringUtils.trimString(kdMohon3) +
        StringUtils.trimString(kdMohon4) +
        StringUtils.trimString(kdMohon5) +
        StringUtils.trimString(kdMohon6);
  }

  static String mergeNomorPolisi(
      {required String nopol1,
      required String nopol2,
      required String nopol3}) {
    // Ensure each part meets the required length
    nopol1 = nopol1.padRight(2, ' '); // Make nopol1 exactly 2 characters
    nopol2 = nopol2.padRight(4, ' '); // Make nopol2 exactly 4 characters
    nopol3 = nopol3.padRight(3, ' '); // Make nopol3 exactly 3 characters

    // Combine the parts with spaces in between
    return "${nopol1.trim()} ${nopol2.trim()} ${nopol3.trim()}";
  }

  static String getStatusPermintaanVerif(StatusPermintaan status) {
    switch (status) {
      case StatusPermintaan.diterima:
        return "1";
      case StatusPermintaan.ditolak:
        return "0";
    }
  }

  static String generateRandomString(int length) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()-_=+';
    Random random = Random();

    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  static String handleSubString(String word, int end) {
    try {
      if (word.length < end) {
        return '';
      }
      return word.substring(0, end);
    } catch (e) {
      return '';
    }
  }
}
