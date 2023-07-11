import 'package:final_project/services/repo/stripe_repository.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:flutter/material.dart';

import '../../models/User.dart';

class TestStripeApiScreen extends StatelessWidget {
  const TestStripeApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonIconText(
                text: 'Create Customer',
                onPressed: () async {
                  await StripeRepository.instance
                      .createCustomer(User(username: 'TestUser', email: 'testuser@gmail.com'));
                }),
            ButtonIconText(
                text: 'Create Ephemeral Key',
                onPressed: () async {
                  await StripeRepository.instance.createEphemeralKey(customerID: 'cus_O2CTsOWgwaON9p');
                }),
            ButtonIconText(
                text: 'Create Payment Intent',
                onPressed: () async {
                  await StripeRepository.instance
                      .createPaymentIntent(customerID: 'cus_O3qs058vjYuARA', amount: '100', currency: 'USD');
                }),
          ],
        ),
      ),
    );
  }
}
