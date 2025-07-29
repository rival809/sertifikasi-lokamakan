// ignore_for_file: library_private_types_in_public_api

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseDropdownSearchMultiSelect extends StatefulWidget {
  final String hintText;
  final List<String> options;
  final List<String> defaultCheckedOptions;
  final Function(List<String>)? onChangedCallback;

  const BaseDropdownSearchMultiSelect({
    super.key,
    this.hintText = 'Pilih data yang ingin ditampilkan',
    required this.options,
    this.defaultCheckedOptions = const [],
    required this.onChangedCallback,
  });

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<BaseDropdownSearchMultiSelect> {
  List<String> checkedOptions = [];
  List<String> filteredOptions = [];
  bool isDropdownExpanded = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _dropdownOverlay;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredOptions = List.from(widget.options);
    checkedOptions = List.from(widget.defaultCheckedOptions);
    _searchController.addListener(_filterOptions);
  }

  void _filterOptions() {
    setState(() {
      filteredOptions = widget.options
          .where((option) => option
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });

    _updateOverlay();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown(BuildContext context) {
    if (isDropdownExpanded) {
      _removeOverlay();
    } else {
      _showOverlay(context);
    }
    setState(() {
      isDropdownExpanded = !isDropdownExpanded;
    });
  }

  void _showOverlay(BuildContext context) {
    final RenderBox buttonBox =
        context.findRenderObject() as RenderBox; // Get button size and position
    final buttonSize = buttonBox.size;
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);

    // Get screen size
    final screenHeight = MediaQuery.of(context).size.height;
    const dropdownHeight = 250.0; // Increased height to include search box
    double offsetY = buttonSize.height + 5;

    // Check if the dropdown will overflow the screen
    if (buttonPosition.dy + buttonSize.height + dropdownHeight > screenHeight) {
      // If it overflows, show the dropdown above the button
      offsetY = -dropdownHeight - 5;
    }

    _dropdownOverlay = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque, // Ensure taps outside are detected
        onTap: () {
          _removeOverlay(); // Remove the dropdown on outside tap
          setState(() {
            isDropdownExpanded = false;
          });
        },
        child: Stack(
          children: [
            Positioned(
              width: buttonSize.width, // Match the width of the button
              left: buttonPosition.dx,
              top: buttonPosition.dy + offsetY,
              child: Material(
                // elevation: 8.0,
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  height: dropdownHeight,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outline),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    children: [
                      // Search bar
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          autofocus: true,
                          controller: _searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            hintText: "Cari data..",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: gray300),
                            ),
                          ),
                        ),
                      ),
                      // Filtered list
                      Expanded(
                        child: ListView(
                          children: filteredOptions.map(
                            (option) {
                              return CheckboxListTile(
                                activeColor: green600,
                                title: Text(
                                  option,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                ),
                                value: checkedOptions.contains(option),
                                onChanged: (isChecked) {
                                  setState(() {
                                    if (isChecked!) {
                                      checkedOptions.add(option);
                                    } else {
                                      checkedOptions.remove(option);
                                    }
                                  });
                                  widget.onChangedCallback!(checkedOptions);
                                  _updateOverlay();
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_dropdownOverlay!);
  }

  void _removeOverlay() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
  }

  void _updateOverlay() {
    // Instead of removing and reinserting, rebuild the current overlay
    _dropdownOverlay?.markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: () => _toggleDropdown(context),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.outline),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (checkedOptions.isEmpty)
                    Text(
                      widget.hintText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: gray500,
                          ),
                    ),
                  Expanded(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: checkedOptions
                          .map(
                            (filter) => Chip(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.5,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              label: Text(filter),
                              onDeleted: () {
                                setState(() {
                                  checkedOptions.remove(filter);
                                });
                                widget.onChangedCallback!(checkedOptions);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Icon(
                    color: green600,
                    isDropdownExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
