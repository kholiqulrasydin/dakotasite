import 'dart:math';

import 'package:flutter/material.dart';

class PieChart extends CustomPainter {
  PieChart({@required this.categories, @required this.width});

  final List<Category> categories;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    // Calculate total amount from each category
    categories.forEach((expense) => total += expense.amount);

    // The angle/radian at 12 o'clcok
    double startRadian = -pi / 2;

    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = currentCategory.amount / total * 2 * pi;
      // Used modulo/remainder to catch use case if there is more than 6 colours
      paint.color = kNeumorphicColors.elementAt(index % categories.length);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      // The new startRadian starts from where the previous sweepRadian.
      // Example, a circle perimeter is 10.
      // Category A takes a startRadian 0 and ends at sweepRadian 5.
      // Category B takes the startRadian where Category A left off, which is 5
      // and ends at sweepRadian 7.
      // Category C takes the startRadian where Category B left off, which is 7
      // and so on.
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Category {
  const Category(this.name, {@required this.amount});

  final String name;
  final double amount;
}


final kCategories = [
  Category('453 Alsintan', amount: 453.00),
  Category('150 SARPRAS', amount: 150.00),
  Category('90 Bibit/Benih', amount: 90.00),
  Category('90 Ternak', amount: 90.00),
  Category('40 Perikanan', amount: 40.00),
  Category('20 Lainnya', amount: 20.00),
];

final kNeumorphicColors = [
  Color.fromRGBO(3,169,244, 1),// rgb(46, 198, 255)
  Color.fromRGBO(0,150,136, 1), //  rgb(82, 98, 255)
  Color.fromRGBO(255,193,7, 1), // rgb(255, 171, 67)
  Color.fromRGBO(236,64,122, 1), // rgb(123, 201, 82)
  Color.fromRGBO(103,58,183, 1),//  rgb(252, 91, 57)
  Color.fromRGBO(96,125,139, 1), //rgb(139, 135, 130)
];