import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majalatek/services/Language/language_service.dart';
import 'package:majalatek/services/storage_service.dart';
import 'package:majalatek/view/routes/routes.dart';
import 'package:majalatek/view/screens/SplashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instacne.initHive();
  runApp(MajalatekApp());
}

class MajalatekApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LanguageService.instance,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Majalatek",
        home: SplashScreen(),
        getPages: routes,
      ),
    );
  }
}
