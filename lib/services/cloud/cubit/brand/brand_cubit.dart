import 'package:bloc/bloc.dart';
import 'package:final_project/models/Brand.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/services/cloud/brand_service.dart';
import 'package:meta/meta.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
    final _brandService = BrandService();
  BrandCubit() : super(BrandInitial());
    void getBrands(List<String> brandIds) async {
    emit(BrandLoading());
    try {
      List<Brand> brands = [];
      for (String brandId in brandIds) {
        final brand =
          await _brandService.getBrandByID(brandId);
        if (brand != null) {
          brands.add(brand);
        }
      }
      emit(BrandLoaded(brands));
    } on Exception catch (e) {
      emit(BrandError(e));
    }
  }
}
