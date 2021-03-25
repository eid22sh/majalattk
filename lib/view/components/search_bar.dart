import 'package:flutter/material.dart';
import 'package:majalatek/view/constants.dart';

class SearchBar extends StatelessWidget {
  final Widget leftIcon;
  final Widget rightIcon;
  final String text;
  final TextDirection textDirection;

  const SearchBar(
      {Key key,
      this.leftIcon,
      this.rightIcon,
      this.text,
      this.textDirection = TextDirection.rtl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26)]),
      child: Row(
        children: [
          leftIcon ?? SizedBox.shrink(),
          Expanded(
              child: Text(
            text,
            textDirection: textDirection,
            style: highlightStyle,
          )),
          rightIcon ?? SizedBox.shrink()
        ],
      ),
    );
  }
}
