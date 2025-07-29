import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ContentDialogKonfirmasi extends StatefulWidget {
  final DialogType dialogType;
  final String titleLabel;
  final String? textDescriptionString;
  final Widget? textDescriptionWidget;
  final String? cancelLabel;
  final String? confirmLabel;
  final Function()? onConfirmCallback;

  const ContentDialogKonfirmasi({
    super.key,
    required this.dialogType,
    required this.titleLabel,
    this.textDescriptionString,
    this.textDescriptionWidget,
    this.cancelLabel,
    this.confirmLabel,
    this.onConfirmCallback,
  });

  @override
  State<ContentDialogKonfirmasi> createState() => _ContentDialogKonfirmasiState();
}

class _ContentDialogKonfirmasiState extends State<ContentDialogKonfirmasi> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(builder: (context) {
              if (widget.dialogType == DialogType.primary) {
                return Text(
                  StringUtils.trimString(widget.titleLabel),
                  style: Theme.of(context).textTheme.displaySmall,
                );
              }

              if (widget.dialogType == DialogType.danger) {
                return Text(
                  StringUtils.trimString(widget.titleLabel),
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
              if (widget.textDescriptionWidget != null) {
                return widget.textDescriptionWidget ?? Container();
              }

              if (widget.textDescriptionString != null) {
                return Text(
                  StringUtils.trimString(widget.textDescriptionString),
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
                    text: widget.cancelLabel ?? "Periksa kembali",
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Builder(builder: (context) {
                  if (widget.dialogType == DialogType.primary) {
                    return Expanded(
                      child: BasePrimaryButton(
                        onPressed: widget.onConfirmCallback,
                        text: widget.confirmLabel ?? "Ya, simpan data",
                      ),
                    );
                  }

                  if (widget.dialogType == DialogType.danger) {
                    return Expanded(
                      child: BaseDangerButton(
                        onPressed: widget.onConfirmCallback,
                        text: widget.confirmLabel ?? "Ya, simpan data",
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
    );
  }
}
