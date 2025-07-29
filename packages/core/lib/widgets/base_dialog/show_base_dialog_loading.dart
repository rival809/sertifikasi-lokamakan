import 'dart:async'; // For Timer
import 'package:core/core.dart'; // Adjust the import if needed
import 'package:core/widgets/text/animated_typing_text.dart';
import 'package:flutter/material.dart';

Future showDialogLoading({
  required BuildContext context,
  String? textTittle,
  required String illustration,
  required String textDescription,
  String? animateTextDescription,
  double? maxWidth,
  double? minWidth,
  bool? barrierDismissible,
  double delayTime = 2,
  Alignment? alignmentTitle,
  Future<void> Function()? onFutureComplete, // Add this parameter
}) async {
  // Create a Completer to handle when the dialog should be dismissed
  final completer = Completer<void>();

  // Show the dialog
  showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible ?? false,
    builder: (BuildContext context) {
      // Check if the dialog is still visible before updating UI
      if (Navigator.canPop(context)) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: minWidth ?? 450,
              maxWidth: maxWidth ?? 450,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    textTittle == null
                        ? Container()
                        : Align(
                            alignment: alignmentTitle ?? Alignment.center,
                            child: Text(
                              StringUtils.trimString(textTittle),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: primaryGreen,
                                    height: 1.75,
                                  ),
                              textHeightBehavior: const TextHeightBehavior(
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ),
                    textTittle == null
                        ? Container()
                        : const SizedBox(
                            height: 16.0,
                          ),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor:
                          isDarkMode(context) ? lowEmphasis : gray100,
                      child: SvgPicture.asset(
                        illustration,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringUtils.trimString(textDescription),
                          style: Theme.of(context).textTheme.bodyLarge,
                          textHeightBehavior: const TextHeightBehavior(
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        animateTextDescription == null
                            ? Container()
                            : TypingText(
                                text: StringUtils.trimString(
                                    animateTextDescription),
                                totalDurationInSeconds: delayTime,
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    },
  );

  // Wait for the future operation to complete, if provided
  if (onFutureComplete != null) {
    await onFutureComplete();
  }

  // Complete the completer after the future operation
  completer.complete();
  return completer.future;
}
