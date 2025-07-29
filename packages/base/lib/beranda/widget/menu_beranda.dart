// ignore_for_file: camel_case_types
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CardMenuBeranda extends StatefulWidget {
  final String prefixSVG;
  final String suffixSVG;
  final String title;
  final String subtitle;
  final Function()? navTo;

  const CardMenuBeranda({
    super.key,
    required this.prefixSVG,
    required this.suffixSVG,
    required this.title,
    required this.subtitle,
    this.navTo,
  });

  @override
  State<CardMenuBeranda> createState() => _CardMenuBerandaState();
}

class _CardMenuBerandaState extends State<CardMenuBeranda> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: widget.navTo,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Image.asset(
                  widget.prefixSVG,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              SvgPicture.asset(
                widget.suffixSVG,
                width: 16,
                height: 16,
                colorFilter: customColorFilter(
                  color: primaryGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
