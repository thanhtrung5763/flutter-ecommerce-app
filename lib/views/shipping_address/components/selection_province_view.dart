import 'package:final_project/utils/colors.dart';
import 'package:final_project/models/District.dart';
import 'package:final_project/models/Province.dart';
import 'package:final_project/models/ShippingAddress.dart';
import 'package:final_project/models/Ward.dart';
import 'package:final_project/services/repo/province_repository.dart';
import 'package:final_project/views/test/custom_stepper.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionProvinceView extends StatefulWidget {
  final Function(Province, District, Ward) onSubmitted;
  ShippingAddress? shippingAddress;
  SelectionProvinceView({super.key, required this.onSubmitted, this.shippingAddress});

  @override
  State<SelectionProvinceView> createState() => _SelectionProvinceViewState();
}

class _SelectionProvinceViewState extends State<SelectionProvinceView> {
  ProvinceRepository provinceRepository = ProvinceRepository();
  List<Province>? provinces;
  List<District>? districts;
  List<Ward>? wards;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.shippingAddress != null) {
      _loading = true;
      preloadEditData();
    } else {
      _loading = false;
    }
  }

  Future<void> preloadEditData() async {
    print('calling edit');
    // Find Province
    provinces = await provinceRepository.getProvinces();
    sortProvinces(provinces!);
    _selectedIndexProvince =
        provinces!.indexWhere((element) => element.provinceName == widget.shippingAddress!.province);
    _selectedProvince = provinces![_selectedIndexProvince];

    // Find District
    districts = await provinceRepository.getDistricts(int.parse(_selectedProvince!.provinceId));
    _selectedIndexDistrict =
        districts!.indexWhere((element) => element.districtName == widget.shippingAddress!.district);
    _selectedDistrict = districts![_selectedIndexDistrict];

    // Find Ward
    wards = await provinceRepository.getWards(int.parse(_selectedDistrict!.districtId));
    _selectedIndexWard = wards!.indexWhere((element) => element.wardName == widget.shippingAddress!.ward);
    _selectedWard = wards![_selectedIndexWard];
    setState(() {
      _loading = false;
    });
  }

  late bool _loading;
  int _currentStep = 0;
  int _selectedIndexProvince = -1;
  int _selectedIndexDistrict = -1;
  int _selectedIndexWard = -1;
  Province? _selectedProvince;
  District? _selectedDistrict;
  Ward? _selectedWard;
  String toLowerCaseNonAccentVietnamese(String str) {
    str = str.toLowerCase();

    str = str.replaceAll(RegExp('à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'), 'a');
    str = str.replaceAll(RegExp('è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'), 'e');
    str = str.replaceAll(RegExp('ì|í|ị|ỉ|ĩ'), 'i');
    str = str.replaceAll(RegExp('ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'), 'o');
    str = str.replaceAll(RegExp('ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'), 'u');
    str = str.replaceAll(RegExp('ỳ|ý|ỵ|ỷ|ỹ'), 'y');
    str = str.replaceAll(RegExp('đ'), 'd');

    // Replace combining accents
    str = str.replaceAll(RegExp('[\u0300-\u0309\u0323]'), '');
    str = str.replaceAll(RegExp('[\u02C6\u0306\u031B]'), '');

    return str;
  }

  void sortProvinces(List<Province> data) {
    data.sort((a, b) {
      String aWithoutPrefix = a.provinceName.replaceFirst(RegExp(r'^(Thành phố|Tỉnh) '), '');
      String bWithoutPrefix = b.provinceName.replaceFirst(RegExp(r'^(Thành phố|Tỉnh) '), '');
      aWithoutPrefix = toLowerCaseNonAccentVietnamese(aWithoutPrefix);
      bWithoutPrefix = toLowerCaseNonAccentVietnamese(bWithoutPrefix);
      return aWithoutPrefix.compareTo(bWithoutPrefix);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: 'New Address',
            size: 14,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10.h),
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        colorScheme: Theme.of(context).colorScheme.copyWith(primary: AppColors.black),
                      ),
                      child: CustomStepper(
                        // key: _selectedIndexProvince == -1
                        //     ? const Key("mysuperkey-1")
                        //     : _selectedIndexDistrict == -1
                        //         ? const Key("mysuperkey-2")
                        //         : const Key("mysuperkey-3"),
                        physics: const NeverScrollableScrollPhysics(),
                        margin: EdgeInsets.zero,
                        controlsBuilder: (context, controller) => Row(children: [
                          Container(
                            height: 10,
                          ),
                        ]),
                        steps: [
                          CustomStep(
                            isActive: _currentStep == 0,
                            title: SmallText(
                              text: (_selectedProvince?.provinceName ?? 'Select City'),
                            ),
                            content: const SizedBox.shrink(),
                          ),
                          CustomStep(
                            isActive: _currentStep == 1,
                            state: _selectedIndexProvince != -1 ? CustomStepState.dotted : CustomStepState.disabled,
                            title: SmallText(
                              text: (_selectedDistrict?.districtName ?? 'Select District'),
                              color: (_selectedProvince != '') ? AppColors.black : AppColors.grey,
                            ),
                            content: const SizedBox.shrink(),
                          ),
                          CustomStep(
                            isActive: _currentStep == 2,
                            state: _selectedIndexProvince != -1 && _selectedIndexDistrict != -1
                                ? CustomStepState.dotted
                                : CustomStepState.disabled,
                            title: SmallText(
                              text: (_selectedWard?.wardName ?? 'Select Ward'),
                              color: (_selectedDistrict != '') ? AppColors.black : AppColors.grey,
                            ),
                            content: const SizedBox.shrink(),
                          )
                        ],
                        onStepTapped: (value) {
                          setState(() {
                            _currentStep = value;
                          });
                        },
                        currentStep: _currentStep,
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: _currentStep == 0
                              ? (provinces == null ? provinceRepository.getProvinces() : null)
                              : _currentStep == 1
                                  ? (districts == null
                                      ? provinceRepository.getDistricts(int.parse(_selectedProvince!.provinceId))
                                      : null)
                                  : (wards == null
                                      ? provinceRepository.getWards(int.parse(_selectedDistrict!.districtId))
                                      : null),
                          builder: (context, snapshot) {
                            List<dynamic> data;
                            if (_currentStep == 0 && provinces != null) {
                              data = provinces!;
                              return _ListWidget(data);
                            } else if (_currentStep == 1 && districts != null) {
                              data = districts!;
                              return _ListWidget(data);
                            } else if (_currentStep == 2 && wards != null) {
                              data = wards!;
                              return _ListWidget(data);
                            }
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasData) {
                                List<dynamic> data;
                                if (_currentStep == 0) {
                                  // data = snapshot.data! as List<Province>;
                                  // data.sort((a, b) {
                                  //   String aWithoutPrefix = a.provinceName.replaceFirst(RegExp(r'^(Thành phố|Tỉnh) '), '');
                                  //   String bWithoutPrefix = b.provinceName.replaceFirst(RegExp(r'^(Thành phố|Tỉnh) '), '');
                                  //   aWithoutPrefix = toLowerCaseNonAccentVietnamese(aWithoutPrefix);
                                  //   bWithoutPrefix = toLowerCaseNonAccentVietnamese(bWithoutPrefix);
                                  //   return aWithoutPrefix.compareTo(bWithoutPrefix);
                                  // });
                                  provinces = snapshot.data! as List<Province>;
                                  sortProvinces(provinces!);
                                  data = provinces!;
                                } else if (_currentStep == 1) {
                                  data = snapshot.data! as List<District>;
                                  districts = snapshot.data! as List<District>;
                                } else {
                                  data = snapshot.data! as List<Ward>;
                                  wards = snapshot.data! as List<Ward>;
                                }
                                return _ListWidget(data);
                              } else {
                                return Container(
                                  constraints: const BoxConstraints.expand(),
                                  color: Colors.amber,
                                  child: Center(child: SmallText(text: 'No Data')),
                                );
                              }
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                    // ButtonIconText(
                    //     text: 'Submit',
                    //     height: 42,
                    //     onPressed: () {
                    //       if (_currentStep == 2) {
                    //         widget.onSubmitted(_selectedProvince!, _selectedDistrict!, _selectedWard!);
                    //         Navigator.of(context).pop();
                    //       } else {
                    //         print('Please select city, district, ward');
                    //       }
                    //     })
                  ],
                ),
        ));
  }

  Column _ListWidget(List<dynamic> data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: SmallText(
            text: (data is List<Province>)
                ? 'City'
                : (data is List<District>)
                    ? 'District'
                    : 'Ward',
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (data is List<Province>) {
                        _selectedIndexProvince = index;
                        _selectedProvince = data[_selectedIndexProvince];
                        _currentStep += 1;

                        _selectedIndexDistrict = -1;
                        _selectedDistrict = null;
                        districts = null;
                        _selectedIndexWard = -1;
                        _selectedWard = null;
                        wards = null;
                      } else if (data is List<District>) {
                        _selectedIndexDistrict = index;
                        _selectedDistrict = data[_selectedIndexDistrict];
                        _currentStep += 1;

                        _selectedIndexWard = -1;
                        _selectedWard = null;
                        wards = null;
                      } else {
                        _selectedIndexWard = index;
                        _selectedWard = data[_selectedIndexWard];
                        widget.onSubmitted(_selectedProvince!, _selectedDistrict!, _selectedWard!);
                        Navigator.of(context).pop();
                        // _currentStep += 1;
                      }
                    });
                    // print(data[_selectedIndexProvince].provinceName);
                  },
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
                      title: SmallText(
                        size: 13,
                        text: (data is List<Province>)
                            ? data[index].provinceName.replaceFirst(RegExp(r'^(Thành phố|Tỉnh) '), '')
                            : (data is List<District>)
                                ? data[index].districtName.replaceFirst(RegExp(r'^(Thành phố|Tỉnh) '), '')
                                : (data is List<Ward>)
                                    ? data[index].wardName.replaceFirst(RegExp(r'^(Thành phố|Tỉnh) '), '')
                                    : '',
                        fontWeight: ((data is List<Province> && _selectedIndexProvince == index) ||
                                (data is List<District> && _selectedIndexDistrict == index) ||
                                (data is List<Ward> && _selectedIndexWard == index))
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                      trailing: Visibility(
                        visible: (data is List<Province>)
                            ? _selectedIndexProvince == index
                            : (data is List<District>)
                                ? _selectedIndexDistrict == index
                                : _selectedIndexWard == index,
                        child: const Icon(
                          Icons.check,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 16),
              itemCount: data.length),
        )
      ],
    );
  }
}
