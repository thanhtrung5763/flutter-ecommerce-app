// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/colors.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/cubit/product_cubit.dart';
import 'package:final_project/services/cloud/cubit/review_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/home/components/product_card.dart';
import 'package:final_project/views/home/components/product_slider_2.dart';
import 'package:final_project/views/product/components/product_info.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductView extends StatefulWidget {
  final Product product;
  const ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String? _selectedSize = null;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final List<String> images = widget.product.images!.split('|');
    final List<Widget> imagesSlider = images
        .map(
          (image) => Image.network(
            image,
            fit: BoxFit.fill,
            width: double.maxFinite,
          ),
        )
        .toList();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()
            ..getContentBasedRecommendForUser([widget.product.id]),
        ),
        BlocProvider(
          create: (context) =>
              ReviewCubit()..getReviewByProduct(widget.product),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              MySliverAppBar(images: images, imagesSlider: imagesSlider),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      ProductInfo(
                        product: widget.product,
                      ),
                      Divider(),
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
                              size: 14,
                            ),
                            value: _selectedSize,
                            items: widget.product.sizeOption!
                                .split(',')
                                .map((String item) {
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
                      Divider(),
                      const SizedBox(
                        height: 11,
                      ),
                      ButtonIconText(
                        height: 43,
                        text: tr('ADD TO BAG'),
                        onPressed: () {
                          if (_selectedSize == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Please select size').tr(),
                              ),
                            );
                          } else {
                            BlocProvider.of<BagBloc>(context)
                              ..add(BagAddItemEvent(
                                  product: widget.product,
                                  size: _selectedSize!));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.greenSuccess,
                                content: Text('It\'s in the bag').tr(),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ReviewOfProduct(),
              ),
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    if (state.products.isNotEmpty) {
                      return SliverToBoxAdapter(
                        child: ProductSlider2(
                          title: tr('You might also like'),
                          backgroundColor: Colors.grey.shade100,
                        ),
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: null,
                      );
                    }
                  } else if (state is ProductError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(state.exception.toString()),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MySliverAppBar extends StatefulWidget {
  final List<String> images;
  const MySliverAppBar({
    Key? key,
    required this.images,
    required this.imagesSlider,
  }) : super(key: key);

  final List<Widget> imagesSlider;

  @override
  State<MySliverAppBar> createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0.5,
      expandedHeight: 420,
      titleSpacing: 4,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: AppColors.black,
            ),
          ),
        ],
      ),
      // flexibleSpace: FlexibleSpaceBar(
      //   background: Image.network(
      //     widget.product.images!.split('|').first,
      //     fit: BoxFit.fill,
      //   ),
      //   collapseMode: CollapseMode.pin,
      // ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: CarouselSlider(
              items: widget.imagesSlider,
              options: CarouselOptions(
                aspectRatio: 0.1,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.map((url) {
                int index = widget.images.indexOf(url);
                return Container(
                  width: _current == index ? 13 : 10,
                  height: _current == index ? 13 : 10,
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.1),
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
      ),
    );
  }
}

class ReviewOfProduct extends StatelessWidget {
  ReviewOfProduct({
    Key? key,
  }) : super(key: key);

  double average = 0;

  Map<String, int> reviewCount = {
    'total': 0,
    '5.0': 0,
    '4.0': 0,
    '3.0': 0,
    '2.0': 0,
    '1.0': 0
  };

  void calculateReview(List<Review> reviews) {
    for (var review in reviews) {
      reviewCount[review.rating!] = reviewCount[review.rating!]! + 1;
      average = average + double.parse(review.rating!);
    }
    reviewCount['total'] = reviews.length;
    average = average / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoaded) {
          calculateReview(state.reviews);
        } else if (state is ReviewError) {
          return Center(
            child: Text(state.exception.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
            color: Colors.white,
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 12, top: 12, bottom: 6, right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: AppColors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    BigText(
                      text: '${average.toStringAsFixed(1)}',
                      color: AppColors.black,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SmallText(
                      text: '(${reviewCount['total']})',
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 5,
                ),
                ChartRow(
                    label: '5 ${tr('stars')}',
                    pct: reviewCount['5.0']!,
                    total: reviewCount['total']!),
                const SizedBox(
                  height: 10,
                ),
                ChartRow(
                    label: '4 ${tr('stars')}',
                    pct: reviewCount['4.0']!,
                    total: reviewCount['total']!),
                const SizedBox(
                  height: 10,
                ),
                ChartRow(
                    label: '3 ${tr('stars')}',
                    pct: reviewCount['3.0']!,
                    total: reviewCount['total']!),
                const SizedBox(
                  height: 10,
                ),
                ChartRow(
                    label: '2 ${tr('stars')}',
                    pct: reviewCount['2.0']!,
                    total: reviewCount['total']!),
                const SizedBox(
                  height: 10,
                ),
                ChartRow(
                    label: '1 ${tr('stars')}',
                    pct: reviewCount['1.0']!,
                    total: reviewCount['total']!),
                const SizedBox(
                  height: 5,
                ),
              ],
            ));
      },
    );
  }
}

class ChartRow extends StatelessWidget {
  String label;
  int pct;
  int total;
  ChartRow({
    Key? key,
    required this.label,
    required this.pct,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontFamily: 'Arial'),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 12,
          width: MediaQuery.of(context).size.width * 0.6 * (pct / total),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
        Container(
          height: 12,
          width:
              MediaQuery.of(context).size.width * 0.6 * ((total - pct) / total),
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          '($pct)',
          style: const TextStyle(fontFamily: 'Arial'),
        ),
      ],
    );
  }
}
