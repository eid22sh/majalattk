import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/view/components/borderRoundedButton.dart';
import 'package:majalatek/view/constants.dart';
import 'package:majalatek/view/screens/HomeScreen/home_screen.dart';
import 'package:majalatek/view/screens/WelcomingScreens/widgets/lang_item.dart';

class LangScreen extends StatefulWidget {
  static const String id = "/choose_lang";

  @override
  _LangScreenState createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  var arabic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.15),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.06, vertical: width * 0.03),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_drop_down,
                                color: Colors.grey[700]),
                            Text(
                              'يرجى اختيار لغة التطبيق',
                              style: welcomeBodyStyle.copyWith(
                                  color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      LangItem(
                        onTap: () {
                          setState(() {
                            arabic = !arabic;
                          });
                        },
                        checked: !arabic,
                        svgFile: "assets/icons/uk_flag.svg",
                        text: "English",
                      ),
                      SizedBox(height: height * 0.02),
                      LangItem(
                        onTap: () {
                          setState(() {
                            arabic = !arabic;
                          });
                        },
                        svgFile: "assets/icons/saudi_flag.svg",
                        text: "Arabic",
                        checked: arabic,
                      ),
                      SizedBox(height: height * 0.07),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.04),
                BorderRoundedButton(
                  onTap: () async {
                    arabic
                        ? await LanguageService.instance.changeLanguage("ar")
                        : await LanguageService.instance.changeLanguage("en");
                    navigator.pushNamed(HomeScreen.id);
                  },
                  text: "ابدأ",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
