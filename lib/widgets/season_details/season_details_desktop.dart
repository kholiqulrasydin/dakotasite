import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dakotawebsite/styles/text_styles.dart';

class SeasonDetailsDesktop extends StatelessWidget {
  final dynamic details;
  SeasonDetailsDesktop(this.details);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            details.title,
            style: titleTextStyle(sizingInformation.deviceScreenType),
          ),
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Text(
              details.description,
              style: descriptionTextStyle(sizingInformation.deviceScreenType),
            ),
          )
        ],
      ),
    );
  }
}