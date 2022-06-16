import 'package:flutter/material.dart';
import 'package:recipe_app/constants/theme_constants.dart';
import 'package:recipe_app/facilities/adding_space.dart';
import 'package:recipe_app/facilities/size_configuration.dart';
import 'package:recipe_app/widgets/sheets/recipe_sheet.dart';
import '../models/all_recipe.dart';

Widget recipeCards(BuildContext context, Recipe recipe, bool isPersonal, String image, bool isEven ) {
  double titleSize = SizeConfigure.textConfig! * 2.5;
  double textSize = SizeConfigure.textConfig! * 2;
  Color textColor = (isEven) ? Colors.white : Colors.black;
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  RecipeSheetPage(image: image, recipe: recipe, isPersonal: isPersonal,)));
      //recipeSheet(context, recipe, isPersonal, image);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfigure.widthConfig!*2),
        color: (isEven)? ThemeConst.lightTheme.primaryColor: ThemeConst.whiteCard,
      ),
        //shadowColor: ThemeConst.lightTheme.primaryColor,
        //elevation: 10,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfigure.widthConfig!*2)),
        child: Stack(
          children: [
            Positioned(
              //top: 1,
                child: SizedBox(
                  height: SizeConfigure.heightConfig!*50,
                  child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfigure.widthConfig!*2),
                  image: DecorationImage(
                      image: Image.asset(image).image,
                      fit: BoxFit.cover,
                  ),
              ),
            ),
                )

            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.all(SizeConfigure.widthConfig! * 2),
                child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name.toString(),
                  style: TextStyle(
                      fontSize: titleSize, fontWeight: FontWeight.bold, color: textColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: null,
                ),
                addVerticalSpace(SizeConfigure.heightConfig! * 2),
                Text(
                  (recipe.directions!.length >1) ? '${recipe.directions!.length} steps to make': '1 step to make',
                  style:
                  TextStyle(fontSize: textSize, fontWeight: FontWeight.bold, color: textColor),
                ),

              ],
                ),
              ),
            ),
          ],
        )),
  );
}
