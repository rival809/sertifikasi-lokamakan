import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseDropdownSearch extends StatefulWidget {
  final List<String> items;
  final String? label;
  final String? helperMessage;
  final bool? require;
  final bool? isSearch;
  final String? Function(String?)? validator;
  final String hint;
  final String? value;
  final bool? useBorder;
  final bool? enabled;
  final bool? isExpand;
  final Function(String? value) onChanged;
  final Function()? onClear;
  final AutovalidateMode? autoValidate;
  final double? height;

  const BaseDropdownSearch({
    super.key,
    required this.items,
    this.label,
    this.helperMessage,
    this.require,
    required this.hint,
    this.useBorder,
    required this.value,
    this.enabled,
    required this.onChanged,
    this.isSearch,
    this.validator,
    this.onClear,
    this.autoValidate,
    this.isExpand,
    this.height,
  });

  @override
  State<BaseDropdownSearch> createState() => _DropdownSearchBase();
}

class _DropdownSearchBase extends State<BaseDropdownSearch> {
  TextEditingController textController = TextEditingController();
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    textController.text = widget.value ?? '';
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

  @override
  Widget build(BuildContext context) {
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
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
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
        if (widget.label != null && widget.label!.isNotEmpty)
          const SizedBox(height: 2.0),
        DropdownSearch(
          validator: widget.enabled ?? true
              ? (value) {
                  final error = widget.validator?.call(value?.toString());
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _isValid.value = error == null;
                  });
                  return error;
                }
              : null,
          onChanged: widget.enabled ?? true ? widget.onChanged : null,
          items: widget.items,
          enabled: widget.enabled ?? true,
          clearButtonProps: ClearButtonProps(
            isVisible: widget.onClear != null ? true : false,
            color: red400,
            icon: const Icon(
              Icons.close,
            ),
            onPressed: widget.onClear,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.25,
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
                    color: isDarkMode(context) ? textMedium : gray600,
                  ),
              filled: true,
              hoverColor: gray200,
              fillColor: widget.enabled ?? true
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical:
                    widget.height != null ? (widget.height! - 33) / 2 : 16.5,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: green600, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
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
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
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
                borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              isDense: true,
            ),
          ),
          dropdownButtonProps: DropdownButtonProps(
            tooltip: "Pilih ${widget.label}",
            icon: SvgPicture.asset(
              "assets/icons/chevron/bawah.svg",
              colorFilter: widget.enabled ?? true
                  ? colorFilterGreen600
                  : colorFilterGray600,
            ),
          ),
          selectedItem: widget.value,
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            listViewProps: const ListViewProps(
                // itemExtent: 32,
                ),
            itemBuilder: (BuildContext context, String item, bool isSelected) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode(context) ? textMedium : gray600,
                        height: 1.25,
                      ),
                ),
              );
            },
            showSearchBox: widget.isSearch ?? true,
            searchDelay: const Duration(milliseconds: 250),
            menuProps: MenuProps(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(
                    color: isDarkMode(context) ? mediumEmphasis : blueGray50),
              ),
            ),
            scrollbarProps: const ScrollbarProps(),
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
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: error, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: green600, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: error, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
