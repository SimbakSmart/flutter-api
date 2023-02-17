import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/AuthProvider.dart';

class Login extends StatefulWidget {


  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController= TextEditingController();
  final passworController= TextEditingController();
  String errorMessage ='';
  late String deviceName;



  @override
  void initState() {
    super.initState();
    getDeviceName();
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (text)=>setState(() {
                          errorMessage='';
                        }),
                        validator: (String? value){
                          if(value!.isEmpty){
                            return 'Enter Email';
                          }
                          return null;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:InputDecoration(
                            labelText: 'Email'
                        ) ,
                      ),

                      TextFormField(
                        onChanged: (text)=>setState(() {
                          errorMessage='';
                        }),
                        validator: (String? value){
                          if(value!.isEmpty){
                            return 'Enter Password';
                          }
                          return null;
                        },
                        controller: passworController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:InputDecoration(
                            labelText: 'Password'
                        ) ,
                      ),
                      ElevatedButton(
                        onPressed: ()=>submit(),
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity,36)
                        ),),

                      Text(errorMessage,style: TextStyle(color:Colors.red),),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: InkWell(
                          child: Text('Register new user'),
                          onTap: (){

                            Navigator.pushNamed(context, '/register');
                          },
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




  Future<void> submit() async{

    final form = _formKey.currentState;
    if(!form!.validate()){
      return;
    }

    AuthProvider provider  = Provider.of<AuthProvider>(context,listen: false);

    try{

        await provider.login(
          emailController.text,
          passworController.text,
          deviceName);

    }catch(Exception){
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception:', '');
      });
    }

  }

  Future<void> getDeviceName() async{

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try{
      if(Platform.isAndroid){
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {

          deviceName = build.model;
        });
      }
      else if(Platform.isIOS){
        var build = await deviceInfoPlugin.iosInfo;
        setState(() {

          deviceName = build.model!;
        });
      }

    } on PlatformException{

      setState(() {

        deviceName = 'Failed to get platform version';
      });
    }
  }


}
