import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/cloud/bloc/saved_storage/saved_storage_bloc.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/helper.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatefulWidget {
  final Product? product;
  final bool isSelected;
  final double imgHeight;
  final double imgWidth;
  const ProductCard({
    super.key,
    required this.imgHeight,
    required this.imgWidth,
    required this.product,
    required this.isSelected,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.isSelected;
    return BlocBuilder<SavedStorageBloc, SavedStorageState>(
      builder: (context, state) {
        return SizedBox(
          height: widget.imgHeight,
          width: widget.imgWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: widget.imgHeight,
                      width: widget.imgWidth, //148
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.product!.images!.split('|').first),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.product!.discountOffer != '',
                    child: Positioned(
                      top: 10,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: AppColors.whiteTag, shape: BoxShape.rectangle),
                        child: SmallText(
                          text: widget.product!.discountOffer != ''
                              ? '-${100 - int.parse(widget.product!.discountOffer!.split('%')[0])}%'
                              : 'NEW',
                          size: 10,
                          fontWeight: FontWeight.w700,
                          color: widget.product!.discountOffer != '' ? AppColors.redPrimary : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(),
                        color: AppColors.whiteTag,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            SmallText(
                              text: '${Helper.calculateAverageRating(widget.product!.Reviews) ?? 5.0}',
                              size: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.black87,
                              size: 9,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            const VerticalDivider(
                              width: 6,
                              indent: 2,
                              endIndent: 2,
                              color: AppColors.grey04,
                            ),
                            SmallText(
                              text: '(${widget.product!.Reviews?.length ?? 10})',
                              size: 10,
                              color: AppColors.black.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //   child: Chip(
                  //     visualDensity: const VisualDensity(
                  //         horizontal: VisualDensity.minimumDensity,
                  //         vertical: VisualDensity.minimumDensity),
                  //     label: SmallText(
                  //       text: product!.discountOffer != ''
                  //           ? '${product!.discountOffer!.substring(0, 3)}'
                  //           : 'NEW',
                  //       size: 8,
                  //       color: AppColors.white,
                  //     ),
                  //     backgroundColor: product!.discountOffer != ''
                  //         ? AppColors.redPrimary
                  //         : AppColors.black,
                  //     padding: EdgeInsets.zero,
                  //     shape: const RoundedRectangleBorder(),
                  //   ),
                  // ),
                  // Positioned(
                  //   right: 0,
                  //   bottom: 0,
                  //   child: ButtonIcon.twoState(
                  //     iconInActive: Icons.favorite_outline,
                  //     iconActivated: Icons.favorite,
                  //   ),
                  // ),
                ],
              ),
              Row(
                children: [
                  widget.product!.discountOffer != ''
                      ? Row(
                          children: [
                            Text(
                              '${widget.product!.originalPrice}\$',
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationColor: AppColors.grey,
                                  decorationThickness: 5,
                                  color: AppColors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            BigText(
                              text: '${widget.product!.discountPrice}\$',
                              size: 14,
                              color: AppColors.redPrimary,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            BigText(
                              text: '${widget.product!.originalPrice}\$',
                              size: 14,
                              color: AppColors.redPrimary,
                            ),
                          ],
                        ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      isSelected = !isSelected;
                      if (isSelected) {
                        context.read<SavedStorageBloc>().add(SavedStorageAddItemEvent(product: widget.product!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: AppColors.green,
                            content: Text('Saved Item'),
                          ),
                        );
                      } else {
                        context
                            .read<SavedStorageBloc>()
                            .add(SavedStorageRemoveItemEvent(productID: widget.product!.id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: AppColors.red,
                            content: Text('Removed Item'),
                          ),
                        );
                      }
                    },
                    icon: isSelected
                        ? const Icon(
                            Icons.favorite_rounded,
                            color: AppColors.black,
                            size: 22,
                          )
                        : const Icon(
                            Icons.favorite_outline_rounded,
                            color: AppColors.black,
                            size: 22,
                          ),
                  ),
                ],
              ),
              Text(
                '${widget.product!.brand!.title}',
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 11,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              BigText(
                text: widget.product!.title.toString(),
                size: 14,
                overflow: TextOverflow.clip,
              ),
              const SizedBox(
                height: 3,
              ),
            ],
          ),
        );
      },
    );
  }
}
