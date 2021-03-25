import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/providers/providers_model.dart';
import '../../../../services/Language/language_service.dart';
import '../../../../services/location_service.dart';
import '../../../../services/providers_service.dart';
import '../../../../utils/distance_calculator.dart';
import '../../../components/contact_icon.dart';
import '../../../components/provider_rating_widget.dart';
import '../../../components/svg_button.dart';
import '../../../constants.dart';
import '../../../dialogs/wait_pop_up.dart';
import '../../SpecialProfileScreen/special_profile_screen.dart';

class ProviderWidget extends StatelessWidget {
  final ProviderModel provider;
  const ProviderWidget({Key key, this.provider}) : super(key: key);

  launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      Get.snackbar("Error", "This contact info is not available");
    }
  }

  @override
  Widget build(BuildContext context) {
    double distance = calculateDistance(
        LocationService.instance.realTimeLocation["lat"],
        LocationService.instance.realTimeLocation["lng"],
        double.parse(provider.lat),
        double.parse(provider.lng));
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5.0)]),
      child: Consumer<LanguageService>(
        builder: (context, language, child) => Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            provider.name ?? "",
                            style: mainStyle.copyWith(color: primaryBlue),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SVGButton(
                            location: "assets/icons/profile_0.svg",
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "(" + provider.ratingTotal + ")",
                            style: mainStyle,
                          ),
                          ProviderRating(
                              itemSize: 16,
                              rating: double.parse(provider.ratingTotal),
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0)),
                          SizedBox(
                            width: width * 0.30,
                            child: Text(
                              language.data["data"]["customers_rating"],
                              textDirection: language.data["data"]["direction"],
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                              style: mainStyle,
                            ),
                          ),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(
                          language.data["data"]["special"],
                          style: mainStyle,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          distance.toStringAsFixed(2) + "km",
                          style: mainStyle,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.yellow,
                        )
                      ])
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: width * 0.1,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: width * 0.08,
                    backgroundImage: provider.imageProvider,
                  ),
                )
              ],
            ),
            Text(
              provider.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: mainStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContactIcon(
                  onTap: () {
                    var whatsapp = provider.whatsapp.substring(2);
                    if (Platform.isIOS) {
                      launchURL("whatsapp://wa.me/$whatsapp/");
                    } else {
                      launchURL("whatsapp://send?phone=$whatsapp");
                    }
                  },
                  assetName: "assets/icons/whatsapp.svg",
                  name: language.data["data"]["whatsapp"],
                  style: mainStyle.copyWith(
                      fontSize: width * 0.02,
                      color: primaryBlue,
                      fontWeight: FontWeight.bold),
                ),
                greySpliter,
                ContactIcon(
                  onTap: () {
                    launchURL("tel:" + provider.phone);
                  },
                  assetName: "assets/icons/phone.svg",
                  name: language.data["data"]["phone"],
                  style: mainStyle.copyWith(
                      fontSize: width * 0.02,
                      color: primaryBlue,
                      fontWeight: FontWeight.bold),
                ),
                greySpliter,
                ContactIcon(
                  onTap: () async {
                    Get.dialog(WaitPopup());
                    await ProvidersService.instance.profileSelected(provider);
                    Get.back();
                    navigator.pushNamed(ProfileScreen.id);
                  },
                  assetName: "assets/icons/profile_0.svg",
                  name: language.data["data"]["profile"],
                  style: mainStyle.copyWith(
                      fontSize: width * 0.02,
                      color: primaryBlue,
                      fontWeight: FontWeight.bold),
                ),
                greySpliter,
                ContactIcon(
                  onTap: () {
                    launchURL(provider.website);
                  },
                  assetName: "assets/icons/mail_tag.svg",
                  name: language.data["data"]["website"],
                  style: mainStyle.copyWith(
                      fontSize: width * 0.02,
                      color: primaryBlue,
                      fontWeight: FontWeight.bold),
                ),
                // greySpliter,
                // ContactIcon(
                //   onTap: () async {
                //     Get.dialog(WaitPopup());
                //     await ProvidersService.instance.profileSelected(provider);
                //     Get.back();
                //     navigator.pushNamed(ChatScreen.id);
                //   },
                //   assetName: "assets/icons/open_mail.svg",
                //   name: language.data["data"]["email"],
                //   style: mainStyle.copyWith(
                //       fontSize: width * 0.02,
                //       color: primaryBlue,
                //       fontWeight: FontWeight.bold),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
