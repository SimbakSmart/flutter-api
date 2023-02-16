import 'package:flutter/material.dart';

class Register extends StatefulWidget {


  @override
  _RegisterState createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
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
    return Scaffold(
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
                      keyboardType: TextInputType.text,
                      decoration:InputDecoration(
                          labelText: 'Name'
                      ) ,
                    ),

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

                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration:InputDecoration(
                          labelText: 'Password confirmation'
                      ) ,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/categories');
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity,36)
                      ),),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        child: Text('Back to login'),
                        onTap: (){

                          Navigator.pop(context);
                        },
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
