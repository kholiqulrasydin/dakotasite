import 'dart:ui';

import 'package:dakotawebsite/constants/app_colors.dart';
import 'package:dakotawebsite/viewmodels/report_view_model.dart';
import 'package:dakotawebsite/widgets/report_data/report_datatable.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportsDesktop extends StatefulWidget {
  @override
  _ReportsDesktopState createState() => _ReportsDesktopState();
}

class _ReportsDesktopState extends State<ReportsDesktop> {
  bool r1enabled;
  bool r2enabled;
  ScrollController mainScrollControler = ScrollController();
  final pdf = pw.Document();
  final pdf2 = pw.Document();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    r1enabled = true;
    r2enabled = false;
    ReportViewModel reportViewModel =
        Provider.of<ReportViewModel>(context, listen: false);
      ReportViewModel().getKelompokPerKecamatan(reportViewModel);
      ReportViewModel().getLahanPerKecamatan(reportViewModel);

  }

  Future savePdf(List<List<dynamic>> tableData, String title) async {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(14),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Text(
                  "APLIKASI SISTEM INFORMASI, MONITORING DAN EVALUASI PERTANIAN DAN PERIKANAN(SIMENTAN)\nDINAS PERTANIAN, KETAHANAN PANGAN DAN PERIKANAN\nKABUPATEN PONOROGO",
                  textAlign: pw.TextAlign.center)),
          pw.Paragraph(text: "$title", textAlign: pw.TextAlign.center),
          pw.Table.fromTextArray(context: context, data: tableData),
          pw.Paragraph(
              text:
                  '\nDicetak pada tanggal ${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}')
        ];
      },
    ));
    Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            '$title-${DateTime.now().toString()}.pdf');
  }

  Future savePdf2(List<List<dynamic>> tableData, String title) async {
    pdf2.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(14),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Text(
                  "APLIKASI SISTEM INFORMASI, MONITORING DAN EVALUASI PERTANIAN DAN PERIKANAN(SIMENTAN)\nDINAS PERTANIAN, KETAHANAN PANGAN DAN PERIKANAN\nKABUPATEN PONOROGO",
                  textAlign: pw.TextAlign.center)),
          pw.Paragraph(text: "$title", textAlign: pw.TextAlign.center),
          pw.Table.fromTextArray(context: context, data: tableData),
          pw.Paragraph(
              text:
              '\nDicetak pada tanggal ${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}')
        ];
      },
    ));
    Printing.sharePdf(
        bytes: await pdf2.save(),
        filename:
        '$title-${DateTime.now().toString()}.pdf');
  }

  List<DataColumn> _totalKelompokHeaders = [
    DataColumn(label: Text('Kecamatan')),
    DataColumn(label: Text('Total\nKelompok')),
    DataColumn(label: Text('Total\nBantuan\nAlsintan')),
    DataColumn(label: Text('Total\nBantuan\nSarpras')),
    DataColumn(label: Text('Total\nBantuan\nBibit')),
    DataColumn(label: Text('Total\nBantuan\nTernak')),
    DataColumn(label: Text('Total\nBantuan\nPerikanan')),
    DataColumn(label: Text('Total\nBantuan\nLainnya')),
    DataColumn(label: Text('')),
  ];

  List<DataColumn> _totalLahanHeaders = [
    DataColumn(label: Text('Kecamatan')),
    DataColumn(label: Text('Total lahan sawah')),
    DataColumn(label: Text('Total lahan pekarangan')),
    DataColumn(label: Text('Total lahan tegal')),
    DataColumn(label: Text('')),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.04, right: width * 0.04, bottom: height * 0.03),
      child: Scaffold(
        backgroundColor: Colors.white24,
        body: Scrollbar(
          controller: mainScrollControler,
          isAlwaysShown: true,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: mainScrollControler,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  buildAnimatedCrossFade(height, width, context),
                  buildAnimatedCrossFade2(height, width, context)
                ],
              )),
        ),
      ),
    );
  }

  AnimatedCrossFade buildAnimatedCrossFade2(
      double height, double width, BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      firstChild: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.02),
        child: Column(
          children: [
            Container(
              width: width * 0.7,
              height: height * 0.07,
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 2,
                      offset: Offset(0.5, 0.0),
                      spreadRadius: 2)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Informasi Jumlah Lahan yang diusahakan per-kecamatan',
                      style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      Tooltip(
                        message: 'Print',
                        child: Consumer<ReportViewModel>(
                          builder: (_, viewModel, __) => IconButton(
                              icon: Icon(
                                Icons.print,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await savePdf2(<List<String>>[
                                  <String>[
                                    'Kecamatan',
                                    'Total\n Lahan \nSawah',
                                    'Total\n Lahan \nPekarangan',
                                    'Total\n Lahan \nTegal',
                                  ],
                                  ...viewModel.lahanReport.map((data) => [
                                    data.kecamatan,
                                    '${data.lahansawah} m\u00B2',
                                    '${data.lahanpekarangan} m\u00B2',
                                    '${data.lahantegal} m\u00B2',
                                  ])
                                ], "Informasi Jumlah Lahan yang diusahakan per-kecamatan");

                              }),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              r2enabled = true;
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
            Container()
          ],
        ),
      ), // When you don't want to show menu..
      secondChild: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.02),
        child: Column(
          children: [
            Container(
              width: width * 0.7,
              height: height * 0.07,
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 2,
                      offset: Offset(0.5, 0.0),
                      spreadRadius: 2)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Informasi Jumlah Lahan yang diusahakan per-kecamatan',
                      style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      Tooltip(
                        message: 'Print',
                        child: Consumer<ReportViewModel>(
                          builder: (_, viewModel, __) => IconButton(
                              icon: Icon(
                                Icons.print,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await savePdf2(<List<String>>[
                                  <String>[
                                    'Kecamatan',
                                    'Total\n Lahan \nSawah',
                                    'Total\n Lahan \nPekarangan',
                                    'Total\n Lahan \nTegal',
                                  ],
                                  ...viewModel.lahanReport.map((data) => [
                                    data.kecamatan,
                                    '${data.lahansawah} m\u00B2',
                                    '${data.lahanpekarangan} m\u00B2',
                                    '${data.lahantegal} m\u00B2',
                                  ])
                                ], "Informasi Jumlah Lahan yang diusahakan per-kecamatan");

                              }),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              r2enabled = false;
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: width * 0.67,
              height: height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9)),
                  border: Border.all(color: Colors.black38)),
              child: Consumer<ReportViewModel>(
                builder: (_, viewModel, __) => Container(
                    child: viewModel.lahanReport.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ReportDatatable(
                      headersColumn: _totalLahanHeaders,
                      reportData: viewModel.lahanReport
                          .map<DataRow>((data) => DataRow(cells: [
                        DataCell(Text(data.kecamatan)),
                        DataCell(
                            Text('${data.lahansawah} m\u00B2')),
                        DataCell(Text('${data.lahanpekarangan} m\u00B2')),
                        DataCell(Text('${data.lahantegal} m\u00B2')),
                        DataCell(RaisedButton(
                          onPressed: () {},
                          child: Text(
                            'Detail',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: primaryColor,
                        )),
                      ]))
                          .toList(),
                    )),
              ),
            )
          ],
        ),
      ),
      crossFadeState:
          !r2enabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  AnimatedCrossFade buildAnimatedCrossFade(
      double height, double width, BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      firstChild: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.02),
        child: Column(
          children: [
            Container(
              width: width * 0.7,
              height: height * 0.07,
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 2,
                      offset: Offset(0.5, 0.0),
                      spreadRadius: 2)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Informasi Kelompok per-Kecamatan',
                      style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      Tooltip(
                        message: 'Print',
                        child: Consumer<ReportViewModel>(
                          builder: (_, viewModel, __) => IconButton(
                              icon: Icon(
                                Icons.print,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await savePdf(<List<String>>[
                                  <String>[
                                    'Kecamatan',
                                    'Total\n  Kelompok  ',
                                    'Total\n Bantuan \nAlsintan',
                                    'Total\n Bantuan \nSapras',
                                    'Total\n Bantuan \nBibit',
                                    'Total\n Bantuan \nTernak',
                                    'Total\n Bantuan \n Perikanan ',
                                    'Total\n Bantuan \nLainnya',
                                  ],
                                  ...viewModel.kelompokReport.map((e) => [
                                        e.kecamatan,
                                        e.totalkelompok.toString(),
                                        e.alsintan.toString(),
                                        e.sarpras.toString(),
                                        e.bibit.toString(),
                                        e.ternak.toString(),
                                        e.perikanan.toString(),
                                        e.lainnya.toString()
                                      ])
                                ], "Informasi Data Kelompok dan Bantuan Per-kecamatan");
                              }),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              r1enabled = false;
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: width * 0.67,
              height: height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9)),
                  border: Border.all(color: Colors.black38)),
              child: Consumer<ReportViewModel>(
                builder: (_, viewModel, __) => Container(
                    child: viewModel.kelompokReport.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ReportDatatable(
                            headersColumn: _totalKelompokHeaders,
                            reportData: viewModel.kelompokReport
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
                                      DataCell(RaisedButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Detail',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: primaryColor,
                                      )),
                                    ]))
                                .toList(),
                          )),
              ),
            )
          ],
        ),
      ), // When you don't want to show menu..
      secondChild: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.02),
        child: Column(
          children: [
            Container(
              width: width * 0.7,
              height: height * 0.07,
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 2,
                      offset: Offset(0.5, 0.0),
                      spreadRadius: 2)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Informasi Kelompok per-Kecamatan',
                      style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      Tooltip(
                        message: 'Print',
                        child: Consumer<ReportViewModel>(
                          builder: (_, viewModel, __) => IconButton(
                              icon: Icon(
                                Icons.print,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await savePdf(<List<String>>[
                                  <String>[
                                    'Kecamatan',
                                    'Total\n  Kelompok  ',
                                    'Total\n Bantuan \nAlsintan',
                                    'Total\n Bantuan \nSapras',
                                    'Total\n Bantuan \nBibit',
                                    'Total\n Bantuan \nTernak',
                                    'Total\n Bantuan \n Perikanan ',
                                    'Total\n Bantuan \nLainnya',
                                  ],
                                  ...viewModel.kelompokReport.map((e) => [
                                        e.kecamatan,
                                        e.totalkelompok.toString(),
                                        e.alsintan.toString(),
                                        e.sarpras.toString(),
                                        e.bibit.toString(),
                                        e.ternak.toString(),
                                        e.perikanan.toString(),
                                        e.lainnya.toString()
                                      ])
                                ], "Informasi Data Kelompok dan Bantuan Per-kecamatan");
                              }),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              r1enabled = true;
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
            Container()
          ],
        ),
      ),
      crossFadeState:
          r1enabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
