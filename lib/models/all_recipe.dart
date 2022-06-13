// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class AllRecipes {

  bool? success;
  List<Recipe>? recipes;
  String? errorMessage;

  AllRecipes({
     this.success,
     this.recipes,
  });

  AllRecipes.withError( String error){
    errorMessage =error;
  }


  factory AllRecipes.fromJson(String str) => AllRecipes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllRecipes.fromMap(Map<String, dynamic> json) => AllRecipes(
    success: json["success"],
    recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "recipes": List<dynamic>.from(recipes!.map((x) => x.toMap())),
  };

  // this method to remove any recipe that does not have a name
  List<Recipe>? checkForNullName(){
        recipes!.removeWhere((element) => element.name == 'no name');
      return recipes;
  }
}

class Recipe {
  Recipe({
     this.id,
     this.name,
     this.description,
     this.kCal,
     this.directions,
     this.ingredients,
     this.isPersonal,
     this.createdAt,
     this.updatedAt,
     this.v,
  });

  String? id;
  String? name;
  String? description;
  int? kCal;
  List<String>? directions;
  List<Ingredient>? ingredients;
  String? isPersonal;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Recipe.fromJson(String str) => Recipe.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Recipe.fromMap(Map<String, dynamic> json) => Recipe(
    id: json["_id"]?? 'no',
    name: json["name"] ?? 'no name',
    description: json["description"] ?? 'no description',
    kCal: json["kCal"] ?? 0,
    directions: List<String>.from(json["directions"].map((x) => x)),
    ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromMap(x))),
    isPersonal: json["isPersonal"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "description": description,
    "kCal": kCal,
    "directions": List<dynamic>.from(directions!.map((x) => x)),
    "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toMap())),
    "isPersonal": isPersonal,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };


  // these two methods are to ease of displaying the Ingredients and Directions
  String toStringAllIngredients(){

    if(ingredients !=null && ingredients!.isNotEmpty) {
      String ingredientsAsOneString = '1- you need ${ingredients![0].quantity.toString()} of ${ingredients![0].name.toString()}';

      if (ingredients?.length == 1) {
        return ingredientsAsOneString;
      }

        for (int i = 1; i < ingredients!.length; i++) {
          ingredientsAsOneString = ingredientsAsOneString +
              '\n${i + 1}- you need ${ingredients![i].quantity
                  .toString()} of ${ingredients![i].name.toString()}';
        }
      return ingredientsAsOneString;
      }

    else{return 'there is no ingredients';}
  }

  String toStringAllDirections(){
    if(directions != null) {
      String directionsAsOneString = '1-${directions![0].toString()}';
      if (directions?.length == 1) {
        return directionsAsOneString;
      }
      for (int i = 1; i < directions!.length; i++) {
        directionsAsOneString = directionsAsOneString +
            '\n${i + 1}-${directions![i].toString()}';
      }
    return directionsAsOneString;
    }
    else{return 'there is no directions';}
  }
}

class Ingredient {
  Ingredient({
     this.name,
     this.quantity,
     this.id,
  });

  String? name;
  String? quantity;
  String? id;

  factory Ingredient.fromJson(String str) => Ingredient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
    name: json["name"]?? "no name",
    quantity: json["quantity"] ?? "no quantity",
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "quantity": quantity,
    "_id": id,
  };
}
