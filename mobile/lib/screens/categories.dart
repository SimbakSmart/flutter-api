

import 'package:flutter/material.dart';
import 'package:mobile/provider/CategoryProvider.dart';
import 'package:mobile/services/api.dart';
import 'package:mobile/widget/category_edit.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../widget/category_add.dart';


class Categories extends StatefulWidget {


  @override
  _CategoriesState createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends State<Categories> {


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

    final provider =  Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories;


    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
     body: ListView.builder(
         itemCount: categories.length,
         itemBuilder: (context,index){
           Category category = categories[index];
         return ListTile(
          title:  Text(category.name),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               IconButton(
                 icon: Icon(Icons.edit),
                 onPressed: (){
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context, builder: (builder){
                  return CategoryEdit(category,provider.updateCategory);

                });

                 },
               ),

               IconButton(
                 icon: Icon(Icons.delete),
                 onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context){

                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Are you sure you want to delete'),

                          actions: [
                            TextButton(
                                onPressed: ()=> deleteCategory(provider.deleteCategory, category),
                                child: Text('Confirm')),
                            TextButton(
                                onPressed: ()=> Navigator.pop(context),
                                child: Text('Cancel'))
                          ],
                        );

                      });

                 },
               ),
             ],
           ),
         );
        }),
      floatingActionButton: new FloatingActionButton(
        onPressed:(){
          showModalBottomSheet(
              isScrollControlled: true,
              context: context, builder: (builder){
            return CategoryAdd(provider.addCategory);

          });

        },
        child: Icon(Icons.add) ,
      ),
    );
  }

  Future deleteCategory(Function callback, Category category) async{
    await callback(category);
    Navigator.pop(context);
  }
}
