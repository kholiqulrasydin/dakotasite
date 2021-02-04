import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dakotawebsite/constants/app_colors.dart';
import 'package:dakotawebsite/main.dart';
import 'package:dakotawebsite/viewmodels/web_mode_model.dart';

class CallToActionMobile extends StatelessWidget {
  final String title;

  const CallToActionMobile(this.title);

  @override
  Widget build(BuildContext context) {
    return Consumer<WebMode>(
        builder: (context, webMode, _) => FlatButton(
              height: 60,
              minWidth: MediaQuery.of(context).size.width * 0.80,
              color: Colors.teal,
              textColor: Colors.white,
              hoverColor: primaryColor,
              onPressed: () {
                webMode.auth = true;
                Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (_, __, ___) => MainApp()
                    )
                );
              },
              child: Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
            ));
  }
}
