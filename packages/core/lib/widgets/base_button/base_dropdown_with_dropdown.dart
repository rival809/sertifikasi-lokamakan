// ignore_for_file: library_private_types_in_public_api

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseDropdownWithSuggestionDropdown extends StatefulWidget {
  final List<String> leftDropdownOptions;
  final String leftDropdownDefaultValue;
  final Function(String value)? onChangedLeftDropdown;

  final Suggestion? suggestionValue;
  final List<Suggestion> suggestionOptions;
  final Function(Suggestion) onChangeSuggestion;

  final String? hintText;
  const BaseDropdownWithSuggestionDropdown({
    super.key,
    required this.leftDropdownOptions,
    required this.leftDropdownDefaultValue,
    required this.onChangedLeftDropdown,
    required this.suggestionValue,
    required this.suggestionOptions,
    required this.onChangeSuggestion,
    this.hintText,
  });

  @override
  _BaseDropdownWithSuggestionDropdownState createState() =>
      _BaseDropdownWithSuggestionDropdownState();
}

class _BaseDropdownWithSuggestionDropdownState
    extends State<BaseDropdownWithSuggestionDropdown> {
  late String dropdownValue;

  List<DropdownMenuItem<String>>? generateDropdownItems() {
    if (widget.leftDropdownOptions.isEmpty) {
      List<DropdownMenuItem<String>> temp = [
        DropdownMenuItem(
          value: widget.leftDropdownDefaultValue,
          child: Text(widget.leftDropdownDefaultValue),
        )
      ];
      return temp;
    }

    return widget.leftDropdownOptions
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  @override
  void initState() {
    dropdownValue = widget.leftDropdownDefaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: Row(
        children: [
          // Dropdown on the left
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            color: Theme.of(context)
                .colorScheme
                .tertiary, // Background color for dropdown
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.primary),
              underline: const SizedBox(), // Remove underline
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });

                widget.onChangedLeftDropdown!(newValue!);
              },
              items: generateDropdownItems(),
            ),
          ),
          Expanded(
            child: BaseDropdownButton(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              useBorder: false,
              asyncItem: (p0) {
                return Future.value(widget.suggestionOptions);
              },
              sortItem: false,
              hint: widget.hintText,
              value: widget.suggestionValue,
              enabled: true,
              onChanged: (p0) {
                widget.onChangeSuggestion(p0 ??
                    const Suggestion(
                      label: '',
                      value: '',
                    ));
              },
              itemAsString: (data) => data.asString(),
            ),
          ),
        ],
      ),
    );
  }
}
