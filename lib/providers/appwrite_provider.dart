import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppwriteProvider{
  static Client client = Client();
  static Account account = Account(AppwriteProvider.client);
  static Avatars avatar = Avatars(client);
  bool _userIsLogged = false;

  void init() async{
    client.setEndpoint('https://backend.justitis.it:2053/v1')
    .setProject('64c6156149b8d74d0fe4')
    .setSelfSigned();
  }

  void auth() async {
    await account.createOAuth2Session(provider: 'google', success: 'https://test.justitis.it/auth.html');
    setIfLogged(true);
  } 

  void deauth() async{
    //final sessionId = await account.getSession(sessionId: 'current');
    //account.deleteSession(sessionId: sessionId.$id);
    account.deleteSessions();
    setIfLogged(false);
  }

  void checkIfUserHaveSession() async{
    try {
      await account.get();
      setIfLogged(true);
      checkIfLogged();
    } on AppwriteException catch(e) {
      if(e.code == 401) {
      } else {
        // errors like connection
      }
    }
  }

  void checkIfLogged() async{
    final prefs = await SharedPreferences.getInstance();
    _userIsLogged = prefs.getBool('isLogged')!;
  }

  bool getIfLogged() => _userIsLogged;

  void setIfLogged(bool isLogged) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', isLogged);
  }

  static Future<User> getUser() async => await account.get();

}