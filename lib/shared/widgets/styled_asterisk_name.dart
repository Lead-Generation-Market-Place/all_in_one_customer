import 'package:flutter/material.dart';

List<TextSpan> StyledAsteriskName(String name, TextStyle? style) {
  return name.split(' ').expand((word) {
    if (word.length <= 2) {
      return [
        TextSpan(text: word[0], style: style),
        TextSpan(
          text: '*' * (word.length - 1),
          style: style?.copyWith(color: Colors.grey),
        ),
      ];
    } else {
      return [
        TextSpan(text: word.substring(0, word.length - 2), style: style),
        TextSpan(
          text: '**',
          style: style?.copyWith(color: Colors.grey),
        ),
        const TextSpan(text: ' '), // space between words
      ];
    }
  }).toList();
}
