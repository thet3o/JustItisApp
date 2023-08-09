import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justitis_app/providers/appwrite_provider.dart';


class Home extends StatefulWidget{

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home>{

  final advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    setState(() {
      AppwriteProvider.checkIfUserHaveSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller:  advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Colors.orange, Colors.orange.withOpacity(0.2)]
          )
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128,
                  height: 128,
                  margin: const EdgeInsets.only(top: 24, bottom: 64),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: FutureBuilder(
                    future: AppwriteProvider.avatar.getInitials(),
                    builder: (context, snapshot) {
                      return snapshot.hasData && snapshot.data != null ? Image.memory(snapshot.data!) : const CircularProgressIndicator();
                    },
                  )
                ),
                if(AppwriteProvider.isLogged)
                ListTile(
                  onTap: () {},
                  leading: const FaIcon(FontAwesomeIcons.utensils),
                  title: const Text('I miei ordini'),
                ),
                if(AppwriteProvider.isLogged)
                ListTile(
                  onTap: () {},
                  leading: const FaIcon(FontAwesomeIcons.pizzaSlice),
                  title: const Text('Ordina'),
                ),
                if(AppwriteProvider.isLogged)
                ListTile(
                  onTap: () {},
                  leading: const FaIcon(FontAwesomeIcons.wallet),
                  title: const Text('Ricarica Wallet'),
                ),
                ListTile(
                  onTap: () => setState(() {
                    (!AppwriteProvider.isLogged)?AppwriteProvider.auth():AppwriteProvider.deauth();
                  }),
                  leading: FaIcon((!AppwriteProvider.isLogged)?FontAwesomeIcons.rightToBracket:FontAwesomeIcons.rightFromBracket),
                  title: Text((!AppwriteProvider.isLogged)?'Login':'Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('JustItis'),
          leading: IconButton(
            onPressed: () => advancedDrawerController.toggleDrawer(),
            icon: const FaIcon(FontAwesomeIcons.bars),
          ),
        ),
      ),
    );
  }

}