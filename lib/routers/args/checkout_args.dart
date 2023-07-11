import 'package:final_project/models/Bag.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/cloud/bloc/shipping_address/shipping_address_bloc.dart';

class CheckoutArguments {
  final BagBloc bagBloc;
  final ShippingAddressBloc shippingAddressBloc;
  final Bag bag;

  CheckoutArguments(this.bagBloc, this.shippingAddressBloc, this.bag);
}