import 'package:flutter/material.dart';
import 'package:mobile/provider/AuthProvider.dart';
import 'package:mobile/provider/CategoryProvider.dart';
import 'package:mobile/screens/categories.dart';
import 'package:mobile/screens/home.dart';
import 'package:mobile/screens/login.dart';
import 'package:mobile/screens/register.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<CategoryProvider>
    //     (create: (context)=>CategoryProvider()),
    //     ChangeNotifierProvider<AuthProvider>
    //       (create: (context)=>AuthProvider()),
    //   ],
 return ChangeNotifierProvider(
   create: (context)=>AuthProvider(),
   child: Consumer<AuthProvider>(builder: (context,authProvider,child){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>
          (create: (context)=>CategoryProvider(authProvider)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome to Flutter',
      //  home: Login(),
        routes:{
          '/':(context){
      final authProvider  = Provider.of<AuthProvider>(context);
      if(authProvider.isAuthenticate){
        return Categories();
      }else{
        return Login();
      }

          },
          '/login':(context) => Login(),
          '/register':(context)=>Register(),
          '/categories':(context)=>Categories()
        },

      ),
    );})
    );
  }
}
