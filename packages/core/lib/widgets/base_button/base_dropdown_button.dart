import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseDropdownButton<T> extends StatefulWidget {
  final String Function(T) itemAsString;
  final List<T>? items;
  final String? label;
  final String? helperMessage;
  final bool? require;
  final bool? isSearch;
  final String? Function(String?)? validator;
  final String? hint;
  final T? value;
  final bool? useBorder;
  final bool? enabled;
  final bool? isExpand;
  final void Function(T?)? onChanged;
  final Function()? onClear;
  final AutovalidateMode? autoValidate;
  final bool? sortItem;
  final Future<List<T>> Function(String)? asyncItem;
  final TextStyle? valueItemStyle;
  final BorderRadius? borderRadius;
  final int? maxLines;

  const BaseDropdownButton(
      {super.key,
      required this.itemAsString,
      this.items,
      this.label,
      this.helperMessage,
      this.require,
      this.hint,
      this.useBorder,
      required this.value,
      this.enabled,
      required this.onChanged,
      this.isSearch,
      this.validator,
      this.onClear,
      this.isExpand,
      this.autoValidate,
      this.sortItem,
      this.asyncItem,
      this.valueItemStyle,
      this.maxLines,
      this.borderRadius = const BorderRadius.all(Radius.circular(8))});

  @override
  State<BaseDropdownButton<T>> createState() => _BaseDropdownButtonState<T>();
}

class _BaseDropdownButtonState<T> extends State<BaseDropdownButton<T>> {
  TextEditingController textController = TextEditingController();
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(true);
  List<T> sortedItems = [];
  @override
  void initState() {
    super.initState();
    sortedItems = widget.items ?? [];
    if (widget.sortItem != false) {
      sortedItems.sort((a, b) => widget.itemAsString(a).compareTo(widget.itemAsString(b)));
    }

    textController.text = widget.value.toString();
    selectedItem = widget.value;
    textController.addListener(_validateInput);
  }

