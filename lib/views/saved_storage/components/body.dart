import 'package:final_project/models/Product.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage/saved_storage_bloc.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/views/catalog/catalog_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedStorageBloc, SavedStorageState>(
      builder: (context, state) {
        if (state is SavedStorageLoadedState) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                color: Colors.grey.withOpacity(0.25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(text: '${state.savedStorage.SavedStorageProducts!.length} ${'items'}'),
                    // DropdownButtonHideUnderline(
                    //   child: DropdownButton(
                    //     isDense: true,
                    //     menuMaxHeight: 150,
                    //     icon: const Icon(
                    //       Icons.keyboard_arrow_down_rounded,
                    //       color: AppColors.black,
                    //       size: 18,
                    //     ),
                    //     hint: SmallText(
                    //       text: 'Recently added',
                    //     ),
                    //     items: Constants.lDropDown.map((String items) {
                    //       return DropdownMenuItem(
                    //         value: items,
                    //         child: SmallText(text: items),
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? items) {},
                    //   ),
                    // ),
                    const Spacer(),
                    SmallText(
                      text: 'Recently added',
                    ),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      ListItem(index: index, product: state.savedStorage.SavedStorageProducts![index].product!),
                  itemCount: state.savedStorage.SavedStorageProducts!.length,
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ],
          );
        } else if (state is SavedStorageErrorState) {
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

class ListItem extends StatelessWidget {
  final int index;
  final Product product;
  const ListItem({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(
            product: product,
          ),
          ProductInfo(
            index: index,
            product: product,
          ),
        ],
      ),
    );
  }
}

class ProductInfo extends StatefulWidget {
  final int index;
  final Product product;
  const ProductInfo({super.key, required this.product, required this.index});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  String? _selectedSize;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.product.discountOffer != ''
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.product.originalPrice}\$',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationStyle: TextDecorationStyle.solid,
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
                            text: '${widget.product.discountPrice}\$',
                            size: 14,
                            color: AppColors.redPrimary,
                          ),
                        ],
                      )
                    : BigText(
                        text: '${widget.product.originalPrice}\$',
                        size: 14,
                        color: AppColors.redPrimary,
                      ),
                SizedBox(
                  height: 30,
                  width: 16,
                  child: PopupMenuButton(
                    splashRadius: 16.0,
                    onSelected: (value) {
                      if (value == PopupMenuValue.delete) {
                        context.read<SavedStorageBloc>().add(SavedStorageRemoveItemEvent(index: widget.index));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: AppColors.red,
                            content: Text('Deleted Item'),
                          ),
                        );
                      } else if (value == PopupMenuValue.similar_items) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              // builder: (_) => CatalogView(
                              //   productID: product.id,
                              // ),
                              builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<SavedStorageBloc>(context),
                                    child: CatalogView(productID: widget.product.id),
                                  )),
                        );
                      }
                    },
                    icon: Icon(Icons.adaptive.more, size: 22),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: PopupMenuValue.move_to_bag,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                              text: 'Move to bag',
                            ),
                            const Icon(Icons.shopping_bag_outlined),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: PopupMenuValue.more_info,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                              text: 'More info',
                            ),
                            const Icon(Icons.info_outlined),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: PopupMenuValue.similar_items,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                              text: 'See similar items',
                            ),
                            const Icon(Icons.search_rounded),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: PopupMenuValue.delete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                              text: 'Delete',
                              color: AppColors.redPrimary,
                            ),
                            const Icon(
                              Icons.delete_outline_rounded,
                              color: AppColors.redPrimary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SmallText(
              text: '${widget.product.brand?.title}',
              size: 9,
              color: AppColors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            BigText(
              text: '${widget.product.title}',
              size: 13,
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
            const Spacer(),
            Row(
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
                      hint: BigText(
                        text: 'SIZE',
                        size: 10,
                      ),
                      value: _selectedSize,
                      items: widget.product.sizeOption!.split(',').map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: BigText(
                            text: item,
                            size: 10,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? selectedSize) {
                        setState(() {
                          _selectedSize = selectedSize!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                OutlinedButtonIconText(
                  text: 'MOVE TO BAG',
                  colorBorderSide: AppColors.green,
                  onPressed: () {
                    if (_selectedSize == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1500),
                          backgroundColor: Colors.green,
                          content: Text('Please select size'),
                        ),
                      );
                    } else {
                      context.read<BagBloc>().add(BagAddItemEvent(product: widget.product, size: _selectedSize!));
                      context.read<SavedStorageBloc>().add(SavedStorageRemoveItemEvent(index: widget.index));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1500),
                          backgroundColor: AppColors.green,
                          content: Text('It\'s in the bag'),
                        ),
                      );
                    }
                  },
                  height: AppSizes.kHeightTiny,
                  width: null,
                  textSize: AppSizes.kTextSizeTiny,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final Product product;
  const ProductImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 110, //148
      decoration: BoxDecoration(
        image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(product.images!.split('|').first)),
      ),
    );
  }
}
