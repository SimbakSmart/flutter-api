
import 'dart:convert';
import 'dart:io';
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
  final _formKey = GlobalKey<FormState>();
  late Category selectedCategory;
  final categoryNameController = TextEditingController();

 Future<List<Category>> fetchCategories() async{

     http.Response response = await http.get(
      // Uri.parse('http://flutter-api.test/api/categories')
         Uri.parse('http://172.16.155.127/flutter-api/public/api/categories')
     );
     List categories = jsonDecode(response.body);

     return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future saveCategory() async{
   final form = _formKey.currentState;
   if(!form!.validate()){
     return;
   }

   String uri ='http://172.16.155.127/flutter-api/public/api/categories/'+selectedCategory.id.toString();
   await http.put(
     Uri.parse(uri),
     headers: {
       HttpHeaders.contentTypeHeader:'application/json',
       HttpHeaders.acceptHeader:'application/json'
     },
     body: jsonEncode({'name':categoryNameController.text})
   );
  Navigator.pop(context);
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
           trailing: IconButton(
             icon: Icon(Icons.edit),
             onPressed: (){
               selectedCategory =category;
               categoryNameController.text = category.name;
            showModalBottomSheet(context: context, builder: (builder){
              return Padding(
                  padding:EdgeInsets.all(10),
                  child:Form(
                    key: _formKey,
                    child:
                      Column(
                        children: [
                          TextFormField(
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
                          ElevatedButton(
                             child: Text('Save'),
                              onPressed:()=> saveCategory())
                        ],
                      ),

                  ) ,);

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
