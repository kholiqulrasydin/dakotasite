import 'package:dakotawebsite/viewmodels/bantuan_usaha_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dakotawebsite/widgets/dashboard/widgets/pie_chart/pie_chart.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<BantuanUsahaViewModel>(
        builder: (_, bantuanUsaha, __)=> Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var category in bantuanUsaha.category)
              ExpenseCategory(
                  text: category.name, index: bantuanUsaha.category.indexOf(category))
          ],
        ),
      )
    );
  }
}

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({
    Key key,
    @required this.index,
    @required this.text,
  }) : super(key: key);

  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  kNeumorphicColors.elementAt(index % kNeumorphicColors.length),
            ),
          ),
          SizedBox(width: 20),
          Text(text.capitalize()),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
