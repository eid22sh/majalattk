import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

import '../../../services/Language/language_service.dart';
import '../../../services/providers_service.dart';
import '../../components/borderRoundedButton.dart';
import '../../components/day_widget.dart';
import '../../components/working_times.dart';
import '../../constants.dart';
import '../../dialogs/pick_time_dialog.dart';
import '../../dialogs/wait_pop_up.dart';
import '../SpecialProfileScreen/special_profile_screen.dart';

class ContinueRegistration extends StatefulWidget {
  static const id = "/register/continue";

  @override
  _ContinueRegistrationState createState() => _ContinueRegistrationState();
}

class _ContinueRegistrationState extends State<ContinueRegistration> {
  var saturday = {"from": "-", "to": "-"};

  var sunday = {"from": "-", "to": "-"};

  var monday = {"from": "-", "to": "-"};

  var tuesday = {"from": "-", "to": "-"};

  var wednesday = {"from": "-", "to": "-"};

  var thursday = {"from": "-", "to": "-"};

  var friday = {"from": "-", "to": "-"};

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigator.pop();
        navigator.pop();
        navigator.pushNamed(ProfileScreen.id);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: primaryBlue,
            ),
            onPressed: () {
              navigator.pop();
              navigator.pop();
              navigator.pushNamed(ProfileScreen.id);
            },
          ),
        ),
        body: Consumer<LanguageService>(
          builder: (context, language, child) => SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async {
                                var sat = await Get.dialog(
                                  PickTimeDialog(),
                                );
                                setState(() {
                                  saturday = sat ?? {"from": "-", "to": "-"};
                                });
                              },
                              child: WorkingTimes(
                                data: saturday,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var sun = await Get.dialog(
                                  PickTimeDialog(),
                                );
                                setState(() {
                                  sunday = sun ?? {"from": "-", "to": "-"};
                                });
                              },
                              child: WorkingTimes(
                                data: sunday,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var mon = await Get.dialog(
                                  PickTimeDialog(),
                                );
                                setState(() {
                                  monday = mon ?? {"from": "-", "to": "-"};
                                });
                              },
                              child: WorkingTimes(
                                data: monday,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var tue = await Get.dialog(
                                  PickTimeDialog(),
                                );
                                setState(() {
                                  tuesday = tue ?? {"from": "-", "to": "-"};
                                });
                              },
                              child: WorkingTimes(
                                data: tuesday,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var wed = await Get.dialog(
                                  PickTimeDialog(),
                                );
                                setState(() {
                                  wednesday = wed ?? {"from": "-", "to": "-"};
                                });
                              },
                              child: WorkingTimes(
                                data: wednesday,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var thur = await Get.dialog(
                                  PickTimeDialog(),
                                );
                                setState(() {
                                  thursday = thur ?? {"from": "-", "to": "-"};
                                });
                              },
                              child: WorkingTimes(
                                data: thursday,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var fri = await Get.dialog(
                                  PickTimeDialog(),
                                );
                                setState(() {
                                  friday = fri ?? {"from": "-", "to": "-"};
                                });
                              },
                              child: WorkingTimes(
                                data: friday,
                              ),
                            ),
                          ].reversed.toList(),
                        ),
                      ),
                    ],
                  ),
                  space24,
                  BorderRoundedButton(
                    text: language.data["data"]["submit"],
                    onTap: () async {
                      Get.dialog(WaitPopup());
                      await ProvidersService.instance.updateWorkingDays(
                        saturdayFrom: saturday["from"],
                        saturdayTo: saturday["to"],
                        sundayFrom: sunday["from"],
                        sundayTo: sunday["to"],
                        mondayFrom: monday["from"],
                        mondayTo: monday["to"],
                        tuesdayFrom: tuesday["from"],
                        tuesdayTo: tuesday["to"],
                        wednesdayFrom: wednesday["from"],
                        wednesdayTo: wednesday["to"],
                        thursdayFrom: thursday["from"],
                        thursdayTo: thursday["to"],
                        fridayFrom: friday["from"],
                        fridayTo: friday["to"],
                      );

                      Get.back();
                    },
                  ),
                  space24
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
