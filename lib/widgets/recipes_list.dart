import 'package:flutter/widgets.dart';
import 'package:recipe_app/models/all_recipe.dart';
import 'package:recipe_app/widgets/recipes_cards.dart';
import '../facilities/size_configuration.dart';



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
      height: SizeConfigure.heightConfig!*60,// card height
      child: PageView.builder(
        itemCount: widget.recipes.length,
        controller: PageController(viewportFraction: 0.6),
        onPageChanged: ((int index) => setState(() {
          _index = index;
        })),
        itemBuilder: (_, i) {
          return
            Transform.scale(
              scale: (_index == i)? 1.0 : .9,
                child: recipeCards(context,widget.recipes[i], widget.isPersonal,
                                  (i.isEven)? 'assets/image_test11.png' : 'assets/image_test22.png',
                                    i.isEven));

        },
      ),
    );
  }
}






