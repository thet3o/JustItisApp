import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final menuProvider = context.read<MenuProvider>();
    final cart = context.watch<MenuProvider>().cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Il tuo ordine'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(cart[index].mainProduct.name),
                      trailing: IconButton.filledTonal(
                          onPressed: () {
                            menuProvider.deleteOrder(index);
                            if (cart.isEmpty) {
                              Navigator.pop(context);
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.trash)),
                    ),
                  );
                },
              ),
            ),
            if (Provider.of<MenuProvider>(context, listen: false)
                .waitToSendOrder)
              const CircularProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Provider.of<MenuProvider>(context)
                          .sendOrderProgress(true);
                      Navigator.pop(context);
                    },
                    child: const Text('Aggiungi altro')),
                ElevatedButton(
                    onPressed: () {
                      menuProvider.createOrder();
                      Navigator.pop(context);
                    },
                    child: const Text('Completa l\'ordine'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
