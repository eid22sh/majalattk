import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/view/constants.dart';
import 'package:majalatek/view/screens/WelcomingScreens/lang_screen.dart';
import 'package:majalatek/view/screens/WelcomingScreens/widgets/animated_image.dart';

class WelcomeScreen1 extends StatelessWidget {
  static const String id = "/welcome1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: AnimatedImage(),
          ),
          InkWell(
            onTap: () {
              navigator.pushNamed(LangScreen.id);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.9),
                    ]),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 50,
            child: Image.asset(
              "assets/images/logo.png",
              height: 50,
            ),
          ),
          Positioned(
              bottom: 50,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                      text: "انهي عناء البحث",
                      style: mainStyle.copyWith(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "\n"),
                        TextSpan(
                          text: "تطبيق واحد لجميع الخدمات",
                          style: mainStyle.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                  textDirection: TextDirection.rtl,
                ),
              ))
        ],
      ),
    );
  }
}
