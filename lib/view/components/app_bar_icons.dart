import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/utils/url_launcher.dart';
import 'package:majalatek/view/components/svg_button.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class TopAppIcons extends StatelessWidget {
  final Color color;
  final Function listTapped;
  const TopAppIcons({
    Key key,
    this.color,
    @required this.listTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SVGButton(
          location: "assets/icons/no_cr.svg",
          height: width * 0.06,
          color: color,
          onTap: () {
            navigator.maybePop();
          },
        ),
        SizedBox(
          width: 20,
        ),
        SVGButton(
          onTap: listTapped,
          location: "assets/icons/list.svg",
          height: width * 0.055,
          color: color,
        ),
        // SizedBox(
        //   width: 20,
        // ),
        // SVGButton(
        //   location: "assets/icons/notifications-bell-button.svg",
        //   height: width * 0.06,
        //   color: color,
        // ),
        SizedBox(
          width: 20,
        ),
        SVGButton(
          location: "assets/icons/email.svg",
          height: width * 0.055,
          color: color,
          onTap: () async {
            await UrlLauncher.launchURL("mailto:cr@majalattk.com");
          },
        )
      ],
    );
  }
}
