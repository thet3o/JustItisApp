import 'package:flutter/material.dart';
import 'package:justitis_app/controllers/appwrite_controller.dart';
import 'package:justitis_app/providers/appwrite_provider.dart';

class Home extends StatelessWidget{

  var name = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name),
        ElevatedButton(onPressed: () => AppwriteProvider.auth(), child: const Text('Login')),
        ElevatedButton(onPressed: () async{
          final datna =  (await AppwriteProvider.getUser()).name;
          print(datna);
        }, child: const Text('Refresh')),
      ],
    );
  }

}