import 'package:flutter/material.dart';

class ReportDatatable extends StatelessWidget {
  const ReportDatatable({
    @required this.headersColumn,
    @required this.reportData,
    Key key,
  }) : super(
          key: key,
        );
  final List<DataColumn> headersColumn;
  final List<DataRow> reportData;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
          flex: 14,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: headersColumn,
                rows: reportData,
                columnSpacing: MediaQuery.of(context).size.width * 0.02,
              ),
            ),
          ),
        ),
          Expanded(
          flex: 1,
          child: Container(),
        )
      ],
    ));
  }
}
