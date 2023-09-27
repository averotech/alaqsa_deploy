import 'package:flutter/material.dart';

class LineDashedPainter extends CustomPainter {
  var _color;
  LineDashedPainter(this._color);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = _color
      ..strokeWidth = 1.2;
    var max = 60;
    var dashWidth = 5;
    var dashSpace = 5;
    double startY = 0;
    while (max >= 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      final space = (dashSpace + dashWidth);
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}