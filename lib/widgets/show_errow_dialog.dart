import 'package:final_project/views/test/custom_paint_triangle.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An error occurred'),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            )
          ],
        );
      });
}

Future<void> showSortDialog(BuildContext context, List<String> options) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: CustomDialogBorder(),
          insetPadding: EdgeInsets.zero,
          alignment: Alignment(-0.5, -0.6),
          title: const Text('An error occurred'),
          content: Container(
            height: 100.0, // Change as per your requirement
            width: 150.0, // Change as per your requirement
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Gujarat, India'),
                );
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            )
          ],
        );
      });
}

class MyDialog extends StatefulWidget {
  MyDialog(
      {super.key,
      required this.sortOptions,
      required this.selectedSortOption,
      required this.onSelectedSortOptionChanged});

  List<String> sortOptions;
  String selectedSortOption;
  ValueChanged<String> onSelectedSortOptionChanged;

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  String _selectedSortOption = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedSortOption = widget.selectedSortOption;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: CustomDialogBorder(),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.fromLTRB(8, 12, 12, 12),
      alignment: Alignment(-0.5, -0.6),
      content: Container(
        height: 200.0, // Change as per your requirement
        width: 150.0, // Change as per your requirement
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.sortOptions.length,
          itemBuilder: (BuildContext context, int index) {
            final option = widget.sortOptions[index];
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedSortOption = option;
                });
                widget.onSelectedSortOptionChanged(_selectedSortOption);
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  _selectedSortOption == option
                      ? Transform.scale(
                          scale: 0.4,
                          child: Checkbox(
                            shape: CircleBorder(),
                            visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                            value: _selectedSortOption == option,
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  _selectedSortOption = option;
                                });
                              }
                            },
                          ),
                        )
                      : Container(
                          height: 32,
                          width: 32,
                        ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    option,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            indent: 36,
            thickness: 1.02,
          ),
        ),
      ),
      // actions: [
      //   TextButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: const Text('Ok'),
      //   )
      // ],
    );
  }
}
