


import 'package:recipe_app/services/fetch_all_recipes.dart';

import '../../models/all_recipe.dart';

class ApiRepository{
  final _apiProvider = FetchRecipes();
  Future<AllRecipes> getAllRecipes(){
    return _apiProvider.getAllRecipes();
}

  Future<AllRecipes> getAllPersonalRecipes(String authToken){
    return _apiProvider.getAllPersonalRecipes(authToken);
  }
}

class NetworkError extends Error{

}