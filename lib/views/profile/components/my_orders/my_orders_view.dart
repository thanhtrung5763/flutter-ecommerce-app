import 'package:final_project/colors.dart';
import 'package:final_project/models/BagProduct.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/views/profile/components/my_orders/components/rating_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

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
          title: BigText(
            text: tr('MY ORDERS'),
            size: 14,
          ),
          elevation: 0.5,
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
                        return Order(
                            order: state.orders[index],
                            status: orderStatus[state.orders[index].bagStatus]);
                      },
                      separatorBuilder: (context, index) => Container(
                        height: 7,
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
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
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: '${tr("Order")}: ${widget.order.id.toString().split('-').last}',
                size: 14 * 0.8,
              ),
              SmallText(
                text: tr('${widget.status}'),
                color: Colors.green,
                size: 14 * 0.7,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 130.0 * 0.7 * widget.order.BagProducts!.length,
            child: ListView.separated(
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
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmallText(
                text: '${tr("Total Amount")}($totalItems ${tr("items")}): ',
                size: 14 * 0.8,
              ),
              BigText(
                text: '$totalAmount\$',
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
  const ListItem(
      {super.key,
      required this.bagProduct,
      required this.index,
      required this.status});

  @override
  Widget build(BuildContext context) {
    String? value = bagProduct.quantity.toString();
    return Column(
      children: [
        Container(
          height: 130 * 0.55,
          margin: const EdgeInsets.only(top: 12, bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120 * 0.55,
                width: 110 * 0.55, //148
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          bagProduct.product!.images!.split('|').first)),
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
                        size: 9 * 0.7,
                        color: AppColors.grey,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BigText(
                        text: '${bagProduct.product!.title}',
                        size: 13 * 0.7,
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
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
                                      text:
                                          '${bagProduct.product!.discountPrice}\$',
                                      size: 14 * 0.7,
                                      color: AppColors.redPrimary,
                                    ),
                                  ],
                                )
                              : BigText(
                                  text:
                                      '${bagProduct.product!.originalPrice}\$',
                                  size: 14 * 0.7,
                                  color: AppColors.redPrimary,
                                ),
                          Spacer(),
                          BigText(
                            text: '${tr("Size")}: ${bagProduct.size}',
                            size: 14 * 0.7,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                VerticalDivider(
                                  width: 1,
                                  color: Colors.grey[500],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                BigText(
                                  text: '${tr("Quantity")}: ${bagProduct.quantity}',
                                  size: 14 * 0.7,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Visibility(
                          visible: status == 'Approved' &&
                              bagProduct.isRated! == false,
                          child: OutlinedButtonIconText(
                            text: SmallText(
                              text: tr('Review'),
                              size: 14 * 0.7,
                            ),
                            borderWidth: 0.5,
                            width: 75,
                            height: 20,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<BagBloc>(context),
                                      child:
                                          RatingView(bagProduct: bagProduct))));
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
