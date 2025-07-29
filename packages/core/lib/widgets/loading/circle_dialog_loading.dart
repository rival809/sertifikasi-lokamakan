import 'package:flutter/material.dart';
import 'package:core/core.dart';

Future showCircleDialogLoading() async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0x00ffffff),
        shadowColor: const Color(0x00ffffff),
        content: SizedBox(
          height: 100,
          width: 100,
          child: CircleAvatar(
            backgroundColor: neutralWhite,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
              strokeWidth: 2.0,
            ),
          ),
        ),
      );
    },
  );
}
