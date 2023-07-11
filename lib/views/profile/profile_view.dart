import 'package:final_project/utils/colors.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/services/cloud/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/profile/components/language/language_view.dart';
import 'package:final_project/views/profile/components/my_orders/my_orders_view.dart';
import 'package:final_project/views/shipping_address/shipping_address_view.dart';
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
    context.read<ShippingAddressBloc>().add(ShippingAddressInitializeEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: BigText(
          text: 'MY ACCOUNT',
          size: 14,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 36),
                  child: Image.asset(
                    'assets/images/default_avt.jpeg',
                    fit: BoxFit.fill,
                    height: 90,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 20,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1.75,
                        ),
                      ),
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
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
              text: context.read<AuthCubit>().sessionCubit.currentUser.username,
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
                    child: const AppListTile(icon: Icons.history, text: 'My orders')),
                Container(
                  color: AppColors.whiteBackGround,
                  height: 8,
                ),
                const AppListTile(icon: Icons.badge_outlined, text: 'My details'),
                const AppListTile(icon: Icons.lock_outline, text: 'Change password'),
                BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
                  builder: (context, state) {
                    if (state is ShippingAddressLoadedState) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<ShippingAddressBloc>(context),
                                      child: ShippingAddressView(
                                        shippingAddresses: state.shippingAddresses,
                                      ),
                                    )));
                          },
                          child: const AppListTile(icon: Icons.home_outlined, text: 'Address book'));
                    }
                    return const AppListTile(icon: Icons.home_outlined, text: 'Address book');
                  },
                ),
                const AppListTile(icon: Icons.payment_outlined, text: 'Payment methods'),
                const AppListTile(icon: Icons.notifications_outlined, text: 'Notifications'),
                const AppListTile(icon: Icons.card_giftcard_outlined, text: 'Promocodes'),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LanguageView()));
                  },
                  child: const AppListTile(icon: Icons.language_outlined, text: 'Language'),
                ),
                Container(
                  color: AppColors.whiteBackGround,
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: const AppListTile(icon: Icons.logout_outlined, text: 'Sign out'),
                ),
                Container(
                  color: AppColors.whiteBackGround,
                  height: 16,
                ),
              ]).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
