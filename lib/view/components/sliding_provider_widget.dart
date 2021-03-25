import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/providers/providers_model.dart';
import '../../services/Language/language_service.dart';
import '../../services/location_service.dart';
import '../../services/providers_service.dart';
import '../../utils/distance_calculator.dart';
import 'provider_rating_widget.dart';
import '../constants.dart';
import '../dialogs/wait_pop_up.dart';
import '../screens/SpecialProfileScreen/special_profile_screen.dart';

class SlidingProviderWidget extends StatelessWidget {
  final LanguageService language;
  final ProviderModel provider;
  const SlidingProviderWidget({
    Key key,
    this.language,
    this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return InkWell(
        onTap: () async {
          Get.dialog(WaitPopup());
          await ProvidersService.instance.profileSelected(provider);
          Get.back();
          navigator.pushNamed(ProfileScreen.id);
        },
        child: Container(
          width: width,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 8,
                spreadRadius: 0.5,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: width * 0.13,
                width: width * 0.13,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: width * 0.06,
                      width: width * 0.06,
                      child: ClipPath(
                        clipper: CrownClip(),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      language.data["data"]["special"],
                      style: mainStyle.copyWith(
                          color: Colors.white, fontSize: width * 0.03),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.name,
                        textDirection: language.data["direction"],
                        overflow: TextOverflow.ellipsis,
                        style: mainStyle.copyWith(
                          color: primaryBlue,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.shrink(),
                          Text(
                            "(${provider.ratingTotal})",
                          ),
                          ProviderRating(
                            rating: double.parse(provider.ratingTotal),
                            itemSize: 16,
                            itemPadding: EdgeInsets.all(1.0),
                          ),
                        ],
                      ),
                      Text(
                          calculateDistance(
                                      LocationService
                                          .instance.realTimeLocation["lat"],
                                      LocationService
                                          .instance.realTimeLocation["lng"],
                                      double.parse(provider.lat),
                                      double.parse(provider.lng))
                                  .toStringAsFixed(1) +
                              " km",
                          style: mainStyle),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Center(
                  child: SizedBox(
                    height: width * 0.2,
                    width: width * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        provider.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } catch (e) {
      return InkWell(
        onTap: () async {
          Get.dialog(WaitPopup());
          await ProvidersService.instance.profileSelected(provider);
          Get.back();
          navigator.pushNamed(ProfileScreen.id);
        },
        child: Container(
          width: width,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 8,
                spreadRadius: 0.5,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: width * 0.13,
                width: width * 0.13,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: width * 0.06,
                      width: width * 0.06,
                      child: ClipPath(
                        clipper: CrownClip(),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      language.data["data"]["special"],
                      style: mainStyle.copyWith(
                          color: Colors.white, fontSize: width * 0.03),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.name,
                        textDirection: language.data["direction"],
                        overflow: TextOverflow.ellipsis,
                        style: mainStyle.copyWith(
                          color: primaryBlue,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.shrink(),
                          Text(
                            "(${provider.ratingTotal})",
                          ),
                          ProviderRating(
                            rating: double.parse(provider.ratingTotal),
                            itemSize: 16,
                            itemPadding: EdgeInsets.all(1.0),
                          ),
                        ],
                      ),
                      Text("Not defined distance", style: mainStyle),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Center(
                  child: SizedBox(
                    height: width * 0.2,
                    width: width * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        provider.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class CrownClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height / 4);
    path.lineTo(size.width / 4, size.height);
    path.lineTo(size.width * 3 / 4, size.height);
    path.lineTo(size.width, size.height / 4);
    path.lineTo(size.width * 3 / 4, size.height * 1.25 / 4);
    path.lineTo(size.width / 2, 0.0);
    path.lineTo(size.width / 4, size.height * 1.25 / 4);
    path.lineTo(0.0, size.height / 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
