import 'package:final_project/services/cloud/bloc/saved_storage/saved_storage_bloc.dart';
import 'package:final_project/views/catalog/catalog_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPrefilledSearch extends StatefulWidget {
  const MyPrefilledSearch({Key? key}) : super(key: key);

  @override
  State<MyPrefilledSearch> createState() => _MyPrefilledSearchState();
}

class _MyPrefilledSearchState extends State<MyPrefilledSearch> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      itemSize: 18,
      prefixInsets: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 3),
      padding: const EdgeInsetsDirectional.fromSTEB(5.5, 6, 5.5, 6),
      controller: _textController,
      borderRadius: BorderRadius.circular(20),
      onChanged: (value) => print('Text has changed to: $value'),
      onSubmitted: (value) {
        // => print('Submitted text: $value')
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<SavedStorageBloc>(context),
                    child: CatalogView(
                      textSearch: value,
                    ),
                  )),
        );
        _textController.clear();
      },
    );
  }
}
