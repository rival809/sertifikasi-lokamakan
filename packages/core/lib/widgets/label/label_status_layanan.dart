// ignore_for_file: camel_case_types

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LabelStatusLayanan extends StatefulWidget {
  final Widget svgPicture;
  final bool isOnline;
  final String title;

  const LabelStatusLayanan(
      {super.key,
      required this.svgPicture,
      required this.isOnline,
      required this.title});

  @override
  State<LabelStatusLayanan> createState() => _LabelStatusLayananState();
}

class _LabelStatusLayananState extends State<LabelStatusLayanan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(18.0),
        ),
        border: Border.all(
          width: 1.0,
          color: Theme.of(context).colorScheme.outline,
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      child: Row(
        children: [
          widget.svgPicture,
          const SizedBox(
            width: 8.0,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: widget.isOnline ? primaryGreen : red500,
                ),
          ),
        ],
      ),
    );
  }
}
