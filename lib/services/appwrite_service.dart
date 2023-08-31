import 'package:appwrite/appwrite.dart';

class AppwriteService{
  static final Client _client = Client();
  static late final Account _account;
  static late final Databases _database;
  static late final Avatars _avatar;
  static late final Functions _functions;

  //Remote
  final String _endpoint = 'http://backend.justitis.it:2053/v1';
  static const String databaseId = 'justitisdb';

  //Local
  //final String _endpoint = 'http://localhost/v1';
  //static const String databaseId = 'justitisdb';

  AppwriteService(){
    //Remote Server
    //client.setEndpoint('https://backend.justitis.it:2053/v1')
    //.setProject('64c6156149b8d74d0fe4').setSelfSigned(status: true);
    _client.setEndpoint(_endpoint)
    .setProject('justitisapp').setSelfSigned(status: true);
    _account = Account(_client);
    _database = Databases(_client);
    _avatar = Avatars(_client);
    _functions = Functions(_client);
  }

  static Client get client => _client;
  static Account get account => _account;
  static Databases get database => _database;
  static Avatars get avatar => _avatar;
  static Functions get functions => _functions;
}