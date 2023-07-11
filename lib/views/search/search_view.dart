import 'package:final_project/utils/colors.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/services/cloud/cubit/broad_category/broad_category_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/search/components/category_card.dart';
import 'package:final_project/views/search/components/prefill_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      const Tab(
        text: 'WOMEN',
      ),
      const Tab(
        text: 'MEN',
      ),
    ];
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BroadWomenCubit()..getBroadCategories(),
        ),
        BlocProvider(
          create: (context) => BroadMenCubit()..getBroadCategories(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const MyPrefilledSearch(),
            titleSpacing: 10,
            bottom: TabBar(
              labelColor: AppColors.black,
              tabs: tabs,
              indicatorColor: AppColors.black,
              indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              onTap: (value) {
                // if (value == 0) {
                //   BlocProvider.of<BroadWomenCubit>(context)
                //       .getBroadCategories();
                // } else if (value == 1) {
                //   BlocProvider.of<BroadMenCubit>(context).getBroadCategories();
                // }
              },
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<BroadWomenCubit, BroadCategoryState>(
                builder: (context, state) {
                  if (state is BroadCategoryLoaded) {
                    return BroadTabView(broadCategories: state.broadCategories);
                  } else if (state is BroadCategoryError) {
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
              BlocBuilder<BroadMenCubit, BroadCategoryState>(
                builder: (context, state) {
                  if (state is BroadCategoryLoaded) {
                    return BroadTabView(broadCategories: state.broadCategories);
                  } else if (state is BroadCategoryError) {
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
            ],
          ),
        ),
      ),
    );
  }
}

class BroadTabView extends StatelessWidget {
  final List<BroadCategory> broadCategories;
  const BroadTabView({
    Key? key,
    required this.broadCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: broadCategories.length,
        itemBuilder: (context, index) => CategoryCard(broadCategory: broadCategories[index]));
  }
}
