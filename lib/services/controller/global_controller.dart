class ApiAuthController {
  ApiAuthController._();
  static final ApiAuthController _instance = ApiAuthController._();
  static ApiAuthController get instance => _instance;

  static  String authToken = '';

  static late String authHeader;

  static bool isLogin = false;

  static bool isSignUp = false;

  static bool newPersonalRecipe = false;

}