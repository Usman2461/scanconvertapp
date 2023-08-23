import 'package:flutter/material.dart';

class GradientInkWell extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  GradientInkWell({required this.onTap, required this.child});

  @override
  _GradientInkWellState createState() => _GradientInkWellState();
}

class _GradientInkWellState extends State<GradientInkWell> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isTapped
              ? LinearGradient(
            colors: [Color(0xff181818), Color(0xffEA3434),],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.child,
      ),
    );
  }
}