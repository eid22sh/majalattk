import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/services/chat_service.dart';
import 'package:majalatek/utils/response.dart';
import 'package:majalatek/view/components/borderRoundedButton.dart';
import 'package:majalatek/view/components/custom_text_field_widget.dart';
import 'package:majalatek/view/screens/ChatScreen/chat_screen.dart';
import '../../constants.dart';

var name = "";
var phone = "";
var email = "";
var title = "";
var description = "";

class ConversationScreen extends StatefulWidget {
  static const id = "/home/conversation";

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.dialog(
              Material(
                type: MaterialType.transparency,
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          iconSize: 16,
                          icon: Icon(
                            Icons.close,
                            size: 16,
                            color: primaryBlue,
                          ),
                          onPressed: navigator.maybePop,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: height * 0.6,
                          margin: EdgeInsets.only(right: 24, left: 2),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextField(
                                onChanged: (value) => name = value,
                                hint: LanguageService.instance.data["data"]
                                    ["chat_name"],
                                suffixWidget: SizedBox.shrink(),
                              ),
                              CustomTextField(
                                onChanged: (value) => email = value,
                                hint: LanguageService.instance.data["data"]
                                    ["chat_email"],
                                suffixWidget: SizedBox.shrink(),
                              ),
                              CustomTextField(
                                onChanged: (value) => phone = value,
                                hint: LanguageService.instance.data["data"]
                                    ["chat_phone"],
                                suffixWidget: SizedBox.shrink(),
                              ),
                              CustomTextField(
                                onChanged: (value) => title = value,
                                hint: LanguageService.instance.data["data"]
                                    ["chat_title"],
                                suffixWidget: SizedBox.shrink(),
                              ),
                              CustomTextField(
                                onChanged: (value) => description = value,
                                hint: LanguageService.instance.data["data"]
                                    ["chat_description"],
                                suffixWidget: SizedBox.shrink(),
                              ),
                              BorderRoundedButton(
                                text: LanguageService.instance.data["data"]
                                    ["submit"],
                                onTap: () async {
                                  await ChatService.instance.startChat(
                                      name, email, phone, title, description);
                                  Get.back();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              barrierDismissible: true);
        },
        backgroundColor: primaryBlue,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Chat",
          style: mainStyle.copyWith(color: primaryBlue, fontSize: 24),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: primaryBlue,
          ),
          onPressed: navigator.maybePop,
        ),
      ),
      body: FutureBuilder<DataHolder>(
          future: ChatService.instance.getChats(),
          builder: (context, snapshot) => snapshot.hasData
              ? (snapshot.data.status && !snapshot.data.data.isEmpty)
                  ? ListView.builder(
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            ChatService.instance.roomId = snapshot
                                .data
                                .data[snapshot.data.data.length - index - 1]
                                    ["id"]
                                .toString();
                            navigator.pushNamed(ChatScreen.id);
                          },
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data.data[snapshot.data.data.length -
                                      index -
                                      1]["title"],
                                  style: mainStyle,
                                ),
                                Text(
                                  snapshot
                                      .data
                                      .data[snapshot.data.data.length -
                                          index -
                                          1]["created_at"]
                                      .toString()
                                      .substring(0, 10),
                                  style: mainStyle,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(snapshot.data.message, style: mainStyle),
                    )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
