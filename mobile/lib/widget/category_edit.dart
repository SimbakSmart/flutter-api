import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/api.dart';

class CategoryEdit extends StatefulWidget {
  final Category category;
  final Function categoryCallback;
  CategoryEdit(this.category,this.categoryCallback);

  @override
  _CategoryEditState createState() {
    return _CategoryEditState();
  }
}

class _CategoryEditState extends State<CategoryEdit> {

  final _formKey = GlobalKey<FormState>();
  late Category selectedCategory;
  final categoryNameController = TextEditingController();
  String errorMessage='';

  @override
  void initState() {
    super.initState();
    categoryNameController.text = widget.category.name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
   widget.category.name = categoryNameController.text;
    widget.categoryCallback(widget.category);
    Navigator.pop(context);
  }
}
