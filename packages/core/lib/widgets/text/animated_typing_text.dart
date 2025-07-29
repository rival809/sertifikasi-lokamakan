// A custom widget to implement typing animation with total duration in seconds
import 'dart:async';

import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final double
      totalDurationInSeconds; // Total duration in seconds for the whole text to be typed

  const TypingText({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign,
    required this.totalDurationInSeconds, // Pass total duration as a double
  });

  @override
  TypingTextState createState() => TypingTextState();
}

class TypingTextState extends State<TypingText> {
  String displayedText = "";
  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTyping();
  }

  void startTyping() {
    // Calculate the typing speed based on the total duration and the text length
    final typingSpeed = (widget.totalDurationInSeconds * 1000) /
        widget.text.length; // milliseconds per character

    timer = Timer.periodic(Duration(milliseconds: typingSpeed.toInt()),
        (Timer timer) {
      if (currentIndex < widget.text.length) {
        setState(() {
          displayedText += widget.text[currentIndex];
          currentIndex++;
        });
      } else {
        // Reset to start the typing animation again (loop)
        setState(() {
          displayedText = "";
          currentIndex = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayedText,
      style: widget.textStyle,
      textAlign: widget.textAlign,
    );
  }
}
