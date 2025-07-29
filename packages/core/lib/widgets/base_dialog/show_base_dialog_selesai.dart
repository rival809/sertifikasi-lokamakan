import 'package:core/core.dart';
import 'package:flutter/material.dart';

Future showDialogSelesai({
  required String illustration,
  required String textDescription,
  String? textButton,
  Function()? onPressed,
  double? maxWidth,
  bool? barrierDismissible,
  String? textDescription2,
  TextAlign? textDescriptionAlign,
}) async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: barrierDismissible ?? false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? 450,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(87.0),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: SvgPicture.asset(
                      illustration,
                      width: 52,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    StringUtils.trimString(textDescription),
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: textDescriptionAlign ?? TextAlign.start,
                    textHeightBehavior: const TextHeightBehavior(
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  if (textDescription2 != null)
                    const SizedBox(
                      height: 16.0,
                    ),
                  if (textDescription2 != null)
                    Text(
                      StringUtils.trimString(textDescription2),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                      textAlign: textDescriptionAlign ?? TextAlign.start,
                      textHeightBehavior: const TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BasePrimaryButton(
                    onPressed: onPressed,
                    text: textButton ?? "Ya, saya mengerti",
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
