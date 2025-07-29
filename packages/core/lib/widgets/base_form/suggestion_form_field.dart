// ignore_for_file: library_private_types_in_public_api

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class Suggestion {
  final String label;
  final String value;

  const Suggestion({
    required this.label,
    required this.value,
  });

  String asString() {
    return label;
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}

class SuggestionFormField extends StatefulWidget {
  final List<Suggestion> suggestions;
  final String labelText;
  final Function(Suggestion)? onSuggestionSelected;
  final TextEditingController textController;
  final InputDecoration? decoration;
  final double? maxHeight;
  final double? itemHeight;
  final Widget Function(BuildContext, Suggestion)? suggestionBuilder;

  const SuggestionFormField({
    super.key,
    required this.suggestions,
    required this.textController,
    required this.onSuggestionSelected,
    this.labelText = 'Enter text',
    this.decoration,
    this.maxHeight = 200.0,
    this.itemHeight = 50.0,
    this.suggestionBuilder,
  });

  @override
  SuggestionFormFieldState createState() => SuggestionFormFieldState();
}

class SuggestionFormFieldState extends State<SuggestionFormField> {
  List<Suggestion> filteredSuggestions = [];
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () {
          filteredSuggestions.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: widget.textController,
        focusNode: _focusNode,
        decoration: widget.decoration ??
            InputDecoration(
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
        onChanged: (value) {
          if (value.length < 3) {
            return;
          }

          filteredSuggestions = widget.suggestions
              .where((suggestion) => suggestion.label.toLowerCase().contains(value.toLowerCase()))
              .toList();

          _updateOverlay();
        },
      ),
    );
  }

  void _updateOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (filteredSuggestions.isEmpty || widget.textController.text.isEmpty) {
      return;
    }

    final renderBox = context.findRenderObject() as RenderBox;
    if (!renderBox.hasSize) return;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.maxHeight ?? 200,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: StaggeredGrid.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  children: filteredSuggestions.map((suggestion) {
                    if (widget.suggestionBuilder != null) {
                      return InkWell(
                        onTap: () => _onSuggestionSelected(suggestion),
                        child: widget.suggestionBuilder!(context, suggestion),
                      );
                    }
                    return ListTile(
                      title: Text(
                        suggestion.label,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () => _onSuggestionSelected(suggestion),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (mounted) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _onSuggestionSelected(Suggestion suggestion) {
    widget.textController.text = suggestion.label;

    if (widget.onSuggestionSelected != null) {
      widget.onSuggestionSelected!(suggestion);
    }

    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _focusNode.dispose();
    super.dispose();
  }
}
