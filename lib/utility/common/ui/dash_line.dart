

import 'package:flutter/material.dart';

class DashLine extends StatelessWidget {
  final Axis direction;
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  const DashLine({
    super.key,
    this.direction = Axis.horizontal,
    this.color = Colors.grey,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxSize = direction == Axis.horizontal
            ? Size(constraints.maxWidth, strokeWidth)
            : Size(strokeWidth, constraints.maxHeight);

        return CustomPaint(
          size: boxSize,
          painter: _DashedLinePainter(
            direction: direction,
            color: color,
            dashWidth: dashWidth,
            dashSpace: dashSpace,
            strokeWidth: strokeWidth,
          ),
        );
      },
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Axis direction;
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  _DashedLinePainter({
    required this.direction,
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (direction == Axis.horizontal) {
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    } else {
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashWidth),
          paint,
        );
        startY += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
