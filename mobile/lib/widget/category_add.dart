import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/api.dart';

class CategoryAdd extends StatefulWidget {

  final Function categoryCallback;
  CategoryAdd(this.categoryCallback) ;

  @override
  _CategoryAddState createState() {
    return _CategoryAddState();
  }
}

class _CategoryAddState extends State<CategoryAdd> {


  final _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  String errorMessage='';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(10),
      child:Form(
        key: _formKey,
        child:
        Column(
          children: [
            TextFormField(
              onChanged: (text)=>setState(() {
                errorMessage='';
              }),
              controller: categoryNameController,
              // initialValue: category.name,
              validator: (String? value){
                if(value!.isEmpty){
                  return 'Enter Category Name';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category Name'
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    child: Text('Save'),
                    onPressed:()=>saveCategory()),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red
                    ),
                    child: Text('Cancel'),
                    onPressed:()=> Navigator.pop(context)),
                Text(errorMessage,style: TextStyle(color:Colors.red),)
              ],
            )
          ],
        ),

      ) ,);


  }

  Future saveCategory() async{
    final form = _formKey.currentState;
    if(!form!.validate()){
      return;
    }

   await widget.categoryCallback(categoryNameController.text);
    Navigator.pop(context);
  }

}
