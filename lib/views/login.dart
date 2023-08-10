import 'package:flutter/material.dart';
import 'package:justitis_app/providers/appwrite_provider.dart';
import 'package:justitis_app/views/home.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login>{

  final appwriteProvider = AppwriteProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const DefaultTextStyle(
          style: TextStyle(
            fontSize: 20
          ),
          child: Text('JustItis'),
        ),
        ElevatedButton(
          onPressed: () {
            appwriteProvider.auth();
            if (appwriteProvider.checkIfLogged()){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home())
              );
            }
          },
          child: const Text('Login'),
        )
      ],
    );
  }

}