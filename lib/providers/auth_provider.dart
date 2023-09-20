import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:justitis_app/services/appwrite_service.dart';


enum AuthStatus{
  uninit, auth, unauth
}

class AuthProvider extends ChangeNotifier{

  late User _currentUser;

  double _wallet = 0.0;
  double _moneyToAdd = 0.0;

  AuthStatus _authStatus = AuthStatus.uninit;

  // Getter
  User get currentUser => _currentUser;
  AuthStatus get authStatus => _authStatus;
  double get wallet => _wallet;
  double get moneyToAdd => _moneyToAdd;

  set moneyToAdd(double money) => _moneyToAdd = money;

  //Appwrite constants

  // Remote Server
  // final String userCollectionId = '64d295100d412a890d19';
  // final String _successRedirectUrl = 'https://test.justitis.it/auth.html';

  //Local Server
  final String _userCollectionId = 'users';
  final String _successRedirectUrl = 'http://justitis.it/auth.html';

  AuthProvider(){
    checkIfLogged();
  }

  void checkIfLogged() async{
    try{
      _currentUser = await AppwriteService.account.get();
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
      var result = await AppwriteService.database.getDocument(databaseId: AppwriteService.databaseId, collectionId: _userCollectionId, documentId: _currentUser.$id);
      var document = result.toMap();
      _wallet = (document['data']['balance'] + 0.0);
    }finally{
      notifyListeners();
    }
  }

  void logIn() async{
    try{
      //final session = 
      await AppwriteService.account.createOAuth2Session(provider: 'google', success: _successRedirectUrl);
      _currentUser = await AppwriteService.account.get();
      _authStatus = AuthStatus.auth;
      updateWallet();
    }finally{
      notifyListeners();
    }
  }

  void logOut() async{
    try{
      await AppwriteService.account.deleteSession(sessionId: 'current');
      _authStatus = AuthStatus.unauth;
    }finally{
      notifyListeners();
    }
  }
}