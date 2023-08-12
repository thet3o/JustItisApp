import 'package:flutter/material.dart';
import 'package:justitis_app/providers/appwrite_provider.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:justitis_app/views/home.dart';
import 'package:justitis_app/views/login.dart';
import 'package:provider/provider.dart';

void main() async{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppwriteProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider())
      ],
      child: const JustItisApp(),
    )
  );
}

class JustItisApp extends StatelessWidget{
  const JustItisApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AppwriteProvider>().authStatus;
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
