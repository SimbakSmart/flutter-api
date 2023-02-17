

import 'package:flutter/cupertino.dart';
import 'package:mobile/services/api.dart';

import '../models/category.dart';
import 'AuthProvider.dart';

class CategoryProvider extends ChangeNotifier{

  List<Category> categories=[];
  late ApiServices apiServices;
  late AuthProvider authProvider;


  CategoryProvider(AuthProvider authProvider){

    this.authProvider = authProvider;
    this.apiServices = ApiServices(authProvider.token);
    init();
  }

  Future init() async{

    categories = await apiServices.fetchCategories();
    notifyListeners();
  }

  Future  updateCategory(Category category) async{

    try{
      Category  updateCategory = await apiServices.updateCategory(category);
      int index =  categories.indexOf(category);
      categories[index]=updateCategory;
      notifyListeners();
    }catch(Exception){
       print(Exception);
       await authProvider.logOut();
    }
  }

  Future<void> deleteCategory(Category category) async{
    try{
      await apiServices.deleteCategory(category.id);
      categories.remove(category);
      notifyListeners();

    }catch(Exception){
      print(Exception);
      await authProvider.logOut();
    }
  }



  Future  addCategory(String name) async{

    try{
      Category  addCategory = await apiServices.addCategory(name);
     categories.add(addCategory);

      notifyListeners();
    }catch(Exception){
      print(Exception);
      await authProvider.logOut();
    }
  }




}
