import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/view/components/borderRoundedButton.dart';
import 'package:majalatek/view/components/choice_widget.dart';

import '../../../../services/providers_service.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class SpecializationDialog extends StatelessWidget {
  int selected;
  SpecializationDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          type: MaterialType.transparency,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: ProvidersService.instance.getSpecialitites(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.done:
                      return Column(
                        children: [
                          Expanded(
                            child: ChoiceWidget(
                              onChanged: (value) {
                                selected = value;
                              },
                              items: List<Widget>.generate(
                                snapshot.data["data"].length,
                                (index) => Text(
                                  snapshot.data["data"][index]["title"],
                                  style: mainStyle,
                                ),
                              ),
                            ),
                          ),
                          BorderRoundedButton(
                            text: LanguageService.instance.data["data"]
                                ["submit"],
                            onTap: () {
                              Get.back(result: snapshot.data["data"][selected]);
                            },
                          )
                        ],
                      );
                      break;
                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ));
  }
}
