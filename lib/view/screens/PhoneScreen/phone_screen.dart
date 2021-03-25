import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/auth_service.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';
import 'package:provider/provider.dart';

import '../../../services/Language/language_service.dart';
import '../../bloc/flagBloc/flag_bloc.dart';
import '../../components/borderRoundedButton.dart';
import '../../components/custom_text_field_widget.dart';
import '../../components/flag_drop_down.dart';
import '../../constants.dart';
import '../VerifyPhoneScreen/verfiy_phone_screen.dart';

class PhoneScreen extends StatefulWidget {
  static const id = "/beforeLogin/phonescreen";

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  var phone = "";
  //TODO : This changes depending on the first country added in the backend

  var country = "00966";
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
                    language.data["data"]["phone_page_text"],
                    textAlign: TextAlign.center,
                    style: welcomeTitleStyle.copyWith(
                        fontSize: 14,
                        color: primaryBlue,
                        fontWeight: FontWeight.w200),
                  ),
                  space24,
                  Row(
                    children: [
                      BlocBuilder(
                        cubit: FlagBloc.instance,
                        builder: (context, data) {
                          return FlagDropDown(
                            data: data,
                            country: country,
                            onChanged: (value) {
                              setState(
                                () {
                                  country = value;
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          inputype: TextInputType.phone,
                          suffixWidget: SizedBox.shrink(),
                          onChanged: (value) {
                            phone = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  space24,
                  BorderRoundedButton(
                    onTap: () async {
                      if (phone.startsWith("0")) {
                        phone = phone.substring(1);
                      }
                      Get.dialog(WaitPopup());
                      await AuthService.instance.login(country + phone);
                      VerifyPhoneScreen.phone = country + phone;
                      Get.back();
                      navigator.pushNamed(VerifyPhoneScreen.id);
                    },
                    text: language.data["data"]["continue"],
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
