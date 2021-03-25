import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:majalatek/services/storage_service.dart';
import 'package:majalatek/utils/image_uploader.dart';

import '../models/providers/providers_model.dart';
import '../utils/constants.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;
import 'location_service.dart';

class ProvidersService {
  ProvidersService._();

  ProviderModel selectedProvider;
  List<Map> nearbySpecialities;
  List<ProviderModel> nearbyProviders;
  List<ProviderModel> searchResultProviders = [];
  List<Map> searchResultSpecialities = [];
  List<ProviderModel> specialProviders = [];
  List<ProviderModel> normalProviders = [];
  List<ProviderModel> depSpecialProviders = [];
  List<ProviderModel> depNormalProviders = [];
  String selectedDepart;

  static final ProvidersService instance = ProvidersService._();

  Dio dio = Dio(
    BaseOptions(
      connectTimeout: 5000,
    ),
  );

  /// Get nearest Providers by location
  Future<List<ProviderModel>> getNearbyProviders() async {
    try {
      Response response = await dio.post(
        api +
            "getNearestProviders?locale=" +
            await StorageService.instacne.getLanguage(),
        queryParameters: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
        data: {
          "lat": LocationService.instance.realTimeLocation["lat"],
          "lng": LocationService.instance.realTimeLocation["lng"]
        },
      );
      var parsedData = json.decode(response.toString());
      var listOfProviders = parsedData["data"]["providers"];
      List<ProviderModel> providers = [];
      for (Map provider in listOfProviders) {
        providers.add(ProviderModel.fromJson(provider));
      }
      nearbyProviders = providers;
      searchResultProviders.addAll(nearbyProviders);
      return providers;
    } catch (e) {
      return [];
    }
  }

