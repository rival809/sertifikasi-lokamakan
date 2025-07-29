import 'package:core/core.dart';
import 'package:flutter/material.dart';

Future showInfoDialog(String message) async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: SelectionArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Text(
                      'Info',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: green700,
                              ),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: isDarkModeCheck(context,
                            darkModeValue: null, lightModeValue: gray50),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(
                            8,
                          ),
                          bottomRight: Radius.circular(
                            8,
                          ),
                        )),
                    child: BasePrimaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: "OK",
                    ),
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
