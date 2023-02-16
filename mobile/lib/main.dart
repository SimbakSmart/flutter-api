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
        body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 8,
                margin:EdgeInsets.only(left: 16.0,right: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
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
              ),
            ],
          ),
        ),
      ),

    );
  }
}
