import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../services/Language/language_service.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/providers_service.dart';
import '../../../constants.dart';
import '../../UpdateScreen/update_screen.dart';

// ignore: must_be_immutable
class DescriptionWidget extends StatelessWidget {
  bool sameLogedInUser = AuthService.instance.loggedinUser == null
      ? false
      : ProvidersService.instance.selectedProvider.id
              .compareTo(AuthService.instance.loggedinUser.id) ==
          0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Consumer<LanguageService>(
            builder: (contextv, language, child) => Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          sameLogedInUser
                              ? navigator.pushNamed(UpdateScreen.id)
                              // ignore: unnecessary_statements
                              : () {};
                        },
                        child: RichText(
                          textDirection: language.data["direction"],
                          text: TextSpan(
                            text: language.data["data"]["provider_about"],
                            style: welcomeTitleStyle.copyWith(
                                color: primaryBlue, fontSize: width * 0.06),
                            children: [
                              sameLogedInUser
                                  ? TextSpan(
                                      text: " " + language.data["data"]["edit"],
                                      style: welcomeTitleStyle.copyWith(
                                          color: Colors.red,
                                          fontSize: width * 0.05),
                                    )
                                  : TextSpan(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        "assets/icons/edit.svg",
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                  Text(
                    ProvidersService.instance.selectedProvider.description,
                    textDirection: TextDirection.rtl,
                    style: mainStyle.copyWith(color: primaryBlue),
                  )
                ])));
  }
}
