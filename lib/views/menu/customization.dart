import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justitis_app/models.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:provider/provider.dart';

class Customization extends StatefulWidget{
  final Ingredient mainProduct;

  const Customization({super.key, required this.mainProduct});

  @override
  CustomizationState createState() => CustomizationState();
}

class CustomizationState extends State<Customization>{
  @override
  Widget build(BuildContext context) {
    final menuProvider = context.read<MenuProvider>();
    //final ingredients = context.watch<MenuProvider>().ingredients;
    final availableFillings = context.watch<MenuProvider>().availableFillings;
    //final available_additions = context.watch<MenuProvider>().availableAdditions;
    final orderFillings = context.watch<MenuProvider>().orderFillings;
    final orderAdditions = context.watch<MenuProvider>().orderAdditions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalizza'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: availableFillings.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(availableFillings[index].name),
                      trailing: IconButton(onPressed: (){
                        orderFillings.add(availableFillings[index]);
                      }, icon: const FaIcon(FontAwesomeIcons.plus)),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: (){
              menuProvider.addOrder(widget.mainProduct, fillings: orderFillings, additions: orderAdditions);
              Navigator.of(context)..pop()..pop();
            }, child: const Text('Aggiungi al carrello'))
          ],
        ),
      ),
    );
  }
}