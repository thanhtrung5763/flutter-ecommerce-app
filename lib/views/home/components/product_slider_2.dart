import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/cubit/product_cubit.dart';
import 'package:final_project/views/home/components/product_card.dart';
import 'package:final_project/views/product/product_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSlider2 extends StatelessWidget {
  final String title;
  final double size;
  final Color backgroundColor;
  const ProductSlider2(
      {super.key,
      required this.title,
      this.size = 16,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          if (state.products.isEmpty) {
            return Container();
          }
          return Container(
            color: backgroundColor,
            height: 340,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(left: 12, top: 12, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigText(
                    text: title,
                    size: size,
                  ),
                  SizedBox(
                    height: 285,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) => Padding(
                        padding: index != state.products.length - 1
                            ? const EdgeInsets.only(right: 12)
                            : EdgeInsets.zero,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<BagBloc>(context),
                                  child: BlocProvider.value(
                                    value: BlocProvider.of<SavedStorageBloc>(
                                        context),
                                    child: ProductView(
                                        product: state.products[index]),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 12),
                            child: ProductCard(
                              isSelected: (BlocProvider.of<SavedStorageBloc>(
                                          context)
                                      .state) is SavedStorageLoadedState
                                  ? (BlocProvider.of<SavedStorageBloc>(context)
                                              .state as SavedStorageLoadedState)
                                          .savedStorage
                                          .SavedStorageProducts!
                                          .indexWhere((element) =>
                                              element.product!.id ==
                                              state.products[index].id) >=
                                      0
                                  : false,
                              imgHeight: 164,
                              imgWidth: 128,
                              product: state.products[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProductError) {
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
