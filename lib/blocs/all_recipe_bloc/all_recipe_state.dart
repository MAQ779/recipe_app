part of 'all_recipe_bloc.dart';


abstract class RecipesState extends Equatable{
  const RecipesState();

  @override
  List<Object> get props => [];

}

class RecipesInitiate extends RecipesState{}

class RecipesLoaded extends RecipesState{
  final AllRecipes recipes;
  const RecipesLoaded(this.recipes);
}

class RecipesLoading extends RecipesState{}

class RecipesNetworkError extends RecipesState{
  final String? error;
  const RecipesNetworkError(this.error);
}