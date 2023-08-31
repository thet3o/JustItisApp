import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justitis_app/providers/myorders_provider.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget{
  const MyOrders({super.key});

  @override
  MyOrdersState createState() => MyOrdersState();
}

class MyOrdersState extends State<MyOrders>{
  @override
  Widget build(BuildContext context) {
    final myOrdersProvider = context.read<MyOrdersProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('I miei ordini'),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
            ElevatedButton(onPressed: (){
              myOrdersProvider.updateOrdersList();
            }, child: const Text('try'))
          ],
        ),
      ),
    );
  }
}