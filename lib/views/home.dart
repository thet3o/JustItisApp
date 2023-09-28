import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justitis_app/providers/auth_provider.dart';
import 'package:justitis_app/providers/myorders_provider.dart';
import 'package:justitis_app/services/appwrite_service.dart';
import 'package:justitis_app/services/fcm_service.dart';
import 'package:justitis_app/views/login.dart';
import 'package:justitis_app/views/myorders.dart';
import 'package:justitis_app/views/wallet.dart';
import 'package:provider/provider.dart';
import 'menu/menu.dart';


class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home>{

  final advancedDrawerController = AdvancedDrawerController();
  final appwriteProvider = AuthProvider();
  final _classInputController = TextEditingController();

  void setFCMTkn() async{
    final user = await AppwriteService.account.get();
    await FCMService.setTokenToUser(user.$id);
  }

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) async{
    //  FCMService();
    //  await FCMService.getToken();
    //  setFCMTkn();
    //});
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //final bool isFirstLogin = context.watch<AuthProvider>().isFirstLogin;
      final AuthProvider appwriteProvider = Provider.of<AuthProvider>(context, listen: false);
      if(appwriteProvider.isFirstLogin){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text('Inserisci la tua classe'),
            content: TextField(
              controller: _classInputController,
              decoration: const InputDecoration(hintText: 'Inserisci la tua classe, es.5AI'),
            ),
            actions: [
              ElevatedButton(onPressed: (){
                if(_classInputController.text != '' && _classInputController.text.length >= 3){
                  appwriteProvider.setClass(_classInputController.text.toUpperCase());
                }
                Navigator.pop(context);
              }, child: const Text('Conferma'))
            ],
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider appwriteProvider = context.read<AuthProvider>();
    final double wallet = context.watch<AuthProvider>().wallet;
    final myOrdersProvider = context.read<MyOrdersProvider>();
    return AdvancedDrawer(
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOutCubicEmphasized,
      animationDuration: const Duration(milliseconds: 500),
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
                    future: AppwriteService.avatar.getInitials(),
                    builder: (context, snapshot) {
                      return snapshot.hasData && snapshot.data != null ? Image.memory(snapshot.data!) : const CircularProgressIndicator();
                    },
                  )
                ),
                ListTile(
                  onTap: () {
                    advancedDrawerController.hideDrawer();
                    myOrdersProvider.updateOrdersList();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrders()));
                  },
                  leading: const FaIcon(FontAwesomeIcons.utensils),
                  title: const Text('I miei ordini'),
                ),
                ListTile(
                  onTap: () {
                    advancedDrawerController.hideDrawer();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Menu()));
                  },
                  leading: const FaIcon(FontAwesomeIcons.pizzaSlice),
                  title: const Text('Ordina'),
                ),
                ListTile(
                  onTap: () {
                    advancedDrawerController.hideDrawer();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Wallet()));
                  },
                  leading: const FaIcon(FontAwesomeIcons.wallet),
                  title: const Text('Wallet'),
                ),
                ListTile(
                  onTap: (){
                    try{
                      appwriteProvider.logOut();
                    }finally{
                      if(appwriteProvider.authStatus == AuthStatus.unauth){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                      }
                    }
                  },
                  leading: const FaIcon(FontAwesomeIcons.rightFromBracket),
                  title: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('JustItis'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => advancedDrawerController.toggleDrawer(),
            icon: const FaIcon(FontAwesomeIcons.bars),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Il tuo saldo: ${wallet}'),
            ],
          ),
        )
      ),
    );
  }

}