import 'package:flutter/material.dart';

class CategoryMenu extends StatefulWidget{
  @override
  CategoryMenuState createState() => CategoryMenuState();
}

class CategoryMenuState extends State<CategoryMenu>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Seleziona elemento')
        ],
      ),
    );
  }

}