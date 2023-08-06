import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:justitis_app/providers/appwrite_provider.dart';

class AppwriteController extends GetxController{

  var account = Account(AppwriteProvider.client);


  auth() async => await account.createOAuth2Session(provider: 'google', success: 'https://test.justitis.it/auth.html');

}