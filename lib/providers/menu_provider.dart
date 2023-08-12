import 'package:flutter/material.dart';


enum MenuScreen{
  category, categoryMenu, cart, checkout
}

class MenuProvider extends ChangeNotifier{

  MenuScreen _currentScreen = MenuScreen.category;


  MenuScreen get currentScreen => _currentScreen;

  void setCurrentScreen(MenuScreen screen) {
    _currentScreen = screen;
    notifyListeners();
  }

}