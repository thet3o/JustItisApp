import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum AuthStatus{
  uninit, auth, unauth
}

class AppwriteProvider extends ChangeNotifier{
  Client client = Client();
  //Account account = Account(AppwriteProvider.client);
  late final Account account;
  //Avatars avatar = Avatars(client);
  late final Avatars avatar;

  late User _currentUser;

  AuthStatus _authStatus = AuthStatus.uninit;


  // Getter
  User get currentUser => _currentUser;
  AuthStatus get authStatus => _authStatus;

  AppwriteProvider(){
    init();
    checkIfLogged();
  }

  void init() async{
    client.setEndpoint('https://backend.justitis.it:2053/v1')
    .setProject('64c6156149b8d74d0fe4')
    .setSelfSigned();
    account = Account(client);
    avatar = Avatars(client);
  }

  void checkIfLogged() async{
    try{
      _currentUser = await account.get();
      _authStatus = AuthStatus.auth;
    }catch(e){
      _authStatus = AuthStatus.unauth;
    }finally{
      notifyListeners();
    }
  }

  void logIn() async{
    try{
      final session = await account.createOAuth2Session(provider: 'google', success: 'https://test.justitis.it/auth.html');
      _currentUser = await account.get();
      _authStatus = AuthStatus.auth;
    }finally{
      notifyListeners();
    }
  }

  void logOut() async{
    try{
      await account.deleteSession(sessionId: 'current');
      _authStatus = AuthStatus.unauth;
    }finally{
      notifyListeners();
    }
  }
}