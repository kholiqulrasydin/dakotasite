import 'package:flutter/material.dart';
import 'package:dakotawebsite/widgets/dashboard/widgets/pie_chart/pie_chart.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({
    Key key, @required this.categoryData
  }) : super(key: key);

  final List<Category> categoryData;


  @override
  Widget build(BuildContext context) {
    return Expanded(
          flex: 4,
          child: LayoutBuilder(
            builder: (context, constraint) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: constraint.maxWidth * 0.6,
                      child: CustomPaint(
                        child: Center(),
                        foregroundPainter: PieChart(
                          width: constraint.maxWidth * 0.5,
                          categories: categoryData,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
