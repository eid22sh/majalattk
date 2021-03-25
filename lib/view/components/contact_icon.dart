import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majalatek/view/constants.dart';

class ContactIcon extends StatelessWidget {
  final Function onTap;
  final String assetName;
  final String name;
  final Color color;
  final TextStyle style;

  const ContactIcon(
      {Key key, this.onTap, this.assetName, this.name, this.style, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            assetName,
            color: color,
            height: 24,
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: width / 10,
            child: Text(
              name,
              style: style,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
