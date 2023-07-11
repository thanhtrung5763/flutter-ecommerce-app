part of 'province_cubit.dart';

@immutable
abstract class ProvinceState {}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceLoaded extends ProvinceState {
  final List<Province> Provinces;

  ProvinceLoaded(this.Provinces);
}

class ProvinceError extends ProvinceState {
  final Exception exception;

  ProvinceError(this.exception);
}