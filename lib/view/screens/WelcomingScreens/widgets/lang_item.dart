import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majalatek/view/constants.dart';

class LangItem extends StatelessWidget {
  final bool checked;
  final String text;
  final String svgFile;
  final Function onTap;
  const LangItem(
      {Key key,
      this.checked = true,
      this.text = "",
      this.onTap,
      @required this.svgFile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: checked ? Colors.grey[200] : Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...{
                    if (text.compareTo("English") == 0)
                      SvgPicture.asset(
                        svgFile,
                        height: height * 0.05,
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: SizedBox(
                          width: height * 0.05,
                          height: height * 0.05,
                          child: SvgPicture.asset(
                            svgFile,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  },
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text(
                    text,
                    style: welcomeBodyStyle.copyWith(color: Colors.grey[700]),
                  ),
                ],
              ),
              checked
                  ? SvgPicture.asset(
                      "assets/icons/check.svg",
                      height: height * 0.045,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
