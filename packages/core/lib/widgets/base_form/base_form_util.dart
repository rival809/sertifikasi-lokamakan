import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:intl/intl.dart';

Future<DateTime?> initSelectedDate({
  required BuildContext context,
  required String? initValue,
  DateTime? lastDate,
}) async {
  try {
    DateFormat inputFormat = DateFormat('dd-MM-yyyy');
    DateTime? selectedDate = await showWebDatePicker(
      context: context,
      width: 350,
      initialDate: DateTime.parse(
        StringUtils.checkDate(StringUtils.trimString(initValue)
                .toString()
                .isEmpty
            ? DateTime.now().toString()
            : StringUtils.trimString(inputFormat
                .parse(StringUtils.trimString(initValue?.replaceAll("/", "-")))
                .toString())),
      ),
      firstDate: DateTime(1900),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 6),
    );
    return selectedDate;
  } catch (e) {
    rethrow;
  }
}