  void _validateInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.validator != null) {
        final isValid = widget.validator!(textController.text) == null;
        if (_isValid.value != isValid) {
          _isValid.value = isValid;
        }
      }
    });
  }

  @override
  void dispose() {
    textController.removeListener(_validateInput);
    _isValid.dispose();
    textController.dispose();
    super.dispose();
  }

  T? selectedItem;

  @override
  Widget build(BuildContext context) {
    selectedItem = widget.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isValid,
          builder: (context, isValid, child) {
            return widget.label != null && widget.label!.isNotEmpty
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: widget.label,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: isValid
                                  ? isDarkMode(context)
                                      ? textHigh
                                      : gray900
                                  : error,
                            ),
                        children: [
                          if (widget.require ?? false)
                            TextSpan(
                              text: ' *',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: error,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
        if (widget.helperMessage != null && widget.helperMessage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              widget.helperMessage!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDarkMode(context) ? textMedium : gray500,
                    height: 1.8,
                  ),
              textHeightBehavior: const TextHeightBehavior(
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
        if (widget.helperMessage == null)
          const SizedBox(
            height: 2.0,
          ),
        DropdownSearch<T>(
          items: sortedItems,
          asyncItems: widget.asyncItem,
          itemAsString: widget.itemAsString,
          selectedItem: selectedItem,
          enabled: widget.enabled ?? true,
          autoValidateMode: widget.autoValidate,
          validator: widget.enabled ?? true
              ? (value) {
                  final error = widget.validator?.call(value?.toString());
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _isValid.value = error == null;
                  });
                  return error;
                }
              : null,
          onChanged: (T? data) {
            setState(() {
              selectedItem = data;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(data);
            }
          },
          clearButtonProps: ClearButtonProps(
            color: red800,
            isVisible: widget.onClear != null,
            onPressed: widget.onClear,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.enabled ?? true
                      ? isDarkMode(context)
                          ? textHigh
                          : gray900
                      : isDarkMode(context)
                          ? mediumEmphasis2
                          : gray600,
                ),
            dropdownSearchDecoration: InputDecoration(
              hintMaxLines: 1,
              helperMaxLines: 1,
              errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: error,
                  ),
              errorMaxLines: 1,
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDarkMode(context) ? mediumEmphasis2 : gray600,
                  ),
              filled: true,
              hoverColor: gray200,
              fillColor: widget.enabled ?? true
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 18,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: error, width: 1),
                borderRadius: widget.borderRadius!,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: green600, width: 1),
                borderRadius: widget.borderRadius!,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.useBorder ?? true
                      ? isDarkMode(context)
                          ? mediumEmphasis
                          : gray300
                      : widget.enabled ?? true
                          ? isDarkMode(context)
                              ? lowEmphasis
                              : neutralWhite
                          : isDarkMode(context)
                              ? mediumEmphasis
                              : neutralWhite,
                  width: 1,
                ),
                borderRadius: widget.borderRadius!,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: error, width: 1),
                borderRadius: widget.borderRadius!,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.useBorder ?? true
                      ? isDarkMode(context)
                          ? lowEmphasis
                          : gray300
                      : widget.enabled ?? true
                          ? isDarkMode(context)
                              ? lowEmphasis
                              : neutralWhite
                          : isDarkMode(context)
                              ? mediumEmphasis
                              : neutralWhite,
                  width: 1,
                ),
                borderRadius: widget.borderRadius!,
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.useBorder ?? true
                      ? isDarkMode(context)
                          ? lowEmphasis
                          : gray300
                      : widget.enabled ?? true
                          ? isDarkMode(context)
                              ? lowEmphasis
                              : neutralWhite
                          : isDarkMode(context)
                              ? mediumEmphasis
                              : neutralWhite,
                  width: 1,
                ),
                borderRadius: widget.borderRadius!,
              ),
              isDense: true,
            ),
          ),
          dropdownBuilder: (context, selectedItem) {
            return selectedItem == null
                ? Text(
                    widget.enabled ?? true ? StringUtils.trimString(widget.hint) : '-',
                    style: widget.valueItemStyle ??
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDarkMode(context) ? textMedium : gray600,
                              height: 1.25,
                            ),
                    textHeightBehavior: const TextHeightBehavior(
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  )
                : Text(
                    widget.itemAsString(selectedItem),
                    style: widget.valueItemStyle ??
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDarkMode(context) ? textHigh : gray900,
                              height: 1.25,
                            ),
                    maxLines: widget.maxLines,
                    textHeightBehavior: const TextHeightBehavior(
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  );
          },
          dropdownButtonProps: DropdownButtonProps(
            tooltip: "Pilih ${widget.label}",
            icon: SvgPicture.asset(
              "assets/icons/chevron/bawah.svg",
              colorFilter: widget.enabled ?? true ? colorFilterGreen600 : colorFilterGray600,
            ),
          ),
          popupProps: PopupProps.menu(
            emptyBuilder: (context, searchEntry) {
              return SingleChildScrollView(
                controller: ScrollController(),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Tidak ada data"),
                  ),
                ),
              );
            },
            fit: FlexFit.loose,
            listViewProps: const ListViewProps(
              padding: EdgeInsets.zero,
            ),
            itemBuilder: (BuildContext context, T item, bool isSelected) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Text(
                  widget.itemAsString(item),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode(context) ? textMedium : gray900,
                      ),
                  softWrap: true,
                ),
              );
            },
            showSearchBox: widget.isSearch ?? true,
            searchDelay: const Duration(milliseconds: 250),
            menuProps: MenuProps(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: widget.borderRadius!,
                side: BorderSide(color: isDarkMode(context) ? mediumEmphasis : blueGray50),
              ),
            ),
            scrollbarProps: ScrollbarProps(
              trackVisibility: true,
              thickness: 8,
              thumbVisibility: true,
              thumbColor: green700,
              radius: const Radius.circular(8),
              trackColor: Theme.of(context).colorScheme.outline,
            ),
            searchFieldProps: TextFieldProps(
              autofocus: true,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDarkMode(context) ? mediumEmphasis2 : gray600,
                    ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SvgPicture.asset(
                    "assets/icons/misc/search.svg",
                    height: 24,
                    width: 24,
                    colorFilter: colorFilterGreen700,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  maxWidth: 50,
                  maxHeight: 50,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: error, width: 1),
                  borderRadius: widget.borderRadius!,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: green600, width: 1),
                  borderRadius: widget.borderRadius!,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.useBorder ?? true
                        ? isDarkMode(context)
                            ? mediumEmphasis
                            : gray300
                        : widget.enabled ?? true
                            ? isDarkMode(context)
                                ? lowEmphasis
                                : neutralWhite
                            : isDarkMode(context)
                                ? mediumEmphasis
                                : neutralWhite,
                    width: 1,
                  ),
                  borderRadius: widget.borderRadius!,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: error, width: 1),
                  borderRadius: widget.borderRadius!,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.useBorder ?? true
                        ? isDarkMode(context)
                            ? lowEmphasis
                            : gray300
                        : widget.enabled ?? true
                            ? isDarkMode(context)
                                ? lowEmphasis
                                : neutralWhite
                            : isDarkMode(context)
                                ? mediumEmphasis
                                : neutralWhite,
                    width: 1,
                  ),
                  borderRadius: widget.borderRadius!,
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.useBorder ?? true
                        ? isDarkMode(context)
                            ? lowEmphasis
                            : gray300
                        : widget.enabled ?? true
                            ? isDarkMode(context)
                                ? lowEmphasis
                                : neutralWhite
                            : isDarkMode(context)
                                ? mediumEmphasis
                                : neutralWhite,
                    width: 1,
                  ),
                  borderRadius: widget.borderRadius!,
                ),
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
