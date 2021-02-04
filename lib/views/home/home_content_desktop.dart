import 'package:flutter/material.dart';
import 'package:dakotawebsite/widgets/call_to_action/call_to_action.dart';
import 'package:dakotawebsite/widgets/course_details/course_details.dart';

class HomeContentDesktop extends StatelessWidget {
  const HomeContentDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 45,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CourseDetails(),
            Container(
              height: 180,
              width: 180,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: Image.asset('assets/logo.png'),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            CallToAction('Dashboard'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
            ),
          ],
        ),
      ],
    );
  }
}
