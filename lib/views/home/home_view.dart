import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/bloc/tracking_bloc.dart';
import 'package:final_project/services/cloud/cubit/brand/brand_cubit.dart';
import 'package:final_project/services/cloud/cubit/product/product_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/catalog/catalog_view.dart';
import 'package:final_project/views/home/components/product_card.dart';
import 'package:final_project/views/home/components/product_slider.dart';
import 'package:final_project/views/home/components/product_slider_2.dart';
import 'package:final_project/views/product/product_view.dart';
import 'package:final_project/views/search/components/prefill_search.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProductCubit _productSaleCubit = ProductCubit();
  final ProductCubit _productNewCubit = ProductCubit();
  final ProductCubit _productRecCubit = ProductCubit();
  final ProductCubit _productSavedCubit = ProductCubit();
  ProductCubit _productRecentlyCubit = ProductCubit();
  ProductCubit _productHabitCubit = ProductCubit();
  final BrandCubit _brandCubit = BrandCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productSaleCubit.close();
    _productNewCubit.close();
    _productRecCubit.close();
    _productSavedCubit.close();
    _productRecentlyCubit.close();
    _productHabitCubit.close();
    _brandCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const MyPrefilledSearch(),
        titleSpacing: 10,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.network(
                            // 'https://content.asos-media.com/-/media/homepages/ww/2023/june/19-prime/ww-gbl/ww_global_best_of_summer_app_mobilehero_640x690.jpg',
                            'https://content.asos-media.com/-/media/homepages/mw/2023/july/03-gbl-ex-uk/gbl-heroes/mw_global_y2k_grunge_app_mobilehero_640x690.jpg',
                            height: 370,
                            width: double.maxFinite,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BigText(text: 'GET GRUNGE'),
                          const SizedBox(
                            height: 2,
                          ),
                          SmallText(text: 'Shop now')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocProvider(
                      create: (context) => _brandCubit
                        ..getBrands(<String>[
                          '792773c0-a1ef-410e-ba7c-5a781a9eb8b7',
                          'e42e0181-ebdc-4979-8f1f-db36dc61b667',
                          '5febf1cd-b12d-4cd9-b83f-3b1531c41c7b',
                          'fa5e5216-dfc1-4fd6-bf72-186bf23e6220'
                        ]),
                      child: BlocBuilder<BrandCubit, BrandState>(
                        builder: (context, state) {
                          if (state is BrandLoaded) {
                            final brands = state.brands;
                            // final titles = [
                            //   'Shorts',
                            //   'Kurtas',
                            // ];
                            final subtitles = [
                              'Runway-inspired styles',
                              'Kick game: brazy',
                              'Bold moves',
                              'The brand to know',
                            ];
                            final images = [
                              'https://content.asos-media.com/-/media/homepages/mw/2023/july/03-gbl-ex-uk/us-cat-tray/126284574_model-1.jpg',
                              'https://content.asos-media.com/-/media/homepages/mw/2023/july/03-gbl-ex-uk/us-cat-tray/126596342_model-1-1_v2.jpg',
                              'https://content.asos-media.com/-/media/homepages/mw/2023/june/19-prime/mw-gbl/mw_global_tnf_pride_moment_870x1110.jpg',
                              'https://content.asos-media.com/-/media/homepages/mw/2023/june/19-prime/mw-gbl/mw_global_new_balance_smu_moment_870x1110.jpg'
                            ];

                            return Column(
                              children: [
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 170 / 220),
                                  itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<SavedStorageBloc>(context),
                                            child: CatalogView(
                                              brand: brands[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 184,
                                      width: 162,
                                      child: Container(
                                        margin:
                                            (index + 1) % 2 != 0 ? const EdgeInsets.only(right: 12) : EdgeInsets.zero,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.network(
                                              // 'https://content.asos-media.com/-/media/homepages/ww/2023/june/19-prime/ww-gbl/ww_global_best_of_summer_app_mobilehero_640x690.jpg',
                                              images[index],
                                              height: 184,
                                              width: double.maxFinite,
                                              fit: BoxFit.fill,
                                            ),
                                            BigText(
                                              text: brands[index].title!,
                                              size: 14,
                                            ),
                                            SmallText(text: subtitles[index])
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  itemCount: 4,
                                )
                              ],
                            );
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocProvider<ProductCubit>(
                      create: (context) => _productSaleCubit..getSaleProducts(),
                      child: ProductSlider(
                        title: 'Sale',
                        subTitle: 'Super summer sale',
                      ),
                    ),
                    // BlocProvider<ProductCubit>.value(value: _productSaleCubit..getSaleProducts(),child: ProductSlider(
                    //     title: 'Sale',
                    //     subTitle: 'bladasdajsdaskh',
                    //   ),),
                    BlocProvider<ProductCubit>(
                      create: (context) => _productNewCubit..getNewProducts(),
                      child: ProductSlider(
                        title: 'New',
                        subTitle: 'You\'ve never seen this before',
                      ),
                    ),
                    // BlocProvider<ProductCubit>(
                    //   create: (context) =>
                    //       _productRecCubit..getModelBasedRecommendForUser(),
                    //   child: ProductSlider(
                    //       title: 'Recommended'), subTitle: 'Product may you like'),),
                    // ),
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => _productSavedCubit
                  ..getContentBasedRecommendForUser((context.read<SavedStorageBloc>().state is SavedStorageLoadedState)
                      ? (context.read<SavedStorageBloc>().state as SavedStorageLoadedState)
                          .savedStorage
                          .SavedStorageProducts!
                          .map((e) => e.productID)
                          .toList()
                      : []),
                child: ProductSlider2(
                  title: 'Similar vibes to your Saved Items',
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
              // UNCOMMENT LATER
              const SizedBox(
                height: 10,
              ),

              BlocBuilder<TrackingBloc, String>(
                builder: (context, state) {
                  print("S: ${state != ""} ");
                  if (state != "") {
                    List<String> productIds = state.split(",");
                    productIds.removeLast();
                    print(productIds);
                    if (_productRecentlyCubit.isClosed) {
                      _productRecentlyCubit = ProductCubit();
                    }
                    if (_productHabitCubit.isClosed) {
                      _productHabitCubit = ProductCubit();
                    }
                    _productRecentlyCubit.getRecentlyViewProducts(productIds);
                    _productHabitCubit.getContentBasedRecommendForUser(productIds);
                    return Column(
                      children: [
                        BlocProvider(
                          create: (context) => _productHabitCubit,
                          child: ProductSlider2(
                            title: 'Based on your Shopping Habit',
                            backgroundColor: Colors.grey.shade100,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocProvider(
                          create: (context) => _productRecentlyCubit,
                          child: Stack(children: [
                            ProductSlider2(
                              title: 'Recently Viewed',
                              backgroundColor: Colors.grey.shade100,
                            ),
                            Positioned(
                              right: 10,
                              top: 12,
                              child: GestureDetector(
                                onTap: () => BlocProvider.of<TrackingBloc>(context).add(TrackingProductClearEvent()),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  color: Colors.white70,
                                  child: SmallText(
                                    text: 'CLEAR',
                                    size: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              // UNCOMMENT LATER
              // KeyPicksCategoriesWidget(),
              const SizedBox(
                height: 10,
              ),
              // RecentlyViewedWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// class KeyPicksCategoriesWidget extends StatelessWidget {
//   const KeyPicksCategoriesWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[200],
//       height: 340,
//       width: double.infinity,
//       child: Container(
//         margin: EdgeInsets.only(left: 12, top: 12, bottom: 6),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             BigText(
//               text: 'Key picks from categories you\'ve been looking at',
//               size: 16,
//               maxLines: 2,
//             ),
//             SizedBox(
//               height: 285,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 clipBehavior: Clip.none,
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                   bottom: 10,
//                 ),
//                 itemCount: 6,
//                 itemBuilder: (context, index) => Padding(
//                   padding: index != 6 - 1
//                       ? const EdgeInsets.only(right: 12)
//                       : EdgeInsets.zero,
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigator.of(context).pushNamed(RouteHelper.productInfoRoute);
//                     },
//                     child: Container(
//                       color: Colors.white,
//                       padding:
//                           const EdgeInsets.only(left: 12, right: 12, top: 12),
//                       child: ProductCard(
//                         imgHeight: 164,
//                         imgWidth: 128,
//                         product: Product(
//                           title: 'Black & White',
//                           images:
//                               'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/6939204/2019/3/8/39b78859-4931-462a-9f5c-3c84ea857f1b1552025457918-her-by-invictus-Women-Off-White-Solid-Semi-Sheer-Top-4315520-1.jpg',
//                           originalPrice: '19.19',
//                           discountOffer: '',
//                           discountPrice: '',
//                           brand: Brand(id: '1', title: 'LV'),
//                           finercategory: FinerCategory(
//                               id: '1', title: 'Topwear', broadcategoryID: '1'),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class RecommendWidget extends StatelessWidget {
  const RecommendWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Container(
            color: Colors.grey[100],
            height: 340,
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.only(left: 12, top: 12, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigText(
                    text: 'Similar vibes to your Saved Items',
                    size: 16,
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
                        padding:
                            index != state.products.length - 1 ? const EdgeInsets.only(right: 12) : EdgeInsets.zero,
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed(RouteHelper.productInfoRoute);
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                            child: GestureDetector(
                              onTap: () {
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
                                isSelected: (BlocProvider.of<SavedStorageBloc>(context).state)
                                        is SavedStorageLoadedState
                                    ? (BlocProvider.of<SavedStorageBloc>(context).state as SavedStorageLoadedState)
                                            .savedStorage
                                            .SavedStorageProducts!
                                            .indexWhere((element) => element.product!.id == state.products[index].id) >=
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
          return Container();
        }
      },
    );
  }
}
