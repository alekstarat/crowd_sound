import 'package:flutter/material.dart';

class MyPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15
      ..color = const Color.fromRGBO(38, 31, 56, 1);
      
    var path = Path();

    var shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    path.moveTo(size.width*0.15, size.height);
    path.quadraticBezierTo(size.width * 0.4, size.height*0.75, size.width, size.height*0.7);
    path.lineTo(size.width, size.height);
    

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class MyPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15
      ..color = const Color.fromRGBO(38, 31, 56, 1);
      
    var path = Path();

    var shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width*0.5, size.height, size.width*0.8, 0);
    path.lineTo(0, 0);
    
    //path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        //size.width * 1.0, size.height * 0.8);
    //path.lineTo(size.width, size.height);
    //path.lineTo(0, size.height);
    
    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
    
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
