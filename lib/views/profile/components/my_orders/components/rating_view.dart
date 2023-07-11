import 'package:final_project/utils/colors.dart';
import 'package:final_project/models/BagProduct.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:flutter/material.dart';
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
  late TextEditingController _contentController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: 'REVIEW',
            size: 14,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: Column(
            children: [
              // SmallText(
              //   text: 'Rate Your Item',
              //   size: 16,
              // ),
              // const SizedBox(
              //   height: 7,
              // ),
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
              Flexible(
                child: Container(
                  height: 200,
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _contentController,
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    maxLines: null,
                    maxLength: 300,
                    cursorColor: AppColors.black,
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: AppColors.grey.withOpacity(0.05),
                        contentPadding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.black),
                          // borderRadius: BorderRadius.circular(AppSizes.kSize8),
                          borderRadius: BorderRadius.zero,
                        ),
                        // border: OutlineInputBorder(
                        //   borderSide: const BorderSide(color: Colors.red),
                        //   borderRadius: BorderRadius.circular(AppSizes.kSize8),
                        // ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.black, width: 1.2),
                          borderRadius: BorderRadius.zero,
                        ),
                        hintText: 'Share with us your experience(optional)',
                        hintStyle: const TextStyle(color: AppColors.grey)),
                  ),
                ),
              ),
              // const Spacer(),
              ButtonIconText(
                text: 'RATE',
                textSize: 16,
                onPressed: () {
                  BlocProvider.of<BagBloc>(context).add(
                    BagOrderAddReviewEvent(
                      bagProduct: widget.bagProduct,
                      rating: _rating.toString(),
                      content: _contentController.text
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
