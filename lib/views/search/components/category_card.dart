import 'package:final_project/colors.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/services/cloud/bloc/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/saved_storage_bloc.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/sub_category/sub_category_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatelessWidget {
  final BroadCategory broadCategory;
  const CategoryCard({super.key, required this.broadCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
              value: BlocProvider.of<BagBloc>(context),
              child: BlocProvider.value(
                value: BlocProvider.of<SavedStorageBloc>(context),
                child: SubCategoryView(broadCategory: broadCategory),
              )),
        ),
      ),
      child: Container(
        height: 100,
        margin: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 10,
              offset: Offset(-5, -1),
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              blurRadius: 10,
              offset: Offset(105, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BigText(
                    text: '${broadCategory.title}',
                    size: getProportionateScreenHeight(16),
                    maxLines: 2,
                  ),
                ),
              ),
            ),
            Image.network(
              width: 150,
              '${broadCategory.image}',
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
