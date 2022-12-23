import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/colors.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/profile/components/language/language_view.dart';
import 'package:final_project/views/profile/components/my_orders/my_orders_view.dart';
import 'package:final_project/widgets/app_listtile.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: 'MY ACCOUNT',
          size: 14,
        ),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: getProportionateScreenHeight(85),
              decoration: const ShapeDecoration(
                  shape: CircleBorder(), color: AppColors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            SmallText(
              text: 'Hi,',
              size: 14,
            ),
            const SizedBox(
              height: 5,
            ),
            BigText(
              text: 'Trung Thành',
              size: 16,
            ),
            const SizedBox(
              height: 20,
            ),
            // using ListView.divideTiles for short static list
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: ListTile.divideTiles(context: context, tiles: [
                GestureDetector(
                    onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MyOrdersView(),
                          ),
                        ),
                    child: AppListTile(
                        icon: Icons.history, text: tr('My orders'))),
                AppListTile(icon: Icons.badge_outlined, text: tr('My details')),
                AppListTile(
                    icon: Icons.lock_outline, text: tr('Change password')),
                AppListTile(
                    icon: Icons.home_outlined, text: tr('Address book')),
                AppListTile(
                    icon: Icons.payment_outlined, text: tr('Payment methods')),
                AppListTile(
                    icon: Icons.notifications_outlined,
                    text: tr('Notifications')),
                AppListTile(
                    icon: Icons.card_giftcard_outlined, text: tr('Promocodes')),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const LanguageView()));
                  },
                  child: AppListTile(
                      icon: Icons.language_outlined, text: tr('Language')),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: AppListTile(
                      icon: Icons.logout_outlined, text: tr('Sign out')),
                ),
              ]).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
