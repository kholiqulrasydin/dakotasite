import 'package:dakotawebsite/datamodels/kelompokper_kecamatan.dart';
import 'package:dakotawebsite/datamodels/lahanper_kecamatan.dart';
import 'package:dakotawebsite/services/auth/report_api.dart';
import 'package:flutter/cupertino.dart';

class ReportViewModel extends ChangeNotifier {
  List<KelompokPerKecamatan> _kelompokReport = [];
  List<LahanPerKecamatan> _lahanReport = [];

  List<KelompokPerKecamatan> get kelompokReport => _kelompokReport;

  List<LahanPerKecamatan> get lahanReport => _lahanReport;

  set kelompokReportSetter(List<KelompokPerKecamatan> list) {
    _kelompokReport = list;
    notifyListeners();
  }

  set lahanReportSetter(List<LahanPerKecamatan> list) {
    _lahanReport = list;
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
}
