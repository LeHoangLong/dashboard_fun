import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectedMenuPainter extends CustomPainter {
  Color? color;
  SelectedMenuPainter({
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();
    var width = size.width;
    var height = size.height;
    path.cubicTo(0, height / 4, width, height / 4, width, height / 2);
    path.cubicTo(width, height * 3 / 4, 0, height * 3 / 4, 0, height);
    paint.color = color ?? Colors.black;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
