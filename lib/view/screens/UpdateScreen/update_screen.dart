import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:majalatek/view/screens/RegisterScreen/dialog/spec_dialog.dart';
import 'package:majalatek/view/screens/SpecialProfileScreen/special_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../../services/Language/language_service.dart';
import '../../../services/auth_service.dart';
import '../../../utils/textValidator/validator.dart';
import '../../bloc/flagBloc/flag_bloc.dart';
import '../../components/borderRoundedButton.dart';
import '../../components/custom_text_field_widget.dart';
import '../../components/flag_drop_down.dart';
import '../../components/search_bar.dart';
import '../../constants.dart';
import '../../dialogs/wait_pop_up.dart';

class UpdateScreen extends StatefulWidget {
  static const id = "/beforeLogin/UpdateScreen";

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  var country = AuthService.instance.loggedinUser.phone.substring(0, 3);
  List coutries = [];
  var spec = {"id": 1, "title": AuthService.instance.loggedinUser.specialty};
  var idCountry;
  var name = AuthService.instance.loggedinUser.name;
  var phone = AuthService.instance.loggedinUser.phone.substring(3);
  var description = AuthService.instance.loggedinUser.description;

  String speciality = AuthService.instance.loggedinUser.specialty["title"];
  final ImagePicker picker = ImagePicker();

  File image;
  Widget warningImage = SizedBox.shrink();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigator.pop();
        navigator.pop();
        navigator.pushNamed(ProfileScreen.id);
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
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
          body: Consumer<LanguageService>(
            builder: (context, language, child) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        language.data["data"]["app_name"],
                        style: welcomeTitleStyle.copyWith(color: primaryBlue),
                      ),
                      InkWell(
                        onTap: () async {
                          await _getImage();
                        },
                        child: CircleAvatar(
                          backgroundColor: primaryBlue,
                          radius: 50,
                          child: SvgPicture.asset("assets/icons/cam_4.svg"),
                          backgroundImage: image.isNull
                              ? NetworkImage(
                                  AuthService.instance.loggedinUser.image)
                              : FileImage(image),
                        ),
                      ),
                      warningImage,
                      space24,
                      CustomTextField(
                        textInitial: name,
                        hint: language.data["data"]["name"],
                        suffixWidget: SizedBox.shrink(),
                        onChanged: (value) {
                          name = value;
                        },
                        validator: Validator.validateText,
                      ),
                      space24,
                      Row(
                        children: [
                          BlocBuilder(
                            cubit: FlagBloc.instance,
                            builder: (context, data) {
                              coutries = data;
                              return FlagDropDown(
                                data: data,
                                country: country,
                                onChanged: (value) {},
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomTextField(
                              textInitial: phone,
                              readOnly: true,
                              hint: language.data["data"]["chat_phone"],
                              inputype: TextInputType.phone,
                              suffixWidget: SizedBox.shrink(),
                              validator: Validator.validateText,
                            ),
                          ),
                        ],
                      ),
                      space24,
                      CustomTextField(
                        textInitial: description,
                        hint: language.data["data"]["description"],
                        maxLines: 3,
                        suffixWidget: SizedBox.shrink(),
                        onChanged: (value) {
                          description = value;
                        },
                        validator: Validator.validateText,
                      ),
                      space24,
                      InkWell(
                        child: SearchBar(
                          rightIcon: SizedBox.shrink(),
                          text: speciality,
                        ),
                        onTap: () async {
                          spec = await Get.dialog(
                            SpecializationDialog(),
                          );
                          setState(() {
                            if (spec != null) {
                              speciality = spec["title"];
                            }
                          });
                        },
                      ),
                      space24,
                      BorderRoundedButton(
                        onTap: () async {
                          getCountryID();
                          print(idCountry);
                          if (_formKey.currentState.validate()) {
                            Get.dialog(WaitPopup());
                            await AuthService.instance.update(
                              name: name,
                              phone: country + phone,
                              description: description,
                              idSpec: spec["id"],
                              idCountry: idCountry,
                              image: image,
                            );
                            Get.back();
                          }
                        },
                        text: language.data["data"]["submit"],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getCountryID() {
    if (coutries.isNotEmpty) {
      for (Map item in coutries) {
        if (item.containsValue(country)) {
          idCountry = item["id"];
        }
      }
    }
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
