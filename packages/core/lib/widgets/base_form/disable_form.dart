import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DisableForm extends StatefulWidget {
  final String titleForm, initialValue;

  const DisableForm({
    super.key,
    required this.titleForm,
    required this.initialValue,
  });

  @override
  State<DisableForm> createState() => _DisableFormState();
}

class _DisableFormState extends State<DisableForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BaseForm(
        label: widget.titleForm,
        enabled: false,
        onChanged: (value) {},
        initialValue: widget.initialValue,
      ),
    );
  }
}
