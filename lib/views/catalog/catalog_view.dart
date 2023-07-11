import 'package:final_project/utils/colors.dart';
import 'package:final_project/models/Brand.dart';
import 'package:final_project/models/FinerCategory.dart';
import 'package:final_project/models/Product.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/cubit/product/product_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/widgets/show_errow_dialog.dart';
import 'package:final_project/views/catalog/test_gender_view.dart';
import 'package:final_project/views/home/components/product_card.dart';
import 'package:final_project/views/product/product_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:page_transition/page_transition.dart';

class CatalogView extends StatefulWidget {
  String? title;
  String? textSearch;
  String? productID;
  FinerCategory? finerCategory;
  Brand? brand;
  CatalogView({super.key, this.productID, this.finerCategory, this.textSearch, this.title, this.brand});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  List<String> sortOptions = ['Recommended', 'Price: High to Low', 'Price: Low to High', "What's New"];
  List<String> filterOptions = [
    "Sale / New Season",
    "Gender",
    "Product Type",
    "Brand",
    "Color",
    "Body Fit",
    "Size",
    "Discount %",
    "Price"
  ];
  String selectedSizeOption = 'Recommended';
  @override
  Widget build(BuildContext context) {
    List<String> sortOption = ['Price: High to Low', 'Price: Low to High'];
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            // use for Capitalize Each Word '${finerCategory!.title!.split('-').map((e) => toBeginningOfSentenceCase(e)).join(' ')}'
            text: (widget.productID != null)
                ? 'SIMILAR ITEMS'
                : (widget.finerCategory != null)
                  ? widget.finerCategory!.title!.toUpperCase().split('-').join(' ')
                  : (widget.textSearch != null)
                      ? widget.textSearch!.toUpperCase()
                      : (widget.title != null)
                        ? widget.title!.toUpperCase()
                        : (widget.brand != null)
                          ? widget.brand!.title!.toUpperCase()
                          : "NAH",

            size: 14,
          ),
        ),
        body: BlocProvider(
          create: (context) {
            if (widget.productID != null) {
              return ProductCubit()..getSimilarItemsOfProduct(widget.productID!);
            }
            if (widget.finerCategory != null) {
              return ProductCubit()..getProductsOfFiner(widget.finerCategory!);
            }
            if (widget.textSearch != null) {
              return ProductCubit()..getProductsOfSearch(widget.textSearch!);
            }
            if (widget.title != null) {
              if (widget.title == 'Sale') {
                return ProductCubit()..getSaleProducts();
              }
              if (widget.title == 'New') {
                return ProductCubit()..getNewProducts();
              }
            }
            if (widget.brand != null) {
              return ProductCubit()..getProductsOfBrand(widget.brand!);
            }
            return ProductCubit()..getSaleProducts();
          },
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                List<Product> products = [...state.products];
                if (selectedSizeOption == 'Price: High to Low') {
                  products = products
                    ..sort(((a, b) {
                      var bo = double.tryParse(b.originalPrice!);
                      var bd = double.tryParse(b.discountPrice!);
                      var ao = double.tryParse(a.originalPrice!);
                      var ad = double.tryParse(a.discountPrice!);

                      if (bd != null && ad != null) {
                        return bd.compareTo(ad);
                      } else if (bd != null && ad == null) {
                        return bd.compareTo(ao!);
                      } else if (bd == null && ad != null) {
                        return bo!.compareTo(ad);
                      }
                      return bo!.compareTo(ao!);
                    }));
                } else if (selectedSizeOption == 'Price: Low to High') {
                  products = products
                    ..sort(((a, b) {
                      var bo = double.tryParse(b.originalPrice!);
                      var bd = double.tryParse(b.discountPrice!);
                      var ao = double.tryParse(a.originalPrice!);
                      var ad = double.tryParse(a.discountPrice!);

                      if (ad != null && bd != null) {
                        return ad.compareTo(bd);
                      } else if (ad != null && bd == null) {
                        return ad.compareTo(bo!);
                      } else if (ad == null && bd != null) {
                        return ao!.compareTo(bd);
                      }
                      return ao!.compareTo(ao);
                    }));
                } else if (selectedSizeOption == 'Recommended') {
                  products = state.products;
                }
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 6),
                      height: 18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) => MyDialog(
                                      sortOptions: sortOptions,
                                      selectedSortOption: selectedSizeOption,
                                      onSelectedSortOptionChanged: (value) {
                                        setState(() {
                                          selectedSizeOption = value;
                                        });
                                        print(selectedSizeOption);
                                      },
                                    )),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BigText(
                                  text: 'SORT',
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 20,
                                )
                              ],
                            ),
                          ),

                          // DropdownButtonHideUnderline(
                          //   child: SizedBox(
                          //     width: 60,
                          //     child: DropdownButton(
                          //       isDense: true,
                          //       isExpanded: true,
                          //       menuMaxHeight: 150,
                          //       icon: const Icon(
                          //         Icons.keyboard_arrow_down_rounded,
                          //         color: AppColors.black,
                          //         size: 20,
                          //       ),
                          //       hint: BigText(
                          //         text: 'SORT',
                          //         size: 12,
                          //       ),
                          //       items: sortOption.map((String item) {
                          //         return DropdownMenuItem(
                          //           value: item,
                          //           child: BigText(
                          //             text: item,
                          //             size: 10,
                          //           ),
                          //         );
                          //       }).toList(),
                          //       onChanged: (String? selectedSize) {},
                          //     ),
                          //   ),
                          // ),
                          // const VerticalDivider(
                          //   color: AppColors.grey,
                          // ),
                          Container(
                            color: AppColors.grey.withOpacity(0.5),
                            width: 0.5,
                            margin: const EdgeInsets.only(right: 18),
                          ),
                          InkWell(
                            onTap: () => showModalBottomSheet(
                                useSafeArea: true,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height * 1,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 24),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () => Navigator.of(context).pop(),
                                                    child: const Icon(Icons.clear)),
                                                BigText(
                                                  text: "FILTER",
                                                  size: 14,
                                                ),
                                                const Icon(
                                                  Icons.clear,
                                                  color: Colors.transparent,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 10,
                                            color: AppColors.grey.withOpacity(0.25),
                                          ),
                                          Expanded(
                                            child: ListView.separated(
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (filterOptions[index] == 'Gender') {
                                                        Navigator.of(context).push(
                                                          PageTransition(
                                                            type: PageTransitionType.rightToLeft,
                                                            child: const MyTestGenderView(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: ListTile(
                                                      dense: true,
                                                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                                      title: SmallText(
                                                        text: filterOptions[index],
                                                        size: 13,
                                                      ),
                                                      trailing: SmallText(
                                                        text: 'All',
                                                        size: 13,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder: (context, index) {
                                                  return const Divider(
                                                    height: 1,
                                                    indent: 16,
                                                  );
                                                },
                                                itemCount: 9),
                                          ),
                                          ButtonIconText(
                                            onPressed: () {},
                                            text: 'VIEW ITEMS',
                                            backgroundColor: AppColors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            child: BigText(
                              text: 'FILTER',
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Expanded(
                      child: LazyLoadScrollView(
                        onEndOfPage: () {
                          if (widget.productID != null) {
                            context.read<ProductCubit>().getSimilarItemsOfProduct(widget.productID!);
                          } else if (widget.finerCategory != null) {
                            context.read<ProductCubit>().getProductsOfFiner(widget.finerCategory!);
                          } else if (widget.textSearch != null) {
                            context.read<ProductCubit>().getProductsOfSearch(widget.textSearch!);
                          } else if (widget.title != null) {
                            if (widget.title == "Sale") {
                              context.read<ProductCubit>().getSaleProducts();
                            } else if (widget.title == "New") {
                              context.read<ProductCubit>().getNewProducts();
                            }
                          } else if (widget.brand != null) {
                            context.read<ProductCubit>().getProductsOfBrand(widget.brand!);
                          } else {
                            context.read<ProductCubit>().getNewProducts();
                          }
                        },
                        scrollOffset: 20,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Container(
                              //     margin: const EdgeInsets.symmetric(vertical: 13),
                              //     child: SmallText(
                              //       text: '${state.length} ${'items found'}',
                              //       color: Colors.grey[700],
                              //       fontWeight: FontWeight.w100,
                              //       size: 10.5,
                              //     )),
                              const SizedBox(
                                height: 16,
                              ),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      getProportionateScreenWidth(170) / getProportionateScreenHeight(260),
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(left: 12, right: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<BagBloc>(context),
                                            child: BlocProvider.value(
                                              value: BlocProvider.of<SavedStorageBloc>(context),
                                              child: ProductView(product: products[index]),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ProductCard(
                                      isSelected: (BlocProvider.of<SavedStorageBloc>(context).state)
                                              is SavedStorageLoadedState
                                          ? (BlocProvider.of<SavedStorageBloc>(context).state
                                                      as SavedStorageLoadedState)
                                                  .savedStorage
                                                  .SavedStorageProducts!
                                                  .indexWhere((element) => element.product!.id == products[index].id) >=
                                              0
                                          : false,
                                      product: products[index],
                                      imgHeight: getProportionateScreenHeight(184),
                                      imgWidth: getProportionateScreenWidth(162),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
