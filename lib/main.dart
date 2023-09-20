import 'package:flutter/material.dart';
import 'package:justitis_app/providers/auth_provider.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:justitis_app/providers/myorders_provider.dart';
import 'package:justitis_app/services/appwrite_service.dart';
import 'package:justitis_app/services/fcm_service.dart';
import 'package:justitis_app/views/home.dart';
import 'package:justitis_app/views/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  AppwriteService();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  FCMService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => MyOrdersProvider())
      ],
      child: const JustItisApp(),
    )
  );
}

class JustItisApp extends StatelessWidget{
  const JustItisApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthProvider>().authStatus;
    return MaterialApp(
      title: 'JustItisApp',
      debugShowCheckedModeBanner: false,
      home: (authStatus == AuthStatus.auth)?const Home():const Login(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: const Color.fromARGB(255, 250, 186, 90),
      ),
    );
  }
}
