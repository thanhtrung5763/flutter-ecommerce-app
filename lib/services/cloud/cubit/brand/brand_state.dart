part of 'brand_cubit.dart';

@immutable
abstract class BrandState {}

class BrandInitial extends BrandState {}
class BrandLoading extends BrandState {}
class BrandLoaded extends BrandState {
  final List<Brand> brands;

  BrandLoaded(this.brands);
}
class BrandError extends BrandState {
  final Exception exception;

  BrandError(this.exception);
}
