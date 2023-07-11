import 'package:final_project/routers/args/checkout_args.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:final_project/views/bag/components/bag_body.dart';
import 'package:final_project/views/bag/components/bag_body_empty.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BagBloc, BagState>(
      builder: (context, state) {
        if (state is BagLoadedState) {
          print(state.bag.BagProducts);
          return Scaffold(
            backgroundColor: (state.bag.BagProducts != null && state.bag.BagProducts!.isNotEmpty)
                ? Colors.white
                : AppColors.whiteBackGround,
            appBar: AppBar(
              centerTitle: true,
              title: BigText(
                text: 'BAG',
                size: 14,
              ),
              actions: [
                Visibility(
                  visible: (state.bag.BagProducts != null && state.bag.BagProducts!.isNotEmpty),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ButtonIconText(
                      backgroundColor: AppColors.green,
                      text: 'CHECKOUT',
                      textSize: 12,
                      width: 96,
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_) => BlocProvider.value(
                        //           value: BlocProvider.of<BagBloc>(context),
                        //           child: BlocProvider.value(
                        //             value: BlocProvider.of<ShippingAddressBloc>(context),
                        //             child: CheckoutView(bag: state.bag),
                        //           ),
                        //         )));

                        Navigator.of(context).pushNamed('/checkout',
                            arguments: CheckoutArguments(BlocProvider.of<BagBloc>(context),
                                BlocProvider.of<ShippingAddressBloc>(context), state.bag));
                      },
                    ),
                  ),
                ),
                // Visibility(
                //   visible: (state.bag.BagProducts != null && state.bag.BagProducts!.isNotEmpty),
                //   child: Padding(
                //     padding: const EdgeInsets.all(12),
                //     child: ButtonIconText(
                //       backgroundColor: AppColors.green,
                //       text: 'CHECKOUT',
                //       textSize: 12,
                //       width: 102,
                //       onPressed: () {
                //         context.read<BagBloc>().add(BagCheckoutEvent());
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
            body: (state.bag.BagProducts != null && state.bag.BagProducts!.isNotEmpty)
                ? const BagBody()
                : const BagBodyEmpty(),
          );
        } else if (state is BagErrorState) {
          return Center(
            child: Text(state.exception.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
