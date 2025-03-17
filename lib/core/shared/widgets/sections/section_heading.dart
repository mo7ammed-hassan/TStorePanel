import 'package:flutter/material.dart';

/// A widget for displaying a section heading with optional actions.
class SectionHeading extends StatelessWidget {
  /// Creates a new instance of [SectionHeading].
  ///
  /// Parameters:
  /// The [title] parameter is required and specifies the title of the section.
  /// The [action] parameter is optional and specifies the action widget to be displayed next to the title.
  /// The [textColor] parameter is optional and specifies the color of the title text.
  const SectionHeading({
    super.key,
    required this.title,
    this.action,
    this.textColor,
  });
  final String title;
  final Widget? action;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: textColor),
        ),
        if (action != null) action!,
      ],
    );
  }
}
