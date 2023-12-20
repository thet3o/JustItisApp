import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:justitis_app/views/menu/cart.dart';
import 'package:justitis_app/views/menu/submenu.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget{
  const Menu({super.key});

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu>{
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<MenuProvider>().cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordina'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: const Color.fromARGB(255, 255, 164, 27),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SubMenu(categories: [IngredientCategory.panino, IngredientCategory.pns])));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/menu/hamburger.png', scale: 3.5,),
                        const Text('Panini e Focaccie')
                      ],
                    ),
                  )
                ),
                Card(
                  color: const Color.fromARGB(255, 255, 164, 27),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SubMenu(categories: [IngredientCategory.bevande])));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/menu/soft-drink.png', scale: 3.5,),
                        const Text('Bevande')
                      ],
                    ),
                  )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: const Color.fromARGB(255, 255, 164, 27),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SubMenu(categories: [IngredientCategory.prodottoDelGiorno])));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/menu/brunch.png', scale: 3.5,),
                        const Text('Prodotto del giorno')
                      ],
                    ),
                  )
                ),
                Card(
                  color: const Color.fromARGB(255, 255, 164, 27),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SubMenu(categories: [IngredientCategory.snack])));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/menu/snack.png', scale: 3.5,),
                        const Text('Snacks')
                      ],
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: (cart.isNotEmpty)?
      FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
        },
        label: Text('${cart.length} Completa l\'ordine')):null,
    );
  }
}