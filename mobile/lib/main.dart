import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile/provider/CategoryProvider.dart';
import 'package:mobile/screens/categories.dart';
import 'package:mobile/screens/login.dart';
import 'package:mobile/screens/register.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>
        (create: (context)=>CategoryProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome to Flutter',
        home: Login(),
        routes:{
          '/login':(context) => Login(),
          '/register':(context)=>Register(),
          '/categories':(context)=>Categories()
        },

      ),
    );
  }
}
