import 'package:badges/badges.dart' as badges;
import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/models/BagProduct.dart';
import 'package:final_project/routers/app_router.dart';
import 'package:final_project/services/auth/auth_repository.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:final_project/services/repo/shipping_address_repository.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/views/bag/bag_view.dart';
import 'package:final_project/views/home/home_view.dart';
import 'package:final_project/views/profile/profile_view.dart';
import 'package:final_project/views/saved_storage/saved_storage_view.dart';
import 'package:final_project/views/search/search_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _router = AppRouter();
  int _selectedIndex = 0;
  final GlobalKey<NavigatorState> homeTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> searchTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> bagTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> savedStorageTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileTabNavKey = GlobalKey<NavigatorState>();
  List<Widget> views = [
    const HomeView(),
    const SearchView(),
    const BagView(),
    const SavedStorageView(),
    const ProfileView(),
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int totalItems = 0;
  void calculateTotalAmountAndItem(List<BagProduct> list) {
    int tempQuantity = 0;

    for (var element in list) {
      tempQuantity += (element.quantity!);
    }
    totalItems = tempQuantity;
  }

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<AuthCubit>().sessionCubit;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ShippingAddressRepository(currentUser: sessionCubit.currentUser)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ShippingAddressBloc(repository: RepositoryProvider.of<ShippingAddressRepository>(context))),
          BlocProvider(
            create: (context) => SavedStorageBloc()..add(SavedStorageInitializeEvent()),
          ),
          BlocProvider(
            create: (context) => BagBloc()..add(BagInitializeEvent()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>(),
            ),
          ),
          // BlocProvider(
          //   create: (context) => TrackingBloc(),
          // )
        ],

        // UPDATE BOTTOM NAV BAR USING CupertinoTabScaffold
        // child: Scaffold(
        //   // appBar: AppBar(
        //   //   elevation: 0.5,
        //   //   actions: [
        //   //     IconButton(
        //   //       onPressed: () {
        //   //         showSearch(context: context, delegate: CustomDelegate());
        //   //       },
        //   //       icon: const Icon(Icons.search),
        //   //     )
        //   //   ],
        //   // ),
        //   body: BlocBuilder<SavedStorageBloc, SavedStorageState>(
        //     builder: (context, state) {
        //       if (state is SavedStorageLoadedState) {
        //         return views[_selectedIndex];
        //       } else {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //     },
        //   ),
        //   bottomNavigationBar: BlocBuilder<BagBloc, BagState>(
        //     builder: (context, state) {
        //       if (state is BagLoadedState) {
        //         (state.bag.BagProducts != null && state.bag.BagProducts!.isNotEmpty)
        //             ? calculateTotalAmountAndItem(state.bag.BagProducts!)
        //             : null;
        //       }
        //       return BottomNavigationBar(
        //           elevation: 0.5,
        //           backgroundColor: Colors.white,
        //           selectedItemColor: AppColors.black,
        //           unselectedItemColor: Colors.grey[400],
        //           showSelectedLabels: false,
        //           showUnselectedLabels: false,
        //           onTap: onTapNav,
        //           currentIndex: _selectedIndex,
        //           selectedFontSize: 0,
        //           unselectedFontSize: 0,
        //           type: BottomNavigationBarType.fixed,
        //           items: [
        //             const BottomNavigationBarItem(
        //               label: 'Home',
        //               icon: Icon(Icons.apps),
        //             ),
        //             const BottomNavigationBarItem(
        //               label: 'Search',
        //               icon: Icon(Icons.manage_search_rounded),
        //             ),
        //             BottomNavigationBarItem(
        //               label: 'Bag',
        //               icon: state is BagLoadedState &&
        //                       (state.bag.BagProducts != null && state.bag.BagProducts!.isNotEmpty)
        //                   ? badges.Badge(
        //                       badgeContent: Text(
        //                         '$totalItems',
        //                         style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        //                       ),
        //                       badgeColor: AppColors.green,
        //                       child: const Icon(Icons.shopping_bag_outlined),
        //                     )
        //                   : const Icon(Icons.shopping_bag_outlined),
        //             ),
        //             const BottomNavigationBarItem(
        //               label: 'Saved',
        //               icon: Icon(Icons.favorite_outline_rounded),
        //             ),
        //             const BottomNavigationBarItem(
        //               label: 'Person',
        //               icon: Icon(Icons.person_outline_rounded),
        //             ),
        //           ]);
        //     },
        //   ),
        // ),
        // UPDATE BOTTOM NAV BAR USING CupertinoTabScaffold
        child: BlocBuilder<BagBloc, BagState>(
          builder: (context, state) {
            if (state is BagLoadedState) {
              (state.bag.BagProducts != null && state.bag.BagProducts!.isNotEmpty)
                  ? calculateTotalAmountAndItem(state.bag.BagProducts!)
                  : null;
            }
            return CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: bottomNavItems(state),
                  backgroundColor: Colors.white,
                  activeColor: AppColors.black,
                  inactiveColor: const Color(0xFFc8c8c8),
                  iconSize: 26,
                  height: 54,
                  border: const Border(top: BorderSide(color: Color(0xFFe1e1e1), width: 0.2)),
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        homeTabNavKey.currentState?.popUntil((r) => r.isFirst);
                        break;
                      case 1:
                        searchTabNavKey.currentState?.popUntil((r) => r.isFirst);
                        break;
                      case 2:
                        bagTabNavKey.currentState?.popUntil((r) => r.isFirst);
                        break;
                      case 3:
                        savedStorageTabNavKey.currentState?.popUntil((r) => r.isFirst);
                        break;
                      case 4:
                        profileTabNavKey.currentState?.popUntil((r) => r.isFirst);
                        break;
                      default:
                    }
                  },
                ),
                tabBuilder: (context, index) {
                  return BlocBuilder<SavedStorageBloc, SavedStorageState>(
                    builder: (context, state) {
                      if (state is SavedStorageLoadedState) {
                        return CupertinoTabView(
                          navigatorKey: index == 0
                              ? homeTabNavKey
                              : index == 1
                                  ? searchTabNavKey
                                  : index == 2
                                      ? bagTabNavKey
                                      : index == 3
                                          ? savedStorageTabNavKey
                                          : profileTabNavKey,
                          onGenerateRoute: _router.onGenerateRoute,
                          builder: (context) {
                            switch (index) {
                              case 0:
                                return const CupertinoPageScaffold(child: HomeView());
                              case 1:
                                return const CupertinoPageScaffold(child: SearchView());
                              case 2:
                                return const CupertinoPageScaffold(child: BagView());
                              case 3:
                                return const CupertinoPageScaffold(child: SavedStorageView());
                              case 4:
                                return const CupertinoPageScaffold(child: ProfileView());
                              default:
                                return const CupertinoPageScaffold(child: HomeView());
                            }
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                });
          },
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomNavItems(BagState state) {
    return [
      BottomNavigationBarItem(
        label: 'Home'.tr(),
        icon: const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(Icons.apps),
        ),
      ),
      BottomNavigationBarItem(
        label: 'Search'.tr(),
        icon: const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(Icons.manage_search_rounded),
        ),
      ),
      BottomNavigationBarItem(
        label: 'Bag'.tr(),
        icon: state is BagLoadedState && (state.bag.BagProducts != null && state.bag.BagProducts!.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: badges.Badge(
                  badgeContent: Text(
                    '$totalItems',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  badgeColor: AppColors.green,
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              )
            : const Icon(Icons.shopping_bag_outlined),
      ),
      BottomNavigationBarItem(
        label: 'Save'.tr(),
        icon: const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(Icons.favorite_outline_rounded),
        ),
      ),
      BottomNavigationBarItem(
        label: 'Person'.tr(),
        icon: const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(Icons.person_outline_rounded),
        ),
      ),
    ];
  }
}

// class CustomDelegate extends SearchDelegate {
//   List<String> searchTerms = ['pothes', 'shirt', 'dress'];

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     // TODO: implement appBarTheme
//     return super.appBarTheme(context);
//   }

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     return [
//       IconButton(
//           onPressed: () {
//             query = '';
//           },
//           icon: const Icon(Icons.clear))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: const Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }

//     return ListView.builder(
//         itemCount: matchQuery.length,
//         itemBuilder: (result, index) {
//           var result = matchQuery[index];
//           return ListTile(
//             title: Text(result),
//           );
//         });
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Custom Search'),
//         backgroundColor: Colors.grey[800],
//         toolbarTextStyle: const TextTheme(
//           titleLarge: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ).bodyMedium,
//         titleTextStyle: const TextTheme(
//           titleLarge: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ).titleLarge,
//       ),
//       body: const Center(
//         child: Text('Enter a search term to begin.'),
//       ),
//     );
//   }
// }
