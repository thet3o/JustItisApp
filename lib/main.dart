import 'package:flutter/material.dart';
import 'package:justitis_app/providers/appwrite_provider.dart';
import 'package:justitis_app/views/home.dart';
import 'package:justitis_app/views/login.dart';

void main() {
  final appwriteProvider = AppwriteProvider();
  appwriteProvider.init();
  appwriteProvider.checkIfUserHaveSession();
  runApp(MaterialApp(home: (appwriteProvider.checkIfLogged())? const Login() : const Home()));
}
