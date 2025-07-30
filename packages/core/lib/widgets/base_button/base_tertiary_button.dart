import 'package:flutter/material.dart';
import 'package:core/core.dart';

class BaseTertiaryButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isDense;

  const BaseTertiaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense,
  });

  @override
  State<BaseTertiaryButton> createState() => _BaseTertiaryButtonState();
}

class _BaseTertiaryButtonState extends State<BaseTertiaryButton> {
  bool onHover = false;

  Color generateTextColor() {
    if (widget.onPressed == null) return Theme.of(context).disabledColor;

    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = generateTextColor();

    return SizedBox(
      width: widget.isDense ?? false ? null : MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: MaterialStateProperty.all<Color>(
              onHover ? Theme.of(context).hoverColor : Colors.transparent),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: widget.onPressed != null
                  ? Colors.transparent
                  : Colors.transparent,
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
              onHover ? Theme.of(context).hoverColor : Colors.transparent),
        ),
        onFocusChange: (value) {
          onHover = value;
          update();
        },
        onHover: (value) {
          onHover = value;
          update();
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
                              color: textColor,
                              height: 1.75,
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
