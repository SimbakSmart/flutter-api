import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {


  @override
  _TransactionsState createState() {
    return _TransactionsState();
  }
}

class _TransactionsState extends State<Transactions> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Transsactions'),
      ),
      body: Text('Transaction'),
    );
  }
}
