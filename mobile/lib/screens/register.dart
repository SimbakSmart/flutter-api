import 'package:flutter/material.dart';
import 'package:mobile/provider/AuthProvider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {


  @override
  _RegisterState createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final nameController = TextEditingController();
final emailController= TextEditingController();
final passworController= TextEditingController();
final passworConfirmController = TextEditingController();
String errorMessage ='';


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
                            return 'Enter Name';
                          }
                          return null;
                        },
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration:InputDecoration(
                            labelText: 'Name'
                        ) ,
                      ),

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

                      TextFormField(
                        onChanged: (text)=>setState(() {
                          errorMessage='';
                        }),
                        validator: (String? value){
                          if(value!.isEmpty){
                            return 'Enter Password Confirm';
                          }
                          return null;
                        },
                        controller: passworConfirmController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:InputDecoration(
                            labelText: 'Password confirmation'
                        ) ,
                      ),
                      ElevatedButton(
                        onPressed: ()=>submit(),
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity,36)
                        ),),
                      Text(errorMessage,style: TextStyle(color:Colors.red),),
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

      String token = await provider.register(
         nameController.text,
          emailController.text,
          passworController.text,
          passworConfirmController.text,
          'some device name');

      Navigator.pop(context);

    }catch(Exception){
       setState(() {
         errorMessage = Exception.toString();
       });
    }

  }


}
