import 'package:flutter/material.dart';
import 'package:majalatek/view/constants.dart';

class BorderRoundedButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color color;
  const BorderRoundedButton({Key key, this.onTap, this.text = "", this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        width: width,
        decoration: BoxDecoration(
            color: color ?? primaryBlue,
            borderRadius: BorderRadius.circular(height * 0.01)),
        alignment: Alignment.center,
        child: Text(
          text,
          style: welcomeTitleStyle.copyWith(fontSize: width * 0.05),
        ),
      ),
    );
  }
}
