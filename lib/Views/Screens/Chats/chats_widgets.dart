import 'package:banquet/App%20Constants/constants.dart';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSenderMe;

  const MessageBubble(
      {super.key, required this.text, required this.isSenderMe});

  @override
  Widget build(BuildContext context) {
    TextSpan textSpan = TextSpan(
      text: text,
      style: const TextStyle(fontSize: 16.0),
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    double bubbleWidth = textPainter.width + 20;
    double bubbleHeight = textPainter.height + 20;

    return Container(
      width: bubbleWidth,
      height: bubbleHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSenderMe == true
            ? AppColors.secondaryColor
            : AppColors.black.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
