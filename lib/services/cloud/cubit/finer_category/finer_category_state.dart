part of 'finer_category_cubit.dart';

@immutable
abstract class FinerCategoryState {}

class FinerCategoryInitial extends FinerCategoryState {}
class FinerCategoryLoading extends FinerCategoryState {}
class FinerCategoryLoaded extends FinerCategoryState {
  final List<FinerCategory> finerCategories;

  FinerCategoryLoaded(this.finerCategories);
}
class FinerCategoryError extends FinerCategoryState {
  final Exception exception;

  FinerCategoryError(this.exception);
}
