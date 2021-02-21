import 'package:dakotawebsite/datamodels/bantuan_usaha.dart';
import 'package:dakotawebsite/services/auth/report_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:dakotawebsite/widgets/dashboard/widgets/pie_chart/pie_chart.dart';

class BantuanUsahaViewModel extends ChangeNotifier {
  List<BantuanUsahaCount> _bantuanUsahaCountList = [];
  List<Category> _category = [];

  set bantuanUsahaCountSetter(List<BantuanUsahaCount> list) {
    _bantuanUsahaCountList = list;
    notifyListeners();
  }

  set categorySetter(List<Category> list) {
    _category = list;
    notifyListeners();
  }

  List<BantuanUsahaCount> get bantuanUsahaCountList => _bantuanUsahaCountList;

  List<Category> get category => _category;

  static Future<void> getBantuanUsahaCountAll(
      BantuanUsahaViewModel viewModel) async {
    List<BantuanUsahaCount> ls = [];
    Map<String, dynamic> dyn = await ReportApi.requestTotalBantuanUsahaAll();
    ls.add(BantuanUsahaCount(
        alsintan: dyn['alsintan'],
        sarpras: dyn['sarpras'],
        bibit: dyn['bibit'],
        ternak: dyn['ternak'],
        perikanan: dyn['perikanan'],
        lainnya: dyn['lainnya']));
    viewModel.bantuanUsahaCountSetter = ls;
    viewModel.categoryset = ls;
    return print('Welcome To Dashboard');
  }

  set categoryset(List<BantuanUsahaCount> count){
    _category.addAll({
      Category('${count.first.alsintan.toString()} bantuan alsintan',
          amount: double.parse(count.first.alsintan.toString())),
      Category('${count.first.sarpras.toString()} bantuan sarpras',
          amount: double.parse(count.first.sarpras.toString())),
      Category('${count.first.bibit.toString()} bantuan bibit',
          amount: double.parse(count.first.bibit.toString())),
      Category('${count.first.ternak.toString()} bantuan ternak',
          amount: double.parse(count.first.ternak.toString())),
      Category('${count.first.perikanan.toString()} bantuan perikanan',
          amount: double.parse(count.first.perikanan.toString())),
      Category('${count.first.lainnya.toString()} bantuan lainnya',
          amount: double.parse(count.first.lainnya.toString()))
    });
    notifyListeners();
  }

}
