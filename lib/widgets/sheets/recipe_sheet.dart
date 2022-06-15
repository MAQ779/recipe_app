import 'package:flutter/material.dart';
import 'package:recipe_app/services/controller/global_controller.dart';
import '../../UI/recipes_main_page.dart';
import '../../constants/theme_constants.dart';
import '../../facilities/adding_space.dart';
import '../../facilities/size_configuration.dart';
import '../../models/all_recipe.dart';
import '../../services/fetch_all_recipes.dart';

Future recipeSheet(BuildContext context, Recipe recipe, bool isPersonal) {
  double titleSize = SizeConfigure.textConfig! * 4;
  double textSize = SizeConfigure.textConfig! * 2;
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(textSize * 2),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: (SizeConfigure.heightConfig! * 60),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfigure.widthConfig! * 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            recipe.name.toString(),
                            style: TextStyle(fontSize: titleSize),
                            overflow: TextOverflow.fade,
                            maxLines: null,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: ThemeConst.lightTheme.hoverColor,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding:
                                EdgeInsets.all(SizeConfigure.widthConfig! * 3),
                            child: Text('${recipe.kCal.toString()}kCals'),
                          )
                        ],
                      ),
                      addVerticalSpace(SizeConfigure.heightConfig! * 2),
                      Text(
                        recipe.description.toString(),
                        style: TextStyle(fontSize: textSize),
                      ),
                      addVerticalSpace(SizeConfigure.heightConfig! * 2),
                      Text(
                        'Ingredients:',
                        style: TextStyle(
                            fontSize: textSize, fontWeight: FontWeight.bold),
                      ),
                      addVerticalSpace(SizeConfigure.heightConfig! * 1),
                      Text(
                        recipe.toStringAllIngredients(),
                        style: TextStyle(fontSize: textSize),
                      ),
                      addVerticalSpace(SizeConfigure.heightConfig! * 2),
                      Text(
                        'Directions:',
                        style: TextStyle(
                            fontSize: textSize, fontWeight: FontWeight.bold),
                      ),
                      addVerticalSpace(SizeConfigure.heightConfig! * 1),
                      Text(
                        recipe.toStringAllDirections(),
                        style: TextStyle(fontSize: textSize),
                      ),
                      addVerticalSpace(SizeConfigure.heightConfig! * 3),
                      if (isPersonal)
                        Center(
                          child: SizedBox(
                            width: SizeConfigure.widthConfig! * 25,
                            child: ElevatedButton(
                              onPressed: () {
                                deletePersonalRecipe(context, recipe);
                              },
                              child: const Center(child: Text('delete')),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: ThemeConst.lightTheme.primaryColor,
                  ))
            ],
          ),
        );
      });
}

Future<void> deletePersonalRecipe(BuildContext context, Recipe recipe) async {
  await FetchRecipes()
      .deletePersonalRecipe(recipe.id.toString(), ApiAuthController.authToken);
  Navigator.of(context).pop();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const RecipesUI(),
    ),
  );
}
