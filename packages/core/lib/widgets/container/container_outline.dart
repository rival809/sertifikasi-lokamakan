import 'package:flutter/widgets.dart';

class ContainerOutline extends StatefulWidget {
  final Widget childWidget;
  final double? sizeBorderRadius;
  final double? paddingContent;
  const ContainerOutline(
      {super.key,
      required this.childWidget,
      this.sizeBorderRadius,
      this.paddingContent});

  @override
  State<ContainerOutline> createState() => _ContainerOutlineState();
}

class _ContainerOutlineState extends State<ContainerOutline> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.sizeBorderRadius ?? 12),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.all(widget.paddingContent ?? 24),
          child: widget.childWidget),
    );
  }
}
