import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';

class TextFieldWidget extends StatefulWidget {
  final String value;
  final String hintText;
  final TextInputType keyboardType;

  final Function onFieldTap;
  final Function(String) onValueChanged;

  const TextFieldWidget({
    Key key,
    this.value,
    this.hintText,
    this.keyboardType,
    this.onFieldTap,
    this.onValueChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.value;
    return TextField(
      controller: controller,
      decoration: AppUtils.getTextFieldDecoration(context, widget.hintText),
      textAlign: TextAlign.center,
      cursorColor: Dark_Grey,
      onTap: widget.onFieldTap,
      onChanged: widget.onValueChanged,
      readOnly: widget.onFieldTap != null,
      keyboardType: widget.keyboardType?? TextInputType.text,
    );
  }
}
