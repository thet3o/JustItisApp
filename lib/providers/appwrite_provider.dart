import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteProvider{
  static Client client = Client();
  static Account account = Account(AppwriteProvider.client);
  static Avatars avatar = Avatars(client);
  static bool isLogged = false;

  AppwriteProvider(){
    client.setEndpoint('https://backend.justitis.it:2053/v1')
    .setProject('64c6156149b8d74d0fe4')
    .setSelfSigned();
  }

  static auth() async {
    await account.createOAuth2Session(provider: 'google', success: 'https://test.justitis.it/auth.html');
    try{
      await account.get();
      isLogged = true;
    }catch(e){}
  } 

  static deauth() async{
    //final sessionId = await account.getSession(sessionId: 'current');
    //account.deleteSession(sessionId: sessionId.$id);
    account.deleteSessions();
  }

  static checkIfUserHaveSession() async{
    try {
      await account.get();
      isLogged = true;
    } on AppwriteException catch(e) {
      if(e.code == 401) {
      } else {
        // errors like connection
      }
    }
  }

  static Future<User> getUser() async => await account.get();

}