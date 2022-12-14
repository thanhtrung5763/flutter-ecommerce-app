import 'package:final_project/colors.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage_bloc.dart';
import 'package:final_project/services/cloud/cubit/finer_category_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/catalog/catalog_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:easy_localization/easy_localization.dart';

class SubCategoryView extends StatelessWidget {
  final BroadCategory broadCategory;
  static const subCategoryName = 'SHOES';
  static const subCategoryItems = [
    'New in',
    'Trainers',
    'Boots',
    'Loafers',
    'Sandals',
    'Shoes',
    'Shoes',
    'Shoes',
    'Shoes',
    'Shoes',
  ];
  const SubCategoryView({super.key, required this.broadCategory});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          FinerCategoryCubit()..getFinerCategoriesOfBroad(broadCategory),
      child: Scaffold(
        appBar: AppBar(
          title: BigText(
            text: '${broadCategory.title!.toUpperCase()}',
            size: 14,
          ),
          elevation: 0.5,
        ),
        body: BlocBuilder<FinerCategoryCubit, FinerCategoryState>(
          builder: (context, state) {
            if (state is FinerCategoryLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ButtonIconText(
                        text: tr('VIEW ALL ITEMS'),
                        onPressed: () {},
                        height: 42,
                        textSize: 12,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SmallText(
                          text: tr('Choose category'),
                          color: AppColors.grey,
                          size: 14,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      // use ListView.separated for long dynamic list
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<BagBloc>(
                                                context),
                                            child: BlocProvider.value(
                                              value: BlocProvider.of<
                                                  SavedStorageBloc>(context),
                                              child: CatalogView(
                                                finerCategory: state
                                                    .finerCategories[index],
                                              ),
                                            ),
                                          ))),
                              child: SmallText(
                                text:
                                    '${state.finerCategories[index].title!.split('-').map((e) => toBeginningOfSentenceCase(e)).join(' ')}',
                                size: 12,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 1,
                          );
                        },
                        itemCount: state.finerCategories.length,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is FinerCategoryError) {
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
      ),
    );
  }
}
