import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration:InputDecoration(
                labelText: 'Email'
              ) ,
            ),

            TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration:InputDecoration(
                  labelText: 'Password'
              ) ,
            ),
            ElevatedButton(
                onPressed: ()=>print("login"),
                child: Text('Login'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity,36)
            ),),

          ],
        ),
      ),

    );
  }
}
