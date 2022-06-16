import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/all_recipe_bloc/all_recipe_bloc.dart';
import 'package:recipe_app/facilities/size_configuration.dart';
import 'package:recipe_app/services/controller/global_controller.dart';
import '../facilities/adding_space.dart';
import '../models/all_recipe.dart';
import '../widgets/buttons/floating_button/child_floating_buttons.dart';
import '../widgets/loading/loading_page.dart';
import '../widgets/recipes_list.dart';

class RecipesUI extends StatefulWidget {
  final bool isAllRecipe;
  const RecipesUI({
    Key? key,
    required this.isAllRecipe
  }) : super(key: key);

  @override
  _RecipesUIState createState() => _RecipesUIState();
}

class _RecipesUIState extends State<RecipesUI> {
  //for control the size
  double titleSize = SizeConfigure.heightConfig! * 5;
  double titleSize2 = SizeConfigure.heightConfig! * 4;
  double textButtonSize = SizeConfigure.heightConfig! * 3;
  double iconSize = SizeConfigure.imageConfig! * 13;

  // main bar
  late Color recipe;
  late Color myRecipe;
  late bool isAllRecipe;

  List<Recipe>? recipes;
  final RecipesBloc _recipesBloc = RecipesBloc();
  final RecipesBloc _personalRecipesBloc = RecipesBloc();

  @override
  void initState() {
    isAllRecipe = widget.isAllRecipe;
    recipe = (isAllRecipe)? Colors.black : Colors.grey;
    myRecipe = (!isAllRecipe)? Colors.black : Colors.grey;
    _recipesBloc.add( (isAllRecipe)? GetRecipeList() : GetPersonalRecipeList());
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

              children: [
                Text(
                  'Let\'s Cook',
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName.toString(),
                  style: TextStyle(
                    fontSize: titleSize2,
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: SizeConfigure.widthConfig!*2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                  child: Text('Recipes', style: TextStyle(fontSize: textButtonSize, color: recipe)),
                    onTap: () { setState(() {
                      isAllRecipe = true;
                      _recipesBloc.add(GetRecipeList());
                      recipe = Colors.black;
                      myRecipe = Colors.grey;
                    });
                    },
                ),
                GestureDetector(child: Text('My Recipes', style: TextStyle(fontSize: textButtonSize, color: myRecipe)),
                  onTap: () { setState(() {
                    isAllRecipe = false;
                    _recipesBloc.add(GetPersonalRecipeList());
                    recipe = Colors.grey;
                    myRecipe = Colors.black;
                  });  },)
              ],),
            ),
            addVerticalSpace(SizeConfigure.heightConfig! * 3),
            //textButton('Recipes', textButtonSize),
             BlocProvider(
              create: (_) => _recipesBloc  ,
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
                          isPersonal: !isAllRecipe,
                        );
                      } else {
                        return const Center(
                            child: Text('there is error on fetching data'));
                      }
                    }),
              ),
            ),


            addVerticalSpace(SizeConfigure.heightConfig! * 3),
            //textButton('My Recipes', textButtonSize),

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
            setState(() {
              if (state is RecipesLoaded) {
                if (ApiAuthController.newPersonalRecipe) {
                  GetPersonalRecipeList();
                  ApiAuthController.newPersonalRecipe = false;
                }
              }
            });
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