  Future<Map> getWorkingDays() async {
    try {
      Response response = await dio.get(
          api + "providers/" + selectedProvider.id + "/getWorkingDays",
          queryParameters: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          });
      var parsedData = json.decode(response.toString());
      return {"status": true, "data": parsedData["data"]};
    } catch (e) {
      return {"status": false, "data": {}};
    }
  }

  Future<String> getCountryFlag() async {
    try {
      Response response = await dio.get(
          api +
              "getCountries?locale=" +
              await StorageService.instacne.getLanguage(),
          queryParameters: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          });
      String flag;
      var parsedData = json.decode(response.toString());
      for (var item in parsedData["data"]) {
        if (item["title"].compareTo(selectedProvider.country) == 0) {
          flag = item["flag"];
        }
      }
      return flag;
    } catch (e) {
      return "404";
    }
  }

  Future<List<Map<String, dynamic>>> getImages() async {
    try {
      Response response = await dio.get(
          api + "providers/" + selectedProvider.id + "/getImages",
          queryParameters: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          });
      var parsedData = json.decode(response.toString());
      List<Map<String, dynamic>> list = [];
      for (var image in parsedData["data"]) {
        list.add(image);
      }
      return list;
    } catch (e) {
      debugPrint("getImages Error : " + e.toString());
      return [];
    }
  }

  getNearbySpecialities() {
    List<String> list = [];
    List<Map> specialities = [];
    if (!(nearbyProviders == null)) {
      for (var provider in nearbyProviders) {
        if (!list.contains(provider.specialty["title"])) {
          list.add(provider.specialty["title"]);
          specialities.add(provider.specialty);
        }
      }
    }
    nearbySpecialities = specialities;
  }

  searchNearbySpecialities(String key) {
    try {
      searchResultProviders.clear();
      searchResultSpecialities.clear();
      specialProviders.clear();
      normalProviders.clear();
      for (ProviderModel provider in nearbyProviders) {
        if (provider.specialty["title"].contains(key)) {
          print(provider.specialty["title"]);
          if (searchResultSpecialities.isEmpty) {
            searchResultSpecialities.add(provider.specialty);
            if (provider.isSpecial.compareTo("1") == 0) {
              specialProviders.add(provider);
            } else {
              normalProviders.add(provider);
            }
          } else {
            for (Map element in searchResultSpecialities) {
              if (!(element["title"].compareTo(provider.specialty["title"]) ==
                  0)) {
                searchResultSpecialities.add(provider.specialty);
                if (provider.isSpecial.compareTo("1") == 0) {
                  specialProviders.add(provider);
                } else {
                  normalProviders.add(provider);
                }
              }
            }
          }
        }
      }
    } catch (e) {}
  }

  getSpecialityProviders(String text) {
    ProvidersService.instance.specialProviders.clear();
    ProvidersService.instance.normalProviders.clear();
    List<ProviderModel> list = [];

    for (var provider in ProvidersService.instance.nearbyProviders) {
      if (provider.specialty["title"].compareTo(text) == 0) {
        list.add(provider);
        if (provider.isSpecial.compareTo("1") == 0) {
          ProvidersService.instance.specialProviders.add(provider);
        } else {
          ProvidersService.instance.normalProviders.add(provider);
        }
      }
    }
    ProvidersService.instance.searchResultProviders = list;
  }

  Future addView() async {
    try {
      if (selectedProvider.id.compareTo(AuthService.instance.loggedinUser.id) ==
          0) {
        return;
      } else {
        await dio.get(api + "providers/" + selectedProvider.id + "/addView",
            queryParameters: {
              "Content-Type": "application/json",
              "X-Requested-With": "XMLHttpRequest"
            });
      }
    } catch (e) {}
  }

  Future profileSelected(ProviderModel provider) async {
    selectedProvider = provider;
    provider.countryFlag = await ProvidersService.instance.getCountryFlag();
    await addView();
  }

  Future rateProvider(double politeness, double time, double quality,
      double again, double satisfied, String comment) async {
    try {
      await dio.post(
        api + "providers/" + selectedProvider.id + "/rateProvider",
        queryParameters: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
        data: {
          "team": politeness,
          "time": time,
          "good": quality,
          "another": again,
          "price": satisfied,
          "comment": comment
        },
      );
    } catch (e) {}
  }

  Future<Map> getCountries() async {
    try {
      Response response = await dio.get(
          api +
              "getCountries?locale=" +
              await StorageService.instacne.getLanguage(),
          queryParameters: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          });
      var parsedData = json.decode(response.toString());
      return {"status": true, "data": parsedData["data"]};
    } catch (e) {
      return {"status": false, "data": []};
    }
  }

  Future<Map> getSpecialitites() async {
    try {
      Response response = await dio.get(
          api +
              "getSpecialties?locale=" +
              await StorageService.instacne.getLanguage(),
          queryParameters: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          });
      var parsedData = json.decode(response.toString());
      return {"status": true, "data": parsedData["data"]};
    } catch (e) {
      return {"status": false, "data": []};
    }
  }

  Future<bool> updateWorkingDays({
    String saturdayFrom,
    String saturdayTo,
    String sundayFrom,
    String sundayTo,
    String mondayFrom,
    String mondayTo,
    String tuesdayFrom,
    String tuesdayTo,
    String wednesdayFrom,
    String wednesdayTo,
    String thursdayFrom,
    String thursdayTo,
    String fridayFrom,
    String fridayTo,
  }) async {
    try {
      http.Response response = await http.post(
        api +
            "providers/" +
            AuthService.instance.loggedinUser.id +
            "/updateWorkingDays",
        headers: {
          // "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest",
          "Authorization": "Bearer ${AuthService.instance.token}"
        },
        body: {
          "saturday_from": saturdayFrom,
          "saturday_to": saturdayTo,
          "sunday_from": sundayFrom,
          "sunday_to": sundayTo,
          "monday_from": mondayFrom,
          "monday_to": mondayTo,
          "tuesday_from": tuesdayFrom,
          "tuesday_to": tuesdayTo,
          "wednesday_from": wednesdayFrom,
          "wednesday_to": wednesdayTo,
          "thursday_from": thursdayFrom,
          "thursday_to": thursdayTo,
          "friday_from": fridayFrom,
          "friday_to": fridayTo,
        },
      );
      Map parsedData = json.decode(response.body.toString());
      if (parsedData.containsKey("data")) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateLocation(double lat, double lng) async {
    try {
      if (AuthService.instance.loggedinUser != null) {
        http.Response response = await http.post(
          api +
              "providers/" +
              AuthService.instance.loggedinUser.id +
              "/updateLocation",
          headers: {
            "X-Requested-With": "XMLHttpRequest",
            "Authorization": "Bearer " + AuthService.instance.token
          },
          body: {
            "lat": lat.toString(),
            "lng": lng.toString(),
          },
        );
        debugPrint(response.body);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Update Location -------->" + e.toString());
      return false;
    }
  }

  Future updateContacts(String snapchat, String instagram, String whatsapp,
      String twitter, String website, String email) async {
    try {
      http.Response response = await http.post(
        api +
            "providers/" +
            AuthService.instance.loggedinUser.id +
            "/updateContact",
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "Authorization": "Bearer " + AuthService.instance.token
        },
        body: {
          "email": email,
          "twitter": twitter,
          "instagram": instagram,
          "whatsapp": whatsapp,
          "snapchat": snapchat,
          "website": website
        },
      );
      print(response.body);
      await refreshProfile();
    } catch (e) {
      print(e.toString());
    }
  }

  Future refreshProfile() async {
    try {
      Response response = await dio.get(
          api +
              "providers/" +
              AuthService.instance.loggedinUser.id +
              "/ProviderProfile?locale=" +
              await StorageService.instacne.getLanguage(),
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
          }));
      AuthService.instance.loggedinUser =
          ProviderModel.fromJsonRegister(response.data["data"]);
      print(response.data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future addImage(String titleAr, String titleEn, File image) async {
    try {
      FormData formData = FormData();
      //add fileds
      formData.fields.add(MapEntry("title_ar", titleAr));
      formData.fields.add(MapEntry("title_en", titleEn));
      //add file (image)
      final mapEntry = await createRequestFile(image);
      formData.files.add(mapEntry);
      Response response = await dio.post(
          api +
              "providers/" +
              AuthService.instance.loggedinUser.id +
              "/addImage",
          options: Options(
            headers: {
              "X-Requested-With": "XMLHttpRequest",
              "Authorization": "Bearer " + AuthService.instance.token
            },
          ),
          data: formData);
      debugPrint(response.toString());
    } catch (e) {}
  }

  Future deleteImage(String imageId) async {
    try {
      await dio.get(api + "providers/images/" + imageId + "/delete",
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Authorization": "Bearer ${AuthService.instance.token}"
          }));
    } catch (e) {}
  }

  Future getRating() async {
    try {
      Response response = await dio.get(
          api +
              "providers/" +
              ProvidersService.instance.selectedProvider.id +
              "/getTotalRate",
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Authorization": "Bearer ${AuthService.instance.token}"
          }));
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future getDepartments() async {
    try {
      Response response = await dio.get(api +
          "getDepartments?locale=" +
          await StorageService.instacne.getLanguage());
      return response.data["data"];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Map>> getDepartmentsSpecialities() async {
    List<Map> specialities = [];
    try {
      Response response = await dio.get(api +
          "departments/$selectedDepart/specialties?locale=" +
          await StorageService.instacne.getLanguage());
      for (var element in response.data["data"]) {
        specialities.add(element);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return specialities;
  }

  Future getAllSpecialityProviders(String id) async {
    try {
      depNormalProviders.clear();
      depSpecialProviders.clear();
      Response response = await dio.get(api +
          "specialties/$id/providers?locale=" +
          await StorageService.instacne.getLanguage());

      for (var element in response.data["data"]) {
        if (element["is_special"] == 1) {
          depSpecialProviders.add(ProviderModel.fromJson(element));
        } else {
          depNormalProviders.add(ProviderModel.fromJson(element));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
