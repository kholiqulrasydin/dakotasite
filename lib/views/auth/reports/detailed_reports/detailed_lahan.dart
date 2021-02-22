import 'package:dakotawebsite/viewmodels/report_view_model.dart';
import 'package:dakotawebsite/widgets/report_data/report_datatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedLahan extends StatefulWidget {

  @override
  _DetailedLahanState createState() => _DetailedLahanState();
}

class _DetailedLahanState extends State<DetailedLahan> {

  final List<DataColumn> _totalLahanHeaders = [
    DataColumn(label: Text('Kelurahan')),
    DataColumn(label: Text('Total lahan sawah')),
    DataColumn(label: Text('Total lahan pekarangan')),
    DataColumn(label: Text('Total lahan tegal')),
  ];

  @override
  void initState() {
    super.initState();
    ReportViewModel reportViewModel =
    Provider.of<ReportViewModel>(context, listen: false);
    ReportViewModel().getDetailedLahanPerKecamatan(reportViewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportViewModel>(
        builder: (_, viewModel, __) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Tooltip(
                      message: 'Kembali',
                      child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                        Navigator.of(context).pop();
                      }),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Consumer<ReportViewModel>(
                    builder: (_, viewModel, __) => Tooltip(
                      message: 'Cetak',
                      child: IconButton(
                          icon: Icon(
                            Icons.print,
                          ),
                          onPressed: () async {
                            await viewModel.savePdf4(<List<String>>[
                              <String>[
                                'Kelurahan',
                                'Total\n Lahan \nSawah',
                                'Total\n Lahan \nPekarangan',
                                'Total\n Lahan \nTegal',
                              ],
                              ...viewModel.detailedLahanReport.map((data) => [
                                data.kecamatan,
                                '${data.lahansawah} m\u00B2',
                                '${data.lahanpekarangan} m\u00B2',
                                '${data.lahantegal} m\u00B2',
                              ])
                            ], "Detail Informasi Jumlah Lahan yang diusahakan kecamatan", viewModel);
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 18,
              child: Container(
                  child: viewModel.detailedLahanReport.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ReportDatatable(
                    headersColumn: _totalLahanHeaders,
                    reportData: viewModel.detailedLahanReport
                        .map<DataRow>((data) => DataRow(cells: [
                      DataCell(Text(data.kecamatan)),
                      DataCell(
                          Text('${data.lahansawah} m\u00B2')),
                      DataCell(Text(
                          '${data.lahanpekarangan} m\u00B2')),
                      DataCell(
                          Text('${data.lahantegal} m\u00B2'))
                    ]))
                        .toList(),
                  )),
            ),
          ],
        )
    );
  }
}