import 'package:final_project/utils/colors.dart';
import 'package:final_project/models/District.dart';
import 'package:final_project/models/Province.dart';
import 'package:final_project/models/ShippingAddress.dart';
import 'package:final_project/models/Ward.dart';
import 'package:final_project/services/cloud/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:final_project/views/shipping_address/components/selection_province_view.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEditShippingAddressView extends StatefulWidget {
  ShippingAddress? shippingAddress;
  bool isDefaultAddress;
  late bool isEditable;
  AddEditShippingAddressView({super.key, this.shippingAddress, this.isDefaultAddress = false});

  @override
  State<AddEditShippingAddressView> createState() => _AddEditShippingAddressViewState();
}

class _AddEditShippingAddressViewState extends State<AddEditShippingAddressView> {
  bool _isTextFieldChanged = false;
  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _locationController; // province, district, ward
  late final TextEditingController _streetController; // street, house no.

  Province? _selectedProvince;
  District? _selectedDistrict;
  Ward? _selectedWard;
  void _setLocationFromChild(Province province, District district, Ward ward) {
    setState(() {
      _selectedProvince = province;
      _selectedDistrict = district;
      _selectedWard = ward;
    });
    print('in parent');
    print('${_selectedProvince?.provinceName}, ${_selectedDistrict?.districtName}, ${_selectedWard?.wardName}');
    _locationController.text = "${_selectedProvince?.provinceName}\n"
        "${_selectedDistrict?.districtName}\n"
        "${_selectedWard?.wardName}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = TextEditingController();
    _phone = TextEditingController();
    _locationController = TextEditingController();
    _streetController = TextEditingController();
    widget.isEditable = widget.isDefaultAddress;
    if (widget.shippingAddress != null) {
      parseEditData();
    }
    // _name.addListener(_handleTextChange);
    // _phone.addListener(_handleTextChange);
    // _locationController.addListener(_handleTextChange);
    // _streetController.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _phone.dispose();
    _locationController.dispose();
    _streetController.dispose();
  }

  void parseEditData() {
    _name.text = widget.shippingAddress!.name!;
    _phone.text = widget.shippingAddress!.phone!;
    _locationController.text = "${widget.shippingAddress!.province!}\n"
        "${widget.shippingAddress!.district!}\n"
        "${widget.shippingAddress!.ward!}";
    _streetController.text = widget.shippingAddress!.street!;
  }

  void _handleTextChange() {
    setState(() {
      _isTextFieldChanged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: 'Address Selection',
            size: 14,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: SmallText(
                            text: 'Contact',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          color: Colors.white,
                          child: Column(
                            children: [
                              TextField(
                                controller: _name,
                                onChanged: (value) {
                                  _handleTextChange();
                                },
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Full Name',
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(top: 14, bottom: 12),
                                  border: InputBorder.none,
                                ),
                              ),
                              const Divider(
                                height: 1,
                              ),
                              TextField(
                                controller: _phone,
                                onChanged: (value) {
                                  _handleTextChange();
                                },
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Phone Number',
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(top: 14, bottom: 12),
                                  border: InputBorder.none,
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: SmallText(
                            text: 'Address',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          color: Colors.white,
                          child: Column(
                            children: [
                              TextField(
                                maxLines: null,
                                controller: _locationController,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => SelectionProvinceView(
                                          onSubmitted: _setLocationFromChild,
                                          shippingAddress: widget.shippingAddress)));
                                },
                                readOnly: true,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'City, District, Ward',
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(top: 14, bottom: 12),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: AppColors.grey,
                                  ),
                                  suffixIconConstraints: BoxConstraints(maxHeight: 14, maxWidth: 14),
                                ),
                              ),
                              const Divider(
                                height: 1,
                              ),
                              TextField(
                                controller: _streetController,
                                onChanged: (value) {
                                  _handleTextChange();
                                },
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Street Name, Building, House No.',
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(top: 14, bottom: 12),
                                  border: InputBorder.none,
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: SmallText(
                            text: 'Settings',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12.w),
                          color: Colors.white,
                          height: 50.h,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.isDefaultAddress = !widget.isDefaultAddress;
                                  });
                                  _handleTextChange();
                                },
                                child: Row(
                                  children: [
                                    SmallText(
                                      text: 'Set as Default Address',
                                      size: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    const Spacer(),
                                    // Transform.scale(
                                    //   scale: 0.75,
                                    //   child: Checkbox(
                                    //     shape: const CircleBorder(),
                                    //     visualDensity: const VisualDensity(
                                    //         horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                                    //     value: widget.isDefaultAddress,
                                    //     onChanged: (bool? value) {
                                    //       if (value != null) {
                                    //         setState(() {
                                    //           widget.isDefaultAddress = !widget.isDefaultAddress;
                                    //         });
                                    //       }
                                    //     },
                                    //   ),
                                    // )
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Switch.adaptive(
                                        activeColor: AppColors.black,
                                        activeTrackColor: AppColors.grey04,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: AppColors.grey04,
                                        value: widget.isDefaultAddress,
                                        onChanged: (value) {
                                          if (!widget.isEditable) {
                                            setState(() {
                                              widget.isDefaultAddress = !widget.isDefaultAddress;
                                            });
                                            _handleTextChange();
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                duration: Duration(milliseconds: 1500),
                                                content: Text('Choose a different default address first'),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Visibility(
                                visible: widget.shippingAddress != null,
                                child: OutlinedButtonIconText(
                                  height: 42,
                                  text: 'DELETE ADDRESS',
                                  onPressed: () {
                                    if (widget.isDefaultAddress) {
                                      context
                                          .read<ShippingAddressBloc>()
                                          .add(ShippingAddressRemoveEvent(shippingAddress: widget.shippingAddress!));
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ButtonIconText(
                                text: 'SAVE ADDRESS',
                                height: 42,
                                onPressed: _isTextFieldChanged
                                    ? () {
                                        if (widget.shippingAddress == null) {
                                          print(_name.text);
                                          print(_phone.text);
                                          print(_locationController.text);
                                          print(_streetController.text);
                                          print(_selectedProvince?.provinceName);
                                          final shippingAddress = ShippingAddress(
                                              userID: '',
                                              name: _name.text,
                                              phone: _phone.text,
                                              province: _selectedProvince?.provinceName,
                                              district: _selectedDistrict?.districtName,
                                              ward: _selectedWard?.wardName,
                                              street: _streetController.text);
                                          print("aaa: ${widget.isDefaultAddress}");
                                          context.read<ShippingAddressBloc>().add(ShippingAddressAddEvent(
                                              shippingAddress: shippingAddress,
                                              isDefaultAddress: widget.isDefaultAddress));
                                          Navigator.of(context).pop();
                                          // Navigator.of(context).pop(true);

                                          // Navigator.of(context).popUntil((route) {
                                          //   print("Route: ${route.settings.name}");

                                          //   return route.settings.name == '/checkout' || route.settings.name == '/';
                                          // });
                                        } else {
                                          widget.shippingAddress = widget.shippingAddress!.copyWith(
                                              name: _name.text,
                                              phone: _phone.text,
                                              province:
                                                  _selectedProvince?.provinceName ?? widget.shippingAddress!.province,
                                              district:
                                                  _selectedDistrict?.districtName ?? widget.shippingAddress!.district,
                                              ward: _selectedWard?.wardName ?? widget.shippingAddress!.ward,
                                              street: _streetController.text);
                                          context.read<ShippingAddressBloc>().add(ShippingAddressEditEvent(
                                              shippingAddress: widget.shippingAddress!,
                                              isDefaultAddress: widget.isDefaultAddress));
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    : null,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
