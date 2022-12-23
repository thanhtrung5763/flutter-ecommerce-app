import 'package:bloc/bloc.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/models/FinerCategory.dart';
import 'package:final_project/services/cloud/finer_category_service.dart';
import 'package:meta/meta.dart';

part 'finer_category_state.dart';

class FinerCategoryCubit extends Cubit<FinerCategoryState> {
    final _finerCategoryService = FinerCategoryService();
  FinerCategoryCubit() : super(FinerCategoryInitial());
    void getFinerCategoriesOfBroad(BroadCategory broadCategory) async {
    emit(FinerCategoryLoading());
    try {
      final finerCategories =
          await _finerCategoryService.getFinerCategoriesOfBroad(broadCategory);
      emit(FinerCategoryLoaded(finerCategories));
    } on Exception catch (e) {
      emit(FinerCategoryError(e));
    }
  }
}
