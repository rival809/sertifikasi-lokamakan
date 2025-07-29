// ignore_for_file: library_private_types_in_public_api

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseDropdownWithSearchFormV3 extends StatefulWidget {
  final List<String>? dropdownOptions;
  final String? dropdownDefaultValue;
  final TextEditingController textController;
  final Function(String value)? onChangedTextForm;
  final Function(Suggestion suggestion)? onSuggestionSelected;
  final List<Suggestion>? suggestionOptions;
  final Function(String value)? onChangedDropdown;
  final String? hintText;

  const BaseDropdownWithSearchFormV3({
    super.key,
    required this.dropdownOptions,
    this.dropdownDefaultValue,
    required this.textController,
    this.onChangedTextForm,
    this.onChangedDropdown,
    this.onSuggestionSelected,
    this.suggestionOptions,
    this.hintText,
  });

  @override
  _BaseDropdownWithSearchFormV3State createState() =>
      _BaseDropdownWithSearchFormV3State();
}

class _BaseDropdownWithSearchFormV3State
    extends State<BaseDropdownWithSearchFormV3> {
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

  void update() {
    if (mounted) {
      setState(() {});
    }
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
                dropdownValue = newValue!;
                update();

                widget.onChangedDropdown!(newValue);
              },
              items: generateDropdownItems(),
            ),
          ),
          // Text field on the right
          Expanded(
            child: BaseFormSuggestion(
              hintText: widget.hintText,
              onChanged: widget.onChangedTextForm,
              textEditingController: widget.textController,
              onSuggestionSelected: widget.onSuggestionSelected,
              suggestions: widget.suggestionOptions ?? [],
            ),
          ),
        ],
      ),
    );
  }
}
