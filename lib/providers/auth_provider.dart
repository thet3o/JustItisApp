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
  String _className = '';

  //late List<DropdownMenuItem<String>> classItems;

  AuthStatus _authStatus = AuthStatus.uninit;

  // Getter
  User get currentUser => _currentUser;
  AuthStatus get authStatus => _authStatus;
  double get wallet => _wallet;
  double get moneyToAdd => _moneyToAdd;
  String get className => _className;

  set moneyToAdd(double money) => _moneyToAdd = money;


  //Appwrite constants
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
      final userdb = await AppwriteService.database.getDocument(databaseId: AppwriteService.databaseId, collectionId: 'users', documentId: _currentUser.$id);
      if (!(userdb.data['class'] == null)){
        _className = userdb.data['class'];
      }
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

   Future<List<DropdownMenuItem<String>>> classesList() async{
    List<DropdownMenuItem<String>> classesItem = [];
    try{
      final classes = await AppwriteService.database.listDocuments(databaseId: AppwriteService.databaseId, collectionId: 'classes');
      for (var element in classes.documents) {
        classesItem.add(DropdownMenuItem(value: element.data['class'], child: Text(element.data['class'])));
      }
      return classesItem;
    }finally{
      notifyListeners();
    }
  }

  void setClassItem(String classItemValue){
    try{
      _className = classItemValue;
    }finally{notifyListeners();}
    
  }

  void setClass() async{
    try{
      await AppwriteService.database.updateDocument(
      databaseId: AppwriteService.databaseId, 
      collectionId: 'users', 
      documentId: _currentUser.$id,
        data: {
          'class': _className
        }
      );
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