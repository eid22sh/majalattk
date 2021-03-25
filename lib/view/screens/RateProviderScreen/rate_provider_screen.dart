import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:majalatek/utils/textValidator/validator.dart';
import 'package:majalatek/view/components/drawer/drawe.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';
import 'package:provider/provider.dart';

import '../../../services/Language/language_service.dart';
import '../../../services/providers_service.dart';
import '../../components/app_bar_icons.dart';
import '../../components/profile_picture_widget.dart';
import '../../components/rate_button.dart';
import '../../constants.dart';
import 'widgets/rate_line_widget.dart';

class RateProviderScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static const String id = "/SpecialScreen/RateProvider";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.3,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Image.network(
                        ProvidersService.instance.selectedProvider.image,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Consumer<LanguageService>(
                              builder: (context, language, child) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: height * 0.1,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      language.data["data"]
                                          ["please_write_your_rating"],
                                      textDirection: language.data["direction"],
                                      style: welcomeTitleStyle.copyWith(
                                          color: primaryBlue,
                                          fontSize: width * 0.06),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/star.svg",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ],
                                ),
                                space24,
                                Container(
                                  width: width,
                                  height: height * 0.2,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          blurRadius: 2.0,
                                          spreadRadius: 3.0),
                                    ],
                                  ),
                                  child: Form(
                                    key: _formkey,
                                    child: TextFormField(
                                      textAlign: TextAlign.end,
                                      style: mainStyle.copyWith(
                                          color: primaryBlue),
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      onChanged: (value) {
                                        comment = value;
                                      },
                                      validator: Validator.validateText,
                                    ),
                                  ),
                                ),
                                space24,
                                RateLineWidget(
                                  text: language.data["data"]["rating_quality"],
                                  onRate: (value) {
                                    quality = value;
                                  },
                                ),
                                RateLineWidget(
                                  text: language.data["data"]["rating_time"],
                                  onRate: (value) {
                                    time = value;
                                  },
                                ),
                                RateLineWidget(
                                  text: language.data["data"]["rating_polite"],
                                  onRate: (value) {
                                    politeness = value;
                                  },
                                ),
                                RateLineWidget(
                                  text: language.data["data"]["rating_price"],
                                  onRate: (value) {
                                    satisfied = value;
                                  },
                                ),
                                RateLineWidget(
                                  text: language.data["data"]
                                      ["rating_recommend"],
                                  onRate: (value) {
                                    again = value;
                                  },
                                ),
                                space24,
                                RateButton(
                                    text: "rate",
                                    icon: SizedBox.shrink(),
                                    onTap: () async {
                                      if (_formkey.currentState.validate()) {
                                        Get.dialog(WaitPopup());
                                        await ProvidersService.instance
                                            .rateProvider(
                                                politeness,
                                                time,
                                                quality,
                                                again,
                                                satisfied,
                                                comment);
                                        Get.back();
                                        Get.back();
                                      }
                                    }),
                                SizedBox(
                                  height: height,
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: width,
                  height: 128,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TopAppIcons(
                        listTapped: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Text(
                          ProvidersService.instance.selectedProvider.name,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style:
                              welcomeBodyStyle.copyWith(fontSize: width * 0.05),
                        ),
                      )
                    ],
                  ),
                  minimum: EdgeInsets.only(left: 16, top: 32.0, right: 16),
                ),
                ProfilePicture()
              ],
            ),
          ),
        ));
  }
}

var quality = 0.0;
var time = 0.0;
var politeness = 0.0;
var satisfied = 0.0;
var again = 0.0;
var comment = "";
