import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: 'LANGUAGE',
          size: 14,
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.5,
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: SmallText(
              text: 'English',
              size: 14,
              fontWeight: FontWeight.w400,
            ),
            onTap: () {
              setState(() {
                context.setLocale(Locale('en', 'US'));
              });
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: SmallText(
              text: 'VietNam',
              size: 14,
              fontWeight: FontWeight.w400,
            ),
            onTap: () {
              setState(() {
                context.setLocale(Locale('vi', 'VN'));
              });
              Navigator.of(context).pop();
            },
          ),
        ]).toList(),
      ),
    );
  }
}
