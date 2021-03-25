import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:majalatek/services/providers_service.dart';
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
import '../../dialogs/error_dialog.dart';
import '../../dialogs/wait_pop_up.dart';
import '../HomeScreen/home_screen.dart';
import 'dialog/spec_dialog.dart';

class RegisterScreen extends StatefulWidget {
  static const id = "/beforeLogin/RegisterScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  //TODO : This changes depending on the first country added in the backend
  var country = "00966";
  List coutries = [];
  var spec;
  var idCountry = 1;
  var name;
  var phone;
  var description;

  String speciality = LanguageService.instance.data["data"]["specialization"];
  final ImagePicker picker = ImagePicker();

  File image;
  Widget warningImage = SizedBox.shrink();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            onPressed: navigator.pop,
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
                      onTap: _getImage,
                      child: CircleAvatar(
                        backgroundColor: primaryBlue,
                        radius: 50,
                        child: SvgPicture.asset("assets/icons/cam_4.svg"),
                        backgroundImage: image.isNull ? null : FileImage(image),
                      ),
                    ),
                    warningImage,
                    space24,
                    CustomTextField(
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
                              onChanged: (value) {
                                setState(
                                  () {
                                    country = value;
                                  },
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            hint: language.data["data"]["chat_phone"],
                            inputype: TextInputType.phone,
                            suffixWidget: SizedBox.shrink(),
                            onChanged: (value) {
                              phone = value;
                            },
                            validator: Validator.validateText,
                          ),
                        ),
                      ],
                    ),
                    space24,
                    CustomTextField(
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
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        spec = await Get.dialog(SpecializationDialog(),
                            barrierDismissible: false);
                        setState(() {
                          speciality = spec["title"];
                        });
                      },
                    ),
                    space24,
                    BorderRoundedButton(
                      onTap: () async {
                        if (phone.startsWith("0")) {
                          phone = phone.substring(1);
                        }
                        getCountryID();
                        imageWarning();
                        print(idCountry);
                        if (_formKey.currentState.validate() && !image.isNull) {
                          Get.dialog(WaitPopup());
                          var registred = await AuthService.instance.register(
                            name: name,
                            phone: country + phone,
                            description: description,
                            idSpec: spec["id"],
                            idCountry: idCountry,
                            image: image,
                          );

                          Get.back();
                          if (registred) {
                            ProvidersService.instance.updateContacts(
                                "", "", country + phone, "", "", "");
                            await Get.dialog(
                              ErrorPopup(
                                errorText: LanguageService.instance.data["data"]
                                    ["wait_admin"],
                              ),
                            );
                            navigator.pushNamed(HomeScreen.id);
                          } else {
                            await Get.dialog(
                              ErrorPopup(
                                  errorText: LanguageService.instance
                                      .data["data"]["register_problem"]),
                            );
                          }
                        }
                      },
                      text: language.data["data"]["continue"],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  imageWarning() {
    if (image.isNull) {
      setState(() {
        warningImage = Text(
          "Image is required",
          style: mainStyle.copyWith(color: Colors.red),
        );
      });
    } else {
      setState(() {
        warningImage = SizedBox.shrink();
      });
    }
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

  void _getImageFromGallerie() async {
    PickedFile _image = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    if (_image != null) {
      setState(() {
        image = File(_image.path);
      });
    }
    Get.back();
  }

  void _getImageFromCamera() async {
    PickedFile _image = await picker.getImage(
        source: ImageSource.camera, maxHeight: 400, maxWidth: 400);
    if (_image != null) {
      setState(() {
        image = File(_image.path);
      });
    }
    Get.back();
  }

  void _getImage() async {
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
