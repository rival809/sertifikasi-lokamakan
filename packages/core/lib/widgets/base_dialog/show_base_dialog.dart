import 'package:core/core.dart';
import 'package:core/state_util.dart';
import 'package:flutter/material.dart';

Future showDialogBase({
  required Widget content,
  double? maxWidth,
  bool? barrierDismissible,
  EdgeInsets? insetPadding,
  bool? disableSelectionArea,
}) async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: barrierDismissible ?? false,
    builder: (BuildContext context) {
      return disableSelectionArea == true
          ? AlertDialog(
              insetPadding:
                  insetPadding ?? const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth ?? 450,
                ),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: content,
                ),
              ),
            )
          : SelectionArea(
              child: AlertDialog(
                insetPadding:
                    insetPadding ?? const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                content: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth ?? 450,
                  ),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: content,
                  ),
                ),
              ),
            );
    },
  );
}
