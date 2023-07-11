import 'dart:convert';

import 'package:final_project/utils/constants.dart';
import 'package:final_project/models/User.dart';
import 'package:http/http.dart' as http;

class StripeRepository {
  // Future<List<Province>> getProvinces() async {
  //   try {
  //     var response = await http.get(
  //       Uri.parse('https://vapi.vnappmob.com/api/province'),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //     // ignore: avoid_print
  //     List<Province> provinces = provincesFromJson(response.body);
  //     print(provinces[0].provinceName);
  //     return provinces;
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  StripeRepository._();

  static final StripeRepository instance = StripeRepository._();

  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     // Create a Customer (skip this and get the existing Customer ID if this is a returning customer)

  //     Map<String, dynamic> body = {
  //       'amount': amount,
  //       'currency': currency,
  //       'payment_method_types[]': 'card',
  //       'setup_future_usage': 'off_session',
  //       'customer': 'cus_O2CTsOWgwaON9p',
  //     };

  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {'Authorization': 'Bearer $SECRET_KEY', 'Content-Type': 'application/x-www-form-urlencoded'},
  //       body: body,
  //     );
  //     // ignore: avoid_print
  //     print('Payment Intent Body->>> ${response.body.toString()}');
  //     return jsonDecode(response.body);
  //   } catch (err) {
  //     // ignore: avoid_print
  //     print('err charging user: ${err.toString()}');
  //   }
  // }
  static calculateAmount(String amount) {
    final calculatedAmout = ((double.parse(amount)) * 100).toInt();
    return calculatedAmout.toString();
  }

  Future<String?> createCustomer(User user) async {
    try {
      // Create a Customer (skip this and get the existing Customer ID if this is a returning customer)
      Map<String, dynamic> body = {
        'name': user.username,
        'email': user.email,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/customers'),
        headers: {'Authorization': 'Bearer $SECRET_KEY', 'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );
      // ignore: avoid_print
      print('Create Customer Body->>> ${response.body.toString()}');
      var data = jsonDecode(response.body);
      var customerID = data['id'];
      return customerID;
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
      return null;
    }
  }

  Future<String?> createEphemeralKey({required String customerID}) async {
    try {
      // Create a Customer (skip this and get the existing Customer ID if this is a returning customer)
      Map<String, dynamic> body = {
        'customer': customerID,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/ephemeral_keys'),
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Stripe-Version': '2022-08-01',
        },
        body: body,
      );
      // ignore: avoid_print
      print('Create Ephemeral Key Body->>> ${response.body.toString()}');
      var data = jsonDecode(response.body);
      var ephemeralKey = data['secret'];
      return ephemeralKey;
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
      return null;
    }
  }

  Future<String?> createPaymentIntent(
      {required String customerID, required String amount, required String currency}) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        'customer': customerID,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {'Authorization': 'Bearer $SECRET_KEY', 'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      var data = jsonDecode(response.body);
      var paymentIntent = data['client_secret'];
      return paymentIntent;
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}
