import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  UrlLauncher._();

  static Future launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      Get.snackbar("Error", "This contact info is not available");
    }
  }
}
