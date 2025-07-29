import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ContentDialogSelesai extends StatefulWidget {
  final String illustration;
  final String title;
  final String? textButton;
  final Function()? onPressed;
  final String? description;

  const ContentDialogSelesai(
      {super.key,
      required this.illustration,
      required this.title,
      this.textButton,
      this.onPressed,
      this.description});

  @override
  State<ContentDialogSelesai> createState() => _ContentDialogSelesaiState();
}

class _ContentDialogSelesaiState extends State<ContentDialogSelesai> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: isDarkMode(context) ? lowEmphasis : gray100,
              child: SvgPicture.asset(
                widget.illustration,
                width: 100,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            if (widget.description != null)
              const SizedBox(
                height: 16.0,
              ),
            if (widget.description != null)
              Text(
                StringUtils.trimString(widget.description),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            if (widget.onPressed != null)
              const SizedBox(
                height: 24.0,
              ),
            if (widget.onPressed != null)
              BasePrimaryButton(
                onPressed: widget.onPressed,
                text: widget.textButton ?? "Ya, saya mengerti",
              )
          ],
        ),
      ),
    );
  }
}
