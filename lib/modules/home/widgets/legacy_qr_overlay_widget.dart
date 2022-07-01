import 'package:flutter/material.dart';

class LegacyQRScannerOverlayWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..strokeWidth = 5
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final paintBackground = Paint()..color = const Color.fromRGBO(0, 0, 2, 0.5);

    double sizeLine = size.width / 4;
    double sizeSpace = sizeLine / 2;

    double x = size.width / 2 - ((sizeLine * 2) + sizeSpace) / 2;
    double y = size.height / 2 - ((sizeLine * 2) + sizeSpace) / 2;

    Rect left = Rect.fromLTWH(0, 0, x, size.height);
    canvas.drawRect(left, paintBackground);

    Rect right = Rect.fromLTWH(
        x + (sizeLine * 2) + sizeSpace, 0, size.width, size.height);
    canvas.drawRect(right, paintBackground);

    Rect top = Rect.fromLTWH(x, 0, (sizeLine * 2) + sizeSpace, y);
    canvas.drawRect(top, paintBackground);

    Rect bottom = Rect.fromLTWH(
        x,
        y + (sizeLine * 2) + sizeSpace,
        (sizeLine * 2) + sizeSpace,
        size.height - (y + (sizeLine * 2) + sizeSpace));
    canvas.drawRect(bottom, paintBackground);

    Path topLeft = Path();
    topLeft.moveTo(x, y + sizeLine);
    topLeft.relativeLineTo(0, -sizeLine);
    topLeft.relativeLineTo(sizeLine, 0);
    canvas.drawPath(topLeft, paintLine);

    Path topRight = Path();
    topRight.moveTo(x + sizeLine + sizeSpace, y);
    topRight.relativeLineTo(sizeLine, 0);
    topRight.relativeLineTo(0, sizeLine);
    canvas.drawPath(topRight, paintLine);

    Path bottomLeft = Path();
    bottomLeft.moveTo(x, y + sizeLine + sizeSpace);
    bottomLeft.relativeLineTo(0, sizeLine);
    bottomLeft.relativeLineTo(sizeLine, 0);
    canvas.drawPath(bottomLeft, paintLine);

    Path bottomRight = Path();
    topRight.moveTo(x + (sizeLine * 2) + sizeSpace, y + sizeLine + sizeSpace);
    topRight.relativeLineTo(0, sizeLine);
    topRight.relativeLineTo(-sizeLine, 0);
    canvas.drawPath(topRight, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
