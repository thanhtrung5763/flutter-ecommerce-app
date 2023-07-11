import 'package:final_project/utils/colors.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/bloc/tracking_bloc.dart';
import 'package:final_project/services/cloud/cubit/product/product_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/catalog/catalog_view.dart';
import 'package:final_project/views/home/components/product_card.dart';
import 'package:final_project/views/product/product_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSlider extends StatelessWidget {
  // final List<Product> products;
  final String title;
  double size;
  String? subTitle;
  ProductSlider({
    super.key,
    required this.title,
    this.size = 20,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  subTitle != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: title,
                              size: size,
                            ),
                            SmallText(
                              text: subTitle!,
                              color: AppColors.grey,
                            )
                          ],
                        )
                      : BigText(
                          text: title,
                          size: size,
                        ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              // builder: (_) => CatalogView(
                              //   productID: product.id,
                              // ),
                              builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<SavedStorageBloc>(context),
                                    child: CatalogView(
                                      title: title,
                                    ),
                                  )),
                        );
                      },
                      child: SmallText(text: 'View all')),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(300),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: index != state.products.length - 1 ? const EdgeInsets.only(right: 12) : EdgeInsets.zero,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<TrackingBloc>(context)
                            .add(TrackingProductPressedEvent(productID: state.products[index].id));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<BagBloc>(context),
                              child: BlocProvider.value(
                                value: BlocProvider.of<SavedStorageBloc>(context),
                                child: ProductView(product: state.products[index]),
                              ),
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        product: state.products[index],
                        isSelected: (BlocProvider.of<SavedStorageBloc>(context).state) is SavedStorageLoadedState
                            ? (BlocProvider.of<SavedStorageBloc>(context).state as SavedStorageLoadedState)
                                    .savedStorage
                                    .SavedStorageProducts!
                                    .indexWhere((element) => element.product!.id == state.products[index].id) >=
                                0
                            : false,
                        imgHeight: 184,
                        imgWidth: 148,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is ProductError) {
          return Center(
            child: Text(state.exception.toString()),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
