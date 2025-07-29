import 'package:flutter/material.dart';

class OneData extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool? isElipsisOn;

  const OneData({
    super.key,
    required this.title,
    required this.subtitle,
    this.isElipsisOn,
  });

  @override
  State<OneData> createState() => _OneDataState();
}

class _OneDataState extends State<OneData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isElipsisOn ?? true
              ? Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
          const SizedBox(
            height: 4.0,
          ),
          widget.isElipsisOn ?? true
              ? Text(
                  widget.subtitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  widget.subtitle,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
        ],
      ),
    );
  }
}
