import 'package:flutter/material.dart';

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
        title: Text('Categories clicked '+clicked.toString()),
      ),
     body: Container(
       color: Theme.of(context).primaryColorDark,
       child: Center(
         child: ListView.builder(
             itemCount: categories.length,
             itemBuilder: (BuildContext context, int index){
           return ListTile(
             title: Text(categories[index],style: TextStyle(color: Colors.white)),
             onTap: ()=>setState(() {
               clicked++;
             }),
           );
    }),
       ),
     ),
    );
  }
}
