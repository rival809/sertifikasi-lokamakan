import 'package:core/utils/string_utils/string_utils.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormater {
  static String getDateTimeNow() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }

  static String formatDate(String? date) {
    try {
      if (date!.isEmpty) {
        return "-";
      } else if (date.contains("null")) {
        return "-";
      }
      initializeDateFormatting('id');

      DateTime dateConverted = DateTime.parse(date);
      return "${dateConverted.day.toString().padLeft(2, '0')}-${dateConverted.month.toString().padLeft(2, '0')}-${dateConverted.year.toString().padLeft(2, '0')}";
    } catch (e) {
      return "-";
    }
  }

  static String? convertToDynamicDatePayload(String? date,
      {String outputFormat = "yyyy-MM-dd"}) {
    if (date == null || date.isEmpty) {
      return null;
    }

    try {
      initializeDateFormatting('id');

      // Coba parsing langsung ke DateTime
      DateTime? parsedDate = tryParseDate(date);

      if (parsedDate != null) {
        return DateFormat(outputFormat).format(parsedDate);
      }
    } catch (e) {
      return null;
    }

    // Jika parsing gagal, kembalikan fallback
    return null;
  }

  static DateTime? tryParseDate(String date) {
    try {
      // Langsung parsing DateTime, akan berhasil untuk format yang valid
      return DateTime.parse(date);
    } catch (_) {
      // Jika parsing default gagal, coba parsing menggunakan pola umum
      List<String> fallbackFormats = [
        "dd/MM/yyyy",
        "MM/dd/yyyy",
        "yyyy-MM-dd",
        "dd-MM-yyyy",
        "MM-dd-yyyy",
        "dd MMM yyyy",
        "yyyy/MM/dd",
        "EEE, dd MMM yyyy",
      ];

      for (String format in fallbackFormats) {
        try {
          return DateFormat(format).parse(date);
        } catch (_) {
          continue; // Lanjutkan ke format berikutnya jika gagal
        }
      }
    }

    // Jika semua gagal, kembalikan null
    return null;
  }

  static String formatDateWithoutStrip(String? date) {
    try {
      if (date!.isEmpty) {
        return "";
      } else if (date.contains("null")) {
        return "";
      }
      initializeDateFormatting('id');

      DateTime dateConverted = DateTime.parse(date);
      return "${dateConverted.year.toString().padLeft(2, '0')}${dateConverted.month.toString().padLeft(2, '0')}${dateConverted.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return "";
    }
  }

  static int dateToInt(String tglInvalid) {
    DateTime dateInvalid = DateTime.parse(tglInvalid);

    int remainingDuration =
        dateInvalid.difference(DateTime.now()).inMilliseconds;

    return DateTime.now().millisecondsSinceEpoch + remainingDuration;
  }

  static String formatDateSlashToPayload(String? date) {
    try {
      if (date!.isEmpty) {
        return "-";
      } else if (date.contains("null")) {
        return "-";
      }
      initializeDateFormatting('id');

      DateTime dateConverted = DateFormat("dd/MM/yyyy").parse(date);
      return DateFormat("yyyy-MM-dd").format(dateConverted);
    } catch (e) {
      return "-";
    }
  }

  static String? formatDMYtoYMD(String? date) {
    try {
      if (date!.isEmpty || date.contains("null")) {
        return null;
      }
      initializeDateFormatting('id');

      DateTime dateConverted = DateFormat("dd/MM/yyyy").parse(date);
      return DateFormat("yyyy-MM-dd").format(dateConverted);
    } catch (e) {
      return null;
    }
  }

  static formatDateSlash(String? date) {
    try {
      if (date!.isEmpty) {
        return "";
      } else if (date.contains("null")) {
        return "";
      }
      initializeDateFormatting('id');

      DateTime dateConverted = DateTime.parse(StringUtils.trimString(date));
      return "${dateConverted.day.toString().padLeft(2, '0')}/${dateConverted.month.toString().padLeft(2, '0')}/${dateConverted.year.toString().padLeft(2, '0')}";
    } catch (e) {
      return "";
    }
  }

  static formatSelectedDate(DateTime selectedDate) {
    String selectedDateString = DateFormat('yyyy-MM-dd').format(selectedDate);
    return selectedDateString;
  }

  static formatDatePicker(DateTime selectedDate) {
    String selectedDateString = DateFormat('dd/MM/yyyy').format(selectedDate);
    return selectedDateString;
  }

  static formatSelectedTime(DateTime selectedDate) {
    String selectedDateString = DateFormat('HH:mm:ss').format(selectedDate);
    return selectedDateString;
  }

  static String formatSelectedDateFull(DateTime selectedDate) {
    String selectedDateString =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
    return selectedDateString;
  }

  static formatDateFull(String? date) {
    try {
      if (date.toString().isEmpty) {
        return "-";
      } else if (date.toString().contains("null")) {
        return "-";
      }
      initializeDateFormatting('id');

      DateTime dateConverted = DateTime.parse(date.toString());
      String formattedDate = DateFormat.yMMMMd('id').format(dateConverted);

      return formattedDate.toUpperCase();
    } catch (e) {
      return date;
    }
  }

  static formatDateWithTime(String? date) {
    if (date.toString().isEmpty) {
      return "-";
    } else if (date.toString().contains("null")) {
      return "-";
    }
    initializeDateFormatting('id');

    DateTime originalDate = DateTime.parse(date.toString());

    String formattedDate = DateFormat('d MMMM y HH:mm:ss').format(originalDate);

    return formattedDate.toUpperCase();
  }

  static getTimeFromDate(String date) {
    try {
      DateTime timestamp = DateTime.parse(date);
      String time = DateFormat('HH:mm:ss').format(timestamp);
      return time;
    } catch (e) {
      return "";
    }
  }

  static cekFormatDate(String? date) {
    if (StringUtils.trimString(date).isEmpty) {
      return null;
    } else if (date.toString().contains("null")) {
      return null;
    } else {
      try {
        DateTime originalDate = DateTime.parse(date.toString());
        String formattedDate = DateFormat('yyyy-MM-dd').format(originalDate);
        return formattedDate;
      } catch (e) {
        return null;
      }
    }
  }

  static Map<String, String> getCurrentDateComponents() {
    DateTime now = DateTime.now();
    String day = now.day.toString().padLeft(2, '0').trim();
    String month = now.month.toString().padLeft(2, '0').trim();
    String year = now.year.toString().trim();

    return {
      'day': day,
      'month': month,
      'year': year,
    };
  }

  static String getDateNow({String format = 'dd/MM/yyyy HH:mm'}) {
    return DateFormat(format).format(DateTime.now());
  }
}

