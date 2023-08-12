import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';


enum AuthStatus{
  uninit, auth, unauth
}

class AppwriteProvider extends ChangeNotifier{
  Client client = Client();
  //Account account = Account(AppwriteProvider.client);
  late final Account account;
  //Avatars avatar = Avatars(client);
  late final Avatars avatar;
  late final Databases database;

  late User _currentUser;

  double _wallet = 0.0;

  AuthStatus _authStatus = AuthStatus.uninit;


  // Getter
  User get currentUser => _currentUser;
  AuthStatus get authStatus => _authStatus;
  double get wallet => _wallet;
  

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
    database = Databases(client);
  }

  void checkIfLogged() async{
    try{
      _currentUser = await account.get();
      _authStatus = AuthStatus.auth;
      updateWallet();
    }catch(e){
      _authStatus = AuthStatus.unauth;
    }finally{
      notifyListeners();
    }
  }

  void updateWallet() async{
    try{
      var result = await database.getDocument(databaseId: '64c624390f8d5b123bdc', collectionId: '64d295100d412a890d19', documentId: _currentUser.$id);
      var document = result.toMap();
      _wallet = (document['data']['balance'] + 0.0);
    }finally{
      notifyListeners();
    }
  }

  void logIn() async{
    try{
      final session = await account.createOAuth2Session(provider: 'google', success: 'https://test.justitis.it/auth.html');
      _currentUser = await account.get();
      _authStatus = AuthStatus.auth;
      updateWallet();
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