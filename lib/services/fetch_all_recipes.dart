import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:recipe_app/models/user_checker.dart';
import 'package:recipe_app/resources/all_api_string.dart';
import '../models/all_recipe.dart';
import 'package:http/http.dart' as http;
import '../models/personal_recipe.dart';
import '../models/user.dart';
import 'controller/global_controller.dart';

class FetchRecipes {
  // fetch recipes
  Future<AllRecipes> getAllRecipes() async {
    try {
      final response =
          await http.get(Uri.parse(RecipesAPI.base + RecipesAPI.allRecipes));
      return AllRecipes.fromJson(response.body);
    } catch (e, stacktrace) {
      log("Exception: $e  stacktrace: $stacktrace");
      return AllRecipes.withError('Failed to load Recipes');
    }
  }

  //fetch personal recipes
  Future<AllRecipes> getAllPersonalRecipes(String authToken) async {
    try {
      var headers = {'Authorization': authToken};
      final response = await http.get(
          Uri.parse(RecipesAPI.base + RecipesAPI.allPersonalRecipes),
          headers: headers);

      // result = AllRecipes.fromJson(response.body) as List<Recipe>;
      return AllRecipes.fromJson(response.body);
    } catch (e, stacktrace) {
      log("Exception: $e  stacktrace: $stacktrace");
      return AllRecipes.withError('Failed to load Recipes');
    }
  }

  // create new personal Recipe
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

  // delete from api
  Future<void> deletePersonalRecipe(String id, String authToken) async {
    try {
      //log(RecipesAPI.base + RecipesAPI.deletePersonalRecipe + id);
      var headers = {'Authorization': ApiAuthController.authToken};
      await http.delete(
          Uri.parse(RecipesAPI.base + RecipesAPI.deletePersonalRecipe + id),
          headers: headers);

      //log(response.statusCode.toString());
    } catch (e, stacktrace) {
      log("Exception: $e  stacktrace: $stacktrace");
    }
  }

  // update personal Recipe
  Future<void> updatePersonalRecipe(
      PersonalRecipe newRecipe, String authToken) async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient
          .putUrl(Uri.parse(RecipesAPI.base + RecipesAPI.updatePersonalRecipe));
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

  // log in to api
  Future<String> logInToApi(String email, String password) async {
    late String authMessage;
    final user = UserLogin(email: email, password: password);
    HttpClientResponse response;
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient
          .postUrl(Uri.parse(RecipesAPI.base + RecipesAPI.login));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(user)));

      response = await request.close();
      if (response.statusCode == 200) {
        //await response.transform(utf8.decoder).join();
        // await response.transform(utf8.decoder).join();
        authMessage = UserData.fromJson(
                json.decode(await response.transform(utf8.decoder).join()))
            .token
            .toString();
        // log(a);
        // log(authMessage.token.toString());
        httpClient.close();
      }
    } catch (e, stacktrace) {
      log("Exception: $e  stacktrace: $stacktrace");
      // log(response.reasonPhrase);
    }
    return authMessage;
  }

  // register to api
  Future<String> registerToApi(
      String name, String email, String password) async {
    String authMessage = '';
    try {
      var request = http.Request(
          'POST', Uri.parse(RecipesAPI.base + RecipesAPI.register));
      request.bodyFields = {'email': email, 'password': password, 'name': name};

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        log('here register');
        authMessage = await response.stream.bytesToString();
      }
    } catch (e, stacktrace) {
      log("Exception: $e  stacktrace: $stacktrace");
      authMessage = e.toString();
    }
    return authMessage;
  }
}
