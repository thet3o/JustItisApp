import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteProvider{
  static Client client = Client();
  static Account account = Account(AppwriteProvider.client);

  AppwriteProvider(){
    client.setEndpoint('https://backend.justitis.it:2053/v1')
    .setProject('64c6156149b8d74d0fe4')
    .setSelfSigned();
  }

  static auth() async => await account.createOAuth2Session(provider: 'google', success: 'https://test.justitis.it/auth.html');
  static Future<User> getUser() async => await account.get();
}