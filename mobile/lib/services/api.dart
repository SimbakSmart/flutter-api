

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';

class ApiServices{

//  final String baseUrl='http://flutter-api.test/api/';
  final String baseUrl='http://172.16.155.127/flutter-api/public/api/';
   ApiServices();

   Future<List<Category>> fetchCategories() async{

     http.Response response = await http.get(
       // Uri.parse('http://flutter-api.test/api/categories')
         Uri.parse(baseUrl+'categories')
     );
     List categories = jsonDecode(response.body);

     return categories.map((category) => Category.fromJson(category)).toList();
   }

   Future<Category> updateCategory(Category category) async{


     String uri =baseUrl+'categories/'+category.id.toString();
      http.Response response  = await http.put(
         Uri.parse(uri),
         headers: {
           HttpHeaders.contentTypeHeader:'application/json',
           HttpHeaders.acceptHeader:'application/json'
         },
         body: jsonEncode({'name':category.name})
     );

      if(response.statusCode != 200){

        throw Exception('Error happened on update');
      }
     return Category.fromJson(jsonDecode(response.body));
   }


    Future<void> deleteCategory (id) async{

      String uri =baseUrl+'categories/'+id.toString();

      http.Response response  = await http.delete(Uri.parse(uri));

      if(response.statusCode != 204){

        throw Exception('Error happened on delete');
      }

    }


  Future<Category> addCategory(String name) async{


    String uri =baseUrl+'categories';
    http.Response response  = await http.post(
        Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader:'application/json',
          HttpHeaders.acceptHeader:'application/json'
        },
        body: jsonEncode({'name':name})
    );

    if(response.statusCode != 201){

      throw Exception('Error happened on create');
    }
    return Category.fromJson(jsonDecode(response.body));
  }


}
