import 'dart:developer';
import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';
import '../../facilities/adding_space.dart';
import '../../facilities/size_configuration.dart';
import '../../models/all_recipe.dart';
import '../../services/fetch_all_recipes.dart';

Future recipeSheet(BuildContext context, Recipe recipe, bool isPersonal) {
  double titleSize = SizeConfigure.textConfig!*4;
  double textSize = SizeConfigure.textConfig!*2;
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(textSize*2),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: (SizeConfigure.heightConfig!*60),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding:  EdgeInsets.all(SizeConfigure.widthConfig!*3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(recipe.name.toString(), style: TextStyle(fontSize: titleSize ), overflow: TextOverflow.fade, maxLines: null,),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: ThemeConst.lightTheme.hoverColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            padding:  EdgeInsets.all(SizeConfigure.widthConfig!*3),
                            child:  Text('${recipe.kCal.toString()}kCals'),
                          )
                        ],
                      ),
                        addVerticalSpace(SizeConfigure.heightConfig!*2),
                      Text(recipe.description.toString(), style: TextStyle(fontSize: textSize),),
                        addVerticalSpace(SizeConfigure.heightConfig!*2),
                      Text('Ingredients:', style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),),
                        addVerticalSpace(SizeConfigure.heightConfig!*1),
                      Text(recipe.toStringAllIngredients(), style: TextStyle(fontSize: textSize),),
                        addVerticalSpace(SizeConfigure.heightConfig!*2),
                      Text('Directions:', style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),),
                        addVerticalSpace(SizeConfigure.heightConfig!*1),
                      Text(recipe.toStringAllDirections(), style: TextStyle(fontSize: textSize),),
                        addVerticalSpace(SizeConfigure.heightConfig!*3),
                      if(isPersonal)
                        Center(
                          child: SizedBox(
                            width: SizeConfigure.widthConfig!*25,
                            child: ElevatedButton(
                              onPressed: () async {
                                String authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjMxODA3N2ViZDdiMTVlM2ViODBhYWUiLCJpYXQiOjE2NTUwMTUwNTZ9.pJlipvWqnxqLicBLVYALR_Wno5eysPqMNrC-jdzJgiU';
                                log(recipe.id.toString());
                                await FetchRecipes().deletePersonalRecipe(recipe.id.toString(), authToken);
                              },
                              child: const Center(child: Text('delete')),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(flex:1,child: Container(color: ThemeConst.lightTheme.primaryColor,))
            ],
          ),
        );
      });
}
