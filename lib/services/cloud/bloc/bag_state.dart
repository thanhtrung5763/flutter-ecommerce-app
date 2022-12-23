// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bag_bloc.dart';

@immutable
abstract class BagState {}

class BagInitial extends BagState {}

class BagLoadedState extends BagState {
  final Bag bag;
  BagLoadedState({
    required this.bag,
  });
}
class BagErrorState extends BagState {
  final Exception exception;
  BagErrorState({
    required this.exception,
  });
}

class BagListOrdersLoadedState extends BagState {
  final List<Bag> orders;
  BagListOrdersLoadedState({
    required this.orders,
  });
}

// class BagItemAddedState extends BagState {
//   final Bag bag;
//   BagItemAddedState({
//     required this.bag,
//   });
// }

// class BagItemDeletedState extends BagState {
//   final Bag bag;
//   BagItemDeletedState({
//     required this.bag,
//   });
// }

// class BagItemCountIncreasedState extends BagState {
//   final Bag bag;
//   BagItemCountIncreasedState({
//     required this.bag,
//   });
// }

// class BagItemCountDecreasedState extends BagState {
//   final Bag bag;
//   BagItemCountDecreasedState({
//     required this.bag,
//   });
// }