import 'dart:convert';

import 'package:dakotawebsite/datamodels/kelompokper_kecamatan.dart';
import 'package:dakotawebsite/datamodels/lahanper_kecamatan.dart';
import 'package:dakotawebsite/viewmodels/report_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportApi{

  static Future<bool> requestKelompokPerKecamatan(ReportViewModel reportViewModel) async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/dakota/groupByKecamatan',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      List group = jsonDecode(content);
      reportViewModel.kelompokReportSetter = group.map((e) => KelompokPerKecamatan.fromJson(e)).toList();
      print('fetch 200! ${group.length}');
      return true;
    }else{
      return false;
    }
  }

  static Future<List<LahanPerKecamatan>> requestLahanPerKecamatan() async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/dakota/dakotaLahanGroupByKecamatan',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      List group = jsonDecode(content);
      return group.map((e) => LahanPerKecamatan.fromJson(e)).toList();
    }else{
      return [];
    }
  }


  static Future<Map<String, dynamic>> requestTotalBantuanUsahaAll() async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/bantuanusaha/countdata',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      Map<String, dynamic> mappedContent = jsonDecode(content);
      Map<String, dynamic> group = mappedContent['count'];
      return group;
    }else{
      return {};
    }
  }

  static Future<int> requestCountDakotaByUser() async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/dakota/dakotaCountCreatedBy',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      return int.parse(content);
    }else{
      return 0;
    }
  }

  static Future<int> requestGalleryCountByUser() async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/gallery/galleryCountByUser',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      return int.parse(content);
    }else{
      return 0;
    }
  }

  static Future<void> requestWebstatsUpload(String action) async {
    final prefs = await SharedPreferences.getInstance();

    return await http.get(
      'http://apidinper.reboeng.com/api/webstats/onAction/$action',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

  }

  static Future<int> requestWebstatsCountedPrint(String action) async {

    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/webstats/$action',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      return int.parse(content);
    }else{
      return 0;
    }

  }

  static Future<int> requestCountDakota() async {

    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/dakota/countall',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      return int.parse(content);
    }else{
      return 0;
    }

  }

  static Future<int> requestCountUser() async {

    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/account/countUser',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      return int.parse(content);
    }else{
      return 0;
    }

  }

  static Future<int> requestCountAdmin() async {

    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/account/countAdmin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      return int.parse(content);
    }else{
      return 0;
    }

  }

  static Future<int> requestCountAccount() async {

    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      'http://apidinper.reboeng.com/api/account/countTotal',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if(response.statusCode == 200){
      String content = response.body;
      return int.parse(content);
    }else{
      return 0;
    }

  }

}