import 'package:flutter/material.dart';

import '../constants.dart';

class DayWidget extends StatelessWidget {
  final String text;
  const DayWidget({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.1,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: mainStyle.copyWith(color: Colors.white, fontSize: width / 40),
        ),
      ),
    );
  }
}
