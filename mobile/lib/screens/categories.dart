
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services/api.dart';
import 'package:mobile/widget/category_edit.dart';

import '../models/category.dart';


class Categories extends StatefulWidget {


  @override
  _CategoriesState createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends State<Categories> {

  final List<String> categories =<String>[
    'Category 1',
    'Category 2',
    'Category 3'
  ];

  int clicked =0;

  final String category="My Categories";

  late Future<List<Category>> futureCategories;
   ApiServices apiServices = new ApiServices();




  @override
  void initState() {
    super.initState();
    futureCategories = apiServices.fetchCategories();
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
        title: Text('Categories clicked '+clicked.toString()),
      ),
     body: Container(
       color: Theme.of(context).primaryColorLight,
       child: FutureBuilder<List<Category>>(
     future: futureCategories,
      builder: (context,snapshot){
       if(snapshot.hasData){
         return ListView.builder(
         itemCount: snapshot.data!.length,
         itemBuilder: (context,index){
           Category category = snapshot.data![index];
         return ListTile(
          title:  Text(category.name),
           trailing: IconButton(
             icon: Icon(Icons.edit),
             onPressed: (){
            showModalBottomSheet(
                isScrollControlled: true,
                context: context, builder: (builder){
              return CategoryEdit(category);

            });

             },
           ),
         );
        });

    }else if(snapshot.hasError){
         return Text('Something went wrong');
    }
       return CircularProgressIndicator();
    }
    )
    )
    );
  }
}
