import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/services/providers_service.dart';
import 'package:majalatek/view/components/borderRoundedButton.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'widgets/social_media_textfield.dart';
import '../../../services/auth_service.dart';

// ignore: must_be_immutable
class EditContactsScreen extends StatelessWidget {
  static const id = "/home/login/editcontacts";
  var snapchat = AuthService.instance.loggedinUser.snapchat;
  var instagram = AuthService.instance.loggedinUser.instagram;
  var whatsapp = AuthService.instance.loggedinUser.whatsapp;
  var twitter = AuthService.instance.loggedinUser.twiter;
  var email = AuthService.instance.loggedinUser.email;
  var website = AuthService.instance.loggedinUser.website;
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
          onPressed: () {
            navigator.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SocialMediaTextField(
                initialText: snapchat,
                svgLocation: "snapchat.svg",
                onChanged: (value) {
                  snapchat = value;
                },
              ),
              SocialMediaTextField(
                initialText: instagram,
                svgLocation: "instagram.svg",
                onChanged: (value) {
                  instagram = value;
                },
              ),
              SocialMediaTextField(
                readOnly: true,
                initialText: whatsapp,
                svgLocation: "whatsapp.svg",
                onChanged: (value) {
                  whatsapp = value;
                },
              ),
              SocialMediaTextField(
                initialText: twitter,
                svgLocation: "twitter.svg",
                onChanged: (value) {
                  twitter = value;
                },
              ),
              SocialMediaTextField(
                initialText: email,
                svgLocation: "email.svg",
                onChanged: (value) {
                  email = value;
                },
              ),
              SocialMediaTextField(
                initialText: website,
                svgLocation: "mail_tag.svg",
                onChanged: (value) {
                  website = value;
                },
              ),
              space24,
              Consumer<LanguageService>(builder: (context, language, child) {
                return BorderRoundedButton(
                  text: language.data["data"]["submit"],
                  onTap: () async {
                    Get.dialog(WaitPopup());
                    await ProvidersService.instance.updateContacts(
                        snapchat, instagram, whatsapp, twitter, website, email);
                    Get.back();
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
