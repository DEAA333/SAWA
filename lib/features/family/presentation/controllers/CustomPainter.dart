import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CornerBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerLength;
  final double radius;

  CornerBorderPainter({
    required this.color,
    this.strokeWidth = 3,
    this.cornerLength = 20,
    this.radius = 6,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final l = cornerLength;
    final r = radius;

    // ركن فوق يسار
    canvas.drawPath(
      Path()
        ..moveTo(0, l)
        ..lineTo(0, r)
        ..arcToPoint(Offset(r, 0), radius: Radius.circular(r))
        ..lineTo(l, 0),
      paint,
    );

    // ركن فوق يمين
    canvas.drawPath(
      Path()
        ..moveTo(w - l, 0)
        ..lineTo(w - r, 0)
        ..arcToPoint(Offset(w, r), radius: Radius.circular(r))
        ..lineTo(w, l),
      paint,
    );

    // ركن تحت يسار
    canvas.drawPath(
      Path()
        ..moveTo(0, h - l)
        ..lineTo(0, h - r)
        ..arcToPoint(Offset(r, h), radius: Radius.circular(r))
        ..lineTo(l, h),
      paint,
    );

    // ركن تحت يمين
    canvas.drawPath(
      Path()
        ..moveTo(w - l, h)
        ..lineTo(w - r, h)
        ..arcToPoint(Offset(w, h - r), radius: Radius.circular(r))
        ..lineTo(w, h - l),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}