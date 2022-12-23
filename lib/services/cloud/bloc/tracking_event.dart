part of 'tracking_bloc.dart';

@immutable
abstract class TrackingEvent {}

class TrackingProductPressedEvent extends TrackingEvent {
  final String productID;

  TrackingProductPressedEvent({required this.productID});
}

  
class TrackingProductClearEvent extends TrackingEvent {}
