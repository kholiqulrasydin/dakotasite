import 'package:flutter/material.dart';
import 'package:dakotawebsite/widgets/call_to_action/call_to_action.dart';
import 'package:dakotawebsite/widgets/course_details/course_details.dart';

class HomeContentMobile extends StatelessWidget {
  const HomeContentMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 18,
          ),
          CourseDetails(),
          SizedBox(
            height: 100,
          ),
          CallToAction('Dashboard'),
        ],
      ),
    );
  }
}
