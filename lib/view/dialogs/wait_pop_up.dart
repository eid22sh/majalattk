import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/view/constants.dart';

class WaitPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.black.withOpacity(0.1),
      child: InkWell(
        onTap: () {
          navigator.pop();
        },
        child: Center(
          child: Container(
            height: _width * 0.35,
            width: _width * 0.35,
            decoration: BoxDecoration(
                color: primaryBlue, borderRadius: BorderRadius.circular(8.0)),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: primaryBlue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
