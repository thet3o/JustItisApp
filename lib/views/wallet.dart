import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:justitis_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Wallet extends StatefulWidget{
  const Wallet({super.key});

  @override
  WalletState createState() => WalletState();
}

class WalletState extends State<Wallet>{

  @override
  Widget build(BuildContext context) {
    final AuthProvider appwriteProvider = context.read<AuthProvider>();
    final double balance = context.watch<AuthProvider>().wallet;
    final double moneyToAdd = context.watch<AuthProvider>().moneyToAdd;
    appwriteProvider.updateWallet();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            appwriteProvider.moneyToAdd = 0;
            Navigator.pop(context);
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              NumberFormat.currency(locale: 'eu').format(balance), style: const TextStyle(
                color: Colors.black54,
                fontSize: 50
              ),
            ),
            Text(
              '+${NumberFormat.currency(locale: 'eu').format(moneyToAdd)}', style: const TextStyle(
                color: Color.fromARGB(255, 57, 107, 60),
                fontSize: 30
              ),
            ),
            QrImageView(
              data: moneyToAdd.toString(),
              size: 200,
            ),
            const Text('Aggiungi:', style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 6,),
            Wrap(
              spacing: 3,
              children: [
                ElevatedButton(onPressed: (){
                  appwriteProvider.moneyToAdd = moneyToAdd + 0.10;
                }, child: const Text('0.10€')),
                ElevatedButton(onPressed: (){
                  appwriteProvider.moneyToAdd = moneyToAdd + 0.20;
                }, child: const Text('0.20€')),
                ElevatedButton(onPressed: (){
                  appwriteProvider.moneyToAdd = moneyToAdd + 0.50;
                }, child: const Text('0.50€'))
              ],
            ),
            const SizedBox(height: 3,),
            Wrap(
              spacing: 3,
              children: [
                ElevatedButton(onPressed: (){
                  appwriteProvider.moneyToAdd = moneyToAdd + 1.00;
                }, child: const Text('1.00€')),
                ElevatedButton(onPressed: (){
                  appwriteProvider.moneyToAdd = moneyToAdd + 2.00;
                }, child: const Text('2.00€')),
                ElevatedButton(onPressed: (){
                  appwriteProvider.moneyToAdd = moneyToAdd + 5.00;
                }, child: const Text('5.00€'))
              ],
            ),
            const SizedBox(height: 3,),
            ElevatedButton(onPressed: (){
              appwriteProvider.moneyToAdd = 0;
            }, child: const Text('RESET'))
          ],
        ),
      ),
    );
  }
}