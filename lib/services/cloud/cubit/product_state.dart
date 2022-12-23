// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final int length;
  final List<Product> products;

  ProductLoaded(this.products, this.length);
}

class ProductError extends ProductState {
  final Exception exception;

  ProductError(this.exception);
}

class ProductSaving extends ProductState {}

class ProductSaved extends ProductState {}
