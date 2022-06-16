import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/services/controller/global_controller.dart';
import '../../UI/recipes_main_page.dart';
import '../../constants/theme_constants.dart';
import '../../facilities/adding_space.dart';
import '../../facilities/size_configuration.dart';
import '../../models/all_recipe.dart';
import '../../services/fetch_all_recipes.dart';

class RecipeSheetPage extends StatefulWidget {
  final String image;
  final Recipe recipe;
  final bool isPersonal;
  const RecipeSheetPage(
      {Key? key,
      required this.image,
      required this.recipe,
      required this.isPersonal})
      : super(key: key);

  @override
  _RecipeSheetPageState createState() => _RecipeSheetPageState();
}

class _RecipeSheetPageState extends State<RecipeSheetPage> {
  double titleSize = SizeConfigure.heightConfig! * 4;
  double textSize = SizeConfigure.textConfig! * 2;
  double paddingRight = SizeConfigure.widthConfig! * 4;
  double paddingTop = SizeConfigure.widthConfig! * 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: ThemeConst.lightTheme.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: ThemeConst.lightTheme.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: (SizeConfigure.heightConfig! * 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeConst.lightTheme.primaryColor,
                    borderRadius:
                        BorderRadius.circular(SizeConfigure.widthConfig! * 2),
                    image: DecorationImage(
                      image: Image.asset(widget.image).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            splashRadius: SizeConfigure.imageConfig! * 4,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                //height: (SizeConfigure.heightConfig! * 60),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(textSize * 2),
                        topRight: Radius.circular(textSize * 2)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              EdgeInsets.all(SizeConfigure.widthConfig! * 3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.recipe.name.toString(),
                                    style: TextStyle(fontSize: titleSize),
                                    overflow: TextOverflow.fade,
                                    maxLines: null,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              ThemeConst.lightTheme.hoverColor,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    padding: EdgeInsets.all(
                                        SizeConfigure.widthConfig! * 3),
                                    child: Text(
                                        '${widget.recipe.kCal.toString()}kCals'),
                                  )
                                ],
                              ),
                              addVerticalSpace(SizeConfigure.heightConfig! * 2),
                              Text(
                                widget.recipe.description.toString(),
                                style: TextStyle(fontSize: textSize),
                              ),
                              addVerticalSpace(SizeConfigure.heightConfig! * 2),
                              Text(
                                'Ingredients:',
                                style: TextStyle(
                                    fontSize: textSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              addVerticalSpace(SizeConfigure.heightConfig! * 1),
                              SizedBox(
                                height: SizeConfigure.heightConfig! * 30,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        widget.recipe.ingredients!.length,
                                    padding: EdgeInsets.all(
                                        SizeConfigure.widthConfig! * 2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final ingredients =
                                          widget.recipe.ingredients![index];
                                      return ingredientsList(
                                          context, ingredients, index);
                                    }),
                              ),
                              addVerticalSpace(SizeConfigure.heightConfig! * 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//this widget for ingredients section the recipe sheet page
  Widget ingredientsList(
      BuildContext context, Ingredient ingredients, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  color: ThemeConst.whiteCard,
                  width: SizeConfigure.widthConfig! * 10,
                  height: SizeConfigure.widthConfig! * 10,
                ),
                addHorizontalSpace(SizeConfigure.widthConfig! * 2),
                Text(
                  ingredients.name.toString(),
                  style: TextStyle(fontSize: textSize),
                ),
              ],
            ),
            Text(
              'Quantity: ${ingredients.quantity.toString()}',
              style: TextStyle(fontSize: textSize, color: Colors.grey),
            ),
          ],
        ),
        addVerticalSpace(SizeConfigure.heightConfig! * 2),
        if (widget.recipe.ingredients!.length - 1 == index) bottomPart(),
      ],
    );
  }

// this the bottom part of the recipe sheet page (directions, and delete button for the personal recipe
  Widget bottomPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Directions:',
          style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
        ),
        addVerticalSpace(SizeConfigure.heightConfig! * 1),
        Text(
          widget.recipe.toStringAllDirections(),
          style: TextStyle(fontSize: textSize),
        ),
        addVerticalSpace(SizeConfigure.heightConfig! * 3),
        if (widget.isPersonal)
          Center(
            child: SizedBox(
              width: SizeConfigure.widthConfig! * 25,
              child: ElevatedButton(
                onPressed: () {
                  deletePersonalRecipe(context, widget.recipe);
                },
                child: const Center(child: Text('delete')),
              ),
            ),
          ),
      ],
    );
  }
}

// delete personal recipe functionality
Future<void> deletePersonalRecipe(BuildContext context, Recipe recipe) async {
  await FetchRecipes()
      .deletePersonalRecipe(recipe.id.toString(), ApiAuthController.authToken);
  Navigator.of(context).pop();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const RecipesUI(
        isAllRecipe: false,
      ),
    ),
  );
}
