import 'package:dakotawebsite/viewmodels/report_view_model.dart';
import 'package:dakotawebsite/widgets/report_data/report_datatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedKelompok extends StatefulWidget {

  @override
  _DetailedKelompokState createState() => _DetailedKelompokState();
}

class _DetailedKelompokState extends State<DetailedKelompok> {

  @override
  void initState() {
    super.initState();

    ReportViewModel reportViewModel =
    Provider.of<ReportViewModel>(context, listen: false);
    ReportViewModel().getDetailedKelompokPerKecamatan(reportViewModel);
  }

  List<DataColumn> _headers = [
    DataColumn(label: Text('Kelurahan')),
    DataColumn(label: Text('Total\nKelompok')),
    DataColumn(label: Text('Total\nBantuan\nAlsintan')),
    DataColumn(label: Text('Total\nBantuan\nSarpras')),
    DataColumn(label: Text('Total\nBantuan\nBibit')),
    DataColumn(label: Text('Total\nBantuan\nTernak')),
    DataColumn(label: Text('Total\nBantuan\nPerikanan')),
    DataColumn(label: Text('Total\nBantuan\nLainnya')),
  ];

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
                            await viewModel.savePdf3(<List<String>>[
                              <String>[
                                'Kelurahan',
                                'Total\n  Kelompok  ',
                                'Total\n Bantuan \nAlsintan',
                                'Total\n Bantuan \nSapras',
                                'Total\n Bantuan \nBibit',
                                'Total\n Bantuan \nTernak',
                                'Total\n Bantuan \n Perikanan ',
                                'Total\n Bantuan \nLainnya',
                              ],
                              ...viewModel.detailedKelompokReport.map((e) => [
                                e.kecamatan,
                                e.totalkelompok.toString(),
                                e.alsintan.toString(),
                                e.sarpras.toString(),
                                e.bibit.toString(),
                                e.ternak.toString(),
                                e.perikanan.toString(),
                                e.lainnya.toString()
                              ])
                            ], "Detail Informasi Data Kelompok dan Bantuan kecamatan", viewModel);
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 18,
              child: Container(
                  child: viewModel.detailedKelompokReport.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ReportDatatable(
                    headersColumn: _headers,
                    reportData: viewModel.detailedKelompokReport
                        .map<DataRow>((data) => DataRow(cells: [
                      DataCell(Text(data.kecamatan)),
                      DataCell(
                          Text(data.totalkelompok.toString())),
                      DataCell(Text(data.alsintan.toString())),
                      DataCell(Text(data.sarpras.toString())),
                      DataCell(Text(data.bibit.toString())),
                      DataCell(Text(data.ternak.toString())),
                      DataCell(Text(data.perikanan.toString())),
                      DataCell(Text(data.lainnya.toString())),
                    ]))
                        .toList(),
                  )),
            ),
          ],
        )
    );
  }
}