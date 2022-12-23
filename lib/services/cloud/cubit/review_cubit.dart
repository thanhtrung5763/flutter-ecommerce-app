import 'package:bloc/bloc.dart';
import 'package:final_project/models/Product.dart';
import 'package:final_project/models/Review.dart';
import 'package:final_project/services/repo/review_repository.dart';
import 'package:meta/meta.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepository _reviewRepository = ReviewRepository();
  ReviewCubit() : super(ReviewInitial());
  void getReviewByProduct(Product product) async {
    emit(ReviewLoading());
    try {
      final reviews = await _reviewRepository.getReviewByProduct(product);
      emit(ReviewLoaded(reviews));
    } on Exception catch (e) {
      emit(ReviewError(e));
    }
  }
}
