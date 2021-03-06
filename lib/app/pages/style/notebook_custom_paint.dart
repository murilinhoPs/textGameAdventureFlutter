import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGrey = Paint()..color = Colors.grey[700];
    var rrectGrey = RRect.fromLTRBR(
      10,
      0,
      size.width + 8,
      size.height + 100,
      Radius.circular(8.0),
    );

    canvas.drawRRect(rrectGrey, paintGrey);

    final paintWhite = Paint()..color = Colors.white;
    var rrectWhite = RRect.fromLTRBR(
      8,
      0,
      size.width,
      size.height + 100,
      Radius.circular(8.0),
    );

    canvas.drawRRect(rrectWhite, paintWhite);

    final paintHorizontalLines = Paint()
      ..color = Colors.blue[200]
      ..strokeWidth = 1.0;

    for (double i = .1; i <= .9; i += 0.1) {
      canvas.drawLine(
          Offset(8, size.height * i), Offset(size.width, size.height * i), paintHorizontalLines);
    }

    final paintPink = Paint()
      ..color = Color.fromRGBO(100, 160, 255, 0.5)
      ..strokeWidth = 2.5;
    canvas.drawLine(
        Offset(size.width * .93, 0), Offset(size.width * .93, size.height + 100), paintPink);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
