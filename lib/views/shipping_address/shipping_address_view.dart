import 'package:final_project/utils/colors.dart';
import 'package:final_project/models/ShippingAddress.dart';
import 'package:final_project/services/cloud/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:final_project/views/shipping_address/components/add_edit_shipping_address_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingAddressView extends StatelessWidget {
  bool _isDefaultAddress = false;
  Function(ShippingAddress)? onSelected;
  List<ShippingAddress> shippingAddresses;
  ShippingAddressView({super.key, this.onSelected, required this.shippingAddresses});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ShippingAddressBloc>().repository;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          centerTitle: true,
          title: BigText(
            text: 'ADDRESS SELECTION',
            size: 14,
          ),
        ),
        body: BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
          builder: (context, state) {
            if (state is ShippingAddressLoadedState) {
              shippingAddresses = [...state.shippingAddresses];
              return Column(
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 8, top: 16, right: 8),
                      color: Colors.white,
                      height: null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OutlinedButtonIconText(
                            height: 42,
                            text: 'ADD ADDRESS',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<ShippingAddressBloc>(context),
                                        child: AddEditShippingAddressView(),
                                      )));
                            },
                            icon: Icons.add,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Flexible(
                            child: ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 8),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: onSelected != null
                                        ? () {
                                            onSelected!(shippingAddresses[index]);
                                            Navigator.of(context).pop();
                                          }
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.map),
                                          // Transform.scale(
                                          //   scale: 0.85,
                                          //   child: Checkbox(
                                          //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          //       side: const BorderSide(),
                                          //       fillColor: MaterialStateProperty.all(Colors.black87),
                                          //       checkColor: Colors.white,
                                          //       shape: const CircleBorder(),
                                          //       value: shippingAddresses[index].id ==
                                          //           repository.currentUser.defaultShippingAddressID,
                                          //       onChanged: (bool? value) {
                                          //         if (value != null) {
                                          //           onSelected(shippingAddresses[index]);
                                          //           Navigator.of(context).pop();
                                          //         }
                                          //       }),
                                          // ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SmallText(
                                                    text: '${shippingAddresses[index].name}',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  SmallText(
                                                      text: '${shippingAddresses[index].phone}',
                                                      fontWeight: FontWeight.w200,
                                                      color: AppColors.grey)
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SmallText(
                                                text: '${shippingAddresses[index].street}',
                                                size: 10,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              SmallText(
                                                text:
                                                    '${shippingAddresses[index].ward}, ${shippingAddresses[index].district}, ${shippingAddresses[index].province}',
                                                size: 10,
                                              ),
                                              Visibility(
                                                visible: shippingAddresses[index].id ==
                                                    repository.currentUser.defaultShippingAddressID,
                                                child: Container(
                                                  margin: const EdgeInsets.only(top: 8),
                                                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                                  decoration: BoxDecoration(border: Border.all(color: AppColors.red)),
                                                  child: SmallText(
                                                    text: 'Default',
                                                    size: 9,
                                                    color: AppColors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Material(
                                            child: InkWell(
                                              onTap: () {
                                                // var shippingAddress = ShippingAddress(
                                                //     userID: '1',
                                                //     province: 'Tỉnh Đồng Nai',
                                                //     district: 'Thành phố Biên Hòa',
                                                //     ward: 'Phường Long Bình',
                                                //     name: 'Ninh Phạm Trung Thành',
                                                //     phone: '0986602759',
                                                //     street: '19/24 Khu Phố 2');
                                                _isDefaultAddress = shippingAddresses[index].id ==
                                                    repository.currentUser.defaultShippingAddressID;
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (_) => AddEditShippingAddressView(
                                                          shippingAddress: shippingAddresses[index],
                                                          isDefaultAddress: _isDefaultAddress,
                                                        )));
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                color: AppColors.grey.withOpacity(0.2),
                                                child: SmallText(
                                                  text: 'EDIT',
                                                  size: 9,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const Divider(),
                                itemCount: shippingAddresses.length),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
