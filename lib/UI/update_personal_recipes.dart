import 'package:flutter/material.dart';
import 'package:recipe_app/constants/theme_constants.dart';
import 'package:recipe_app/facilities/size_configuration.dart';

import '../models/all_recipe.dart';
import 'edit_personal_recipe.dart';

class UpdatePersonalRecipe extends StatefulWidget {
  final List<Recipe> recipes;
  const UpdatePersonalRecipe({Key? key, required this.recipes})
      : super(key: key);

  @override
  _UpdatePersonalRecipeState createState() => _UpdatePersonalRecipeState();
}

class _UpdatePersonalRecipeState extends State<UpdatePersonalRecipe> {
  int? selectedCard;
  double titleSize = SizeConfigure.heightConfig! * 4;
  String title = 'EDIT RECIPES';
  @override
  Widget build(BuildContext context) {
    if (widget.recipes.isEmpty) {
      return Column(
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
              Center(
                child: Text(
                  title,
                  style: ThemeConst.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: titleSize,
                  ),
                ),
              ),
            ],
          ),
          const Center(
            child: Text('no Loaded recipes'),
          ),
        ],
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(SizeConfigure.widthConfig! * 2),
            child: Column(
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
                    Center(
                      child: Text(
                        title,
                        style: ThemeConst.lightTheme.textTheme.titleMedium
                            ?.copyWith(
                          fontSize: titleSize,
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                    key: Key('builder ${selectedCard.toString()}'),
                    shrinkWrap: true,
                    itemCount: widget.recipes.length,
                    padding: EdgeInsets.all(SizeConfigure.widthConfig! * 2),
                    itemBuilder: (BuildContext context, int index) {
                      final recipe = widget.recipes[index];
                      return updateRecipeCard(context, recipe, index);
                    }),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget updateRecipeCard(BuildContext context, Recipe recipe, int i) {
    return Card(
        child: ExpansionTile(
      textColor: Colors.black,
      key: Key(i.toString()), //attention
      initiallyExpanded: i == selectedCard,
      tilePadding: EdgeInsets.symmetric(
          horizontal: SizeConfigure.heightConfig! * 1,
          vertical: SizeConfigure.heightConfig! * 1),
      title: Text(
        recipe.name!,
        style: TextStyle(fontSize: SizeConfigure.textConfig! * 2),
      ),
      subtitle: Text(
        recipe.description!,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfigure.textConfig! * 2),
      ),
      trailing: Text(
        'click me',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfigure.textConfig! * 2),
      ),
      children: [
        updateButton(context, recipe),
      ],

      onExpansionChanged: ((newState) {
        if (newState) {
          setState(() {
            selectedCard = i;
          });
        } else {
          setState(() {
            selectedCard = -1;
          });
        }
      }),
    ));
  }

  Widget updateButton(BuildContext context, Recipe recipe) => Row(
        children: [
          Expanded(
              child: TextButton.icon(
            clipBehavior: Clip.hardEdge,
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            label: const Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  EditPersonalRecipe(
                       recipe: recipe,
                    ),
                  ));
            },
          )),
        ],
      );
}
