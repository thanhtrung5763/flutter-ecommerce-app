import 'package:final_project/colors.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class BagBody extends StatefulWidget {
  const BagBody({super.key});

  @override
  State<BagBody> createState() => _BagBodyState();
}

class _BagBodyState extends State<BagBody> {
  double totalAmount = 0;
  int totalItems = 0;
  void calculateTotalAmountAndItem(List<BagProduct> list) {
    double tempAmount = 0;
    int tempQuantity = 0;

    for (var element in list) {
      tempAmount += (element.product!.discountOffer == ''
          ? double.parse(element.product!.originalPrice!) * element.quantity!
          : double.parse(element.product!.discountPrice!) * element.quantity!);
      tempQuantity += (element.quantity!);
    }
    totalAmount = tempAmount;
    totalItems = tempQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BagBloc, BagState>(
      builder: (context, state) {
        if (state is BagLoadedState) {
          calculateTotalAmountAndItem(state.bag.BagProducts!);
          return Column(
            children: [
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallText(
                        text: '$totalItems ${tr('items: Total (excluding delivery) ')}'),
                    SmallText(
                      text: '${totalAmount.toStringAsFixed(2)}\$',
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 0.8,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.separated(
                    itemBuilder: (context, index) => ListItem(
                      index: index,
                      bagProduct: state.bag.BagProducts![index],
                    ),
                    itemCount: state.bag.BagProducts!.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final int index;
  final BagProduct bagProduct;
  const ListItem({super.key, required this.bagProduct, required this.index});

  @override
  Widget build(BuildContext context) {
    String? value = bagProduct.quantity.toString();
    String? _selectedSize = bagProduct.size;
    return Container(
      height: 130,
      margin: const EdgeInsets.only(top: 12, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 110, //148
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      bagProduct.product!.images!.split('|').first)),
            ),
          ),
          Expanded(
            child: Container(
              height: 120,
              margin: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bagProduct.product!.discountOffer != ''
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${bagProduct.product!.originalPrice}\$',
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decorationColor: AppColors.grey,
                                      decorationThickness: 5,
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                BigText(
                                  text:
                                      '${bagProduct.product!.discountPrice}\$',
                                  size: 14,
                                  color: AppColors.redPrimary,
                                ),
                              ],
                            )
                          : BigText(
                              text: '${bagProduct.product!.originalPrice}\$',
                              size: 14,
                              color: AppColors.redPrimary,
                            ),
                      GestureDetector(
                        onTap: () => context
                            .read<BagBloc>()
                            .add(BagRemoveItemEvent(index: index)),
                        child: Icon(
                          Icons.clear_rounded,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SmallText(
                    text: '${bagProduct.product!.brand?.title}',
                    size: 9,
                    color: AppColors.grey,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BigText(
                    text: '${bagProduct.product!.title}',
                    size: 13,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  const Spacer(),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonHideUnderline(
                          child: SizedBox(
                            width: 60,
                            child: DropdownButton(
                              isDense: true,
                              isExpanded: true,
                              menuMaxHeight: 150,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.black,
                                size: 20,
                              ),
                              value: _selectedSize,
                              items: bagProduct.product!.sizeOption!
                                  .split(',')
                                  .map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: BigText(
                                    text: item,
                                    size: 10,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? item) {
                                _selectedSize = item;
                                context.read<BagBloc>().add(
                                      BagItemSizeChangeEvent(
                                        index: index,
                                        size: _selectedSize!,
                                      ),
                                    );
                              },
                            ),
                          ),
                        ),
                        VerticalDivider(
                          width: 1,
                          color: Colors.grey[500],
                        ),
                        DropdownButtonHideUnderline(
                          child: SizedBox(
                            width: 60,
                            child: DropdownButton(
                              isDense: true,
                              isExpanded: true,
                              menuMaxHeight: 150,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.black,
                                size: 20,
                              ),
                              value: value,
                              items: List<String>.generate(
                                      10, (index) => (index + 1).toString())
                                  .map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: BigText(
                                    text: item,
                                    size: 10,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  if (newValue.compareTo(value) > 0) {
                                    context.read<BagBloc>().add(
                                          BagItemCountIncreaseEvent(
                                            index: index,
                                            quantity: int.parse(newValue),
                                          ),
                                        );
                                  } else if (newValue.compareTo(value) < 0) {
                                    context.read<BagBloc>().add(
                                          BagItemCountDecreaseEvent(
                                            index: index,
                                            quantity: int.parse(newValue),
                                          ),
                                        );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
