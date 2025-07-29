import 'package:flutter/material.dart';

class BaseCenter extends StatelessWidget {
  final Widget child;

  const BaseCenter({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(),
      ),
      Expanded(
        flex: 2,
        child: child,
      ),
      Expanded(
        child: Container(),
      ),
    ]);
  }
}
