import 'package:final_project/size_config.dart';
import 'package:final_project/views/saved_storage/components/body.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';

class SavedStorageView extends StatelessWidget {
  const SavedStorageView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: 'SAVED ITEMS',
            size: 14,
          ),
        ),
        body: const SingleChildScrollView(
          child: Body(),
        ));
  }
}
