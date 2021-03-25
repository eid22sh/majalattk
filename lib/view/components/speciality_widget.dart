import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';
import 'package:majalatek/view/screens/SpecialityProvidersScreen/speciality_providers_screen.dart';
import '../../services/providers_service.dart';
import '../constants.dart';
import '../screens/SearchResultScreen/search_result_screen.dart';

class SpecialityWidget extends StatelessWidget {
  final String text;
  final String image;
  final bool allProviders;
  final String id;
  const SpecialityWidget({
    Key key,
    this.text,
    this.id,
    this.image,
    this.allProviders = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (allProviders) {
          Get.dialog(WaitPopup());
          await ProvidersService.instance.getAllSpecialityProviders(this.id);
          Get.back();
          navigator.pushNamed(SpecProvidersScreen.id);
        } else {
          ProvidersService.instance.getSpecialityProviders(this.text);
          navigator.pushNamed(SearchResultScreen.id);
        }
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              child: Image.network(
                image,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 100,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: mainStyle.copyWith(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
