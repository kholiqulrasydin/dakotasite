import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Aplikasi Ini dikelola oleh\nDinas Pertanian, Perikanan, dan Ketahanan Pangan\nKabupaten Ponorogo',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
