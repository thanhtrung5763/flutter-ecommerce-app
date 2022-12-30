import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/bloc/tracking_bloc.dart';
import 'package:final_project/services/cloud/cubit/product_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/home/components/product_card.dart';
import 'package:final_project/views/home/components/product_slider.dart';
import 'package:final_project/views/home/components/product_slider_2.dart';
import 'package:final_project/views/product/product_view.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  BlocProvider<ProductCubit>(
                    create: (context) => _productSaleCubit..getSaleProducts(),
                    child: ProductSlider(
                      title: tr('Sale'),
                      subTitle: tr('Super summer sale'),
                    ),
                  ),
                  // BlocProvider<ProductCubit>.value(value: _productSaleCubit..getSaleProducts(),child: ProductSlider(
                  //     title: 'Sale',
                  //     subTitle: 'bladasdajsdaskh',
                  //   ),),
                  BlocProvider<ProductCubit>(
                    create: (context) => _productNewCubit..getNewProducts(),
                    child: ProductSlider(
                      title: tr('New'),
                      subTitle: tr('You\'ve never seen this before'),
                    ),
                  ),
                  BlocProvider<ProductCubit>(
                    create: (context) =>
                        _productRecCubit..getModelBasedRecommendForUser(),
                    child: ProductSlider(
                        title: tr('Recommended'), subTitle: tr('Product may you like'),),
                  ),
                ],
              ),
            ),
            BlocProvider(
              create: (context) => _productSavedCubit
                ..getContentBasedRecommendForUser((context
                        .read<SavedStorageBloc>()
                        .state is SavedStorageLoadedState)
                    ? (context.read<SavedStorageBloc>().state
                            as SavedStorageLoadedState)
                        .savedStorage
                        .SavedStorageProducts!
                        .map((e) => e.productID)
                        .toList()
                    : []),
              child: ProductSlider2(
                title: tr('Similar vibes to your Saved Items'),
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            BlocBuilder<TrackingBloc, String>(
              builder: (context, state) {
                print("S: ${state != ""} ");
                if (state != "") {
                  List<String> product_ids = state.split(",");
                  product_ids.removeLast();
                  print(product_ids);
                  if (_productRecentlyCubit.isClosed) {
                    _productRecentlyCubit = ProductCubit();
                  }
                  if (_productHabitCubit.isClosed) {
                    _productHabitCubit = ProductCubit();
                  }
                  _productRecentlyCubit.getRecentlyViewProducts(product_ids);
                  _productHabitCubit
                      .getContentBasedRecommendForUser(product_ids);
                  return Column(
                    children: [
                      BlocProvider(
                        create: (context) => _productHabitCubit,
                        child: ProductSlider2(
                          title: tr('Based on your Shopping Habit'),
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
                            title: tr('Recently Viewed'),
                            backgroundColor: Colors.grey.shade100,
                          ),
                          Positioned(
                            right: 10,
                            top: 12,
                            child: GestureDetector(
                              onTap: () =>
                                  BlocProvider.of<TrackingBloc>(context)
                                      .add(TrackingProductClearEvent()),
                              child: Container(
                                padding: EdgeInsets.all(6),
                                color: Colors.white70,
                                child: SmallText(
                                  text: tr('CLEAR'),
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
            // KeyPicksCategoriesWidget(),
            SizedBox(
              height: 10,
            ),
            // RecentlyViewedWidget(),
          ],
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
              margin: EdgeInsets.only(left: 12, top: 12, bottom: 6),
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
                        padding: index != state.products.length - 1
                            ? const EdgeInsets.only(right: 12)
                            : EdgeInsets.zero,
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed(RouteHelper.productInfoRoute);
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 12),
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
