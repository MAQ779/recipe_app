import 'package:flutter/material.dart';
import 'package:recipe_app/UI/recipes_main_page.dart';
import 'package:recipe_app/facilities/adding_space.dart';
import 'package:recipe_app/facilities/size_configuration.dart';
import 'package:recipe_app/models/personal_recipe.dart';
import '../Constants/theme_constants.dart';
import '../services/fetch_all_recipes.dart';
import '../widgets/dynamic_text_fields.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class NewPersonalRecipeForm extends StatefulWidget {
  const NewPersonalRecipeForm({Key? key}) : super(key: key);

  @override
  _NewPersonalRecipeFormState createState() => _NewPersonalRecipeFormState();
}

class _NewPersonalRecipeFormState extends State<NewPersonalRecipeForm> {
  double titleSize = SizeConfigure.heightConfig! * 4;
  double paddingRight = SizeConfigure.widthConfig! * 4;
  double paddingTop = SizeConfigure.widthConfig! * 2;

  List<String> directionList = [''];
  List<String> ingredientList = [''];

  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  TextEditingController? _caloriesController;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(SizeConfigure.widthConfig! * 2),
          child: SingleChildScrollView(
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
                    Center(
                      child: Text(
                        'NEW RECIPE',
                        style: ThemeConst.lightTheme.textTheme.titleMedium
                            ?.copyWith(
                          fontSize: titleSize,
                        ),
                      ),
                    ),
                  ],
                ),
                FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfigure.heightConfig! * 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: paddingRight, top: paddingTop),
                          child: FormBuilderTextField(
                              decoration: const InputDecoration(
                                  hintText: 'Enter Recipe Title'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter title';
                                }
                                return null;
                              },
                              name: 'title'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: paddingRight, top: paddingTop),
                          child: FormBuilderTextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                                hintText: 'Enter Recipe Description'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter description';
                              }
                              return null;
                            },
                            name: 'description',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: paddingRight, top: paddingTop),
                          child: FormBuilderTextField(
                            controller: _caloriesController,
                            decoration: const InputDecoration(
                                hintText: 'Enter Recipe Calories'),
                            validator: (value) {
                              if (double.tryParse(value!) == null) {
                                return 'Please integer input';
                              }
                              if (value.isEmpty) {
                                return 'Please enter calories';
                              }
                              return null;
                            },
                            name: 'calo',
                          ),
                        ),
                        addVerticalSpace(SizeConfigure.heightConfig! * 4),
                        Text(
                          'DIRECTIONS:',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfigure.textConfig! * 2,
                          ),
                        ),
                        ..._getDirections(
                            directionList, 'please enter direction'),
                        addVerticalSpace(SizeConfigure.heightConfig! * 4),
                        Text(
                          'INGREDIENTS:',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfigure.textConfig! * 2,
                          ),
                        ),
                        ..._getIngredients(ingredientList,
                            'please enter Ingredients', 'Quantity'),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                formatNewPersonalRecipe(_formKey);
                              }
                            });
                          },
                          child: const Center(child: Text('Submit')),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// get directions text-fields
  List<Widget> _getDirections(List<String> directionList, String hint) {
    List<Widget> directionTextFields = [];
    for (int i = 0; i < directionList.length; i++) {
      directionTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                child: DynamicFields(
              index: i,
              directionList: directionList,
              hintText: hint,
              id: 'direction',
            )),
            SizedBox(
              width: SizeConfigure.heightConfig! * 2,
            ),
// we need add button at last friends row
            _addRemoveButton(i == directionList.length - 1, i, directionList),
          ],
        ),
      ));
    }
    return directionTextFields;
  }

  /// get ingredients text-fields
  List<Widget> _getIngredients(
      List<String> ingredientList, String hintIngredient, hintNum) {
    List<Widget> directionTextFields = [];
    for (int i = 0; i < ingredientList.length; i++) {
      directionTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: DynamicFields(
                  index: i,
                  directionList: ingredientList,
                  hintText: hintIngredient,
                  id: 'ingredient',
                )),
            addHorizontalSpace(SizeConfigure.heightConfig! * 1),
            Expanded(
                flex: 1,
                child: DynamicFields(
                  index: i,
                  directionList: ingredientList,
                  hintText: hintNum,
                  id: 'quantity',
                )),
            addHorizontalSpace(SizeConfigure.heightConfig! * 2),

// we need add button at last friends row
            _addRemoveButton(i == ingredientList.length - 1, i, ingredientList),
          ],
        ),
      ));
    }
    return directionTextFields;
  }

  // add / remove button
  Widget _addRemoveButton(bool add, int index, List<String> list) {
    double iconSize = SizeConfigure.imageConfig! * 8;
    return (index == 0 || index == list.length - 1)
        ? InkWell(
            highlightColor: Colors.transparent,
            //highlightColor: (Theme)Colors.white,
            onTap: () {
              if (add) {
                // add new text-fields at the top of all friends text fields
                list.insert(0, ' ');
              } else {
                list.removeAt(index);
              }
              //for update fields
              setState(() {});
            },
            child: Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: ThemeConst.lightTheme.hoverColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                (add) ? Icons.add : Icons.remove,
                color: Colors.white,
              ),
            ),
          )
        : SizedBox(
            width: iconSize,
            height: iconSize,
          );
  }

// method to formatting the form values into personal recipe
  Future<void> formatNewPersonalRecipe(
      GlobalKey<FormBuilderState> _formKey) async {
    _formKey.currentState!.save();

    List<String> direction = [];
    List<String> ingredient = [];
    List<String> quantity = [];

    _formKey.currentState!.value.forEach((key, value) {
      if (key.contains('direction')) {
        direction.add(value);
      } else if (key.contains('ingredient')) {
        ingredient.add(value);
      } else if (key.contains('quantity')) {
        quantity.add(value);
      }
    });

    List<Ingredients> ingredients = [];
    for (int i = 0; i < ingredient.length; i++) {
      ingredients.add(Ingredients(name: ingredient[i], quantity: quantity[i]));
    }
    ingredient.clear();
    quantity.clear();

    PersonalRecipe newRecipe = PersonalRecipe(
      name: _formKey.currentState!.value['title'],
      description: _formKey.currentState!.value['description'],
      kCal: double.tryParse(_formKey.currentState!.value['calo'])!.round(),
      directions: direction,
      ingredients: ingredients,
    );
    String authToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjMxODA3N2ViZDdiMTVlM2ViODBhYWUiLCJpYXQiOjE2NTUwMTUwNTZ9.pJlipvWqnxqLicBLVYALR_Wno5eysPqMNrC-jdzJgiU';
    await FetchRecipes().createPersonalRecipe(newRecipe, authToken);

    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RecipesUI(),
      ),
    );

    //Navigator.of(context).pop();
  }
}
