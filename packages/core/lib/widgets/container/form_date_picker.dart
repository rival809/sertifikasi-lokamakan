import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormDatePickerInput extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final TextEditingController? textEditingController;
  final Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool? enabled;
  final List<TextInputFormatter>? formatDatePicker;
  final bool? autoFocus;
  final AutovalidateMode? autoValidate;
  final int? maxLength;
  final TextStyle? textStyle;
  final Function()? onEditingComplete;

  const FormDatePickerInput({
    super.key,
    this.hintText,
    this.initialValue,
    this.formatDatePicker,
    required this.textStyle,
    this.textEditingController,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.enabled,
    this.autoFocus,
    this.autoValidate,
    this.maxLength,
    this.onEditingComplete,
  });

  @override
  State<FormDatePickerInput> createState() => _FormDatePickerInputState();
}

class _FormDatePickerInputState extends State<FormDatePickerInput> {
  final _isValid = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    widget.textEditingController?.addListener(_validateInput);
  }

  void _validateInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.validator != null && widget.autoValidate != null) {
        final isValid = widget.validator!(widget.textEditingController != null
                ? widget.textEditingController?.text
                : widget.initialValue) ==
            null;
        if (_isValid.value != isValid) {
          _isValid.value = isValid;
        }
      }
    });
  }

  @override
  void dispose() {
    widget.textEditingController?.removeListener(_validateInput);
    _isValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus ?? false,
      textAlign: TextAlign.center,
      cursorColor: Theme.of(context).colorScheme.primary,
      keyboardType: TextInputType.number,
      inputFormatters:
          widget.formatDatePicker ?? [FilteringTextInputFormatter.digitsOnly],
      maxLength: widget.maxLength,
      style: widget.textStyle?.copyWith(
        color: widget.enabled ?? true
            ? Theme.of(context).colorScheme.onBackground
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        counterText: '',
        border: InputBorder.none,
        hintStyle: widget.textStyle?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
        errorStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.error),
      ),
      autovalidateMode: widget.autoValidate,
      enabled: widget.enabled,
      validator: widget.validator != null
          ? (value) {
              final error = widget.validator?.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final isValid = error == null;
                if (_isValid.value != isValid) {
                  _isValid.value = isValid;
                }
              });
              return error;
            }
          : null,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
