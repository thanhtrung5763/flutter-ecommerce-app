import 'package:final_project/size_config.dart';
import 'package:final_project/views/confirm/components/confirmation_form.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /* -- Section-1 [Header] -- */
              BigText(
                text: 'Confirmation',
                size: getProportionateScreenWidth(34),
              ),
              /* -- Section-2 [Form] -- */
              ConfirmationForm(
              ),
              /* -- Section-3 [Footer] -- */
            ],
          ),
        ),
      ),
    );
  }
}
