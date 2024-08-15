import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar({
    Key? key,
    required this.max,
    required this.current,
    this.height = 8,
    this.trackColor,
    this.color = const Color(0xFF01A985),
  }) : super(key: key);

  final double max;
  final double current;
  final double height;
  final Color color;
  final Color? trackColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        final x = boxConstraints.maxWidth;
        final percent = (current / max) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: height,
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
