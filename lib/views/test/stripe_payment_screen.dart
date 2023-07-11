import 'dart:convert';

import 'package:final_project/utils/constants.dart';
import 'package:final_project/services/repo/stripe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({Key? key}) : super(key: key);

  @override
  _StripePaymentScreenState createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Make Payment'),
              onPressed: () async {
                await makePayment();
              },
            ),
            TextButton(
              child: const Text('Comfirm Payment'),
              onPressed: () async {
                await confirmPayment();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      const customerID = 'cus_O2CTsOWgwaON9p';
      final paymentIntent =
          await StripeRepository.instance.createPaymentIntent(customerID: customerID, amount: '100', currency: 'USD');
      final ephemeralKey = await StripeRepository.instance.createEphemeralKey(customerID: customerID);
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  customFlow: true,
                  paymentIntentClientSecret: paymentIntent,
                  customerEphemeralKeySecret: ephemeralKey,
                  customerId: customerID,
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.light,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      // await Stripe.instance.presentPaymentSheet().then((value) {
      //   showDialog(
      //       context: context,
      //       builder: (_) => const AlertDialog(
      //             content: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 Row(
      //                   children: [
      //                     Icon(
      //                       Icons.check_circle,
      //                       color: Colors.green,
      //                     ),
      //                     Text("Payment Successfull"),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ));
      //   // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(milliseconds: 1500),content: Text("paid successfully")));

      //   paymentIntent = null;
      // }).onError((error, stackTrace) {
      //   print('Error is:--->$error $stackTrace');
      // });

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('Payment option selected'),
        ),
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: $e'),
          ),
        );
      }
    }
  }

  Future<void> confirmPayment() async {
    try {
      await Stripe.instance.confirmPaymentSheetPayment();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('Payment succesfully completed'),
        ),
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: $e'),
          ),
        );
      }
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        'setup_future_usage': 'off_session',
        'customer': 'cus_O2CTsOWgwaON9p',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {'Authorization': 'Bearer $SECRET_KEY', 'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
