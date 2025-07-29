// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class BasePrefixRupiah extends StatefulWidget {
  const BasePrefixRupiah({
    super.key,
  });

  @override
  State<BasePrefixRupiah> createState() => _BasePrefixRupiahState();
}

class _BasePrefixRupiahState extends State<BasePrefixRupiah> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 12),
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(6),
            topLeft: Radius.circular(6),
          ),
          color: Theme.of(context).colorScheme.outline,
        ),
        child: const Center(
          child: Text("Rp"),
        ),
      ),
    );
  }
}
