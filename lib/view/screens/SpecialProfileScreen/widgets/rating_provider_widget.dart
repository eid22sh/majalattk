import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../services/Language/language_service.dart';
import '../../../../services/providers_service.dart';
import '../../../components/provider_rating_widget.dart';
import '../../../constants.dart';
import 'rating_detail_widdget.dart';

class RatingProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<LanguageService>(
        builder: (contextv, language, child) => Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  language.data["data"]["clients_rating"],
                  textDirection: language.data["direction"],
                  style: welcomeTitleStyle.copyWith(
                      color: primaryBlue, fontSize: width * 0.06),
                ),
                SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  "assets/icons/star.svg",
                  height: 24,
                  width: 24,
                ),
              ],
            ),
            space24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: ProvidersService
                            .instance.selectedProvider.ratingTotal,
                        style: welcomeTitleStyle.copyWith(
                            color: primaryBlue, fontSize: 64),
                        children: [
                      TextSpan(text: " out of 5", style: mainStyle)
                    ])),
                ProviderRating(
                  rating: double.parse(
                      ProvidersService.instance.selectedProvider.ratingTotal),
                  itemPadding: EdgeInsets.all(4.0),
                  itemSize: 16,
                )
              ],
            ),
            space24,
            FutureBuilder(
                future: ProvidersService.instance.getRating(),
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RatingDetailWidget(
                                    rating: snapshot.data["good"].toDouble(),
                                    asset: "assets/icons/work_quality.svg",
                                    text: language.data["data"]
                                        ["rating_quality"],
                                  ),
                                  RatingDetailWidget(
                                    rating: snapshot.data["time"].toDouble(),
                                    asset: "assets/icons/time_accuracy.svg",
                                    text: language.data["data"]["rating_time"],
                                  ),
                                  RatingDetailWidget(
                                    rating: snapshot.data["team"].toDouble(),
                                    asset: "assets/icons/desciplined.svg",
                                    text: language.data["data"]
                                        ["rating_polite"],
                                  ),
                                ],
                              ),
                              space24,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RatingDetailWidget(
                                    rating: snapshot.data["price"].toDouble(),
                                    asset: "assets/icons/pricing.svg",
                                    text: language.data["data"]["rating_price"],
                                  ),
                                  RatingDetailWidget(
                                    rating: snapshot.data["another"].toDouble(),
                                    asset: "assets/icons/work_again.svg",
                                    text: language.data["data"]
                                        ["rating_recommend"],
                                  ),
                                ],
                              ),
                            ],
                          )
                    : SizedBox.shrink()),
            space24
          ],
        ),
      ),
    );
  }
}
