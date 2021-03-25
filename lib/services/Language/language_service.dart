import 'package:flutter/material.dart';
import 'package:majalatek/services/Language/data.dart';
import 'package:majalatek/services/storage_service.dart';

class LanguageService extends ChangeNotifier {
  static LanguageService instance = LanguageService();
  Map data = arabic;
  Future changeLanguage(String id) async {
    if (id.compareTo("ar") == 0) {
      data = arabic;
      notifyListeners();
      await StorageService.instacne.saveLanguage(id);
    } else {
      data = english;
      notifyListeners();
      await StorageService.instacne.saveLanguage(id);
    }
  }
}
