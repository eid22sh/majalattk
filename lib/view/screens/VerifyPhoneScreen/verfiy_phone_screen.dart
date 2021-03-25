import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/auth_service.dart';
import 'package:majalatek/view/dialogs/error_dialog.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';
import 'package:majalatek/view/screens/HomeScreen/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../services/Language/language_service.dart';
import '../../components/borderRoundedButton.dart';
import '../../components/custom_text_field_widget.dart';
import '../../constants.dart';

class VerifyPhoneScreen extends StatefulWidget {
  static const id = "/beforeLogin/VerifyPhoneScreen";
  static String phone;
  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  var code = "";
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
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    language.data["data"]["app_name"],
                    style: welcomeTitleStyle.copyWith(color: primaryBlue),
                  ),
                  Text(
                    language.data["data"]["otp_text"],
                    textAlign: TextAlign.center,
                    style: welcomeTitleStyle.copyWith(
                        fontSize: 14,
                        color: primaryBlue,
                        fontWeight: FontWeight.w200),
                  ),
                  space24,
                  CustomTextField(
                    inputype: TextInputType.phone,
                    suffixWidget: SizedBox.shrink(),
                    onChanged: (value) {
                      code = value;
                    },
                  ),
                  space24,
                  InkWell(
                    onTap: () async {
                      Get.dialog(WaitPopup());
                      await AuthService.instance.login(VerifyPhoneScreen.phone);
                      Get.back();
                    },
                    child: Text(
                      language.data["data"]["resend_otp_text"],
                      textAlign: TextAlign.center,
                      style: welcomeTitleStyle.copyWith(
                          fontSize: 14,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  space24,
                  BorderRoundedButton(
                    text: language.data["data"]["verify"],
                    onTap: () async {
                      Get.dialog(WaitPopup());
                      Map verified = await AuthService.instance
                          .verify(VerifyPhoneScreen.phone, code);
                      Get.back();
                      if (verified["status"]) {
                        navigator.pushNamed(HomeScreen.id);
                      } else {
                        Get.dialog(
                          ErrorPopup(
                            errorText: verified["message"],
                          ),
                        );
                      }
                    },
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
