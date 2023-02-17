import 'package:flutter/material.dart';



class Home extends StatefulWidget {


  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Welcom to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Logged in !'),
        ),
        body: Center(
          child: Text(
            'Welcome',
            style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
