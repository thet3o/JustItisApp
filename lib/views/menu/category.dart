import 'package:flutter/material.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget{
  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Category>{
  @override
  Widget build(BuildContext context) {
    final MenuProvider menuProvider = context.read<MenuProvider>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Seleziona categoria'),
          ElevatedButton(onPressed: () => menuProvider.setCurrentScreen(MenuScreen.categoryMenu), child: const Text('Select'))
        ],
      ),
    );
  }
}