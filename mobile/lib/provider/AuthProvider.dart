



import 'package:flutter/cupertino.dart';
import 'package:mobile/services/api.dart';

class AuthProvider extends ChangeNotifier{

 ApiServices apiServices = new ApiServices();
 bool isAuthenticate = false;

   AuthProvider();

   Future<String> register(String name,String email,String password,String passwordConfirm,String deviceName) async{

      String token = await apiServices.register(name, email, password, passwordConfirm, deviceName);
       isAuthenticate= true;
       notifyListeners();
       return token;
   }
}
