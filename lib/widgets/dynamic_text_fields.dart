import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DynamicFields extends StatefulWidget {
  final String id;
  final int index;
  final List<String> directionList;
  final String hintText;
  const DynamicFields({Key? key, required this.index, required this.directionList, required this.hintText, required this.id}) : super(key: key);
  @override
  _DynamicFieldsState createState() => _DynamicFieldsState();
}

class _DynamicFieldsState extends State<DynamicFields> {
  TextEditingController? _directionController;
  @override
  void initState() {
    super.initState();
    _directionController = TextEditingController();
  }

  @override
  void dispose() {
    _directionController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _directionController?.text;
    });

    return FormBuilderTextField(
      controller: _directionController,

      onChanged: (value) =>
        widget.directionList[widget.index] = value!,
        decoration:  InputDecoration(hintText: widget.hintText),
       validator: (value) {
          if(widget.id =='quantity'){
          if(double.tryParse(value!) == null){
            return 'integer';
          }
         }
          if (value!.isEmpty) return 'Please fill all fields';
          return null;},
      name: '${widget.id}${widget.index}',
    );
  }
}