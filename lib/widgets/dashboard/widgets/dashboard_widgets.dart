import 'package:flutter/material.dart';

class InfoNumeric extends StatelessWidget {
  const InfoNumeric({
    this.title,
    this.value,
    @required this.numColor,
    @required this.titleColor,
    Key key,
  }) : super(key: key);
  final String title;
  final String value;
  final Color numColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$value", style: TextStyle(fontSize: 59, color: numColor),),
          Text("$title", style: TextStyle(fontSize: 16, color: titleColor),)
        ],
      ),
    );
  }
}

class ExpandedInfo extends StatelessWidget {
  const ExpandedInfo({
    Key key,
    @required this.numColor,
    @required this.titleColor,
    @required this.title,
    @required this.numValue,
    @required this.onPressed,
  }) : super(key: key);

  final Color numColor;
  final Color titleColor;
  final String title;
  final String numValue;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoNumeric(numColor: numColor, titleColor: titleColor, title: title, value: numValue,),
          RaisedButton(onPressed: onPressed, shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(color: Colors.black38)
          ),
            color: Colors.white,
            child: Text('lihat selengkapnya  '),
          )
        ],
      ),
    );
  }
}


