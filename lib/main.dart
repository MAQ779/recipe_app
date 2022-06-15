import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/resources/repositories/auth_repository.dart';
import 'package:recipe_app/services/controller/global_controller.dart';
import 'UI/login.dart';
import 'blocs/google_auth_bloc/auth_bloc.dart';
import 'constants/theme_constants.dart';
import 'facilities/size_configuration.dart';
import 'services/fetch_all_recipes.dart';
import 'UI/recipes_main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage();

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static bool isDark = false;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeConst(isDark: isDark).themeData,
              home: LayoutBuilder(builder: (context, screenConstraints) {
                SizeConfigure().takeScreenMeasurement(screenConstraints);
                return  StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot)  {
                      // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                      if (snapshot.hasData) {
                        final auth = getToken().toString();

                          ApiAuthController.authToken = auth;

                        ApiAuthController.isLogin = true;

                        return const RecipesUI();
                      }
                      // Otherwise, they're not signed in. Show the sign in page.
                      return const Login();
                    }
                    );
              }),
            ),
          ),
    );
  }
}

Future<String> getToken() async{
  String auth = await FetchRecipes().logInToApi(FirebaseAuth.instance.currentUser!.displayName.toString(),
    FirebaseAuth.instance.currentUser!.email.toString());
  return await auth;


}