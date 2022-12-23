import 'package:bloc/bloc.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/services/cloud/broad_category_service.dart';
import 'package:meta/meta.dart';

part 'broad_category_state.dart';

class BroadMenCubit extends Cubit<BroadCategoryState> {
  final _broadCategoryService = BroadCategoryService();
  BroadMenCubit() : super(BroadCategoryInitial());
  void getBroadCategories() async {
    emit(BroadCategoryLoading());
    try {
      final broadCategories =
          await _broadCategoryService.getBroadCategories('Men');
      emit(BroadCategoryLoaded(broadCategories));
    } on Exception catch (e) {
      emit(BroadCategoryError(e));
    }
  }
}

class BroadWomenCubit extends Cubit<BroadCategoryState> {
  final _broadCategoryService = BroadCategoryService();
  BroadWomenCubit() : super(BroadCategoryInitial());
  void getBroadCategories() async {
    emit(BroadCategoryLoading());
    try {
      final broadCategories =
          await _broadCategoryService.getBroadCategories('Women');
      emit(BroadCategoryLoaded(broadCategories));
    } on Exception catch (e) {
      emit(BroadCategoryError(e));
    }
  }
}
