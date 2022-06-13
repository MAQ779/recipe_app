import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app/models/all_recipe.dart';
import 'package:recipe_app/widgets/recipes_cards.dart';

import '../facilities/size_configuration.dart';
import '../services/fetch_all_recipes.dart';


class RecipeHorizontalList extends StatefulWidget {
  final List<Recipe> recipes;
  final bool isPersonal;
  const RecipeHorizontalList({Key? key, required this.recipes, required this.isPersonal }) : super(key: key);

  @override
  _RecipeHorizontalListState createState() => _RecipeHorizontalListState();
}

class _RecipeHorizontalListState extends State<RecipeHorizontalList> {
  int _index =0;
  bool once =true;
  late List<Recipe> spareRecipes;
  @override
  void initState() {
    if(once){
    spareRecipes = widget.recipes;
    once = false;}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfigure.heightConfig!*25,// card height
      child: PageView.builder(
        itemCount: widget.recipes.length,
        controller: PageController(viewportFraction: 0.8),
        onPageChanged: ((int index) => setState(() {
          _index = index;
        })),
        itemBuilder: (_, i) {
          return
            Transform.scale(
              scale: (_index == i)? 1.0 : .9,
                child: recipeCards(context,widget.recipes[i], widget.isPersonal));

        },
      ),
    );
  }
   void filterSearchResults(String searchWord) async {
    if (searchWord.isNotEmpty) {
      List<Recipe>? searchList = [];
      for (var recipe in widget.recipes) {
        if (recipe.name!.toUpperCase().contains(searchWord.toUpperCase())) {
          searchList.add(recipe);
        }
      }
      setState(() {
        if (searchList.isNotEmpty) {
          widget.recipes.clear();
          widget.recipes.addAll(searchList);
        } else {
          widget.recipes.clear();
          widget.recipes.addAll(spareRecipes);
        }
      });
    } else {
      setState(() {
        widget.recipes.clear();
        widget.recipes.addAll(spareRecipes);
      });
    }
  }
}






