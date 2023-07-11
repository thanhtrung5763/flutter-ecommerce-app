import 'package:final_project/utils/colors.dart';
import 'package:final_project/models/Review.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewView extends StatelessWidget {
  final List<Review> reviews;
  const ReviewView({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: 'REVIEWS',
            size: 14,
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: List.generate(
                                    double.parse(reviews[index].rating!).toInt(),
                                    (index) => const Icon(
                                      Icons.star,
                                      color: AppColors.black,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SmallText(
                                  text: DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(reviews[index].createdAt.toString()),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // SmallText(
                            //     text:
                            //         'Potenti ullamcorper magnis pretium elementum, ullamcorper cursus pellentesque. Primis lobortis dis mollis sed sed etiam lorem.'),
                            reviews[index].content != null
                                ? SmallText(
                                    text: reviews[index].content!,
                                    size: 13,
                                  )
                                : Container(),
                            const SizedBox(
                              height: 8,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: SmallText(
                                  text: '-Anonymous',
                                  color: AppColors.black.withOpacity(0.6),
                                )),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: reviews.length),
              ),
            ],
          ),
        ));
  }
}
