import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService{
  static late FirebaseMessaging messaging;
  static late NotificationSettings settings;
  String token = "";

  FCMService(){
    messaging = FirebaseMessaging.instance;
    requestPermission();
    getToken();
  }

  void requestPermission() async{
    settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void getToken() async{
    token = (await messaging.getToken(vapidKey: "BMxkL_37yjIRiVe0j-n-gdxNwT73BRhOY91aiz7v-tM9KgdGmKs9EN7w8uWecmR3BdUUFxm0qhIrBGM8A-VCTtg"))!;
    print(token);
  }
}