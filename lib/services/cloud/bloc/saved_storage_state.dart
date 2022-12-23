part of 'saved_storage_bloc.dart';

@immutable
abstract class SavedStorageState {}

class SavedStorageInitial extends SavedStorageState {}

class SavedStorageLoadedState extends SavedStorageState {
  final SavedStorage savedStorage;
  SavedStorageLoadedState({
    required this.savedStorage,
  });
}
class SavedStorageErrorState extends SavedStorageState {
  final Exception exception;
  SavedStorageErrorState({
    required this.exception,
  });
}