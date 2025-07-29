import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BaseFormSuggestion extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextEditingController textEditingController;
  final Function(String value)? onChanged;
  final Function(Suggestion suggestion)? onSuggestionSelected;
  final List<Suggestion> suggestions;

  const BaseFormSuggestion({
    super.key,
    this.label,
    this.hintText,
    required this.textEditingController,
    this.onChanged,
    this.onSuggestionSelected,
    required this.suggestions,
  });

  @override
  State<BaseFormSuggestion> createState() => _BaseFormSuggestionState();
}

class _BaseFormSuggestionState extends State<BaseFormSuggestion> {
  late TextEditingController _controller;
  List<Suggestion> _filteredSuggestions = [];
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  String _lastText = '';

  @override
  void initState() {
    super.initState();

    _controller = widget.textEditingController;
    _controller.addListener(() {
      if (_controller.text == _lastText) return; // Mencegah pemanggilan jika tidak berubah
      _lastText = _controller.text;

      _filterSuggestions(_controller.text);
      widget.onChanged?.call(_controller.text);
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _filteredSuggestions.clear();
          _removeOverlay();
          update();
        });
      }
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  void _filterSuggestions(String input) {
    if (input.isEmpty) {
      _filteredSuggestions.clear();
      _removeOverlay();
    } else {
      _filteredSuggestions.clear();
      _filteredSuggestions.addAll(
        widget.suggestions.where(
          (item) => item.label.toLowerCase().contains(
                input.toLowerCase(),
              ),
        ),
      );
      _showOverlay();
    }
    update();
  }

  void _showOverlay() {
    _removeOverlay();
    if (_filteredSuggestions.isEmpty || _controller.text.isEmpty) {
      return;
    }

    final renderBox = context.findRenderObject() as RenderBox;
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
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _filteredSuggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _filteredSuggestions[index];
                  return ListTile(
                    title: Text(
                      suggestion.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDarkMode(context) ? mediumEmphasis2 : gray600,
                            height: 1.4,
                          ),
                    ),
                    onTap: () {
                      _controller.text = suggestion.value;
                      _filteredSuggestions = [];
                      _removeOverlay();
                      if (widget.onSuggestionSelected != null) {
                        widget.onSuggestionSelected!(suggestion);
                        _removeOverlay();
                      }
                      update();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
          ],
          Expanded(
            child: TextFormField(
              onChanged: widget.onChanged,
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
