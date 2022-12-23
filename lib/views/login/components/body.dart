import 'package:final_project/size_config.dart';
import 'package:final_project/views/login/components/login_footer.dart';
import 'package:final_project/views/login/components/login_form.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /* -- Section-1 [Header] -- */
                BigText(
                  text: 'Login',
                  size: getProportionateScreenWidth(34),
                ),
                /* -- Section-2 [Form] -- */
                const LoginForm(),
                /* -- Section-3 [Footer] -- */
                const LoginFooter()
              ],
            ),
          ),
        ),
      );
  }
}