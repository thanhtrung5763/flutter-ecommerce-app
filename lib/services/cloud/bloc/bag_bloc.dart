import 'package:bloc/bloc.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/repo/bag_repository.dart';
import 'package:meta/meta.dart';

part 'bag_event.dart';
part 'bag_state.dart';

class BagBloc extends Bloc<BagEvent, BagState> {
  BagRepository _bagRepository = BagRepository();
  BagBloc() : super(BagInitial()) {
    on<BagInitializeEvent>(
      (event, emit) async {
        try {
          Bag? bag = await _bagRepository.getBag();
          emit(BagLoadedState(bag: bag!));
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
    on<BagAddItemEvent>(
      (event, emit) async {
        try {
          if (state is BagLoadedState) {
            Bag bag = (state as BagLoadedState).bag;
            if (bag.BagProducts == null) {
              final bagProduct = await _bagRepository.createBagProduct(
                  bag, event.product, event.size);
              List<BagProduct> bagProducts = [];
              bagProducts.add(bagProduct);
              bag = bag.copyWith(BagProducts: bagProducts);
              emit(BagLoadedState(bag: bag));
            } else {
              final productIndex = bag.BagProducts!.indexWhere(
                  (element) => element.product!.id == event.product.id);
              if (productIndex >= 0) {
                bag.BagProducts![productIndex] = bag.BagProducts![productIndex]
                    .copyWith(
                        quantity: bag.BagProducts![productIndex].quantity! + 1);
                // update bagproduct quantity
                _bagRepository.updateBagProduct(bag.BagProducts![productIndex]);
              } else {
                final bagProduct = await _bagRepository.createBagProduct(
                    bag, event.product, event.size);
                bag.BagProducts!.add(bagProduct);
                // Bag? newBag = await _bagRepository.getBag();
              }
              emit(BagLoadedState(bag: bag));
            }
          }
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
    on<BagRemoveItemEvent>(
      (event, emit) {
        try {
          if (state is BagLoadedState) {
            Bag bag = (state as BagLoadedState).bag;
            final bagProductID = bag.BagProducts!.elementAt(event.index).id;
            bag.BagProducts!.removeAt(event.index);
            _bagRepository.deleteBagProduct(bagProductID);
            emit(BagLoadedState(bag: bag));
          }
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
    on<BagItemCountIncreaseEvent>(
      (event, emit) {
        try {
          if (state is BagLoadedState) {
            Bag bag = (state as BagLoadedState).bag;
            bag.BagProducts![event.index] = bag.BagProducts![event.index]
                .copyWith(quantity: event.quantity);
            // update bagproduct quantity
            _bagRepository.updateBagProduct(bag.BagProducts![event.index]);
            emit(BagLoadedState(bag: bag));
          }
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
    on<BagItemSizeChangeEvent>(
      (event, emit) {
        try {
          if (state is BagLoadedState) {
            Bag bag = (state as BagLoadedState).bag;
            bag.BagProducts![event.index] =
                bag.BagProducts![event.index].copyWith(size: event.size);
            // update bagproduct quantity
            _bagRepository.updateBagProduct(bag.BagProducts![event.index]);
            emit(BagLoadedState(bag: bag));
          }
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
    on<BagItemCountDecreaseEvent>(
      (event, emit) {
        try {
          if (state is BagLoadedState) {
            Bag bag = (state as BagLoadedState).bag;
            bag.BagProducts![event.index] = bag.BagProducts![event.index]
                .copyWith(quantity: event.quantity);
            // update bagproduct quantity
            _bagRepository.updateBagProduct(bag.BagProducts![event.index]);
            emit(BagLoadedState(bag: bag));
          }
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
    on<BagCheckoutEvent>(
      (event, emit) async {
        try {
          if (state is BagLoadedState) {
            Bag bag = (state as BagLoadedState).bag;
            bag = bag.copyWith(bagStatus: BagStatus.PROCESSING);
            _bagRepository.updateBagStatus(bag);

            Bag? emptyBag = await _bagRepository.getBag();
            emit(BagLoadedState(bag: emptyBag!));
          }
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
    on<BagListOrdersEvent>(
      (event, emit) async {
        try {
          List<Bag> orders = await _bagRepository.getOrders();
          emit(BagListOrdersLoadedState(orders: orders));
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
    on<BagOrderAddReviewEvent>(
      (event, emit) async {
        try {
          if (state is BagListOrdersLoadedState) {
            List<Bag> orders = (state as BagListOrdersLoadedState).orders;
            final orderIndex = orders
                .indexWhere((element) => element.id == event.bagProduct.bagID);
            Bag bag = orders[orderIndex];
            final bagProductIndex = bag.BagProducts!
                .indexWhere((element) => element.id == event.bagProduct.id);
            bag.BagProducts![bagProductIndex] =
                bag.BagProducts![bagProductIndex].copyWith(isRated: true);
            orders[orderIndex] = bag;

            _bagRepository.updateBagProduct(bag.BagProducts![bagProductIndex]);
            await _bagRepository.addReview(event.bagProduct.bagID,
                event.bagProduct.productID, event.rating);
            emit(BagListOrdersLoadedState(orders: orders));
          }
        } on Exception catch (e) {
          emit(BagErrorState(exception: e));
        }
      },
    );
  }
}
