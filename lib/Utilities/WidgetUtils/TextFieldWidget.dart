import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';
import 'package:auto_direction/auto_direction.dart';

class TextFieldWidget extends StatefulWidget {
  final String value;
  final String hintText;
  final TextInputType keyboardType;

  final Function onFieldTap;
  final Function(bool) isTextRTL;
  final Function(String) onValueChanged;

  const TextFieldWidget({
    Key key,
    this.value,
    this.hintText,
    this.keyboardType,
    this.onFieldTap,
    this.isTextRTL,
    this.onValueChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  String textFieldValue = "";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      controller.value = controller.value.copyWith(
        text: widget.value
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // controller.text = widget.value;
    return AutoDirection(
      text: textFieldValue,
      onDirectionChange: widget.isTextRTL,
      child: TextFormField(
        controller: AppUtils.isNotEmptyText(widget.value)? controller : null,
        decoration: AppUtils.getTextFieldDecoration(context, widget.hintText),
        textAlign: TextAlign.center,
        cursorColor: Dark_Grey,
        onTap: widget.onFieldTap,
        onChanged: (value){
          widget.onValueChanged(value);
          setState(() {
            textFieldValue = value;
          });
        },
        readOnly: widget.onFieldTap != null,
        keyboardType: widget.keyboardType?? TextInputType.text,
      ),
    );
  }
}
