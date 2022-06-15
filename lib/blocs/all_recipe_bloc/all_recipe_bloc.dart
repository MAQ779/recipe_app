import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/resources/repositories/api_repository.dart';
import 'package:recipe_app/services/controller/global_controller.dart';
import '../../models/all_recipe.dart';
part 'all_recipe_event.dart';
part 'all_recipe_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc() : super(RecipesInitiate()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetRecipeList>((event, emit) async {
      try {
        emit(RecipesLoading());
        final recipes = await _apiRepository.getAllRecipes();
        emit(RecipesLoaded(recipes));
        if (recipes.errorMessage != null) {
          emit(RecipesNetworkError(recipes.errorMessage));
        }
      } on NetworkError {
        emit(const RecipesNetworkError('please check your connection'));
      }
    });

    on<GetPersonalRecipeList>((event, emit) async {
      try {
        emit(RecipesLoading());
        final recipes = await _apiRepository
            .getAllPersonalRecipes(ApiAuthController.authToken);
        emit(RecipesLoaded(recipes));
        if (recipes.errorMessage != null) {
          emit(RecipesNetworkError(recipes.errorMessage));
        }
      } on NetworkError {
        emit(const RecipesNetworkError('please check your connection'));
      }
    });
  }
}
