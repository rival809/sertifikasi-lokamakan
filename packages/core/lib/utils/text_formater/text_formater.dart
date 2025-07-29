import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:core/core.dart';

class DateFormatter extends TextInputFormatter {
  static const separator = '/';
  static const maxLength = 10; // Max length for dd/MM/yyyy format

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Remove all separators to count actual input characters
    String newValueText = newValue.text.replaceAll(separator, '');

    // Limit the length of the input to maxLength (8 characters for date, excluding separators)
    if (newValueText.length > 8) {
      return oldValue;
    }

    String oldValueText = oldValue.text.replaceAll(separator, '');

    // Prevents removing separator by the user
    if (oldValue.text.endsWith(separator) && oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    if (oldValueText != newValueText) {
      String formattedText = '';
      int selectionIndex = newValueText.length;

      // Insert '/' at position 2 (after day) and position 5 (after month)
      for (int i = 0; i < newValueText.length; i++) {
        if (i == 2 || i == 4) {
          formattedText += separator;
        }
        formattedText += newValueText[i];
      }

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(
          offset: formattedText.length - (newValueText.length - selectionIndex),
        ),
      );
    }

    return newValue;
  }
}

class ThousandsFormatter extends TextInputFormatter {
  static const separator = '.'; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is null or empty
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) && oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    if (oldValue.text == '0' && newValueText.isNotEmpty) {
      newValueText = newValueText.substring(1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}

String formatMoney(
  dynamic number, {
  dynamic defaultValue = "",
}) {
  if (number == null) return defaultValue;

  if (number is num) {
    final formatter = NumberFormat("#,###", "id-ID");
    return StringUtils.trimString(formatter.format(number));
  }

  if (number is! String) return defaultValue;

  try {
    final numericValue = double.tryParse(number)?.toInt() ?? 0;
    final formatter = NumberFormat("#,###", "id-ID");
    return StringUtils.trimString(formatter.format(numericValue));
  } catch (e) {
    return defaultValue;
  }
}

String formatMoneyV2(
  dynamic number, {
  dynamic defaultValue = "0",
}) {
  try {
    // Guard clause untuk null atau kosong
    if (number == null || number.toString().trim().isEmpty) {
      return defaultValue;
    }

    // Jika `number` adalah tipe num
    if (number is num) {
      final formatter = NumberFormat("#,###", "id-ID");
      return StringUtils.trimString(formatter.format(number));
    }

    // Jika `number` adalah String
    if (number is String) {
      try {
        final numericValue = double.parse(number);
        final formatter = NumberFormat("#,###", "id-ID");
        return StringUtils.trimString(formatter.format(numericValue));
      } catch (_) {
        // Return defaultValue jika parsing gagal
        return defaultValue;
      }
    }

    // Jika tipe data lain, kembalikan defaultValue
    return defaultValue;
  } catch (_) {
    // Tangani error tidak terduga dengan defaultValue
    return defaultValue;
  }
}

String removeComma(String? value) {
  return StringUtils.trimString(value).toString().replaceAll('.', '');
}

String kdPlatFormater(String? kdPlat) {
  switch (StringUtils.trimString(kdPlat)) {
    case "1":
      return "1 - Hitam";
    case "2":
      return "2 - Merah";
    case "3":
      return "3 - Kuning";
    case "4":
      return "4 - Putih";
    default:
      return "-";
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class AlphabeticInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z *]'), '');

    final int selectionIndex = newText.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class CalendarFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9-]'), '');

    final int selectionIndex = newText.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class SelangHariFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    String oldText = oldValue.text;

    // Extract the numbers and check if they are in the expected format
    RegExp regex = RegExp(r'(\d*)\sTahun\s(\d*)\sBulan\s(\d*)\sHari');
    RegExpMatch? match = regex.firstMatch(newText);
    RegExpMatch? matchOld = regex.firstMatch(oldText);
    if (match != null) {
      // Extract the individual parts
      String years = match.group(1) ?? '0';
      String months = match.group(2) ?? '0';
      String days = match.group(3) ?? '0';
      String yearsOld = matchOld?.group(1) ?? '0';
      String monthsOld = matchOld?.group(2) ?? '0';
      String daysOld = matchOld?.group(3) ?? '0';
      if (years.isEmpty) {
        years = '0';
      }
      if (months.isEmpty) {
        months = '0';
      }
      if (days.isEmpty) {
        days = '0';
      }

      // Remove leading zero if a non-zero digit is added
      if (years.startsWith('0') && years.length > 1) years = years.substring(1);
      if (months.startsWith('0') && months.length > 1) {
        months = months.substring(1);
      }
      if (days.startsWith('0') && days.length > 1) days = days.substring(1);

      if (yearsOld == '0' && years.length > 1) years = years.substring(0, 1);
      if (monthsOld == '0' && months.length > 1) {
        months = months.substring(0, 1);
      }
      if (daysOld == '0' && days.length > 1) days = days.substring(0, 1);

      String formattedText = '$years Tahun $months Bulan $days Hari';

      int monthsValue = int.tryParse(months) ?? 0;
      if (monthsValue > 12) {
        monthsValue = 12;
      }
      months = monthsValue.toString();

      int daysValue = int.tryParse(days) ?? 0;
      if (daysValue > 31) {
        daysValue = 31;
      }
      days = daysValue.toString();

      formattedText = '$years Tahun $months Bulan $days Hari';

      return TextEditingValue(
        text: formattedText,
        selection: newValue.selection,
      );
    } else if (newText.isEmpty) {
      return TextEditingValue(
        text: '0 Tahun 0 Bulan 0 Hari',
        selection: newValue.selection,
      );
    } else {
      return oldValue;
    }
  }
}
