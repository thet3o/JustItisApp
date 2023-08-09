import 'package:flutter/material.dart';
import 'package:justitis_app/providers/appwrite_provider.dart';
import 'package:justitis_app/views/home.dart';

void main() {
  AppwriteProvider();
  runApp(MaterialApp(home: Home()));
}
