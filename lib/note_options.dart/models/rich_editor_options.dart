import 'package:flutter/material.dart';

import 'enum/bar_position.dart';

class RichEditorOptions {
  Color? backgroundColor;
  Color? baseTextColor;
  EdgeInsets? padding;
  String? placeholder;
  String? baseFontFamily;
  BarPosition? barPosition;
  bool? enableVoice;

  RichEditorOptions({
    Color? backgroundColor,
    Color? baseTextColor,
    EdgeInsets? padding,
    String? placeholder,
    String? baseFontFamily,
    BarPosition? barPosition,
    bool? enableVoice = true,
  }) {
    this.backgroundColor = backgroundColor;
    this.baseTextColor = baseTextColor;
    this.padding = padding;
    this.placeholder = placeholder;
    this.baseFontFamily = baseFontFamily;
    this.barPosition = barPosition;
    this.enableVoice = enableVoice;
  }
}
