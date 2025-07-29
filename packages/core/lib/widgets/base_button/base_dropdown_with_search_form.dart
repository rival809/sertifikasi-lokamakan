// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BaseDropdownWithSearchForm extends StatefulWidget {
  final List<String>? dropdownOptions;
  final String? dropdownDefaultValue;
  final TextEditingController? textController;
  final Function(String value)? onChangedTextForm;
  final Function(String value)? onChangedDropdown;
  final String? hintText;

  const BaseDropdownWithSearchForm({
    super.key,
    required this.dropdownOptions,
    this.dropdownDefaultValue,
    this.textController,
    this.onChangedTextForm,
    this.onChangedDropdown,
    this.hintText,
  });

  @override
  _BaseDropdownWithSearchFormState createState() =>
      _BaseDropdownWithSearchFormState();
}

class _BaseDropdownWithSearchFormState
    extends State<BaseDropdownWithSearchForm> {
  late String dropdownValue;

  List<DropdownMenuItem<String>>? generateDropdownItems() {
    return widget.dropdownOptions
        ?.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  void initDropdownValue() {
    // not empty exist in dropdownOptions -> set default value
    if (widget.dropdownDefaultValue!.isNotEmpty &&
        widget.dropdownOptions!.contains(widget.dropdownDefaultValue)) {
      dropdownValue = widget.dropdownDefaultValue ?? '';
      return;
    }

    // set default value with first item
    dropdownValue = widget.dropdownOptions!.first;
    return;
  }

  @override
  void initState() {
    super.initState();

    initDropdownValue();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          // Dropdown on the left
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .tertiary, // Background color for dropdown
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
              underline: const SizedBox(), // Remove underline
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });

                widget.onChangedDropdown!(newValue!);
              },
              items: generateDropdownItems(),
            ),
          ),
          // Text field on the right
          Expanded(
            child: TextFormField(
              onChanged: widget.onChangedTextForm,
              controller: widget.textController,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}