import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';

class RaisedButtonWidget extends StatefulWidget {
  final String buttonTitle;
  final Function onButtonTap;
  final Color buttonColor;
  final Color titleColor;

  const RaisedButtonWidget({
    Key key,
    this.buttonTitle,
    this.onButtonTap,
    this.buttonColor,
    this.titleColor,
  }) : super(key: key);

  @override
  _RaisedButtonWidgetState createState() => _RaisedButtonWidgetState();
}

class _RaisedButtonWidgetState extends State<RaisedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onButtonTap ?? null,
      color: widget.buttonColor ?? White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BUTTON_BORDER_RADUIS),
      ),
      elevation: 5,
      child: Text(widget.buttonTitle ?? ""),
    );
  }
}
