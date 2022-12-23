import 'package:badges/badges.dart';
import 'package:final_project/colors.dart';
import 'package:final_project/models/BagProduct.dart';
import 'package:final_project/services/auth/auth_repository.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/bloc/tracking_bloc.dart';
import 'package:final_project/views/bag/bag_view.dart';
import 'package:final_project/views/home/home_view.dart';
import 'package:final_project/views/profile/profile_view.dart';
import 'package:final_project/views/saved_storage/saved_storage_view.dart';
import 'package:final_project/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SavedStorageBloc()..add(SavedStorageInitializeEvent()),
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
        BlocProvider(
          create: (context) => TrackingBloc(),
        )
      ],
      child: Scaffold(
        body: BlocBuilder<SavedStorageBloc, SavedStorageState>(
          builder: (context, state) {
            if (state is SavedStorageLoadedState) {
              return views[_selectedIndex];
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<BagBloc, BagState>(
          builder: (context, state) {
            if (state is BagLoadedState) {
              (state.bag.BagProducts != null &&
                      state.bag.BagProducts!.isNotEmpty)
                  ? calculateTotalAmountAndItem(state.bag.BagProducts!)
                  : null;
            }
            return BottomNavigationBar(
                selectedItemColor: AppColors.black,
                unselectedItemColor: Colors.grey[400],
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: onTapNav,
                currentIndex: _selectedIndex,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                type: BottomNavigationBarType.fixed,
                items: [
                  const BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(Icons.apps),
                  ),
                  const BottomNavigationBarItem(
                    label: 'Search',
                    icon: Icon(Icons.manage_search_rounded),
                  ),
                  BottomNavigationBarItem(
                    label: 'Bag',
                    icon: state is BagLoadedState &&
                            (state.bag.BagProducts != null &&
                                state.bag.BagProducts!.isNotEmpty)
                        ? Badge(
                            badgeContent: Text(
                              '$totalItems',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            badgeColor: AppColors.green,
                            child: Icon(Icons.shopping_bag_outlined),
                          )
                        : Icon(Icons.shopping_bag_outlined),
                  ),
                  const BottomNavigationBarItem(
                    label: 'Saved',
                    icon: Icon(Icons.favorite_outline_rounded),
                  ),
                  const BottomNavigationBarItem(
                    label: 'Person',
                    icon: Icon(Icons.person_outline_rounded),
                  ),
                ]);
          },
        ),
      ),
    );
  }
}
