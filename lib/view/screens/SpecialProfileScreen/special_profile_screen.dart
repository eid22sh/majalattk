import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/auth_service.dart';
import 'package:majalatek/view/screens/ChatScreen/chat_screen.dart';

import '../../../services/providers_service.dart';
import '../../components/app_bar_icons.dart';
import '../../components/contacts_widget.dart';
import '../../components/drawer/drawe.dart';
import '../../components/profile_picture_widget.dart';
import '../../components/rate_button.dart';
import '../../constants.dart';
import '../RateProviderScreen/rate_provider_screen.dart';
import 'widgets/description_widget.dart';
import 'widgets/images_widget.dart';
import 'widgets/rating_provider_widget.dart';
import 'widgets/timing_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "/SpecialScreen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool sameLogedInUser = AuthService.instance.loggedinUser == null
        ? false
        : ProvidersService.instance.selectedProvider.id
                .compareTo(AuthService.instance.loggedinUser.id) ==
            0;
    return Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: height,
                width: width,
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.3,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Image.network(
                        ProvidersService.instance.selectedProvider.image,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.1,
                              ),
                              TimingWidget(),
                              space24,
                              DescriptionWidget(),
                              space24,
                              ProvidersService
                                          .instance.selectedProvider.isSpecial
                                          .compareTo("1") ==
                                      0
                                  ? ImagesWidget()
                                  : SizedBox.shrink(),
                              space24,
                              ContactsWidget(
                                chatPressed: () {
                                  navigator.pushNamed(ChatScreen.id);
                                },
                                containerColor: primaryBlue,
                                iconsColor: Colors.white,
                                inProfile: true,
                                provider:
                                    ProvidersService.instance.selectedProvider,
                                isSpecial: ProvidersService
                                        .instance.selectedProvider.isSpecial
                                        .compareTo("1") ==
                                    0,
                              ),
                              space24,
                              RatingProviderWidget(),
                              space24,
                              sameLogedInUser
                                  ? SizedBox.shrink()
                                  : RateButton(
                                      onTap: () {
                                        navigator
                                            .pushNamed(RateProviderScreen.id);
                                      },
                                      text: "write_your_rating",
                                    ),
                              space24
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: width,
              height: 128,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.black.withOpacity(0.0)])),
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopAppIcons(
                    listTapped: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      ProvidersService.instance.selectedProvider.name,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: welcomeBodyStyle.copyWith(fontSize: width * 0.05),
                    ),
                  )
                ],
              ),
              minimum: EdgeInsets.only(left: 16, top: 32.0, right: 16),
            ),
            ProfilePicture()
          ],
        ));
  }
}
