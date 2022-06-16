import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipe_app/UI/recipes_main_page.dart';
import 'package:recipe_app/constants/theme_constants.dart';
import 'package:recipe_app/facilities/adding_space.dart';
import 'package:recipe_app/facilities/size_configuration.dart';
import 'package:recipe_app/services/controller/global_controller.dart';
import '../blocs/google_auth_bloc/auth_bloc.dart';
import '../services/fetch_all_recipes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is Authenticated) {
          if (ApiAuthController.isSignUp) {
            await FetchRecipes().registerToApi(
                FirebaseAuth.instance.currentUser!.displayName.toString(),
                FirebaseAuth.instance.currentUser!.email.toString(),
                FirebaseAuth.instance.currentUser!.uid.toString());
            final auth = await FetchRecipes().logInToApi(
                FirebaseAuth.instance.currentUser!.email.toString(),
                FirebaseAuth.instance.currentUser!.uid.toString());

            ApiAuthController.authToken = auth;
          } else {
            final auth = await FetchRecipes().logInToApi(
                FirebaseAuth.instance.currentUser!.email.toString(),
                FirebaseAuth.instance.currentUser!.uid.toString());
            ApiAuthController.authToken = auth;
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const RecipesUI(
                        isAllRecipe: true,
                      )));
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is Loading) {
          return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: ThemeConst.lightTheme.primaryColor,
                  size: SizeConfigure.imageConfig! * 30));
        } else {
          return SafeArea(
            child: Container(
              color: const Color(0xfffefcfd),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(image: AssetImage('assets/recipe_login.jpeg')),
                  addVerticalSpace(SizeConfigure.heightConfig! * 3),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          'you need to authenticate',
                          style: TextStyle(
                              fontSize: SizeConfigure.textConfig! * 3,
                              color: ThemeConst.lightTheme.primaryColor),
                        ),
                      ),
                      Center(
                        child: Text(
                          'through google first',
                          style: TextStyle(
                              fontSize: SizeConfigure.textConfig! * 3,
                              color: ThemeConst.lightTheme.primaryColor),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: SizeConfigure.widthConfig! * 25,
                          height: SizeConfigure.heightConfig! * 18,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              addVerticalSpace(SizeConfigure.heightConfig! * 3),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _authenticateWithGoogle(context);
                                      },
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.google,
                                            color: ThemeConst
                                                .lightTheme.hoverColor,
                                          ),
                                          addHorizontalSpace(
                                              SizeConfigure.widthConfig),
                                          Text(
                                            'log-in',
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfigure.textConfig! *
                                                        2,
                                                color: ThemeConst
                                                    .lightTheme.primaryColor),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              addVerticalSpace(SizeConfigure.heightConfig! * 4),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ApiAuthController.isSignUp = true;
                                        });
                                        _authenticateWithGoogle(context);
                                      },
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.google,
                                            color: ThemeConst
                                                .lightTheme.hoverColor,
                                          ),
                                          addHorizontalSpace(
                                              SizeConfigure.widthConfig),
                                          Text(
                                            'sign-up',
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfigure.textConfig! *
                                                        2,
                                                color: ThemeConst
                                                    .lightTheme.primaryColor),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      }),
    ));
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
