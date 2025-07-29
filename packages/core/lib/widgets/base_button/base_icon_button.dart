import 'package:flutter/material.dart';
import 'package:core/core.dart';

class BaseIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String iconAsset;
  final double? size;
  final bool? isDisabled;

  const BaseIconButton({
    super.key,
    required this.onPressed,
    required this.iconAsset,
    this.size,
    this.isDisabled,
  });

  @override
  State<BaseIconButton> createState() => _BaseIconButtonState();
}

class _BaseIconButtonState extends State<BaseIconButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !(widget.isDisabled ?? false);

    final ColorFilter colorFilter = isEnabled
        ? isHovering
            ? colorFilterGreen900
            : colorFilterGreen700
        : colorFilterGray400;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: Material(
        color: Colors.transparent, // Agar ripple tidak punya latar belakang
        shape: const CircleBorder(), // Untuk bentuk ripple bundar (opsional)
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: isEnabled ? widget.onPressed : null,
          splashColor: green100.withOpacity(0.3), // Warna ripple
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Area sentuh lebih besar
            child: SvgPicture.asset(
              widget.iconAsset,
              width: widget.size ?? 24,
              height: widget.size ?? 24,
              colorFilter: colorFilter,
            ),
          ),
        ),
      ),
    );
  }
}
