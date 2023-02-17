

import 'package:flutter/cupertino.dart';
import 'package:mobile/services/api.dart';

import '../models/category.dart';

class CategoryProvider extends ChangeNotifier{

  List<Category> categories=[];

  late ApiServices apiServices;

  CategoryProvider(){
    this.apiServices = ApiServices();
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
    }
  }

  Future<void> deleteCategory(Category category) async{
    try{
      await apiServices.deleteCategory(category.id);
      categories.remove(category);
      notifyListeners();

    }catch(Exception){
      print(Exception);
    }
  }







}
