// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool? value)? onChanged;
  final String label;

  const BaseCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  State<BaseCheckbox> createState() => _BaseCheckboxState();
}

class _BaseCheckboxState extends State<BaseCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onChanged == null
          ? null
          : () {
              widget.onChanged?.call(!widget.value);
            },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            activeColor: green600,
            value: widget.value,
            onChanged: widget.onChanged,
          ),
          Expanded(
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isDarkMode(context) ? textHigh : gray900,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
