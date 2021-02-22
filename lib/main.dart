import 'package:dakotawebsite/viewmodels/bantuan_usaha_view_model.dart';
import 'package:dakotawebsite/viewmodels/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dakotawebsite/viewmodels/web_mode_model.dart';
import 'package:dakotawebsite/views/auth/wrapper.dart';
import 'package:dakotawebsite/views/layout_template/layout_template.dart';

import 'locator.dart';

void main() {
  setupLocator();
  setPrefs();
  runApp(MyApp());
}

void setPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  if(prefs.getString('token') == null || prefs.getString('token').isEmpty )
    prefs.setString('token', null);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WebMode()),
        ChangeNotifierProvider(create: (context) => ReportViewModel()),
        ChangeNotifierProvider(create: (context) => BantuanUsahaViewModel())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ReportPrimaryBloc>(builder: (context) => ReportPrimaryBloc()),
          BlocProvider<ReportSecondaryBloc>(builder: (context) => ReportSecondaryBloc()),
        ],
        child: MaterialApp(
          title: 'SIMENTAN',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
          ),
          home: MainApp()
        ),
      )
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WebMode>(
      builder: (context, webMode, _)
      => MaterialApp(
        title: 'SIMENTAN',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
        ),
        home: webMode.auth ? AuthWrapper() : LayoutTemplate(),
      ),
    );
  }
}

