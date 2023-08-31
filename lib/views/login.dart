import 'package:flutter/material.dart';
import 'package:justitis_app/providers/auth_provider.dart';
import 'package:justitis_app/views/home.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    final AuthProvider appwriteProvider = Provider.of<AuthProvider>(context, listen: true);
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
          onPressed: (){
            appwriteProvider.logIn();
            if(appwriteProvider.authStatus == AuthStatus.auth){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
            }
          },
          child: const Text('Login'),
        )
      ],
    );
  }

}