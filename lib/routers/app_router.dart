import 'package:final_project/routers/args/checkout_args.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:final_project/views/checkout/checkout_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    print('ROUTE: ${settings.name}');
    switch (settings.name) {
      case '/checkout':
        final args = settings.arguments as CheckoutArguments;

        return MaterialPageRoute(
          settings: settings,
                  builder: (context) => BlocProvider.value(
                        value: args.bagBloc,
                        child: BlocProvider.value(
                          value: args.shippingAddressBloc,
                          child: CheckoutView(bag: args.bag),
                        ),
                      ));
      default:
        return null;
    }
  } 
}