import 'package:core/core.dart';
import 'package:flutter/material.dart';

Future showDialogConfirm({
  required DialogType dialogType,
  required String titleLabel,
  String? textDescriptionString,
  Widget? textDescriptionWidget,
  String? cancelLabel,
  String? confirmLabel,
  Function()? onConfirmCallback,
  double? maxWidth,
  bool? barrierDismissible,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    if (dialogType == DialogType.primary) {
                      return Text(
                        StringUtils.trimString(titleLabel),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: green600,
                            ),
                      );
                    }

                    if (dialogType == DialogType.danger) {
                      return Text(
                        StringUtils.trimString(titleLabel),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: red600,
                            ),
                      );
                    }

                    return const SizedBox.shrink();
                  }),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Builder(builder: (context) {
                    if (textDescriptionWidget != null) {
                      return textDescriptionWidget;
                    }

                    if (textDescriptionString != null) {
                      return Text(
                        StringUtils.trimString(textDescriptionString),
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
                    }

                    return const SizedBox.shrink();
                  }),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BaseSecondaryButton(
                          onPressed: () {
                            context.pop();
                          },
                          text: cancelLabel ?? "Periksa kembali",
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Builder(builder: (context) {
                        if (dialogType == DialogType.primary) {
                          return Expanded(
                            child: BasePrimaryButton(
                              onPressed: onConfirmCallback,
                              text: confirmLabel ?? "Ya, simpan data",
                            ),
                          );
                        }

                        if (dialogType == DialogType.danger) {
                          return Expanded(
                            child: BaseDangerButton(
                              onPressed: onConfirmCallback,
                              text: confirmLabel ?? "Ya, simpan data",
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
