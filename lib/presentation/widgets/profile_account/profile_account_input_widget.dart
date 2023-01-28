import 'package:flutter/material.dart';

typedef VoidCallBack = void Function(String value);

class ProfileAccountInput extends StatelessWidget {
  ProfileAccountInput(
      {Key? key, required this.hintText, required this.onSonChanged})
      : super(key: key);
  late double screenHeight;
  late double screenWidth;
  final String hintText;
  final VoidCallBack onSonChanged;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
        child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(6)),
            height: screenHeight * 0.096,
            child: TextField(
              onChanged: ((value) {
                onSonChanged(value);
              }),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: const Color(0xFFADB5BD),
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: screenHeight * 0.017),
              ),
              style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight * 0.017),
            )));
  }
}
