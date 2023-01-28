import 'package:flutter/material.dart';

class MoreAppBar extends StatelessWidget {
  MoreAppBar({Key? key}) : super(key: key);
  late double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Text('More',
        style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w600,
            fontSize: screenHeight * 0.022,
            color: Colors.black));
  }
}
