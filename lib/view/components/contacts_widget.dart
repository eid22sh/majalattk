import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majalatek/services/auth_service.dart';
import 'package:majalatek/view/screens/EditContactsScreen/edit_contact_screen.dart';
import 'package:provider/provider.dart';

import '../../models/providers/providers_model.dart';
import '../../services/Language/language_service.dart';
import '../../services/providers_service.dart';
import '../../utils/url_launcher.dart';
import '../constants.dart';
import '../dialogs/wait_pop_up.dart';
import '../screens/SpecialProfileScreen/special_profile_screen.dart';
import 'contact_icon.dart';

class ContactsWidget extends StatelessWidget {
  final Color containerColor;
  final Color iconsColor;
  final bool inProfile;
  final ProviderModel provider;
  final Function chatPressed;
  final bool isSpecial;

  const ContactsWidget({
    Key key,
    @required this.containerColor,
    @required this.iconsColor,
    @required this.inProfile,
    this.provider,
    @required this.isSpecial,
    @required this.chatPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool sameLogedInUser = AuthService.instance.loggedinUser == null
        ? false
        : ProvidersService.instance.selectedProvider.id
                .compareTo(AuthService.instance.loggedinUser.id) ==
            0;
    return Column(
      children: [
        sameLogedInUser
            ? InkWell(
                onTap: () {
                  navigator.pushNamed(EditContactsScreen.id);
                },
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                  ),
                  child: Text(
                    LanguageService.instance.data["data"]["edit"],
                    style: welcomeTitleStyle.copyWith(fontSize: width * 0.05),
                  ),
                ),
              )
            : SizedBox.shrink(),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Consumer<LanguageService>(
            builder: (context, language, child) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isSpecial
                    ? ContactIcon(
                        onTap: () async {
                          if (provider.instagram.startsWith("https")) {
                            await UrlLauncher.launchURL(provider.instagram);
                          } else {
                            await UrlLauncher.launchURL(
                                "https://instagram.com/" + provider.instagram);
                          }
                        },
                        color: iconsColor,
                        assetName: "assets/icons/instagram.svg",
                        name: language.data["data"]["instagram"],
                        style: contactStyle.copyWith(color: iconsColor),
                      )
                    : SizedBox.shrink(),
                isSpecial
                    ? ContactIcon(
                        onTap: () async {
                          if (provider.twiter.startsWith("https")) {
                            await UrlLauncher.launchURL(provider.twiter);
                          } else {
                            await UrlLauncher.launchURL(
                                "https://twitter.com/" + provider.twiter);
                          }
                        },
                        color: iconsColor,
                        assetName: "assets/icons/twitter.svg",
                        name: language.data["data"]["twitter"],
                        style: contactStyle.copyWith(color: iconsColor),
                      )
                    : SizedBox.shrink(),
                isSpecial
                    ? ContactIcon(
                        onTap: () async {
                          {
                            if (provider.snapchat.startsWith("https")) {
                              await UrlLauncher.launchURL(provider.snapchat);
                            } else {
                              await UrlLauncher.launchURL(
                                  "https://www.snapchat.com/add/" +
                                      provider.snapchat);
                            }
                          }
                        },
                        color: iconsColor,
                        assetName: "assets/icons/snapchat.svg",
                        name: language.data["data"]["snapchat"],
                        style: contactStyle.copyWith(color: iconsColor),
                      )
                    : SizedBox.shrink(),
                isSpecial
                    ? ContactIcon(
                        onTap: () async {
                          await UrlLauncher.launchURL(provider.website);
                        },
                        color: iconsColor,
                        assetName: "assets/icons/mail_tag.svg",
                        name: language.data["data"]["website"],
                        style: contactStyle.copyWith(color: iconsColor),
                      )
                    : SizedBox.shrink(),
                inProfile
                    ? SizedBox.shrink()
                    : ContactIcon(
                        onTap: () async {
                          Get.dialog(WaitPopup());
                          await ProvidersService.instance
                              .profileSelected(provider);
                          Get.back();
                          navigator.pushNamed(ProfileScreen.id);
                        },
                        color: iconsColor,
                        assetName: "assets/icons/profile_0.svg",
                        name: language.data["data"]["profile"],
                        style: contactStyle.copyWith(color: iconsColor),
                      ),
                ContactIcon(
                  onTap: () async {
                    var whatsapp = provider.whatsapp.substring(2);
                    if (Platform.isIOS) {
                      await UrlLauncher.launchURL(
                          "whatsapp://wa.me/$whatsapp/");
                    } else {
                      await UrlLauncher.launchURL(
                          "whatsapp://send?phone=$whatsapp");
                    }
                  },
                  color: iconsColor,
                  assetName: "assets/icons/whatsapp.svg",
                  name: language.data["data"]["whatsapp"],
                  style: contactStyle.copyWith(color: iconsColor),
                ),
                ContactIcon(
                  onTap: () async {
                    await UrlLauncher.launchURL("tel:" + provider.phone);
                  },
                  color: iconsColor,
                  assetName: "assets/icons/phone.svg",
                  name: language.data["data"]["phone"],
                  style: contactStyle.copyWith(color: iconsColor),
                ),
                // ContactIcon(
                //   onTap: chatPressed,
                //   color: iconsColor,
                //   assetName: "assets/icons/open_mail.svg",
                //   name: language.data["data"]["email"],
                //   style: contactStyle.copyWith(color: iconsColor),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
