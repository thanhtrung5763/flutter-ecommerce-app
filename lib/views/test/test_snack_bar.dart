import 'package:final_project/utils/colors.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

class TestSnackBar extends StatelessWidget {
  const TestSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonIconText(
                text: 'Green SnackBar',
                onPressed: () {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1500),
                        backgroundColor: AppColors.green,
                        content: Text('Green SnackBar'),
                      ),
                    );
                }),
            ButtonIconText(
                text: 'Red SnackBar',
                onPressed: () {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1500),
                        backgroundColor: AppColors.redError,
                        content: Text('Green SnackBar'),
                      ),
                    );
                }),
            ButtonIconText(
                text: 'Show Dialog',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            actionsPadding: const EdgeInsets.all(12),
                            actions: [
                              ButtonIconText(
                                text: 'OK',
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                width: double.maxFinite,
                                height: 40,
                                textSize: 12,
                              )
                            ],
                            titlePadding: const EdgeInsets.all(8),
                            title: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 48, maxWidth: 48),
                              child: const Icon(
                                Icons.cancel,
                                size: 56,
                                color: AppColors.red,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            shape: const RoundedRectangleBorder(),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: SmallText(
                                    text: 'Your card has insufficient funds.',
                                    size: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ));
                }),
          ],
        ),
      ),
    );
  }
}
