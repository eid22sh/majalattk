import 'package:flutter/material.dart';

import '../constants.dart';

class WorkingTimes extends StatelessWidget {
  final Map data;

  const WorkingTimes({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      width: width * 0.1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 0.1, blurRadius: 0.2)
          ]),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              data["from"],
              style: mainStyle.copyWith(
                  color: primaryBlue, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
            child: Text(
              data["to"],
              style: mainStyle.copyWith(
                  color: primaryBlue, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
