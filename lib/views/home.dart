import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justitis_app/providers/auth_provider.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:justitis_app/providers/myorders_provider.dart';
import 'package:justitis_app/services/appwrite_service.dart';
import 'package:justitis_app/views/login.dart';
import 'package:justitis_app/views/myorders.dart';
import 'package:justitis_app/views/wallet.dart';
import 'package:provider/provider.dart';
import 'menu/menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MenuProvider>().checkIfOnTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider appwriteProvider = context.read<AuthProvider>();
    //final MenuProvider menuProvider = context.read<MenuProvider>();
    //Provider.of<MenuProvider>(context, listen: true).checkIfOnTime();
    //menuProvider.checkIfOnTime();
    return AdvancedDrawer(
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOutCubicEmphasized,
      animationDuration: const Duration(milliseconds: 500),
      animateChildDecoration: true,
      childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.orange, Colors.orange.withOpacity(0.2)])),
      ),
      drawer: SafeArea(
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
                      return snapshot.hasData && snapshot.data != null
                          ? Image.memory(snapshot.data!)
                          : const CircularProgressIndicator();
                    },
                  )),
              ListTile(
                onTap: () {
                  advancedDrawerController.hideDrawer();
                  Provider.of<MyOrdersProvider>(context, listen: false)
                      .updateOrdersList();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyOrders()));
                },
                leading: const FaIcon(FontAwesomeIcons.utensils),
                title: const Text('I miei ordini'),
              ),
              ListTile(
                onTap: () {
                  advancedDrawerController.hideDrawer();
                  //menuProvider.checkIfOnTime();
                  if (Provider.of<AuthProvider>(context, listen: false)
                      .className
                      .isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Classe mancante'),
                            content: const Text(
                                'Non hai ancora selezionato la classe a cui appartieni, per far ciò vai su "Imposta classe"'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'))
                            ],
                          );
                        });
                  } else if (!Provider.of<MenuProvider>(context, listen: false)
                      .onTime) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Fuori fascia oraria'),
                            content: const Text(
                                'Impossibile al momento ordinare poichè fuori dalla fascia oraria, ovvero le 9:30 del mattino'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'))
                            ],
                          );
                        });
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Menu()));
                  }
                },
                leading: const FaIcon(FontAwesomeIcons.pizzaSlice),
                title: const Text('Ordina'),
              ),
              ListTile(
                enabled: false,
                onTap: () {
                  advancedDrawerController.hideDrawer();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Wallet()));
                },
                leading: const FaIcon(FontAwesomeIcons.wallet),
                title: const Text('Wallet'),
              ),
              ListTile(
                onTap: () async {
                  advancedDrawerController.hideDrawer();
                  final items = await appwriteProvider.classesList();
                  if (!context.mounted) return;
                  showDialog(
                      context: context,
                      builder: (context) {
                        String currentValue =
                            Provider.of<AuthProvider>(context, listen: false)
                                .className;
                        String? currentItem =
                            (currentValue.isNotEmpty) ? currentValue : null;
                        return AlertDialog(
                          title: const Text('Seleziona la tua classe'),
                          content: DropdownButton(
                            hint: const Text('Classe'),
                            value: currentItem,
                            items: items,
                            onChanged: (value) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setClassItem(value!);
                            },
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .setClassItem('');
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancella')),
                            ElevatedButton(
                                onPressed: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .setClass();
                                  Navigator.pop(context);
                                },
                                child: const Text('Imposta'))
                          ],
                        );
                      });
                },
                leading: const FaIcon(FontAwesomeIcons.school),
                title: const Text('Imposta classe'),
              ),
              ListTile(
                onTap: () {
                  try {
                    appwriteProvider.logOut();
                  } finally {
                    if (appwriteProvider.authStatus == AuthStatus.unauth) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
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
                const Text(
                  'Benvenuto su JustItis',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                if (Provider.of<AuthProvider>(context, listen: true)
                        .className ==
                    "")
                  const Text(
                    'Vai nel menu laterale e seleziona la classe',
                    style: TextStyle(fontSize: 20),
                  )
                else if (Provider.of<MenuProvider>(context, listen: true)
                    .onTime)
                  const Text(
                    'Vai nel menu laterale e seleziona effetturare un\'ordinazione',
                    style: TextStyle(fontSize: 20),
                  )
                else
                  const Text(
                    'Al momento impossibile effetture ordini fuori fascia oraria',
                    style: TextStyle(fontSize: 20),
                  )
              ],
            ),
          )),
    );
  }
}
