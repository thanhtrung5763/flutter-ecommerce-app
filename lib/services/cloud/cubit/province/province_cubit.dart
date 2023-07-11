import 'package:bloc/bloc.dart';
import 'package:final_project/models/Province.dart';
import 'package:final_project/services/repo/province_repository.dart';
import 'package:meta/meta.dart';

part 'province_state.dart';

class ProvinceCubit extends Cubit<ProvinceState> {
  ProvinceRepository repository;
  ProvinceCubit({required this.repository}) : super(ProvinceInitial());

  void getSaleProvinces() async {
    emit(ProvinceLoading());
    try {
      final provinces = await repository.getProvinces();
      emit(ProvinceLoaded(provinces));
    } on Exception catch (e) {
      emit(ProvinceError(e));
    }
  }
}
