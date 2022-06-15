
// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

PersonalRecipe personalRecipeFromMap(String str) => PersonalRecipe.fromMap(json.decode(str));

String personalRecipeToMap(PersonalRecipe data) => json.encode(data.toMap());

class PersonalRecipe {
  PersonalRecipe({
    this.id,
    this.name,
    this.description,
    this.kCal,
    this.directions,
    this.ingredients,
  });

  String? id;
  String? name;
  String? description;
  int? kCal;
  List<String>? directions;
  List<Ingredients>? ingredients;

  factory PersonalRecipe.fromMap(Map<String, dynamic> json) => PersonalRecipe(
    id: json["id"],
    name: json["name"] ?? 'no name',
    description: json["description"] ?? 'no description',
    kCal: json["kCal"] ?? 0,
    directions: json["directions"] == null ? null : List<String>.from(json["directions"].map((x) => x)),
    ingredients: json["ingredients"] == null ? null : List<Ingredients>.from(json["ingredients"].map((x) => Ingredients.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name ?? 'no name',
    "description": description ?? 'no description',
    "kCal": kCal ?? 0,
    "directions": directions == null ? null : List<dynamic>.from(directions!.map((x) => x)),
    "ingredients": ingredients == null ? null : List<dynamic>.from(ingredients!.map((x) => x.toMap())),
  };

  PersonalRecipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    kCal = json['kCal'];
    directions = json['directions'].cast<String>();
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }}
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['kCal'] = this.kCal;
    data['directions'] = this.directions;
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class Ingredients {
  Ingredients({
    this.name,
    this.quantity,
  });

  String? name;
  String?quantity;

  factory Ingredients.fromMap(Map<String, dynamic> json) => Ingredients(
    name: json["name"] ?? 'no name',
    quantity: json["quantity"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "name": name ?? 'no name',
    "quantity": quantity ?? 0,
  };

  Ingredients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}
