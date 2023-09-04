import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class TextIconButton extends StatefulWidget {
  final String text;
  final String iconData;

  TextIconButton({required this.text, required this.iconData});

  @override
  _TextIconButtonState createState() => _TextIconButtonState();
}

class _TextIconButtonState extends State<TextIconButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isTapped
              ? LinearGradient(
                  colors: [Colors.transparent,Colors.red,],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null, // No gradient when not tapped
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.iconData,
              height: 22,
              width: 20,
            ),
            SizedBox(height: 4.0),
            Text(
              widget.text,
              style: TextStyle(
                color: isTapped ? Colors.white : Colors.white,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
