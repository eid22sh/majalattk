import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../constants.dart';

class ErrorPopup extends StatelessWidget {
  final String errorText;

  const ErrorPopup({Key key, this.errorText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.1),
      child: InkWell(
        onTap: () {
          navigator.pop();
        },
        child: Center(
          child: Container(
            height: width * 0.35,
            width: width * 0.65,
            decoration: BoxDecoration(
                color: primaryBlue, borderRadius: BorderRadius.circular(8.0)),
            child: Center(
              child: Text(
                errorText,
                textAlign: TextAlign.center,
                style: mainStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
