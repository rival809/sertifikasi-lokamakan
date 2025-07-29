import 'package:flutter/material.dart';

class BodyBackground extends StatefulWidget {
  final Widget childWidget;
  const BodyBackground({super.key, required this.childWidget});

  @override
  State<BodyBackground> createState() => _BodyBackgroundState();
}

class _BodyBackgroundState extends State<BodyBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Theme.of(context).colorScheme.background,
      child: widget.childWidget,
    );
  }
}
