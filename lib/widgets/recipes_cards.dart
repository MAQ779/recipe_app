import 'package:flutter/material.dart';
import 'package:recipe_app/constants/theme_constants.dart';
import 'package:recipe_app/facilities/adding_space.dart';
import 'package:recipe_app/facilities/size_configuration.dart';
import 'package:recipe_app/widgets/sheets/recipe_sheet.dart';
import '../models/all_recipe.dart';

Widget recipeCards(BuildContext context, Recipe recipe, bool isPersonal) {
  double titleSize = SizeConfigure.textConfig! * 2.5;
  double textSize = SizeConfigure.textConfig! * 2;
  return GestureDetector(
    onTap: () {
      recipeSheet(context, recipe, isPersonal);
    },
    child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(SizeConfigure.widthConfig! * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recipe.name.toString(),
                    style: TextStyle(
                        fontSize: titleSize, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.fade,
                    maxLines: null,
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfigure.widthConfig! * 1),
                    color: ThemeConst.lightTheme.primaryColor,
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
                style:
                    TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
              ),
              addVerticalSpace(SizeConfigure.heightConfig! * 1),
              Text(
                'This recipe needs ${recipe.ingredients!.length} of ingredients',
                style: TextStyle(fontSize: textSize),
              ),
              addVerticalSpace(SizeConfigure.heightConfig! * 3),
              Center(
                child: Text(
                  '${recipe.directions!.length} steps to make',
                  style:
                  TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),
        ))),
  );
}
