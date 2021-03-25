import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/services/storage_service.dart';
import 'package:majalatek/view/constants.dart';
import 'package:majalatek/view/screens/HomeScreen/home_screen.dart';
import 'package:majalatek/view/screens/WelcomingScreens/welcome_screen1.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  GifController controller;

  @override
  void initState() {
    super.initState();
    controller = GifController(vsync: this, duration: Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.repeat(min: 0, max: 53, period: Duration(milliseconds: 2000));
      Future.delayed(Duration(seconds: 5), () async {
        String lang = await StorageService.instacne.getLanguage();
        if (lang.compareTo("404") == 0) {
          navigator.pushNamed(WelcomeScreen1.id);
        } else {
          await LanguageService.instance.changeLanguage(lang);
          navigator.pushNamed(HomeScreen.id);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GifImage(
        height: height,
        width: width,
        controller: controller,
        image: AssetImage("assets/images/splash_screen.gif"),
      ),
    );
  }
}
