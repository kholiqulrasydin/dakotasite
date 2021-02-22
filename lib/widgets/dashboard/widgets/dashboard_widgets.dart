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

class OnHoverCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final String percentComplete;
  final IconData icon;
  OnHoverCard({
    this.color,
    this.progressIndicatorColor,
    this.percentComplete,
    this.projectName,
    this.icon,
  });
  @override
  _OnHoverCardState createState() => _OnHoverCardState();
}

class _OnHoverCardState extends State<OnHoverCard> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (value) {
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 275),
        height: hovered ? 180.0 : 175.0,
        width: hovered ? 220.0 : 215.0,
        decoration: BoxDecoration(
            color: hovered ? widget.color : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
                spreadRadius: 5.0,
              ),
            ]),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              AnimatedContainer(duration: Duration(milliseconds: 275), child: Text("${widget.percentComplete}", style: TextStyle(fontSize: 59, color: hovered ? Colors.white : widget.color),),),
              Row(
                children: [
                  SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.white : Colors.black,
                      size: 16.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: hovered ? Colors.white : widget.color,
                    ),
                  ),
                  SizedBox(
                    width: 13.0,
                  ),
                  Container(
                    child: Text(
                      widget.projectName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnHoverGreetingsCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final String percentComplete;
  final IconData icon;
  OnHoverGreetingsCard({
    this.color,
    this.progressIndicatorColor,
    this.percentComplete,
    this.projectName,
    this.icon,
  });
  @override
  _OnHoverGreetingsCardState createState() => _OnHoverGreetingsCardState();
}

class _OnHoverGreetingsCardState extends State<OnHoverGreetingsCard> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (value) {
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 275),
        height: hovered ? 100.0 : 95.0,
        width: hovered ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width - 5,
        decoration: BoxDecoration(
            color: hovered ? widget.color : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
                spreadRadius: 5.0,
              ),
            ]),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: AnimatedContainer(duration: Duration(milliseconds: 275), child: Text("${widget.percentComplete}", style: TextStyle(fontSize: 52, color: hovered ? Colors.white : widget.color),textAlign: TextAlign.center,),),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.white : Colors.black,
                      size: 16.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: hovered ? Colors.white : widget.color,
                    ),
                  ),
                  SizedBox(
                    width: 13.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      widget.projectName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

