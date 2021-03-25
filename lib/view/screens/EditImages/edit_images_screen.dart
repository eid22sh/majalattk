import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/services/providers_service.dart';
import 'package:majalatek/view/components/borderRoundedButton.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';
import 'package:majalatek/view/screens/SpecialProfileScreen/special_profile_screen.dart';
import '../../constants.dart';

class EditImageScreen extends StatefulWidget {
  static const id = "/home/login/editimages";

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  final PageController controller = PageController();
  final ImagePicker picker = ImagePicker();
  File image;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigator.pop();
        navigator.pop();
        navigator.pushNamed(ProfileScreen.id);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: primaryBlue,
            ),
            onPressed: () {
              navigator.pop();
              navigator.pop();
              navigator.pushNamed(ProfileScreen.id);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
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
                          builder: (context, snapshot) => snapshot.hasData
                              ? (snapshot.data.length != 0)
                                  ? Stack(
                                      children: [
                                        PageView.builder(
                                          physics: BouncingScrollPhysics(),
                                          controller: controller,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) =>
                                              Stack(children: [
                                            Image.network(
                                              snapshot.data[index]["image"],
                                              fit: BoxFit.cover,
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () async {
                                                  Get.dialog(WaitPopup());
                                                  await ProvidersService
                                                      .instance
                                                      .deleteImage(snapshot
                                                          .data[index]["id"]
                                                          .toString());
                                                  setState(() {});
                                                  Get.back();
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white
                                                      .withOpacity(0.5),
                                                  radius: 24,
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red[700],
                                                    size: 32,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
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
                                                        duration: Duration(
                                                            seconds: 1),
                                                        curve:
                                                            Curves.decelerate);
                                                  }),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    controller.nextPage(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        curve:
                                                            Curves.decelerate);
                                                  })
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Icon(
                                      Icons.image_not_supported,
                                      size: 32,
                                      color: primaryBlue,
                                    ))
                              : Center(child: CircularProgressIndicator()))
                    ],
                  ),
                ),
              ),
              space24,
              BorderRoundedButton(
                text: LanguageService.instance.data["data"]["add_image"],
                onTap: () async {
                  await _getImage();
                  Get.dialog(WaitPopup());
                  await ProvidersService.instance.addImage("-", "-", image);
                  setState(() {});
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _getImageFromGallerie() async {
    PickedFile _image = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    if (_image != null) {
      setState(() {
        image = File(_image.path);
      });
    }
    Get.back();
  }

  Future _getImageFromCamera() async {
    PickedFile _image = await picker.getImage(
        source: ImageSource.camera, maxHeight: 400, maxWidth: 400);
    if (_image != null) {
      setState(() {
        image = File(_image.path);
      });
    }
    Get.back();
  }

  Future _getImage() async {
    await Get.bottomSheet(
      Container(
        height: 130.0,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library, color: Color(0xfff29f04)),
              title: Text("Import a picture"),
              onTap: _getImageFromGallerie,
            ),
            ListTile(
              leading: Icon(Icons.photo_camera, color: Color(0xfff29f04)),
              title: Text("Take a picture"),
              onTap: _getImageFromCamera,
            ),
          ],
        ),
      ),
    );
  }
}
