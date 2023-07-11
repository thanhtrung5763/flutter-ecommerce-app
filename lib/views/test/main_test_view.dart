import 'package:final_project/views/checkout/components/checkout_success_view.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:flutter/material.dart';

class MainTestView extends StatelessWidget {
  const MainTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ButtonIconText(
              //     text: 'CHECKOUT',
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutView()));
              //     })

              // ButtonIconText(
              //     text: 'Add Address',
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShippingAddressView()));
              //     }),
              
              // ButtonIconText(
              //     text: 'Checkout Success View',
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutSuccessView()));
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
