import 'package:core/core.dart';
import 'package:flutter/material.dart';

class HeaderStepper extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<bool> steps;

  const HeaderStepper({
    super.key,
    required this.title,
    this.subtitle,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (subtitle != null) const SizedBox(height: 4),
        if (subtitle != null)
          Text(
            StringUtils.trimString(subtitle),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Get.theme.colorScheme.onSecondary,
                ),
          ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            steps.length,
            (index) {
              final step = steps[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index == steps.length - 1 ? 0 : 8),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: step ? primaryGreen : Get.theme.colorScheme.outline,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
