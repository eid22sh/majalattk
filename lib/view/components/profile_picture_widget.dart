import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majalatek/services/providers_service.dart';
import 'package:majalatek/view/components/profile_circle_widget.dart';
import 'package:majalatek/view/constants.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, -0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: primaryBlue,
            radius: 32,
            backgroundImage: NetworkImage(
                ProvidersService.instance.selectedProvider.countryFlag),
          ),
          Material(
            type: MaterialType.circle,
            color: Colors.white,
            elevation: 5.0,
            child: ProfileCircleWidget(
              size: 58,
            ),
          ),
          CircleAvatar(
            backgroundColor: primaryBlue,
            radius: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset("assets/icons/multiple-users-silhouette.svg"),
                Text(
                  ProvidersService.instance.selectedProvider.views,
                  style: mainStyle.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
