import 'package:dakotawebsite/datamodels/kelompokper_kecamatan.dart';
import 'package:dakotawebsite/datamodels/lahanper_kecamatan.dart';
import 'package:dakotawebsite/services/auth/report_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:bloc/bloc.dart';


enum ReportPrimaryState{enable, disable}
enum ReportSecondaryState{enable, disable}


class ReportViewModel extends ChangeNotifier {
  List<KelompokPerKecamatan> _kelompokReport = [];
  List<LahanPerKecamatan> _lahanReport = [];
  List<KelompokPerKecamatan> _detailedKelompokReport = [];
  List<LahanPerKecamatan> _detailedLahanReport = [];

  String _selectedKecamatanKelompok = '';
  String _selectedKecamatanLahan = '';


  final pdf = pw.Document();
  final pdf2 = pw.Document();
  final pdf3 = pw.Document();
  final pdf4 = pw.Document();


  List<KelompokPerKecamatan> get kelompokReport => _kelompokReport;
  List<LahanPerKecamatan> get lahanReport => _lahanReport;
  List<KelompokPerKecamatan> get detailedKelompokReport => _detailedKelompokReport;
  List<LahanPerKecamatan> get detailedLahanReport => _detailedLahanReport;

  String get selectedKecamatanKelompok => _selectedKecamatanKelompok;
  String get selectedKecamatanLahan => _selectedKecamatanLahan;

  set kelompokReportSetter(List<KelompokPerKecamatan> list) {
    _kelompokReport = list;
    notifyListeners();
  }

  set lahanReportSetter(List<LahanPerKecamatan> list) {
    _lahanReport = list;
    notifyListeners();
  }

  set detailedKelompokReportSetter(List<KelompokPerKecamatan> list) {
    _detailedKelompokReport = list;
    notifyListeners();
  }

  set detailedLahanReportSetter(List<LahanPerKecamatan> list) {
    _detailedLahanReport = list;
    notifyListeners();
  }

  set selectedKecamatanKelompok(String kecamatan){
    _selectedKecamatanKelompok = kecamatan;
    notifyListeners();
  }

  set selectedKecamatanLahan(String kecamatan){
    _selectedKecamatanLahan = kecamatan;
    notifyListeners();
  }

  Future<bool> getKelompokPerKecamatan(ReportViewModel reportViewModel) async {
    bool result;
    await ReportApi.requestKelompokPerKecamatan(reportViewModel)
        .then((value) => value ? result = true : result = false);
    print(_kelompokReport.length.toString());
    return result;
  }

  Future<void> getLahanPerKecamatan(ReportViewModel reportViewModel) async {
    return reportViewModel.lahanReportSetter = await ReportApi.requestLahanPerKecamatan();
  }

  Future<void> getDetailedKelompokPerKecamatan(ReportViewModel reportViewModel) async {
    return reportViewModel.detailedKelompokReportSetter = await ReportApi.requestDetailedKelompokPerKecamatan(reportViewModel._selectedKecamatanKelompok);
  }

  Future<void> getDetailedLahanPerKecamatan(ReportViewModel reportViewModel) async {
    return reportViewModel.detailedLahanReportSetter = await ReportApi.requestDetailedLahanPerKecamatan(reportViewModel._selectedKecamatanLahan);
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
        filename: '$title-${DateTime.now().toString()}.pdf');
    await ReportApi.requestWebstatsUpload('printed_group_info');
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
        filename: '$title-${DateTime.now().toString()}.pdf');
    await ReportApi.requestWebstatsUpload('printed_field_info');
  }

  Future savePdf3(List<List<dynamic>> tableData, String title, ReportViewModel viewModel) async {
    String headerTitle = '$title ${viewModel._selectedKecamatanKelompok}';
    pdf3.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(14),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Text(
                  "APLIKASI SISTEM INFORMASI, MONITORING DAN EVALUASI PERTANIAN DAN PERIKANAN(SIMENTAN)\nDINAS PERTANIAN, KETAHANAN PANGAN DAN PERIKANAN\nKABUPATEN PONOROGO",
                  textAlign: pw.TextAlign.center)),
          pw.Paragraph(text: headerTitle, textAlign: pw.TextAlign.center),
          pw.Table.fromTextArray(context: context, data: tableData),
          pw.Paragraph(
              text:
              '\nDicetak pada tanggal ${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}')
        ];
      },
    ));
    Printing.sharePdf(
        bytes: await pdf3.save(),
        filename: '$headerTitle-${DateTime.now().toString()}.pdf');
    await ReportApi.requestWebstatsUpload('printed_group_info');
  }

  Future savePdf4(List<List<dynamic>> tableData, String title, ReportViewModel viewModel) async {
    String headerTitle = '$title ${viewModel._selectedKecamatanLahan}';
    pdf4.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(14),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Text(
                  "APLIKASI SISTEM INFORMASI, MONITORING DAN EVALUASI PERTANIAN DAN PERIKANAN(SIMENTAN)\nDINAS PERTANIAN, KETAHANAN PANGAN DAN PERIKANAN\nKABUPATEN PONOROGO",
                  textAlign: pw.TextAlign.center)),
          pw.Paragraph(text: headerTitle, textAlign: pw.TextAlign.center),
          pw.Table.fromTextArray(context: context, data: tableData),
          pw.Paragraph(
              text:
              '\nDicetak pada tanggal ${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}')
        ];
      },
    ));
    Printing.sharePdf(
        bytes: await pdf4.save(),
        filename: '$headerTitle-${DateTime.now().toString()}.pdf');
    await ReportApi.requestWebstatsUpload('printed_field_info');
  }


}

class ReportPrimaryBloc extends Bloc<ReportPrimaryState, bool>{

  @override
  bool get initialState => true;

  @override
  Stream<bool> mapEventToState(ReportPrimaryState event) async* {
    yield (event == ReportPrimaryState.enable) ? true : false;
  }

}

class ReportSecondaryBloc extends Bloc<ReportSecondaryState, bool>{

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(ReportSecondaryState event) async* {
    yield (event == ReportSecondaryState.enable) ? true : false;
  }
}
