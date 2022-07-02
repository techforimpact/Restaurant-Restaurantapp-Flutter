import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'general_controller.dart';

sendNotificationCall(String token, String? title, String body) async {
  http.Response response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAjs2U2XQ:APA91bGigJB1vnEYmb8wR7H1Tr2tu3e5hwBEZma4xQ44twCEmMkQd3TtDZb1GOFIublUm5mBrcKQxUZ_ISoQvonKdCW7w9y_tA32VI0BLtCVfeqt4JibhkZUWqsOjAi33zArCY4hJZXp',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': ' ${Get.find<GeneralController>().boxStorage.read('uid')}: $body', 'title': title},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
        },
        'to': token
      },
    ),
  );
}
