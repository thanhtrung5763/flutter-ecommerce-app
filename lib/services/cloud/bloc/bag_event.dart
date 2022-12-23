// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bag_bloc.dart';

@immutable
abstract class BagEvent {}

class BagInitializeEvent extends BagEvent {}
class BagAddItemEvent extends BagEvent {
  final Product product;
  final String size;
  BagAddItemEvent({
    required this.product,
    required this.size,
  });
}

class BagRemoveItemEvent extends BagEvent {
  final int index;
  BagRemoveItemEvent({
    required this.index,
  });
}

class BagItemCountIncreaseEvent extends BagEvent {
  final int index;
  final int quantity;
  BagItemCountIncreaseEvent({
    required this.index,
    required this.quantity,
  });
}

class BagItemCountDecreaseEvent extends BagEvent {
  final int index;
  final int quantity;
  BagItemCountDecreaseEvent({
    required this.index,
    required this.quantity,
  });
}

class BagItemSizeChangeEvent extends BagEvent {
  final int index;
  final String size;
  BagItemSizeChangeEvent({
    required this.index,
    required this.size,
  });
}

class BagCheckoutEvent extends BagEvent {}
class BagListOrdersEvent extends BagEvent {}
class BagOrderAddReviewEvent extends BagEvent {
  final BagProduct bagProduct;
  final String rating;

  BagOrderAddReviewEvent({required this.bagProduct, required this.rating}); 
}


