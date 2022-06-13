import 'package:flutter/material.dart';
import 'package:recipe_app/facilities/size_configuration.dart';

import '../../../UI/create_personal_recipe.dart';
import '../../../UI/update_personal_recipes.dart';
import '../../../models/all_recipe.dart';
import '../../../services/auth_google.dart';
import 'floating_action_btn.dart';
import 'floating_button_expandable.dart';

Widget childFloatingButtons(BuildContext context, List<Recipe> recipes) {
  Future<void> logout() async {
    await Authentification().signOut();
  }

  return ExpandableFab(
    distance: SizeConfigure.widthConfig! * 20,
    buttons: [
      ActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NewPersonalRecipeForm()),
          );
        },
        icon: const Icon(Icons.add),
      ),
      ActionButton(
        onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  UpdatePersonalRecipe(
                      recipes: recipes,
                    ),
                  ))

        },
        icon: const Icon(Icons.edit),
      ),
      ActionButton(
        onPressed: () => {logout()},
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}
