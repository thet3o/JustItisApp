import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justitis_app/controllers/appwrite_controller.dart';
import 'package:justitis_app/providers/appwrite_provider.dart';

class Home extends StatelessWidget{

  var name = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name.value),
        ElevatedButton(onPressed: () => AppwriteProvider.auth(), child: const Text('Login')),
        ElevatedButton(onPressed: () async{
          name.value = (await AppwriteProvider.getUser()).name;
        }, child: const Text('Refresh')),
      ],
    );
  }

}