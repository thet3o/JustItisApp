import 'package:appwrite/appwrite.dart';

class AppwriteProvider{
  static Client client = Client();

  AppwriteProvider(){
    client.setEndpoint('https://backend.justitis.it:2053/v1')
    .setProject('64c6156149b8d74d0fe4')
    .setSelfSigned();
  }

}