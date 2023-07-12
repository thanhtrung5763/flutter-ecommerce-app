import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/views/profile/components/my_orders/components/rating_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  Map<BagStatus, String> orderStatus = {
    BagStatus.PROCESSING: 'Processing',
    BagStatus.APPROVED: 'Approved',
    BagStatus.REJECTED: 'Rejected',
  };
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BagBloc()..add(BagListOrdersEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: 'MY ORDERS',
            size: 14,
          ),
        ),
        body: BlocBuilder<BagBloc, BagState>(
          builder: (context, state) {
            if (state is BagListOrdersLoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return Order(order: state.orders[index], status: orderStatus[state.orders[index].bagStatus]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 7,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class Order extends StatefulWidget {
  final order;
  final status;
  const Order({
    Key? key,
    this.order,
    this.status,
  }) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
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
    calculateTotalAmountAndItem(widget.order.BagProducts);
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: '${"Order"}: ${widget.order.id.toString().split('-').last}',
                size: 14 * 0.8,
              ),
              SmallText(
                text: '${widget.status}',
                color: Colors.green,
                size: 14 * 0.7,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Flexible(
            // height: 150.0 * 0.7 * widget.order.BagProducts!.length,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index2) => ListItem(
                status: widget.status,
                index: index2,
                bagProduct: widget.order.BagProducts![index2],
              ),
              itemCount: widget.order.BagProducts!.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmallText(
                text: '${"Total Amount"}($totalItems ${"items"}): ',
                size: 14 * 0.8,
              ),
              BigText(
                text: '${totalAmount.toStringAsFixed(2)}\$',
                size: 14 * 0.8,
              )
            ],
          )
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String status;
  final int index;
  final BagProduct bagProduct;
  const ListItem({super.key, required this.bagProduct, required this.index, required this.status});

  @override
  Widget build(BuildContext context) {
    String? value = bagProduct.quantity.toString();
    return Column(
      children: [
        Container(
          height: 170 * 0.55,
          margin: const EdgeInsets.only(top: 12, bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150 * 0.55,
                width: 110 * 0.55, //148
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(bagProduct.product!.images!.split('|').first)),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallText(
                        text: '${bagProduct.product!.brand?.title}',
                        size: 12 * 0.7,
                        color: AppColors.grey,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BigText(
                        text: '${bagProduct.product!.title}',
                        size: 16 * 0.7,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          bagProduct.product!.discountOffer != ''
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${bagProduct.product!.originalPrice}\$',
                                      style: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          decorationStyle: TextDecorationStyle.solid,
                                          decorationColor: AppColors.grey,
                                          decorationThickness: 5,
                                          color: AppColors.grey,
                                          fontSize: 12 * 0.7,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    BigText(
                                      text: '${bagProduct.product!.discountPrice}\$',
                                      size: 16 * 0.7,
                                      color: AppColors.redPrimary,
                                    ),
                                  ],
                                )
                              : BigText(
                                  text: '${bagProduct.product!.originalPrice}\$',
                                  size: 16 * 0.7,
                                  color: AppColors.redPrimary,
                                ),
                          const Spacer(),
                          BigText(
                            text: '${"Size"}: ${bagProduct.size}',
                            size: 14 * 0.7,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                VerticalDivider(
                                  width: 1,
                                  color: Colors.grey[500],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                BigText(
                                  text: '${"Quantity"}: ${bagProduct.quantity}',
                                  size: 14 * 0.7,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Visibility(
                          visible: status == 'Approved' && bagProduct.isRated! == false,
                          child: OutlinedButtonIconText(
                            text: 'Review',
                            textSize: AppSizes.kTextSizeTiny,
                            borderWidth: 0.5,
                            colorBorderSide: AppColors.black,
                            width: 75,
                            height: 20,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<BagBloc>(context),
                                      child: RatingView(bagProduct: bagProduct))));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
