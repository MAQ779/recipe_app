import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app/UI/recipes_main_page.dart';
import 'package:recipe_app/constants/theme_constants.dart';
import 'package:recipe_app/facilities/adding_space.dart';
import 'package:recipe_app/facilities/size_configuration.dart';

import '../blocs/google_auth_bloc/auth_bloc.dart';

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
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigating to the dashboard screen if the user is authenticated
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const RecipesUI()));
        } else if (state is AuthError) {
          // Showing the error message if the user has entered invalid credentials
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is Loading) {
          // Showing the loading indicator while the user is signing in
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/recipe_login.jpeg')),
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
                        width: SizeConfigure.heightConfig! * 10,
                        height: SizeConfigure.heightConfig! * 16,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _authenticateWithGoogle(context);
                                },
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.google,
                                      color: ThemeConst.lightTheme.hoverColor,
                                    ),
                                    addHorizontalSpace(
                                        SizeConfigure.widthConfig),
                                    Text(
                                      'sign-in',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfigure.textConfig! * 2,
                                          color: ThemeConst
                                              .lightTheme.primaryColor),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
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
