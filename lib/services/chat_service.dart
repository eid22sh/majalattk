import 'package:dio/dio.dart';
import 'package:majalatek/services/storage_service.dart';
import 'package:majalatek/utils/constants.dart';
import 'package:majalatek/utils/response.dart';

class ChatService {
  String roomId;

  ChatService._();
  static final instance = ChatService._();

  Dio dio = Dio(
    BaseOptions(
      headers: {
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest",
      },
    ),
  );

  Future<DataHolder> getChats() async {
    String id = await StorageService.instacne.getChatId();
    if (id.compareTo("404") != 0) {
      Response response = await dio.get(api + "chats/$id/getChats");
      if (response.data["status"].toString().compareTo("0") == 1) {
        return DataHolder(
            message: "Empty conversation",
            status: true,
            data: response.data["data"]["chats"]);
      } else {
        return DataHolder(
            message: response.data["message"], status: true, data: []);
      }
    }

    return DataHolder(
        status: false, message: "start new converstaion", data: null);
  }

  Future<DataHolder> getMessages() async {
    if (roomId.compareTo("404") != 0) {
      Response response = await dio.get(api + "chats/$roomId/getMessages");
      if (response.data["status"].toString().compareTo("0") == 1) {
        return DataHolder(
            message: "Empty conversation",
            status: true,
            data: response.data["data"]["messages"]);
      } else {
        return DataHolder(
            message: response.data["message"], status: true, data: []);
      }
    }

    return DataHolder(
        status: false, message: "start new converstaion", data: null);
  }

  Future sendMessage(String message) async {
    await dio
        .post(api + "chats/$roomId/sendMessage", data: {"message": message});
  }

  Future startChat(
    String name,
    String email,
    String phone,
    String title,
    String description,
  ) async {
    await dio.post(api + "chats/start", data: {
      "name": name,
      "email": email,
      "phone": phone,
      "title": title,
      "description": description,
    });
    StorageService.instacne.saveChatId(phone);
  }
}
