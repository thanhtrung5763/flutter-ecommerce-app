import 'package:final_project/models/BagProduct.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingView extends StatefulWidget {
  final BagProduct bagProduct;
  const RatingView({super.key, required this.bagProduct});

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  double _rating = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BigText(
            text: 'REVIEW',
            size: 14,
          ),
          elevation: 0.5,
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          height: 150,
          child: Column(
            children: [
              SmallText(
                text: 'Rate Your Item',
                size: 16,
              ),
              const SizedBox(
                height: 7,
              ),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              const Spacer(),
              ButtonIconText(
                text: 'Rate',
                textSize: 16,
                onPressed: () {
                  BlocProvider.of<BagBloc>(context).add(
                    BagOrderAddReviewEvent(
                      bagProduct: widget.bagProduct,
                      rating: _rating.toString(),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                backgroundColor: Colors.black87,
              )
            ],
          ),
        ));
  }
}
