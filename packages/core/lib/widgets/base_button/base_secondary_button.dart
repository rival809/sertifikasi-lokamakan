import 'package:flutter/material.dart';
import 'package:core/core.dart';

class BaseSecondaryButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isDense;

  const BaseSecondaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense,
  });

  @override
  State<BaseSecondaryButton> createState() => _BaseSecondaryButtonState();
}

class _BaseSecondaryButtonState extends State<BaseSecondaryButton> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    Color textColor = widget.onPressed != null
        ? onHover
            ? Theme.of(context).primaryColorDark
            : Theme.of(context).primaryColor
        : Theme.of(context).disabledColor;

    return SizedBox(
      width: widget.isDense ?? false ? null : MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.surface,
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: widget.onPressed != null
                  ? onHover
                      ? Theme.of(context).primaryColorDark
                      : Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
              onHover ? Theme.of(context).hoverColor : Colors.transparent),
        ),
        onFocusChange: (value) {
          setState(
            () {
              onHover = value;
            },
          );
        },
        onHover: (value) {
          setState(
            () {
              onHover = value;
            },
          );
        },
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
                          color: textColor,
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
                              color: textColor,
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
                          color: textColor,
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
