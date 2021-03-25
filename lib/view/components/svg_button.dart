import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGButton extends StatelessWidget {
  final String location;
  final Function onTap;
  final double height;
  final double width;
  final Color color;
  const SVGButton(
      {Key key, this.location, this.onTap, this.height, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          location,
          height: this.height,
          width: this.width,
          color: color,
        ));
  }
}
