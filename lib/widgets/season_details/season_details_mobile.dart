import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dakotawebsite/styles/text_styles.dart';

class SeasonDetailsMobile extends StatelessWidget {
  final dynamic details;
  SeasonDetailsMobile(this.details);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Column(
        children: <Widget>[
          Text(
            details.title,
            style: titleTextStyle(sizingInformation.deviceScreenType),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            details.description,
            style: descriptionTextStyle(sizingInformation.deviceScreenType),
          ),
        ],
      ),
    );
  }
}
