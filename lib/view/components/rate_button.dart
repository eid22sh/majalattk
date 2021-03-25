import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../services/Language/language_service.dart';
import '../constants.dart';

class RateButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function onTap;
  const RateButton({
    Key key,
    this.onTap,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryBlue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<LanguageService>(
              builder: (context, language, child) {
                return Text(
                  language.data["data"][text],
                  style: welcomeTitleStyle.copyWith(
                      color: primaryBlue, fontSize: width * 0.05),
                  textDirection: language.data["direction"],
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
            icon ?? SvgPicture.asset("assets/icons/pen_2_plus.svg")
          ],
        ),
      ),
    );
  }
}
