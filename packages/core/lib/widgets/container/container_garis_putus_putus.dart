import 'package:flutter/material.dart';

class ContainerGarisPutus extends StatelessWidget {
  final double dashWidth;
  final double dashSpace;
  final double thickness;
  final Color color;

  const ContainerGarisPutus({
    super.key,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.thickness = 1.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, thickness), // Panjang penuh secara horizontal
      painter: DashedLinePainter(
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        thickness: thickness,
        color: color,
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final double thickness;
  final Color color;

  DashedLinePainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.thickness,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    double startX = 0.0;
    final endX = size.width;

    while (startX < endX) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
