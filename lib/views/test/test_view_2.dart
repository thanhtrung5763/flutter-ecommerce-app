import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class TestView2 extends StatefulWidget {
  const TestView2({super.key});

  @override
  State<TestView2> createState() => _TestView2State();
}

class _TestView2State extends State<TestView2> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    final subCategoryItems = [
      'New in',
      'Trainers',
      'Boots',
      'Loafers',
      'Sandals',
      'Shoes'
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: SmallText(
                        text: subCategoryItems[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: subCategoryItems.length),
            ),
            RangeSlider(
              values: _currentRangeValues,
              max: 100,
              divisions: 100,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
