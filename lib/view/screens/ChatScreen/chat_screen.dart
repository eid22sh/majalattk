import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/services/chat_service.dart';
import 'package:majalatek/utils/response.dart';
import '../../components/custom_text_field_widget.dart';
import '../../constants.dart';

class ChatScreen extends StatefulWidget {
  static const id = "/home/specialscreen/chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var message = "";
  final textController = TextEditingController();
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          SizedBox(
            height: height * 0.15,
            width: width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: Colors.grey[400])
                      ],
                    ),
                    height: height * 0.14,
                    width: width,
                    padding: const EdgeInsets.fromLTRB(8.0, 16, 8.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: primaryBlue,
                          ),
                          onPressed: navigator.maybePop,
                        ),
                        Text(
                          LanguageService.instance.data["data"]["admin_chat"],
                          textDirection: TextDirection.rtl,
                          style: mainStyle.copyWith(
                            color: primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: ProfileCircleWidget(size: height * 0.04),
                // )
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<DataHolder>(
            future: ChatService.instance.getMessages(),
            builder: (context, snapshot) => snapshot.hasData
                ? (snapshot.data.status && !snapshot.data.data.isEmpty)
                    ? ListView(
                        reverse: true,
                        children: List.generate(
                          snapshot.data.data.length,
                          (index) => MessageWidget(
                            message: snapshot.data.data[index]["message"],
                            isSender:
                                snapshot.data.data[index]["sender_id"] == 1,
                          ),
                        ).reversed.toList(),
                      )
                    : Center(
                        child: Text(
                          snapshot.data.message,
                          style: mainStyle,
                        ),
                      )
                : Center(child: CircularProgressIndicator()),
          )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextField(
              controller: textController,
              onChanged: (value) {
                message = value;
              },
              suffixWidget: IconButton(
                onPressed: () async {
                  textController.clear();
                  await ChatService.instance.sendMessage(message);
                },
                icon: Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  color: primaryBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final bool isSender;
  final String message;
  const MessageWidget({
    Key key,
    this.isSender,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width * 0.6, minWidth: 0.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: isSender ? Radius.circular(16) : Radius.zero,
                    topRight: !(isSender) ? Radius.circular(16) : Radius.zero,
                    bottomLeft: isSender ? Radius.circular(16) : Radius.zero,
                    bottomRight:
                        !(isSender) ? Radius.circular(16) : Radius.zero),
                color: isSender ? primaryBlue : Colors.white),
            child: Text(
              message,
              style: mainStyle.copyWith(
                  color: isSender ? Colors.white : primaryBlue),
            ),
          ),
        ),
      ),
    );
  }
}
