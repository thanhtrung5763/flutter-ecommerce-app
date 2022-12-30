import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/colors.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/views/bag/components/bag_body.dart';
import 'package:final_project/views/bag/components/bag_body_empty.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            backgroundColor: (state.bag.BagProducts != null &&
                    state.bag.BagProducts!.isNotEmpty)
                ? AppColors.whiteBackGround
                : Colors.grey[200],
            appBar: AppBar(
              title: BigText(
                text: tr('BAG'),
                size: 14,
              ),
              elevation: 0.5,
              actions: [
                Visibility(
                  visible: (state.bag.BagProducts != null &&
                      state.bag.BagProducts!.isNotEmpty),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ButtonIconText(
                      backgroundColor: AppColors.green,
                      text: tr('CHECKOUT'),
                      textSize: 12,
                      width: 102,
                      onPressed: () {
                        context.read<BagBloc>().add(BagCheckoutEvent());
                      },
                    ),
                  ),
                )
              ],
            ),
            body: (state.bag.BagProducts != null &&
                    state.bag.BagProducts!.isNotEmpty)
                ? BagBody()
                : BagBodyEmpty(),
          );
        } else if (state is BagErrorState) {
          return Center(
            child: Text(state.exception.toString()),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
