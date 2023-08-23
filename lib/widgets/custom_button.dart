import 'package:flutter/material.dart';
class CButton extends StatelessWidget {
  String text;
  Function onPress;
  double width;
  double height;
  Color color;
  double fontSize;
  Color textColor;
  double borderRadius;
  BorderSide borderSide;

  CButton(
      {Key? key,
        this.fontSize = 16,
        this.textColor = Colors.white,
        required this.text,
        required this.onPress,
        this.width = double.infinity,
        this.height = 40.0,
        this.borderRadius=20.0,
        this.color = Colors.red,
        this.borderSide=BorderSide.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: borderSide,
              )),
          onPressed: () {
            onPress();
          },
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: textColor),
          )),
    );
  }
}