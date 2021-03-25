import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majalatek/view/components/borderRoundedButton.dart';
import '../../services/Language/language_service.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class PickTimeDialog extends StatefulWidget {
  const PickTimeDialog({
    Key key,
  }) : super(key: key);

  @override
  _PickTimeDialogState createState() => _PickTimeDialogState();
}

class _PickTimeDialogState extends State<PickTimeDialog> {
  var from = "-";
  var to = "-";
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 200),
        child: Card(
          child: Consumer<LanguageService>(
            builder: (context, language, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      language.data["data"]["time_from"],
                      style: mainStyle,
                    ),
                    InkWell(
                      onTap: () async {
                        var time1 = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 0, minute: 0),
                        );
                        setState(() {
                          from = time1?.format(context) ?? "-";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: primaryBlue),
                        ),
                        child: Text(from),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      language.data["data"]["time_to"],
                      style: mainStyle,
                    ),
                    InkWell(
                      onTap: () async {
                        var time2 = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 0, minute: 0),
                        );
                        setState(() {
                          to = time2?.format(context) ?? "-";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: primaryBlue),
                        ),
                        child: Text(to),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BorderRoundedButton(
                    text: language.data["data"]["submit_working_days"],
                    onTap: () {
                      Get.back(result: {"from": from, "to": to});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
