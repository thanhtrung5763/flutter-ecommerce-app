import '../models/Review.dart';

class Helper {
  const Helper._();

  // void calculateTotalAmountAndItem(List<BagProduct> list) {
  //   double tempAmount = 0;
  //   int tempQuantity = 0;

  //   for (var element in list) {
  //     tempAmount += (element.product!.discountOffer == ''
  //         ? double.parse(element.product!.originalPrice!) * element.quantity!
  //         : double.parse(element.product!.discountPrice!) * element.quantity!);
  //     tempQuantity += (element.quantity!);
  //   }
  //   totalAmount = tempAmount;
  //   totalItems = tempQuantity;
  // }
  static String? calculateAverageRating(dynamic reviews) {
    if (reviews == null || reviews.isEmpty) {
      return null; // Return null if the Reviews list is null or empty
    }

    double sum = 0;
    for (var review in reviews) {
      sum += double.parse(review.rating);
    }

    return (sum / reviews.length).toStringAsFixed(1);
  }
}