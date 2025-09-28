import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../core/use_case.dart';
import '../../domain/entities/categories/category.dart';
import '../../domain/usecases/categories/filter_category_usecase.dart';
import '../../domain/usecases/categories/get_cached_category_usecase.dart';
import '../../domain/usecases/categories/get_remot_category_usecase.dart';


part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetRemoteCategoryUseCase _getCategoryUseCase;
  final GetCachedCategoryUseCase _getCashedCategoryUseCase;
  final FilterCategoryUseCase _filterCategoryUseCase;

  CategoryBloc(this._getCategoryUseCase, this._getCashedCategoryUseCase,this._filterCategoryUseCase)
      : super(const CategoryLoading(categories: [])) {
    on<GetCategories>(_onLoadCategories);
    on<FilterCategories>(_onFilterCategories);
  }

  void _onLoadCategories(
      GetCategories event, Emitter<CategoryState> emit) async {
    try {
      ///Initial Category loading with minimal loading animation
      ///
      ///Cashed category
      emit(const CategoryLoading(categories: []));
      final cashedResult = await _getCashedCategoryUseCase(NoParams());
      cashedResult.fold(
            (failure) => (),
            (categories) => emit(CategoryCacheLoaded(
          categories: categories,
        )),
      );

      ///Check remote data source to find categories
      ///Method will find and update if there any new category update from server
      ///Remote Category
      final result = await _getCategoryUseCase(NoParams());
      result.fold(
            (failure) => emit(CategoryError(
          categories: state.categories,
          failure: failure,
        )),
            (categories) => emit(CategoryLoaded(
          categories: categories,
        )),
      );
    } catch (e) {
      log(e.toString());
      emit(CategoryError(
        categories: state.categories,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onFilterCategories(
      FilterCategories event, Emitter<CategoryState> emit) async {
    try {
      ///Initial Category loading with minimal loading animation
      ///
      ///Cashed category
      emit(CategoryLoading(categories: state.categories));
      final cashedResult = await _filterCategoryUseCase(event.keyword);
      cashedResult.fold(
            (failure) => emit(CategoryError(
          categories: state.categories,
          failure: failure,
        )),
            (categories) => emit(CategoryCacheLoaded(
          categories: categories,
        )),
      );
    } catch (e) {
      emit(CategoryError(
        categories: state.categories,
        failure: ExceptionFailure(),
      ));
    }
  }
}
