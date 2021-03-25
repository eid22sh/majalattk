import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  Box _box;
  StorageService._();
  static final instacne = StorageService._();

  Future<bool> initHive() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      _box = await Hive.openBox("storage");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future saveLanguage(String value) async {
    await _box.put("lang", value);
  }

  Future deleteLanguage() async {
    await _box.delete("lang");
  }

  Future<String> getLanguage() async {
    var lang = await _box.get("lang");
    if (lang == null) {
      return "404";
    }
    return lang.toString();
  }

  Future saveChatId(String number) async {
    await _box.put("chat_id", number);
  }

  Future<String> getChatId() async {
    var id = await _box.get("chat_id");
    if (id == null) {
      return "404";
    }
    return id.toString();
  }

  Future saveRoomId(String number) async {
    await _box.put("room_id", number);
  }

  Future<String> getRoomId() async {
    var id = await _box.get("room_id");
    if (id == null) {
      return "404";
    }
    return id.toString();
  }
}
