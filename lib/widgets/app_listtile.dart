import 'package:final_project/utils/colors.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const AppListTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.black,
      ),
      title: SmallText(
        text: text,
        size: 14,
        fontWeight: FontWeight.w400,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
    );
  }
}
