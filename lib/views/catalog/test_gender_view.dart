import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class MyTestGenderView extends StatelessWidget {
  const MyTestGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> genderOptions = ["Men", "Women", "Unisex"];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            // use for Capitalize Each Word '${finerCategory!.title!.split('-').map((e) => toBeginningOfSentenceCase(e)).join(' ')}'
            text: 'GENDER',
            size: 14,
          ),
          actions: [
            Container(
              width: 48,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              color: AppColors.grey.withOpacity(0.4),
              child: Center(
                  child: SmallText(
                text: 'ALL',
                size: 12,
                fontWeight: FontWeight.w600,
              )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            children: [
              Container(
                height: 10,
                color: AppColors.grey.withOpacity(0.25),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          title: Wrap(children: [
                            SmallText(
                              text: '${genderOptions[index]}',
                              size: 13,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SmallText(
                              text: '(1945)',
                              size: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                          ]),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        indent: 16,
                      );
                    },
                    itemCount: genderOptions.length),
              ),
              ButtonIconText(
                onPressed: () {},
                text: 'VIEW ITEMS',
                backgroundColor: AppColors.black,
              )
            ],
          ),
        ));
  }
}
