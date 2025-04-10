import '../../../core/class/crud.dart';
import '../../../core/function/get_functions.dart';
import '../../../link_api.dart';

class MessageData {
  CRUD crud;
  final String _token = getToken();
  MessageData(this.crud);

  getMessage({required String sendID, required String reseiveID}) async {
    var response = await crud.postdata(
        AppLink.messagesAll,
        {
          "resiver_users_id": sendID,
          "sender_users_id": reseiveID,
        },
        _token);
    return response.fold((l) => l, (r) => r);
  }

  addMessage(
      {required String text,
      required String state,
      required String senderID,
      required String reciverID}) async {
    var response = await crud.postdata(
        AppLink.messagesAdd,
        {
          "text": text,
          "state": state,
          "resiver_users_id": reciverID,
          "sender_users_id": senderID,
        },
        _token);
    return response.fold((l) => l, (r) => r);
  }
}
