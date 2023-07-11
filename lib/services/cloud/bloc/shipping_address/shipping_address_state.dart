part of 'shipping_address_bloc.dart';

@immutable
abstract class ShippingAddressState extends Equatable {}

class ShippingAddressInitial extends ShippingAddressState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShippingAddressLoadedState extends ShippingAddressState {
  final List<ShippingAddress> shippingAddresses;
  ShippingAddressLoadedState({
    required this.shippingAddresses,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [shippingAddresses];
}

class ShippingAddressErrorState extends ShippingAddressState {
  final Exception exception;
  ShippingAddressErrorState({
    required this.exception,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [exception];
}
