import 'package:core/core.dart';
import 'package:core/widgets/container/form_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContainerDatepicker extends StatefulWidget {
  final String label;
  final FocusNode focusNodeDD;
  final FocusNode focusNodeMM;
  final FocusNode focusNodeYYYY;
  final Function(String) onChangedDD;
  final Function(String) onChangedMM;
  final Function(String) onChangedYYYY;
  final TextEditingController? controllerDD;
  final TextEditingController? controllerMM;
  final TextEditingController? controllerYYYY;
  final Function()? onEditingComplete;

  const ContainerDatepicker({
    super.key,
    required this.label,
    required this.focusNodeDD,
    required this.focusNodeMM,
    required this.focusNodeYYYY,
    required this.onChangedDD,
    required this.onChangedMM,
    required this.onChangedYYYY,
    this.onEditingComplete,
    this.controllerDD,
    this.controllerMM,
    this.controllerYYYY,
  });

  @override
  State<ContainerDatepicker> createState() => _ContainerDatepickerState();
}

class _ContainerDatepickerState extends State<ContainerDatepicker> {
  List<TextInputFormatter> _getDayInputFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(2),
      TextInputFormatter.withFunction((oldValue, newValue) {
        if (newValue.text.isNotEmpty) {
          final day = int.tryParse(newValue.text);
          if (day != null && (day < 1 || day > 31)) {
            return oldValue; // Reject the input if day exceeds the limit
          }
        }
        return newValue;
      }),
    ];
  }

  List<TextInputFormatter> _getMonthInputFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(2),
      TextInputFormatter.withFunction((oldValue, newValue) {
        if (newValue.text.isNotEmpty) {
          final month = int.tryParse(newValue.text);
          if (month != null && (month < 1 || month > 12)) {
            return oldValue; // Reject the input if month exceeds the limit
          }
        }
        return newValue;
      }),
    ];
  }

  List<TextInputFormatter> _getYearInputFormatters() {
    final currentYear = DateTime.now().year;
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(4),
      TextInputFormatter.withFunction((oldValue, newValue) {
        if (newValue.text.isNotEmpty) {
          final year = int.tryParse(newValue.text);
          if (year != null && year > currentYear) {
            return oldValue; // Reject the input if year exceeds the current year
          }
        }
        return newValue;
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              color: Get.theme.colorScheme.outline,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: FormDatePickerInput(
                    textStyle: Get.theme.textTheme.displayLarge,
                    textEditingController: widget.controllerDD,
                    focusNode: widget.focusNodeDD,
                    maxLength: 2,
                    hintText: "DD",
                    onChanged: widget.onChangedDD,
                    formatDatePicker: _getDayInputFormatters(),
                    onEditingComplete: widget.onEditingComplete,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  "-",
                  style: Get.theme.textTheme.displayLarge,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: FormDatePickerInput(
                    textStyle: Get.theme.textTheme.displayLarge,
                    textEditingController: widget.controllerMM,
                    focusNode: widget.focusNodeMM,
                    maxLength: 2,
                    hintText: "MM",
                    onChanged: widget.onChangedMM,
                    formatDatePicker: _getMonthInputFormatters(),
                    onEditingComplete: widget.onEditingComplete,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  "-",
                  style: Get.theme.textTheme.displayLarge,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: FormDatePickerInput(
                    textStyle: Get.theme.textTheme.displayLarge,
                    textEditingController: widget.controllerYYYY,
                    focusNode: widget.focusNodeYYYY,
                    maxLength: 4,
                    hintText: "YYYY",
                    onChanged: widget.onChangedYYYY,
                    formatDatePicker: _getYearInputFormatters(),
                    onEditingComplete: widget.onEditingComplete,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                SvgPicture.asset(
                  MediaRes.icons.input.calendarMonth,
                  colorFilter: const ColorFilter.mode(
                    green700,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
