import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:majalatek/view/components/drawer/drawe.dart';
import 'package:majalatek/view/components/expanded_provider_widget.dart';
import 'package:majalatek/view/components/sliding_provider_widget.dart';
import 'package:provider/provider.dart';

import '../../../services/Language/language_service.dart';
import '../../../services/providers_service.dart';
import '../../components/app_bar_icons.dart';
import '../../constants.dart';

class DepartmentsProvidersScreen extends StatelessWidget {
  static const id = "/home/departments/result";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: Consumer<LanguageService>(
        builder: (context, language, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopAppIcons(
                    listTapped: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  Text(
                    "مزودي الخدمة",
                    style: TextStyle(
                        fontFamily: "NotoKufi",
                        color: primaryBlue,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16, left: 16),
                    child: Text(
                      language.data["data"]["special_providers_near_you"],
                      textDirection: language.data["direction"],
                      style: welcomeTitleStyle.copyWith(
                          color: primaryBlue, fontSize: width * 0.045),
                    ),
                  ),
                  CarouselSlider(
                    items: List.generate(
                      ProvidersService.instance.depSpecialProviders.length,
                      (index) => SlidingProviderWidget(
                        language: language,
                        provider: ProvidersService
                            .instance.depSpecialProviders[index],
                      ),
                    ),
                    options: CarouselOptions(
                      aspectRatio: 16 / 6,
                      initialPage: 0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                  ),
                  space24,
                  ...List.generate(
                    ProvidersService.instance.depSpecialProviders.length,
                    (index) => ExpandedProviderWidget(
                      language: language,
                      provider:
                          ProvidersService.instance.depSpecialProviders[index],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16, left: 16),
                    child: Text(
                      language.data["data"]["other_providers"],
                      textDirection: language.data["direction"],
                      style: welcomeTitleStyle.copyWith(
                          color: primaryBlue, fontSize: width * 0.045),
                    ),
                  ),
                  ...List.generate(
                    ProvidersService.instance.depNormalProviders.length,
                    (index) => ExpandedProviderWidget(
                      language: language,
                      provider:
                          ProvidersService.instance.depNormalProviders[index],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
