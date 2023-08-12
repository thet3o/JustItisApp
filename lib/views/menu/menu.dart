import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:justitis_app/views/menu/category.dart';
import 'package:justitis_app/views/menu/categoryMenu.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget{
  const Menu({super.key});

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> with TickerProviderStateMixin{

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final currentScreen =  context.watch<MenuProvider>().currentScreen;
    final menuProvider = context.read<MenuProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordina'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
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
    );
  }
}