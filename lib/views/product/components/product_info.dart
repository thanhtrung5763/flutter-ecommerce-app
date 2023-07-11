import 'package:final_project/utils/colors.dart';
import 'package:final_project/models/Product.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BigText(
                text: '${product.title}',
                size: 16,
                overflow: TextOverflow.clip,
                maxLines: 2,
              ),
            ),
            product.discountOffer != ''
                ? Row(
                    children: [
                      Text(
                        '${product.originalPrice}\$',
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: AppColors.grey,
                            decorationThickness: 5,
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      BigText(
                        text: '${product.discountPrice}\$',
                        size: 18,
                        color: AppColors.redPrimary,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      BigText(
                        text: '${product.originalPrice}\$',
                        size: 18,
                        color: AppColors.redPrimary,
                      ),
                    ],
                  ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SmallText(
          text: '${product.brand!.title}',
          size: 11,
          color: AppColors.grey,
        ),
        const SizedBox(
          height: 8,
        ),
        // Row(
        //   children: [
            // Wrap(
            //   children: List.generate(
            //     5,
            //     (index) => Icon(
            //       Icons.star,
            //       color: AppColors.black,
            //       size: 14,
            //     ),
            //   ),
            // ),
        //     const SizedBox(
        //       width: 5,
        //     ),
        //     SmallText(
        //       text: '(10)',
        //       color: AppColors.grey,
        //     )
        //   ],
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        SmallText(
          text: '${product.description}',
          size: 14,
          fontWeight: FontWeight.w300,
        ),
      ],
    );
  }
}
