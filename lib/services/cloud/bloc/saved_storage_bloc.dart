import 'package:bloc/bloc.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/models/Product.dart';
import 'package:final_project/models/SavedStorage.dart';
import 'package:final_project/services/repo/saved_storage_repository.dart';
import 'package:meta/meta.dart';

part 'saved_storage_event.dart';
part 'saved_storage_state.dart';

class SavedStorageBloc extends Bloc<SavedStorageEvent, SavedStorageState> {
  SavedStorageRepository _savedStorageRepository = SavedStorageRepository();
  SavedStorageBloc() : super(SavedStorageInitial()) {
    on<SavedStorageInitializeEvent>((event, emit) async {
      try {
        SavedStorage? savedStorage =
            await _savedStorageRepository.getSavedStorage();
        emit(SavedStorageLoadedState(savedStorage: savedStorage!));
      } on Exception catch (e) {
        emit(SavedStorageErrorState(exception: e));
      }
    });
    on<SavedStorageAddItemEvent>((event, emit) async {
      try {
        if (state is SavedStorageLoadedState) {
          SavedStorage savedStorage =
              (state as SavedStorageLoadedState).savedStorage;
          if (savedStorage.SavedStorageProducts == null) {
            final savedStorageProduct = await _savedStorageRepository
                .createSavedStorageProduct(savedStorage, event.product);
            List<SavedStorageProduct> saveStorageProducts = [];
            saveStorageProducts.add(savedStorageProduct);
            savedStorage = savedStorage.copyWith(
                SavedStorageProducts: saveStorageProducts);
          } else {
            final savedStorageProduct = await _savedStorageRepository
                .createSavedStorageProduct(savedStorage, event.product);
            savedStorage.SavedStorageProducts!.add(savedStorageProduct);
          }
          emit(SavedStorageLoadedState(savedStorage: savedStorage));
        }
      } on Exception catch (e) {
        emit(SavedStorageErrorState(exception: e));
      }
    });
    on<SavedStorageMoveItemEvent>((event, emit) {
      try {} on Exception catch (e) {
        emit(SavedStorageErrorState(exception: e));
      }
    });
    on<SavedStorageRemoveItemEvent>((event, emit) {
      try {
        if (state is SavedStorageLoadedState) {
          SavedStorage savedStorage =
              (state as SavedStorageLoadedState).savedStorage;
          final savedStorageProductID;
          final indexInSavedStorageProducts;
          if (event.index != null) {
            indexInSavedStorageProducts = event.index;
          } else { // productID != null
            indexInSavedStorageProducts = savedStorage.SavedStorageProducts!.indexWhere((element) => element.product!.id == event.productID);
          }
          savedStorageProductID =
              savedStorage.SavedStorageProducts!.elementAt(indexInSavedStorageProducts).id;
          savedStorage.SavedStorageProducts!.removeAt(indexInSavedStorageProducts);
          _savedStorageRepository
              .deleteSavedStorageProduct(savedStorageProductID);
          emit(SavedStorageLoadedState(savedStorage: savedStorage));
        }
      } on Exception catch (e) {
        emit(SavedStorageErrorState(exception: e));
      }
    });
  }
}
