import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseExpansionTile extends StatefulWidget {
  final String? leadingIcon;
  final String title;
  final Widget children;
  final EdgeInsetsGeometry? padding;
  final bool? initiallyExpanded;

  const BaseExpansionTile({
    super.key,
    this.leadingIcon,
    required this.title,
    required this.children,
    this.padding,
    this.initiallyExpanded,
  });

  @override
  State<BaseExpansionTile> createState() => _BaseExpansionTileState();
}

class _BaseExpansionTileState extends State<BaseExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: ListTileTheme(
        minLeadingWidth: 0,
        child: ExpansionTile(
          iconColor: primaryGreen,
          initiallyExpanded: widget.initiallyExpanded ?? false,
          shape: Border.all(color: Colors.transparent),
          collapsedIconColor: primaryGreen,
          leading: widget.leadingIcon == null
              ? null
              : SvgPicture.asset(
                  widget.leadingIcon ?? "",
                ),
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            Padding(
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 16.0),
              child: widget.children,
            )
          ],
        ),
      ),
    );
  }
}
