import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

import '../../../../services/Language/language_service.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/providers_service.dart';
import '../../../components/day_widget.dart';
import '../../../components/working_times.dart';
import '../../../constants.dart';
import '../../ContinueRegisterScreen/continue_register_screen.dart';

class TimingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool sameLogedInUser = AuthService.instance.loggedinUser == null
        ? false
        : ProvidersService.instance.selectedProvider.id
                .compareTo(AuthService.instance.loggedinUser.id) ==
            0;
    return SizedBox(
      width: double.infinity,
      child: Consumer<LanguageService>(
        builder: (contextv, language, child) => Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    sameLogedInUser
                        ? navigator.pushNamed(ContinueRegistration.id)
                        // ignore: unnecessary_statements
                        : () {};
                  },
                  child: RichText(
                    textDirection: language.data["direction"],
                    text: TextSpan(
                      text: language.data["data"]["working_time"],
                      style: welcomeTitleStyle.copyWith(
                          color: primaryBlue, fontSize: width * 0.06),
                      children: [
                        sameLogedInUser
                            ? TextSpan(
                                text: " " + language.data["data"]["edit"],
                                style: welcomeTitleStyle.copyWith(
                                    color: Colors.red, fontSize: width * 0.05),
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
                  "assets/icons/time_1.svg",
                  height: 24,
                  width: 24,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 0.1, blurRadius: 5)
                  ]),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DayWidget(
                          text: language.data["data"]["sat"],
                        ),
                        DayWidget(
                          text: language.data["data"]["sun"],
                        ),
                        DayWidget(
                          text: language.data["data"]["mon"],
                        ),
                        DayWidget(
                          text: language.data["data"]["tue"],
                        ),
                        DayWidget(
                          text: language.data["data"]["wed"],
                        ),
                        DayWidget(
                          text: language.data["data"]["thu"],
                        ),
                        DayWidget(
                          text: language.data["data"]["fri"],
                        )
                      ].reversed.toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: ProvidersService.instance.getWorkingDays(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                            break;
                          case ConnectionState.active:
                            return CircularProgressIndicator();
                            break;
                          case ConnectionState.done:
                            return snapshot.data["status"]
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      WorkingTimes(
                                        data: snapshot.data["data"]
                                                ["saturday"] ??
                                            {"from": "-", "to": "-"},
                                      ),
                                      WorkingTimes(
                                        data: snapshot.data["data"]["sunday"] ??
                                            {"from": "-", "to": "-"},
                                      ),
                                      WorkingTimes(
                                        data: snapshot.data["data"]["monday"] ??
                                            {"from": "-", "to": "-"},
                                      ),
                                      WorkingTimes(
                                        data: snapshot.data["data"]
                                                ["tuesday"] ??
                                            {"from": "-", "to": "-"},
                                      ),
                                      WorkingTimes(
                                        data: snapshot.data["data"]
                                                ["wednesday"] ??
                                            {"from": "-", "to": "-"},
                                      ),
                                      WorkingTimes(
                                        data: snapshot.data["data"]
                                                ["thursday"] ??
                                            {"from": "-", "to": "-"},
                                      ),
                                      WorkingTimes(
                                        data: snapshot.data["data"]["friday"] ??
                                            {"from": "-", "to": "-"},
                                      ),
                                    ].reversed.toList())
                                : Text("Error 404");
                            break;
                          default:
                            return SizedBox.shrink();
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
