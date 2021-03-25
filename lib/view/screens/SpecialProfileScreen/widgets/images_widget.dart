import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:majalatek/services/providers_service.dart';
import 'package:majalatek/view/constants.dart';
import 'package:majalatek/view/screens/EditImages/edit_images_screen.dart';
import '../../../../services/auth_service.dart';

class ImagesWidget extends StatelessWidget {
  final PageController controller = PageController();
  final sameLogedInUser = AuthService.instance.loggedinUser == null
      ? false
      : ProvidersService.instance.selectedProvider.id
              .compareTo(AuthService.instance.loggedinUser.id) ==
          0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ignore: unnecessary_statements
        sameLogedInUser ? navigator.pushNamed(EditImageScreen.id) : null;
      },
      child: SizedBox(
        height: height * 0.25,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: ProvidersService.instance.getImages(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? (snapshot.data.length != 0)
                            ? Stack(
                                children: [
                                  PageView.builder(
                                    physics: BouncingScrollPhysics(),
                                    controller: controller,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) =>
                                        Image.network(
                                      snapshot.data[index]["image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              controller.previousPage(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  curve: Curves.decelerate);
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              controller.nextPage(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  curve: Curves.decelerate);
                                            })
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: Icon(
                                Icons.image_not_supported,
                                size: 32,
                                color: primaryBlue,
                              ))
                        : Center(child: CircularProgressIndicator());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
