import 'package:final_project/models/FinerCategory.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/cubit/product_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/home/components/product_card.dart';
import 'package:final_project/views/product/product_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:easy_localization/easy_localization.dart';

class CatalogView extends StatelessWidget {
  String? textSearch;
  String? productID;
  FinerCategory? finerCategory;
  CatalogView({super.key, this.productID, this.finerCategory, this.textSearch});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: BigText(
            // use for Capitalize Each Word '${finerCategory!.title!.split('-').map((e) => toBeginningOfSentenceCase(e)).join(' ')}'
            text: (productID != null)
                ? tr('SIMILAR ITEMS')
                : (finerCategory != null)
                    ? '${finerCategory!.title!.toUpperCase().split('-').join(' ')}'
                    : '${textSearch!.toUpperCase()}',

            size: 14,
          ),
          elevation: 0.5,
        ),
        body: BlocProvider(
          create: (context) {
            if (productID != null) {
              return ProductCubit()..getSimilarItemsOfProduct(productID!);
            }
            if (finerCategory != null) {
              return ProductCubit()..getProductsOfFiner(finerCategory!);
            }
            return ProductCubit()..getProductsOfSearch(textSearch!);
          },
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                return LazyLoadScrollView(
                  onEndOfPage: () {
                    if (productID != null) {
                      context
                          .read<ProductCubit>()
                          .getSimilarItemsOfProduct(productID!);
                    } else if (finerCategory != null) {
                      context
                          .read<ProductCubit>()
                          .getProductsOfFiner(finerCategory!);
                    } else {
                      context
                          .read<ProductCubit>()
                          .getProductsOfSearch(textSearch!);
                    }
                  },
                  scrollOffset: 20,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 13),
                            child: SmallText(
                              text: '${state.length} ${tr('items found')}',
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w100,
                              size: 10.5,
                            )),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: getProportionateScreenWidth(170) /
                                getProportionateScreenHeight(260),
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<BagBloc>(context),
                                      child: BlocProvider.value(
                                        value:
                                            BlocProvider.of<SavedStorageBloc>(
                                                context),
                                        child: ProductView(
                                            product: state.products[index]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: ProductCard(
                                isSelected:
                                    (BlocProvider.of<SavedStorageBloc>(context)
                                            .state) is SavedStorageLoadedState
                                        ? (BlocProvider.of<SavedStorageBloc>(
                                                            context)
                                                        .state
                                                    as SavedStorageLoadedState)
                                                .savedStorage
                                                .SavedStorageProducts!
                                                .indexWhere((element) =>
                                                    element.product!.id ==
                                                    state.products[index].id) >=
                                            0
                                        : false,
                                product: state.products[index],
                                imgHeight: getProportionateScreenHeight(184),
                                imgWidth: getProportionateScreenWidth(162),
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
          ),
        ));
  }
}
