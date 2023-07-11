part of 'shipping_address_bloc.dart';

@immutable
abstract class ShippingAddressEvent {}

class ShippingAddressInitializeEvent extends ShippingAddressEvent {}
class ShippingAddressAddEvent extends ShippingAddressEvent {
  final bool isDefaultAddress;
  final ShippingAddress shippingAddress;

  ShippingAddressAddEvent({
    required this.shippingAddress,
    required this.isDefaultAddress,
  });
  
}
class ShippingAddressEditEvent extends ShippingAddressEvent {
  final bool isDefaultAddress;
  final ShippingAddress shippingAddress;

  ShippingAddressEditEvent({
    required this.shippingAddress,
    required this.isDefaultAddress,
  });
}
class ShippingAddressRemoveEvent extends ShippingAddressEvent {
  final ShippingAddress shippingAddress;

  ShippingAddressRemoveEvent({
    required this.shippingAddress
  });
}