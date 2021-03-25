import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/auth_service.dart';
import 'package:majalatek/services/providers_service.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';
import 'package:majalatek/view/screens/SpecialProfileScreen/special_profile_screen.dart';
import 'package:provider/provider.dart';
import '../../../services/Language/language_service.dart';
import '../../constants.dart';
import '../provider_rating_widget.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: width * 0.7,
      color: Colors.white,
      child: SafeArea(
        child: Consumer<LanguageService>(builder: (context, language, child) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    navigator.pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: primaryBlue,
                    size: 32,
                  ),
                ),
              ),
              AuthService.instance.loggedinUser == null
                  ? Text(
                      language.data["data"]["what_is_your_rating"] +
                          " " +
                          language.data["data"]["app_name"],
                      style: welcomeTitleStyle.copyWith(
                        color: primaryBlue,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: language.data["direction"],
                    )
                  : Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              AuthService.instance.loggedinUser.image),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AuthService.instance.loggedinUser.name,
                                style: mainStyle,
                              ),
                              SizedBox(height: 10),
                              ProviderRating(
                                  itemPadding: EdgeInsets.all(2.0),
                                  itemSize: 16,
                                  rating: double.parse(AuthService
                                      .instance.loggedinUser.ratingTotal))
                            ],
                          ),
                        ),
                      ],
                    ),
              space24,
              (AuthService.instance.loggedinUser) == null
                  ? ProviderRating(
                      rating: 0.0,
                      ignore: false,
                      itemSize: 24,
                      itemPadding: EdgeInsets.all(2.0),
                      onChanged: (value) {},
                    )
                  : SizedBox.shrink(),
              AuthService.instance.loggedinUser == null
                  ? SizedBox.shrink()
                  : ListTile(
                      onTap: () async {
                        Get.dialog(WaitPopup());
                        await ProvidersService.instance
                            .profileSelected(AuthService.instance.loggedinUser);
                        Get.back();
                        navigator.pushNamed(ProfileScreen.id);
                      },
                      leading: SvgPicture.asset("assets/icons/gear_2.svg"),
                      title: Text(
                        language.data["data"]["update_profile"],
                        textDirection: language.data["direction"],
                        style: mainStyle.copyWith(color: primaryBlue),
                      ),
                    ),
              AuthService.instance.loggedinUser == null
                  ? SizedBox.shrink()
                  : ListTile(
                      leading: SvgPicture.asset("assets/icons/open_mail.svg"),
                      title: Text(
                        language.data["data"]["inbox"],
                        textDirection: language.data["direction"],
                        style: mainStyle.copyWith(color: primaryBlue),
                      ),
                    ),
              ListTile(
                leading: SvgPicture.asset("assets/icons/ico_ 377.svg"),
                title: Text(
                  language.data["data"]["app_version"],
                  textDirection: language.data["direction"],
                  style: mainStyle.copyWith(color: primaryBlue),
                ),
              ),
              Text(
                "1.0.0",
                style: mainStyle.copyWith(color: primaryBlue),
              )
            ],
          );
        }),
      ),
    );
  }
}
