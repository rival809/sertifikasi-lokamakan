import 'package:flutter/material.dart';

class CardLabel extends StatelessWidget {
  final Color cardBorderColor;
  final Color cardColor;
  final String cardTitle;
  final Color cardTitleColor;
  final double width;
  const CardLabel(
      {super.key,
      required this.cardColor,
      required this.cardTitle,
      required this.cardTitleColor,
      required this.cardBorderColor,
      this.width = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            18.0,
          ),
        ),
        border: Border.all(color: cardBorderColor),
      ),
      child: SizedBox(
        width: width,
        child: Text(
          cardTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: cardTitleColor),
        ),
      ),
    );
  }
}
