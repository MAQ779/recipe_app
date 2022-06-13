part of 'all_recipe_bloc.dart';

abstract class RecipesEvent extends Equatable{

  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class GetRecipeList extends RecipesEvent{

}
class GetPersonalRecipeList extends RecipesEvent{

}