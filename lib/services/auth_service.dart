import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:majalatek/services/storage_service.dart';

import '../models/providers/providers_model.dart';
import '../utils/constants.dart';
import '../utils/image_uploader.dart';
import 'location_service.dart';
import 'providers_service.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();
  ProviderModel loggedinUser;
  String token = "";
  Dio dio = Dio();

  Future<bool> login(String phone) async {
    try {
      await dio.post(
        api + "providers/login",
        queryParameters: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
        data: {"phone": phone},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map> verify(String phone, String code) async {
    try {
      Response response = await dio.post(
        api +
            "providers/verify?locale=" +
            await StorageService.instacne.getLanguage(),
        queryParameters: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
        data: {"phone": phone, "code": code},
      );
      Map parsedData = json.decode(response.toString());
      if (response.statusCode == 200) {
        if (parsedData["status"] == 1) {
          loggedinUser =
              ProviderModel.fromJsonRegister(parsedData["data"]["provider"]);
          token = parsedData["data"]["token"];
          return {"status": true, "message": parsedData["message"]};
        }
        return {"status": false, "message": parsedData["message"]};
      } else
        return {"status": false, "message": "Problem happened"};
    } catch (e) {
      debugPrint("Error---------------->" + e.toString());
      return {"status": false, "message": "Connection Problem"};
    }
  }

  Future<bool> register({
    String name,
    String phone,
    String description,
    int idSpec,
    int idCountry,
    File image,
  }) async {
    try {
      FormData formData = FormData();
      //add fileds
      formData.fields.add(MapEntry("name", name));
      formData.fields.add(MapEntry("phone", phone));
      formData.fields.add(MapEntry("country_id", idCountry.toString()));
      formData.fields.add(MapEntry("specialty_id", idSpec.toString()));
      formData.fields.add(MapEntry("description", description));
      //add file (image)
      final mapEntry = await createRequestFile(image);
      formData.files.add(mapEntry);
      Response response = await dio.post(
          api +
              "providers/store-provider?locale=" +
              await StorageService.instacne.getLanguage(),
          queryParameters: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          },
          data: formData);
      print(response.data);
      Map parsedData = json.decode(response.toString());
      token = parsedData["data"]["token"];
      await ProvidersService.instance.updateLocation(
          LocationService.instance.realTimeLocation["lat"],
          LocationService.instance.realTimeLocation["lng"]);
      if (parsedData.containsKey("data")) {
        loggedinUser =
            ProviderModel.fromJsonRegister(parsedData["data"]["provider"]);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> update({
    String name,
    String phone,
    String description,
    int idSpec,
    int idCountry,
    File image,
  }) async {
    try {
      FormData formData = FormData();
      //add fileds
      formData.fields.add(MapEntry("name", name));
      formData.fields.add(MapEntry("phone", phone));
      formData.fields.add(MapEntry("country_id", idCountry.toString()));
      formData.fields.add(MapEntry("specialty_id", idSpec.toString()));
      formData.fields.add(MapEntry("description", description));
      //add file (image)
      if (image != null) {
        final mapEntry = await createRequestFile(image);
        formData.files.add(mapEntry);
      }
      Response response =
          await dio.post(api + "providers/" + loggedinUser.id + "/update",
              options: Options(
                headers: {
                  "X-Requested-With": "XMLHttpRequest",
                  "Authorization": "Bearer $token"
                },
              ),
              data: formData);
      debugPrint(response.toString());
      Map parsedData = json.decode(response.toString());
      if (parsedData.containsKey("data")) {
        loggedinUser =
            ProviderModel.fromJsonRegister(parsedData["data"]["provider"]);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
