import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getCustomerDeviceToken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      return token;
    } else {
      throw Exception('Failed to get token');
    }
  } catch (e) {
    // ignore: avoid_print
    print("Error : $e");
    throw Exception('Failed to get token');
  }
}
