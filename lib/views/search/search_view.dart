import 'package:final_project/colors.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/services/cloud/bloc/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/cubit/broad_category_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/catalog/catalog_view.dart';
import 'package:final_project/views/search/components/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      Tab(
        text: tr('WOMEN'),
      ),
      Tab(
        text: tr('MEN'),
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
            title: const MyPrefilledSearch(),
            bottom: TabBar(
              labelColor: AppColors.black,
              tabs: tabs,
              indicatorColor: AppColors.redPrimary,
              indicatorPadding: EdgeInsets.only(left: 10, right: 10),
              labelStyle: TextStyle(
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
        itemBuilder: (context, index) =>
            CategoryCard(broadCategory: broadCategories[index]));
  }
}

class MyPrefilledSearch extends StatefulWidget {
  const MyPrefilledSearch({Key? key}) : super(key: key);

  @override
  State<MyPrefilledSearch> createState() => _MyPrefilledSearchState();
}

class _MyPrefilledSearchState extends State<MyPrefilledSearch> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: _textController,
      borderRadius: BorderRadius.circular(20),
      onChanged: (value) => print('Text has changed to: $value'),
      onSubmitted: (value) {
        // => print('Submitted text: $value')
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<SavedStorageBloc>(context),
                    child: CatalogView(
                      textSearch: value,
                    ),
                  )),
        );
      },
    );
  }
}
