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

  static stringDouble(String? string) {
    var value = "";
    try {
      value = double.parse(string ?? "0").toInt().toString();
      return trimString(value);
    } catch (e) {
      return value;
    }
  }

  static String capitalizeEachWord(String text) {
    return text
        .split(" ")
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : "")
        .join(" ");
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

  static checkModel(dynamic data) {
    if (data == null) return null;
    if (data.runtimeType == String) return data;
    if (data.runtimeType == bool) return data;
    if (data.runtimeType == double) return data;

    return data.toString();
  }

  static List<T?> createNullList<T>(int length) {
    return List<T?>.filled(length, null, growable: false);
  }

  static int calcStringNumber(List<dynamic> items) {
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
}
