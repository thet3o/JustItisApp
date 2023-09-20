import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:justitis_app/services/appwrite_service.dart';

class FCMService{
  static late FirebaseMessaging messaging;
  static late NotificationSettings settings;
  static String token = "";

  FCMService(){
    messaging = FirebaseMessaging.instance;
    requestPermission();
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

  static void getToken() async{
    token = (await messaging.getToken(vapidKey: "BMxkL_37yjIRiVe0j-n-gdxNwT73BRhOY91aiz7v-tM9KgdGmKs9EN7w8uWecmR3BdUUFxm0qhIrBGM8A-VCTtg"))!;
  }

  static void setTokenToUser(String userId) async{
    await AppwriteService.functions.createExecution(
      functionId: '650b5d07bcf5bc3a4c8d',
      data: jsonEncode({
        'userId': userId,
        'fcm_token': token
      })
    );
  }
}