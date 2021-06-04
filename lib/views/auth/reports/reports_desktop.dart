import 'dart:ui';

import 'package:dakotawebsite/constants/app_colors.dart';
import 'package:dakotawebsite/viewmodels/report_view_model.dart';
import 'package:dakotawebsite/views/auth/reports/detailed_reports/detailed_kelompok.dart';
import 'package:dakotawebsite/views/auth/reports/detailed_reports/detailed_lahan.dart';
import 'package:dakotawebsite/widgets/report_data/report_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ReportsDesktop extends StatefulWidget {
  @override
  _ReportsDesktopState createState() => _ReportsDesktopState();
}

class _ReportsDesktopState extends State<ReportsDesktop> {
  ScrollController mainScrollControler = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReportViewModel reportViewModel =
        Provider.of<ReportViewModel>(context, listen: false);
    ReportViewModel().getKelompokPerKecamatan(reportViewModel);
    ReportViewModel().getLahanPerKecamatan(reportViewModel);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Padding(
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
                    PrimaryReportWidget(),
                    SecondaryReportWidget()
                  ],
                )),
          ),
        ),
      ),
    );
  }
  
}

class SecondaryReportWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportSecondaryBloc, bool>(
      builder:(context, state) => AnimatedCrossFade(
        duration: const Duration(milliseconds: 1000),
        firstChild: FirstContainerReportSecondary(),
        secondChild: SecondContainerReportSecondary(),
        crossFadeState: !state
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
    );
  }
}

class PrimaryReportWidget extends StatelessWidget {
  const PrimaryReportWidget({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportPrimaryBloc, bool>(
      builder:(context, state) => AnimatedCrossFade(
        duration: const Duration(milliseconds: 1000),
        firstChild: FirstContainerReportPrimary(),
        secondChild: SecondContainerReportPrimary(),
        crossFadeState: state
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
    );
  }
}

class SecondContainerReportSecondary extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ReportSecondaryBloc _reportSecondaryBloc = BlocProvider.of<ReportSecondaryBloc>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                      message: 'Cetak',
                      child: Consumer<ReportViewModel>(
                        builder: (_, viewModel, __) => IconButton(
                            icon: Icon(
                              Icons.print,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await viewModel.savePdf2(<List<String>>[
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
                    Tooltip(
                      message: 'Sembunyikan Tabel',
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _reportSecondaryBloc.add(ReportSecondaryState.disable);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
          ReportBodySecondary(width: width, height: height)
        ],
      ),
    );
  }
}

class ReportBodySecondary extends StatelessWidget {
  const ReportBodySecondary({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.67,
      height: height * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(9),
              bottomRight: Radius.circular(9)),
          border: Border.all(color: Colors.black38)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/lahanKecamatan',
        routes: {
          '/lahanKecamatan' : (context) => LahanKecamatan(),
          '/detailedLahan' : (context) => DetailedLahan()
        },
      ),
    );
  }
}

class LahanKecamatan extends StatelessWidget {
  
  final List<DataColumn> _totalLahanHeaders = [
    DataColumn(label: Text('Kecamatan')),
    DataColumn(label: Text('Total lahan sawah')),
    DataColumn(label: Text('Total lahan pekarangan')),
    DataColumn(label: Text('Total lahan tegal')),
    DataColumn(label: Text('')),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportViewModel>(
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
              DataCell(Text(
                  '${data.lahanpekarangan} m\u00B2')),
              DataCell(
                  Text('${data.lahantegal} m\u00B2')),
              DataCell(RaisedButton(
                onPressed: () {
                  viewModel.selectedKecamatanLahan = data.kecamatan;
                  Navigator.pushNamed(context, '/detailedLahan');
                },
                child: Text(
                  'Detail',
                  style: TextStyle(color: Colors.white),
                ),
                color: primaryColor,
              )),
            ]))
                .toList(),
          ))
    );
  }
}

class FirstContainerReportSecondary extends StatelessWidget {
  const FirstContainerReportSecondary({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReportSecondaryBloc _reportSecondaryBloc = BlocProvider.of<ReportSecondaryBloc>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                      message: 'Cetak',
                      child: Consumer<ReportViewModel>(
                        builder: (_, viewModel, __) => IconButton(
                            icon: Icon(
                              Icons.print,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await viewModel.savePdf2(<List<String>>[
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
                    Tooltip(
                      message: 'Tampilkan Tabel',
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _reportSecondaryBloc.add(ReportSecondaryState.enable);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}

class SecondContainerReportPrimary extends StatelessWidget {
  const SecondContainerReportPrimary({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReportPrimaryBloc _reportPrimaryBloc = BlocProvider.of<ReportPrimaryBloc>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                      message: 'Cetak',
                      child: Consumer<ReportViewModel>(
                        builder: (_, viewModel, __) => IconButton(
                            icon: Icon(
                              Icons.print,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await viewModel.savePdf(<List<String>>[
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
                    Tooltip(
                      message: 'Tampilkan Tabel',
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _reportPrimaryBloc.add(ReportPrimaryState.enable);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}

class FirstContainerReportPrimary extends StatelessWidget {
  const FirstContainerReportPrimary({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReportPrimaryBloc _reportPrimaryBloc = BlocProvider.of<ReportPrimaryBloc>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                      message: 'Cetak',
                      child: Consumer<ReportViewModel>(
                        builder: (_, viewModel, __) => IconButton(
                            icon: Icon(
                              Icons.print,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await viewModel.savePdf(<List<String>>[
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
                    Tooltip(
                      message: 'Sembunyikan Tabel',
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _reportPrimaryBloc.add(ReportPrimaryState.disable);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
          ReportBodyPrimary(width: width, height: height)
        ],
      ),
    );
  }
}

class ReportBodyPrimary extends StatelessWidget {
  const ReportBodyPrimary({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.67,
      height: height * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(9),
              bottomRight: Radius.circular(9)),
          border: Border.all(color: Colors.black38)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/kelompokKecamatan',
        routes: {
          '/kelompokKecamatan' : (context) => KelompokKecamatan(),
          '/kelompokKelurahan' : (context) => DetailedKelompok(),
        },
      )
    );
  }
}

class KelompokKecamatan extends StatelessWidget {

  final List<DataColumn> _totalKelompokHeaders = [
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportViewModel>(
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
                  onPressed: () {
                    viewModel.selectedKecamatanKelompok = data.kecamatan;
                    Navigator.pushNamed(context, '/kelompokKelurahan');
                  },
                  child: Text(
                    'Detail',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: primaryColor,
                )),
              ]))
                  .toList(),
            ))
    );
  }
}



