import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final double radiusCircular;

  const BaseCard({
    super.key,
    required this.child,
    this.radiusCircular = 16.0, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusCircular),
        ),
        side: BorderSide(
          width: 1,
          color: isDarkMode(context) ? mediumEmphasis : blueGray50,
        ),
      ),
      child: child,
    );
  }
}
