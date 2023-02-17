



import 'package:flutter/cupertino.dart';
import 'package:mobile/services/api.dart';

class AuthProvider extends ChangeNotifier {


  bool isAuthenticate = false;
  late String token;

  ApiServices apiServices = new ApiServices('');

  AuthProvider();

  Future<void> register(String name, String email, String password,
      String passwordConfirm, String deviceName) async {
    token = await apiServices.register(
        name, email, password, passwordConfirm, deviceName);
    isAuthenticate = true;
    notifyListeners();
  }


  Future<void> login(String email, String password, String deviceName) async {
    token = await apiServices.login(email, password, deviceName);
    isAuthenticate = true;
    notifyListeners();
  }

  Future<void> logOut() async {
    token='';
    isAuthenticate = true;
    notifyListeners();
  }

}
