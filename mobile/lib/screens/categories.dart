
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
   return Category( id :json['id'],name : json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

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


 Future<List<Category>> fetchCategories() async{

     http.Response response = await http.get(
      // Uri.parse('http://flutter-api.test/api/categories')
         Uri.parse('http://172.16.155.127/flutter-api/public/api/categories')
     );
     List categories = jsonDecode(response.body);

     return categories.map((category) => Category.fromJson(category)).toList();
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
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
       color: Theme.of(context).primaryColorDark,
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
