import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  const PageHeading({super.key, required this.heading, this.rightSideWidget});

  final String heading;
  final Widget? rightSideWidget;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  heading,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
          ],
        ),
        rightSideWidget ?? const SizedBox(),
      ],
    );
  }
}
