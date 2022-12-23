import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tracking_event.dart';

class TrackingBloc extends Bloc<TrackingEvent, String> {
  late SharedPreferences prefs;
  TrackingBloc() : super("") {
    // _clearPref();
    _getPref();
    on<TrackingProductPressedEvent>((event, emit) async {
      prefs = await SharedPreferences.getInstance();
      final recentlyViewProducts;
      if (prefs.getString('recentlyViewProducts') != null && prefs.getString('recentlyViewProducts')!.contains(event.productID)) {
        recentlyViewProducts = prefs.getString('recentlyViewProducts');
      } else {
        recentlyViewProducts =
          "${prefs.getString('recentlyViewProducts') ?? ""}${event.productID},";
      }
      emit(recentlyViewProducts);
      prefs.setString('recentlyViewProducts', recentlyViewProducts);
    });
    on<TrackingProductClearEvent>((event, emit) async {
      _clearPref();
    });
  }
  void _getPref() async {
    prefs = await SharedPreferences.getInstance();
    emit(prefs.getString("recentlyViewProducts") ?? "");
  }
  void _clearPref() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("recentlyViewProducts");
    emit("");
  }
}
