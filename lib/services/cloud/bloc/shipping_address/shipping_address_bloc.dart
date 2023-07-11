import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/repo/shipping_address_repository.dart';
import 'package:meta/meta.dart';

part 'shipping_address_event.dart';
part 'shipping_address_state.dart';

class ShippingAddressBloc extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  ShippingAddressRepository repository;

  ShippingAddressBloc({required this.repository}) : super(ShippingAddressInitial()) {
    int sortByUpdatedDate(ShippingAddress a, ShippingAddress b) {
      if (b.updatedAt != null) {
        if (a.updatedAt != null) {
          return b.updatedAt!.compareTo(a.updatedAt!);
        }
        return b.updatedAt!.compareTo(a.createdAt!);
      }
      return b.createdAt!.compareTo(a.createdAt!);
    }

    on<ShippingAddressInitializeEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        List<ShippingAddress> shippingAddresses = await repository.getShippingAddresses();
        shippingAddresses.sort(sortByUpdatedDate);
        emit(ShippingAddressLoadedState(shippingAddresses: shippingAddresses));
      } on Exception catch (e) {
        emit(ShippingAddressErrorState(exception: e));
      }
    });
    on<ShippingAddressAddEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        if (state is ShippingAddressLoadedState) {
          List<ShippingAddress> shippingAddresses = [...(state as ShippingAddressLoadedState).shippingAddresses];
          final shippingAddress = await repository.createShippingAddress(
              event.shippingAddress, shippingAddresses.isEmpty ? true : event.isDefaultAddress);
          if (shippingAddress != null) {
            shippingAddresses.add(shippingAddress);
            shippingAddresses.sort(sortByUpdatedDate);
            emit(ShippingAddressLoadedState(shippingAddresses: shippingAddresses));
          }
        }
      } on Exception catch (e) {
        emit(ShippingAddressErrorState(exception: e));
      }
    });

    on<ShippingAddressEditEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        if (state is ShippingAddressLoadedState) {
          List<ShippingAddress> shippingAddresses = [...(state as ShippingAddressLoadedState).shippingAddresses];
          final shippingAddress = await repository.updateShippingAddress(event.shippingAddress, event.isDefaultAddress);
          final idx = shippingAddresses.indexWhere((element) => element.id == event.shippingAddress.id);
          if (idx != -1 && shippingAddress != null) {
            shippingAddresses.removeAt(idx);
            // shippingAddresses[idx] = event.shippingAddress;
            shippingAddresses.insert(0, shippingAddress);
            shippingAddresses.sort(sortByUpdatedDate);
            emit(ShippingAddressLoadedState(shippingAddresses: shippingAddresses));
          }
        }
      } on Exception catch (e) {
        emit(ShippingAddressErrorState(exception: e));
      }
    });
  }
}
