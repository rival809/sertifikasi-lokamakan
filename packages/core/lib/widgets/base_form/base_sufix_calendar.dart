// ignore_for_file: camel_case_types
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseSufixCalendar extends StatefulWidget {
  final Function()? onTapClose;
  const BaseSufixCalendar({
    super.key,
    this.onTapClose,
  });

  @override
  State<BaseSufixCalendar> createState() => _BaseSufixCalendarState();
}

class _BaseSufixCalendarState extends State<BaseSufixCalendar> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        children: [
          InkWell(
            onTap: widget.onTapClose,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SvgPicture.asset(
                MediaRes.icons.misc.close,
                colorFilter: colorFilterRed800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              MediaRes.icons.misc.calendarMonth,
              colorFilter: colorFilterGreen700,
            ),
          )
        ],
      ),
    );
  }
}
