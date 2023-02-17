



import 'package:flutter/cupertino.dart';
import 'package:mobile/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {

 // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isAuthenticate = false;
  late String token;
  late ApiServices apiServices;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    this.token = await getToken();
    if (this.token.isNotEmpty) {
      this.isAuthenticate = true;
    }
    this.apiServices = new ApiServices(this.token);
    notifyListeners();
  }
  Future<void> register(String name, String email, String password,
      String passwordConfirm, String deviceName) async {
    this.token = await apiServices.register(
        name, email, password, passwordConfirm, deviceName);
    setToken(this.token);
    isAuthenticate = true;
    notifyListeners();
  }


  Future<void> login(String email, String password, String deviceName) async {
    this.token = await apiServices.login(email, password, deviceName);
    setToken(this.token);
    isAuthenticate = true;
    notifyListeners();
  }

  Future<void> logOut() async {
    token='';
    isAuthenticate = false;
    setToken('');
    notifyListeners();
  }

  Future<void> setToken(String token) async {
   final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    // final SharedPreferences prefs = await _prefs;
    // await prefs.setString('token', token);
  }

  Future<String> getToken() async {
   final prefs = await SharedPreferences.getInstance();
   return prefs.getString('token') ?? '';
   //  final SharedPreferences prefs = await _prefs;
   //  return prefs.getString('token') ?? '';
  }

}
