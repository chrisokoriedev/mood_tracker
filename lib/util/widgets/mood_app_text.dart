import 'package:flutter/material.dart';

enum MoodTextVariant { header, normal, small }

class KMoodText extends StatelessWidget {
  const KMoodText(
    this.text, {
    super.key,
    this.variant = MoodTextVariant.normal,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final MoodTextVariant variant;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final base = switch (variant) {
      MoodTextVariant.header => textTheme.titleLarge,
      MoodTextVariant.normal => textTheme.bodyMedium,
      MoodTextVariant.small => textTheme.bodySmall,
    };

    return Text(
      text,
      style: (base ?? const TextStyle()).merge(style),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}