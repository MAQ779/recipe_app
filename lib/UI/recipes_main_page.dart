import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/all_recipe_bloc/all_recipe_bloc.dart';
import 'package:recipe_app/constants/theme_constants.dart';
import 'package:recipe_app/facilities/size_configuration.dart';

import '../facilities/adding_space.dart';
import '../models/all_recipe.dart';

import '../widgets/buttons/floating_button/child_floating_buttons.dart';
import '../widgets/buttons/text_btn.dart';
import '../widgets/loading/loading_page.dart';

import '../widgets/recipes_list.dart';

class RecipesUI extends StatefulWidget {
  const RecipesUI({
    Key? key,
  }) : super(key: key);

  @override
  _RecipesUIState createState() => _RecipesUIState();
}

class _RecipesUIState extends State<RecipesUI> {
  double titleSize = SizeConfigure.heightConfig! * 5;
  double textButtonSize = SizeConfigure.heightConfig! * 4;
  double iconSize = SizeConfigure.imageConfig! * 13;

  bool isPersonal = true;
  List<Recipe>? recipes;
  final RecipesBloc _recipesBloc = RecipesBloc();
  final RecipesBloc _personalRecipesBloc = RecipesBloc();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    _recipesBloc.add(GetRecipeList());
    _personalRecipesBloc.add(GetPersonalRecipeList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfigure.widthConfig! * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(SizeConfigure.heightConfig! * 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Let\'s Cook',
                  style: ThemeConst.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: titleSize,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName.toString(),
                  style: ThemeConst.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: titleSize,
                  ),
                ),
              ],
            ),
            addVerticalSpace(1),
            //searchBar(SizeConfigure.widthConfig!.toInt()*50, searchController),
            addVerticalSpace(SizeConfigure.heightConfig! * 3),
            textButton('Recipes', textButtonSize),
            BlocProvider(
              create: (_) => _recipesBloc,
              child: BlocListener<RecipesBloc, RecipesState>(
                listener: (context, state) {
                  if (state is RecipesNetworkError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error!)));
                  }
                },
                child: BlocBuilder<RecipesBloc, RecipesState>(
                    builder: (context, state) {
                  if (state is RecipesInitiate) {
                    return loading();
                  } else if (state is RecipesLoading) {
                    return loading();
                  } else if (state is RecipesLoaded) {
                    return RecipeHorizontalList(
                      recipes: state.recipes.checkForNullName()!,
                      isPersonal: !(isPersonal),
                    );
                  } else {
                    return const Center(
                        child: Text('there is error on fetching data'));
                  }
                }),
              ),
            ),
            addVerticalSpace(SizeConfigure.heightConfig! * 3),
            textButton('My Recipes', textButtonSize),
            BlocProvider(
              create: (_) => _personalRecipesBloc,
              child: BlocListener<RecipesBloc, RecipesState>(
                listener: (context, state) {
                  if (state is RecipesNetworkError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error!)));
                  }
                },
                child: BlocBuilder<RecipesBloc, RecipesState>(
                    builder: (context, state) {
                  if (state is RecipesInitiate) {
                    return loading();
                  } else if (state is RecipesLoading) {
                    return loading();
                  } else if (state is RecipesLoaded) {
                    recipes = state.recipes.checkForNullName()!;

                    return RecipeHorizontalList(
                      recipes: state.recipes.checkForNullName()!,
                      isPersonal: isPersonal,
                    );
                  } else {
                    return Container(
                      child: const Text('there is error on fetching data'),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: BlocProvider(
        create: (_) => _personalRecipesBloc,
        child: BlocListener<RecipesBloc, RecipesState>(
          listener: (context, state) {
            if (state is RecipesNetworkError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          child:
              BlocBuilder<RecipesBloc, RecipesState>(builder: (context, state) {
            if (state is RecipesInitiate) {
              return Container();
            } else if (state is RecipesLoading) {
              return Container();
            } else if (state is RecipesLoaded) {
              return childFloatingButtons(
                  context, state.recipes.checkForNullName()!);
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}

/*
      floatingActionButton: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        hoverColor: ThemeConst.lightTheme.hoverColor,
        splashColor: ThemeConst.lightTheme.hoverColor,
        child:Center(
          child: Icon( Icons.keyboard_arrow_up_sharp,
            color: ThemeConst.lightTheme.hoverColor,
            size: SizeConfigure.imageConfig!*15,
          ),
        ),
        onPressed: (){},
      ), */
