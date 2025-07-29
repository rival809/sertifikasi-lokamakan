import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseDropdownCheckbox extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  const BaseDropdownCheckbox(
      {super.key, required this.items, required this.selectedItems});

  @override
  State<BaseDropdownCheckbox> createState() => _BaseDropdownCheckboxState();
}

class _BaseDropdownCheckboxState extends State<BaseDropdownCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        border:
            Border.all(color: isDarkMode(context) ? mediumEmphasis : gray300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text('Pilih Data Yang Ingin Ditampilkan',
              style: Theme.of(context).textTheme.bodyMedium),
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              enabled: true,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  final isSelected = widget.selectedItems.contains(item);
                  return InkWell(
                    onTap: () {
                      isSelected
                          ? widget.selectedItems.remove(item)
                          : widget.selectedItems.add(item);
                      setState(() {});
                      menuSetState(() {});
                    },
                    child: Row(
                      children: [
                        if (isSelected)
                          Row(
                            children: [
                              Checkbox(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return primaryGreen;
                                    }
                                    return primaryGreen;
                                  }),
                                  value: true,
                                  onChanged: null,
                                  activeColor: primaryGreen),
                              const SizedBox(width: 8),
                              Text(item,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ],
                          )
                        else
                          Row(
                            children: [
                              const Checkbox(
                                  value: false,
                                  onChanged: null,
                                  activeColor: primaryGreen),
                              const SizedBox(width: 8),
                              Text(item,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          )
                      ],
                    ),
                  );
                },
              ),
            );
          }).toList(),
          value:
              widget.selectedItems.isEmpty ? null : widget.selectedItems.last,
          onChanged: (value) {},
          selectedItemBuilder: (context) {
            return widget.items.map(
              (item) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(widget.selectedItems.join(', '),
                      style: Theme.of(context).textTheme.bodyMedium),
                );
              },
            ).toList();
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
