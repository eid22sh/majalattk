import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;

///These constants are related to colors
const primaryBlue = Color(0xff2386c9);
const primaryBlue20 = Color(0x552386c9);

const blueGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [primaryBlue, primaryBlue20]);

///These constants are related to sizes and dimensions
final height = getx.Get.height;
final width = getx.Get.width;

///These constants are related to Text styles
final welcomeTitleStyle = TextStyle(
    fontFamily: "NotoKufi",
    fontSize: width * 0.07,
    color: Colors.white,
    fontWeight: FontWeight.bold);

final welcomeBodyStyle = TextStyle(
  fontFamily: "NotoKufi",
  fontSize: width * 0.04,
  color: Colors.white,
);

final highlightStyle = TextStyle(
  fontFamily: "NotoKufi",
  fontSize: width * 0.04,
  color: Colors.grey,
);

final mainStyle = TextStyle(
  fontFamily: "NotoKufi",
  fontSize: width * 0.04,
  color: Colors.black45,
);

final contactStyle =
    mainStyle.copyWith(fontWeight: FontWeight.bold, fontSize: width * 0.02);

// Splitter

final greySpliter = Container(
  height: 30,
  width: 2.5,
  color: Colors.grey[400],
);

// Spaces

const space24 = SizedBox(height: 24);
