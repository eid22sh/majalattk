import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/view/components/borderRoundedButton.dart';
import 'package:majalatek/view/constants.dart';
import 'package:majalatek/view/screens/PhoneScreen/phone_screen.dart';
import 'package:majalatek/view/screens/RegisterScreen/register_screen.dart';
import 'package:provider/provider.dart';

class BeforeLoginScreen extends StatelessWidget {
  static const id = "/beforeLogin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: primaryBlue,
          ),
          onPressed: navigator.pop,
        ),
      ),
      body: Center(
        child: Consumer<LanguageService>(
          builder: (context, language, child) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    language.data["data"]["app_name"],
                    style: welcomeTitleStyle.copyWith(color: primaryBlue),
                  ),
                  Text(
                    language.data["data"]["dont_search_for_client"],
                    textAlign: TextAlign.center,
                    style: welcomeTitleStyle.copyWith(
                        color: primaryBlue, fontWeight: FontWeight.w200),
                  ),
                  space24,
                  BorderRoundedButton(
                    onTap: () {
                      navigator.pushNamed(PhoneScreen.id);
                    },
                    text: language.data["data"]["login"],
                  ),
                  space24,
                  BorderRoundedButton(
                    onTap: () {
                      navigator.pushNamed(RegisterScreen.id);
                    },
                    color: Colors.yellow[800],
                    text: language.data["data"]["register"],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
