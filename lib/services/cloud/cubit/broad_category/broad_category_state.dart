part of 'broad_category_cubit.dart';

@immutable
abstract class BroadCategoryState {}

class BroadCategoryInitial extends BroadCategoryState {}
class BroadCategoryLoading extends BroadCategoryState {}
class BroadCategoryLoaded extends BroadCategoryState {
    final List<BroadCategory> broadCategories;

  BroadCategoryLoaded(this.broadCategories);

}
class BroadCategoryError extends BroadCategoryState {
    final Exception exception;

  BroadCategoryError(this.exception);

}