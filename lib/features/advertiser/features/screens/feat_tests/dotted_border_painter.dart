import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  final Color borderColor;

  DottedBorderPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const double dashWidth = 4;
    const double dashSpace = 4;

    // Draw dotted lines for all sides
    _drawDottedLine(canvas, paint, const Offset(0, 0), Offset(size.width, 0),
        dashWidth, dashSpace); // Top
    _drawDottedLine(canvas, paint, Offset(0, size.height),
        Offset(size.width, size.height), dashWidth, dashSpace); // Bottom
    _drawDottedLine(canvas, paint, const Offset(0, 0), Offset(0, size.height),
        dashWidth, dashSpace); // Left
    _drawDottedLine(canvas, paint, Offset(size.width, 0),
        Offset(size.width, size.height), dashWidth, dashSpace); // Right
  }

  void _drawDottedLine(Canvas canvas, Paint paint, Offset start, Offset end,
      double dashWidth, double dashSpace) {
    double distance = (end - start).distance;
    double current = 0;

    final direction = (end - start) / distance;

    while (current < distance) {
      final startOffset = start + direction * current;
      final endOffset =
          start + direction * (current + dashWidth).clamp(0, distance);
      canvas.drawLine(startOffset, endOffset, paint);
      current += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
