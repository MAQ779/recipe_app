
// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

UserRegister personalRecipeFromMap(String str) => UserRegister.fromMap(json.decode(str));

String personalRecipeToMap(UserRegister data) => json.encode(data.toMap());

class UserRegister {
  UserRegister({
    this.email,
    this.password,
    this.name,

  });


  String? name;
  String? email;
  String? password;

  factory UserRegister.fromMap(Map<String, dynamic> json) => UserRegister(
    password: json["password"],
    email: json["email"] ,
    name: json["name"] ,
    );

  Map<String, dynamic> toMap() => {
    "password": password,
    "email" : email,
    "name": name
    };

  UserRegister.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    email = json["email"];
    name = json['name'];
    }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['email'] = this.email;
    data['name'] = this.name;

    return data;
  }


}

class UserLogin {
  UserLogin({
    this.email,
    this.password,


  });


  String? email;
  String? password;

  factory UserLogin.fromMap(Map<String, dynamic> json) => UserLogin(
    password: json["password"],
    email: json["email"] ,

  );

  Map<String, dynamic> toMap() => {
    "password": password,
    "email" : email,
  };

  UserLogin.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    email = json["email"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['email'] = this.email;


    return data;
  }


}

