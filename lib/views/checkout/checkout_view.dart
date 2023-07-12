import 'package:final_project/models/Bag.dart';
import 'package:final_project/models/BagProduct.dart';
import 'package:final_project/models/ShippingAddress.dart';
import 'package:final_project/models/User.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:final_project/services/repo/stripe_repository.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/views/checkout/components/checkout_success_view.dart';
import 'package:final_project/views/shipping_address/components/add_edit_shipping_address_view.dart';
import 'package:final_project/views/shipping_address/shipping_address_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/horizontal_or_line.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutView extends StatefulWidget {
  final Bag bag;
  const CheckoutView({super.key, required this.bag});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final TextEditingController _controller = TextEditingController();
  ShippingAddress? _defaultShippingAddress;
  ShippingAddress? _selectedShippingAddress;
  Map<String, dynamic>? paymentIntent;

  double totalAmount = 0;
  int totalItems = 0;
  void calculateTotalAmountAndItem(List<BagProduct> bagProducts) {
    double tempAmount = 0;
    int tempQuantity = 0;

    for (var element in bagProducts) {
      tempAmount += (element.product!.discountOffer == ''
          ? double.parse(element.product!.originalPrice!) * element.quantity!
          : double.parse(element.product!.discountPrice!) * element.quantity!);
      tempQuantity += (element.quantity!);
    }
    totalAmount = tempAmount;
    totalItems = tempQuantity;
  }

  void _onSelected(ShippingAddress shippingAddress) {
    print("Call _onSelected");
    setState(() {
      _selectedShippingAddress = shippingAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ShippingAddressBloc>().repository;
    context.read<ShippingAddressBloc>().add(ShippingAddressInitializeEvent());
    print('Current user: ${repository.currentUser.email}');
    print(widget.bag.BagProducts);
    calculateTotalAmountAndItem(widget.bag.BagProducts!);
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      builder: (context, state) {
        if (state is ShippingAddressLoadedState) {
          print('Shipping Addresses: ${state.shippingAddresses}');
          if (state.shippingAddresses.isEmpty) {
            _defaultShippingAddress = null;
          } else {
            _defaultShippingAddress = state.shippingAddresses
                .firstWhere((element) => element.id == repository.currentUser.defaultShippingAddressID);
            print(_defaultShippingAddress?.name);
          }
          if (_selectedShippingAddress != null) {
            _defaultShippingAddress = _selectedShippingAddress;
          }
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: BigText(
                  text: 'CHECKOUT',
                  size: 14,
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(top: 10.h),
                      //   padding: EdgeInsets.symmetric(horizontal: 8.w),
                      //   height: 52.h,
                      //   color: Colors.white,
                      //   child: Row(children: [
                      //     BigText(
                      //       text: 'DELIVER TO: ',
                      //       size: 14.h,
                      //     ),
                      //     Image.asset(
                      //       'assets/images/vietnam_flag.png',
                      //       fit: BoxFit.cover,
                      //       width: 16,
                      //       height: 16,
                      //     ),
                      //     const SizedBox(
                      //       width: 4,
                      //     ),
                      //     SmallText(
                      //       text: 'Vietnam',
                      //     ),
                      //     const Spacer(),
                      //     const Icon(Icons.keyboard_arrow_right)
                      //   ]),
                      // ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                        height: (52 * 2.5).h,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: 'MY BAG',
                                  size: 14.h,
                                ),
                                SmallText(
                                  text: 'View',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Expanded(
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: 120 * 0.55,
                                          width: 110 * 0.55, //148
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    widget.bag.BagProducts![index].product!.images!.split('|').first)),
                                          ),
                                        ),
                                        Visibility(
                                          visible: widget.bag.BagProducts![index].quantity != 1,
                                          child: Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              color: Colors.white.withOpacity(0.9),
                                              child: SmallText(
                                                text: 'x${widget.bag.BagProducts![index].quantity}',
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: widget.bag.BagProducts![index].size != null,
                                          child: Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              color: Colors.white.withOpacity(0.9),
                                              child: SmallText(
                                                text: '${widget.bag.BagProducts![index].size}',
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) => const SizedBox(
                                        width: 6,
                                      ),
                                  itemCount: widget.bag.BagProducts!.length),
                            ),
                            // Row(
                            //   children: [
                            //     // Container(
                            //     //   height: 60,
                            //     //   width: 50,
                            //     //   color: AppColors.grey,
                            //     // ),
                            //     Container(
                            //       height: 120 * 0.55,
                            //       width: 110 * 0.55, //148
                            //       decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //             fit: BoxFit.fill,
                            //             image:
                            //                 NetworkImage(widget.bag.BagProducts![0].product!.images!.split('|').first)),
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 4,
                            //     ),
                            //     Stack(
                            //       children: [
                            //         Container(
                            //           height: 120 * 0.55,
                            //           width: 110 * 0.55, //148
                            //           decoration: BoxDecoration(
                            //             image: DecorationImage(
                            //                 fit: BoxFit.fill,
                            //                 image: NetworkImage(
                            //                     widget.bag.BagProducts![1].product!.images!.split('|').first)),
                            //           ),
                            //         ),
                            //         Positioned(
                            //           right: 0,
                            //           top: 0,
                            //           child: Container(
                            //             color: Colors.white,
                            //             child: SmallText(text: 'x${widget.bag.BagProducts![1].quantity}'),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //     const SizedBox(
                            //       width: 4,
                            //     ),
                            //     Container(
                            //       height: 60,
                            //       width: 50,
                            //       color: AppColors.grey,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: 'DELIVERY ADDRESS',
                                  size: 14.h,
                                ),
                                // SmallText(
                                //   text: 'Change',
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            // Row(
                            //   children: [
                            //     const Icon(Icons.place),
                            //     BigText(
                            //       text: 'Ninh Pham Trung Thanh | 0986602759',
                            //       size: 12.h,
                            //     ),
                            //     const Spacer(),
                            //     Material(
                            //       child: InkWell(
                            //         onTap: () {},
                            //         child: Container(
                            //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            //           color: AppColors.grey.withOpacity(0.2),
                            //           child: GestureDetector(
                            //             onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            //                 builder: (_) => BlocProvider.value(
                            //                       value: BlocProvider.of<ShippingAddressBloc>(context),
                            //                       child: const ShippingAddressView(),
                            //                     ))),
                            //             child: SmallText(
                            //               text: 'CHANGE',
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<ShippingAddressBloc>(context),
                                        child: ShippingAddressView(
                                          onSelected: _onSelected,
                                          shippingAddresses: state.shippingAddresses,
                                        ),
                                      ))),
                              child: _defaultShippingAddress != null
                                  ? Material(
                                      color: Colors.transparent,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.place),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // SmallText(text: '${_defaultShippingAddress.name} | ${_defaultShippingAddress.phone}'),
                                                // SmallText(text: '${_defaultShippingAddress.street}'),
                                                // SmallText(
                                                //     text:
                                                //         '${_defaultShippingAddress.ward}, ${_defaultShippingAddress.district}, ${_defaultShippingAddress.province}'),

                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //     SmallText(
                                                //       text: 'Ninh Pham Trung Thanh | 0986602759',
                                                //       fontWeight: FontWeight.bold,
                                                //     ),
                                                //     const Icon(Icons.keyboard_arrow_right)
                                                //   ],
                                                // ),
                                                // SmallText(text: '19/24 Khu Pho 2'),
                                                // SmallText(text: 'Phường Long Bình, Thành phố Biên Hoà, Tỉnh Đồng Naiiiiiiii'),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SmallText(
                                                      text:
                                                          '${_defaultShippingAddress?.name} | ${_defaultShippingAddress?.phone}',
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    ConstrainedBox(
                                                      constraints: const BoxConstraints(maxWidth: 20, maxHeight: 20),
                                                      child: const Icon(
                                                        Icons.keyboard_arrow_right,
                                                      ),
                                                    )
                                                    // Material(
                                                    //   child: InkWell(
                                                    //     child: Container(
                                                    //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                    //       color: AppColors.grey.withOpacity(0.2),
                                                    //       child: SmallText(
                                                    //         text: 'CHANGE',
                                                    //         fontWeight: FontWeight.bold,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                                SmallText(text: '${_defaultShippingAddress?.street}'),
                                                SmallText(
                                                    text:
                                                        '${_defaultShippingAddress?.ward}, ${_defaultShippingAddress?.district}, ${_defaultShippingAddress?.province}'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : OutlinedButtonIconText(
                                      text: 'ADD ADDRESS',
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                                  value: BlocProvider.of<ShippingAddressBloc>(context),
                                                  child: AddEditShippingAddressView(),
                                                )));
                                      },
                                      icon: Icons.add,
                                    ),
                            ),

                            // Flexible(
                            //   child: Container(
                            //     padding: const EdgeInsets.all(12),
                            //     decoration: BoxDecoration(
                            //         color: Colors.transparent,
                            //         border: Border.all(color: AppColors.grey.withOpacity(0.3), width: 2.2)),
                            //     child: ListView(
                            //       children: [
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             SmallText(
                            //               text: 'Name:',
                            //
                            //             ),
                            //             SmallText(
                            //               text: 'Trung Thành',
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ],
                            //         ),
                            //         const SizedBox(
                            //           height: 1,
                            //         ),
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             SmallText(
                            //               text: 'Apartment No:',
                            //
                            //             ),
                            //             SmallText(
                            //               text: '19/24',
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ],
                            //         ),
                            //         const SizedBox(
                            //           height: 1,
                            //         ),
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             SmallText(
                            //               text: 'Quarter:',
                            //
                            //             ),
                            //             SmallText(
                            //               text: 'Khu Phố 2',
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ],
                            //         ),
                            //         const SizedBox(
                            //           height: 1,
                            //         ),
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             SmallText(
                            //               text: 'Ward:',
                            //
                            //             ),
                            //             SmallText(
                            //               text: 'Long Bình',
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ],
                            //         ),
                            //         const SizedBox(
                            //           height: 1,
                            //         ),
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             SmallText(
                            //               text: 'City(Province):',
                            //
                            //             ),
                            //             SmallText(
                            //               text: 'Biên Hoà, Đồng Nai',
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ],
                            //         ),
                            //         const SizedBox(
                            //           height: 1,
                            //         ),
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             SmallText(
                            //               text: 'Postal Code:',
                            //
                            //             ),
                            //             SmallText(
                            //               text: '73000',
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ],
                            //         ),
                            //         const SizedBox(
                            //           height: 1,
                            //         ),
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             SmallText(
                            //               text: 'Country:',
                            //
                            //             ),
                            //             SmallText(
                            //               text: 'Vietnam',
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ],
                            //         ),
                            //         const SizedBox(
                            //           height: 1,
                            //         ),
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             SmallText(
                            //               text: 'Phone No:',
                            //
                            //             ),
                            //             SmallText(
                            //               text: '098 660 27 59',
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                        height: (52 * 3.5).h,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: 'PAYMENT',
                                  size: 14.h,
                                ),
                              ],
                            ),
                            const Spacer(),
                            OutlinedButtonIconText(
                              text: 'COD',
                              onPressed: () {},
                              shape: const RoundedRectangleBorder(),
                            ),
                            // Container(
                            //     margin: const EdgeInsets.symmetric(vertical: 8),
                            //     child: SmallText(
                            //       text: 'OR',
                            //       fontWeight: FontWeight.bold,
                            //     )),
                            const HorizontalOrLine(label: 'OR', height: 36),
                            OutlinedButtonIconText(
                              text: 'CREDIT/DEBIT CARD',
                              onPressed: () async {
                                await makePayment(
                                    currentUser: repository.currentUser,
                                    stripeCustomerID: repository.currentUser.stripeCustomerID ?? 'cus_O2CTsOWgwaON9p',
                                    amount: (totalAmount + 5.00).toStringAsFixed(2));
                              },
                              shape: const RoundedRectangleBorder(),
                              icon: Icons.credit_card_sharp,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: 'ADD A PROMO CODE',
                                  size: 14.h,
                                ),
                              ],
                            ),
                            TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(top: 12, bottom: 8),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.black),
                                ),
                              ),
                              style: const TextStyle(fontSize: 14.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10.h,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: 'ORDER SUMMARY',
                                  size: 14.h,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                  text: 'Sub-total:',
                                ),
                                SmallText(
                                  size: 14,
                                  text: '\$${totalAmount.toStringAsFixed(2)}',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                  text: 'Delivery:',
                                ),
                                SmallText(
                                  size: 14,
                                  text: '\$5.00',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                  text: 'Total to pay:',
                                  size: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                SmallText(
                                  size: 15,
                                  text: '\$${(totalAmount + 5.00).toStringAsFixed(2)}',
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonIconText(
                              text: 'BUY NOW',
                              height: AppSizes.kHeightLarge,
                              textSize: AppSizes.kTextSizeLarge,
                              onPressed: () async {
                                await confirmPayment();
                              },
                              width: 400,
                              backgroundColor: AppColors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> makePayment(
      {required User currentUser, required String stripeCustomerID, required String amount}) async {
    try {
      // const stripeCustomerID = 'cus_O2CTsOWgwaON9p';
      print('ainoway: $stripeCustomerID');
      final paymentIntent = await StripeRepository.instance
          .createPaymentIntent(customerID: stripeCustomerID, amount: amount, currency: 'USD');
      final ephemeralKey = await StripeRepository.instance.createEphemeralKey(customerID: stripeCustomerID);
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            customFlow: true,
            paymentIntentClientSecret: paymentIntent,
            customerEphemeralKeySecret: ephemeralKey,
            customerId: stripeCustomerID,
            // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
            // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
            style: ThemeMode.light,
            merchantDisplayName: currentUser.username,
            appearance: const PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(
                primary: AppColors.black,
              ),
            ),
          ))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      // await Stripe.instance.presentPaymentSheet().then((value) {
      //   showDialog(
      //       context: context,
      //       builder: (_) => const AlertDialog(
      //             content: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 Row(
      //                   children: [
      //                     Icon(
      //                       Icons.check_circle,
      //                       color: Colors.green,
      //                     ),
      //                     Text("Payment Successfull"),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ));
      //   // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(milliseconds: 1500),content: Text("paid successfully")));

      //   paymentIntent = null;
      // }).onError((error, stackTrace) {
      //   print('Error is:--->$error $stackTrace');
      // });

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('Payment option selected'),
        ),
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: $e'),
          ),
        );
      }
    }
  }

  Future<void> confirmPayment() async {
    try {
      await Stripe.instance.confirmPaymentSheetPayment();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          backgroundColor: AppColors.green,
          content: Text('Payment succesfully completed'),
        ),
      );
      context.read<BagBloc>().add(BagCheckoutEvent());
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutSuccessView()));
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            backgroundColor: AppColors.red,
            content: Row(
              children: [
                Flexible(
                  child: Text(
                    'Payment Issue: ${e.error.localizedMessage}',
                  ),
                ),
              ],
            ),
          ),
        );
        // showDialog(
        //     context: context,
        //     builder: (_) => AlertDialog(
        //           actionsAlignment: MainAxisAlignment.center,
        //           actionsPadding: const EdgeInsets.all(12),
        //           actions: [
        //             ButtonIconText(
        //               text: 'OK',
        //               onPressed: () {
        //                 Navigator.of(context, rootNavigator: true).pop();
        //               },
        //               width: double.maxFinite,
        //               height: 40,
        //               textSize: 12,
        //             )
        //           ],
        //           titlePadding: const EdgeInsets.all(8),
        //           title: ConstrainedBox(
        //             constraints: const BoxConstraints(maxHeight: 48, maxWidth: 48),
        //             child: const Icon(
        //               Icons.cancel,
        //               size: 56,
        //               color: AppColors.red,
        //             ),
        //           ),
        //           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        //           shape: const RoundedRectangleBorder(),
        //           content: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Flexible(
        //                 child: SmallText(
        //                   text: '${e.error.localizedMessage}',
        //                   size: 14,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: $e'),
          ),
        );
      }
    }
  }
}