class DateInputFormatter extends TextInputFormatter {
  final int maxLength;
  final bool dayFirst;
  final String separator;

  /// [dayFirst] menentukan apakah format tanggal diawali dengan hari (dd/MM/yyyy) atau tahun (yyyy/MM/dd).
  /// [separator] menentukan karakter pemisah yang digunakan (misalnya '/', '-', dll).
  DateInputFormatter(
      {this.maxLength = 8, this.dayFirst = true, this.separator = '/'});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Hapus semua karakter kecuali angka
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Pastikan panjangnya tidak melebihi maxLength
    if (text.length > maxLength) {
      text = text.substring(0, maxLength);
    }

    // Sisipkan karakter pemisah sesuai dengan format dan separator
    if (dayFirst) {
      // Format dd/MM/yyyy
      if (text.length > 2 && text.length <= 4) {
        text = text.replaceFirstMapped(RegExp(r'^(\d{2})(\d{1,2})'), (match) {
          return '${match[1]}$separator${match[2]}';
        });
      } else if (text.length > 4) {
        text = text.replaceFirstMapped(RegExp(r'^(\d{2})(\d{2})(\d{1,4})'),
            (match) {
          return '${match[1]}$separator${match[2]}$separator${match[3]}';
        });
      }
    } else {
      // Format yyyy/MM/dd
      if (text.length > 4 && text.length <= 6) {
        text = text.replaceFirstMapped(RegExp(r'^(\d{4})(\d{1,2})'), (match) {
          return '${match[1]}$separator${match[2]}';
        });
      } else if (text.length > 6) {
        text = text.replaceFirstMapped(RegExp(r'^(\d{4})(\d{2})(\d{1,2})'),
            (match) {
          return '${match[1]}$separator${match[2]}$separator${match[3]}';
        });
      }
    }

    // Kembalikan nilai baru dengan posisi kursor diperbarui
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
