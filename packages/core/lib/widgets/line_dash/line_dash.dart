import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LineDash extends StatelessWidget {
  final double height;
  final double dashWidth;
  final Color color;
  final bool isUsedOldVersion;

  const LineDash({
    super.key,
    this.height = 1,
    this.dashWidth = 10,
    this.color = Colors.black,
    this.isUsedOldVersion = false,
  });

  @override
  Widget build(BuildContext context) {
    return isUsedOldVersion
        ? Row(
            children: List.generate(
              150 ~/ 3,
              (index) => Expanded(
                child: Container(
                  color: index % 2 == 0 ? Colors.transparent : gray900,
                  height: 1,
                ),
              ),
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              final boxWidth = constraints.constrainWidth();

              if (dashWidth <= 0) {
                return Container();
              }

              final dashCount = (boxWidth / (2 * dashWidth)).floor();

              if (dashCount <= 0) {
                return Container(
                  width: boxWidth,
                  height: height,
                  color: color,
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(dashCount, (_) {
                  return SizedBox(
                    width: dashWidth,
                    height: height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: color),
                    ),
                  );
                }),
              );
            },
          );
  }
}
