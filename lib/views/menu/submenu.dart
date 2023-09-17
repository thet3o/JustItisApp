import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:justitis_app/views/menu/customization.dart';
import 'package:provider/provider.dart';

class SubMenu extends StatefulWidget{
  final List<IngredientCategory> categories;

  const SubMenu({super.key, required this.categories});

  @override
  SubMenuState createState() => SubMenuState();
}

class SubMenuState extends State<SubMenu>{
  @override
  Widget build(BuildContext context) {
    final MenuProvider menuProvider = context.read<MenuProvider>();
    final ingredients = context.watch<MenuProvider>().ingredients;
    menuProvider.updateIngredients(widget.categories);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordina'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      if(IngredientCategory.values[ingredients[index].productType.idProductType] != IngredientCategory.panino){
                        menuProvider.addOrder(ingredients[index]);
                        Navigator.pop(context);
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Customization(mainProduct: ingredients[index])));
                      }
                    },
                    title: Text(ingredients[index].name),
                    subtitle: Text(NumberFormat.currency(locale:'eu').format(ingredients[index].price)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}