// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class RowData extends StatefulWidget {
  final String titleLeft;
  final String subtitleLeft;
  final String titleRight;
  final String subtitleRight;

  const RowData({
    super.key,
    required this.titleLeft,
    required this.subtitleLeft,
    required this.titleRight,
    required this.subtitleRight,
  });

  @override
  State<RowData> createState() => _RowDataState();
}

class _RowDataState extends State<RowData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.titleLeft,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleLeft,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.titleRight,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleRight,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ],
    );
  }
}
