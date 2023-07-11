import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/main.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: BigText(
          text: 'LANGUAGE',
          size: 14,
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: SmallText(
              text: '🇬🇧   English',
              size: 14,
              fontWeight: FontWeight.w400,
            ),
            onTap: () async {
              await context.setLocale(const Locale('en', 'US'));
              Navigator.of(context).pop();
              MyApp.restartApp(context);
              // Navigator.of(context).popUntil((route) {
              //   return route.isFirst;
              // });
            },
          ),
          ListTile(
            title: SmallText(
              text: '🇻🇳   VietNam',
              size: 14,
              fontWeight: FontWeight.w400,
            ),
            onTap: () async {
              await context.setLocale(const Locale('vi', 'VN'));
              Navigator.of(context).pop();
              MyApp.restartApp(context);
              // Navigator.of(context).popUntil((route) {
              //   return route.isFirst;
              // });
            },
          ),
        ]).toList(),
      ),
    );
  }
}
