import 'package:final_project/size_config.dart';
import 'package:final_project/views/saved_storage/components/body.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SavedStorageView extends StatelessWidget {
  const SavedStorageView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: BigText(
            text: tr('SAVED ITEMS'),
            size: 14,
          ),
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Body(),
        ));
  }
}
