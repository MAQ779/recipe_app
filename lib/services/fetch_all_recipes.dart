import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:recipe_app/resources/all_api_string.dart';
import '../models/all_recipe.dart';
import 'package:http/http.dart' as http;

import '../models/personal_recipe.dart';

class FetchRecipes {
  Future<AllRecipes> getAllRecipes() async {
    try {
      final response =
          await http.get(Uri.parse(RecipesAPI.base + RecipesAPI.allRecipes));
      return AllRecipes.fromJson(response.body);
    } catch (e, stacktrace) {
      print("Exception: $e  stacktrace: $stacktrace");
      return AllRecipes.withError('Failed to load Recipes');
    }
  }

  Future<AllRecipes> getAllPersonalRecipes(String authToken) async {
    try {
      var headers = {'Authorization': authToken};
      final response = await http.get(
          Uri.parse(RecipesAPI.base + RecipesAPI.allPersonalRecipes),
          headers: headers);

      // result = AllRecipes.fromJson(response.body) as List<Recipe>;
      return AllRecipes.fromJson(response.body);
    } catch (e, stacktrace) {
      print("Exception: $e  stacktrace: $stacktrace");
      return AllRecipes.withError('Failed to load Recipes');
    }
  }

  Future<void> createPersonalRecipe(
      PersonalRecipe newRecipe, String authToken) async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.postUrl(
          Uri.parse(RecipesAPI.base + RecipesAPI.createPersonalRecipe));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', authToken);
      request.add(utf8.encode(json.encode(newRecipe)));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        await response.transform(utf8.decoder).join();
        httpClient.close();
      }
    } catch (e, stacktrace) {
      log("Exception: $e  stacktrace: $stacktrace");
    }
  }

  Future<void> deletePersonalRecipe(String id, String authToken) async {
    try {
      log(RecipesAPI.base + RecipesAPI.deletePersonalRecipe + id);
      var headers = {'Authorization': authToken};
      final response = await http.delete(
          Uri.parse(RecipesAPI.base + RecipesAPI.deletePersonalRecipe + id),
          headers: headers);

      log(response.statusCode.toString());
    } catch (e, stacktrace) {
      log("Exception: $e  stacktrace: $stacktrace");
    }
  }
}
