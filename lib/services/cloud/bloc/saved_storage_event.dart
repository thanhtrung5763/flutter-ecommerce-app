part of 'saved_storage_bloc.dart';

@immutable
abstract class SavedStorageEvent {}

class SavedStorageInitializeEvent extends SavedStorageEvent {}
class SavedStorageAddItemEvent extends SavedStorageEvent {
  final Product product;
  SavedStorageAddItemEvent({
    required this.product,
  });
}

class SavedStorageMoveItemEvent extends SavedStorageEvent {
  final SavedStorageProduct savedStorageProduct;
  SavedStorageMoveItemEvent({
    required this.savedStorageProduct,
  });
}

class SavedStorageRemoveItemEvent extends SavedStorageEvent {
  final int? index;
  final String? productID;
  SavedStorageRemoveItemEvent({
     this.index,
     this.productID,
  });
}