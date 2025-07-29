// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class BasePrimaryButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isDense;
  final double? height;

  const BasePrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense,
    this.height,
  });

  @override
  State<BasePrimaryButton> createState() => _BasePrimaryButtonState();
}

class _BasePrimaryButtonState extends State<BasePrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.isDense ?? false ? null : MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          backgroundColor: widget.onPressed != null
              ? MaterialStatePropertyAll(Theme.of(context).primaryColor)
              : MaterialStatePropertyAll(Theme.of(context).disabledColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
              Theme.of(context).primaryColorDark),
        ),
        onPressed: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.prefixIcon != null
                    ? IconTheme(
                        data: IconThemeData(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: widget.prefixIcon!,
                      )
                    : Container(),
                widget.prefixIcon != null &&
                        StringUtils.trimString(widget.text).isNotEmpty
                    ? const SizedBox(
                        width: 8.0,
                      )
                    : Container(),
                StringUtils.trimString(widget.text).isNotEmpty
                    ? Text(
                        StringUtils.trimString(widget.text),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              height: 1.75,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                        textHeightBehavior: const TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      )
                    : Container(),
                widget.suffixIcon != null &&
                        StringUtils.trimString(widget.text).isNotEmpty
                    ? const SizedBox(
                        width: 8.0,
                      )
                    : Container(),
                widget.suffixIcon != null
                    ? IconTheme(
                        data: IconThemeData(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: widget.suffixIcon!,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
