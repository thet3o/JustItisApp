import 'package:flutter/material.dart';
import 'package:justitis_app/controllers/appwrite_controller.dart';

class Home extends StatelessWidget{

  final appwritectrl = AppwriteController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () => appwritectrl.auth(), child: const Text('Login'))
      ],
    );
  }

}