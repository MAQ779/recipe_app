import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/resources/repositories/api_repository.dart';

import '../../models/all_recipe.dart';

part 'all_recipe_event.dart';
part 'all_recipe_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState>{

  RecipesBloc() : super(RecipesInitiate()) {
    final ApiRepository _apiRepository = ApiRepository();


    on<GetRecipeList>((event, emit) async {
      try{
        emit(RecipesLoading());
        final recipes = await _apiRepository.getAllRecipes();
        emit(RecipesLoaded(recipes));
        if(recipes.errorMessage != null){
          emit(RecipesNetworkError(recipes.errorMessage));
        }
      } on NetworkError{
        emit(const RecipesNetworkError('please check your connection'));
      }

    });

    on<GetPersonalRecipeList>((event, emit) async {
      try{
        emit(RecipesLoading());
        String authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjMxODA3N2ViZDdiMTVlM2ViODBhYWUiLCJpYXQiOjE2NTUwMTUwNTZ9.pJlipvWqnxqLicBLVYALR_Wno5eysPqMNrC-jdzJgiU';

        final recipes = await _apiRepository.getAllPersonalRecipes(authToken);
        emit(RecipesLoaded(recipes));
        if(recipes.errorMessage != null){
          emit(RecipesNetworkError(recipes.errorMessage));
        }
      } on NetworkError{
        emit(const RecipesNetworkError('please check your connection'));
      }

    });


  }






}