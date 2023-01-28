import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/presentation/screens/phone_input_screen.dart';
import 'package:flutter_svg/svg.dart';

class WalkthroughScreen extends StatelessWidget {
  WalkthroughScreen({Key? key}) : super(key: key);
  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          const Spacer(flex: 2),
          Expanded(
            flex: 5,
            child: SvgPicture.asset('assets/images/walkthrough.svg',
                fit: BoxFit.fill),
          ),
          const Spacer(flex: 1),
          Expanded(
              flex: 3,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.125),
                  child: Text(
                    'Легко связывайтесь со своей семьей и друзьями на расстоянии',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.029),
                  ))),
          const Spacer(flex: 2)
        ]),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
              bottom: screenHeight * 0.066,
              left: screenWidth * 0.064,
              right: screenWidth * 0.064),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.872, screenHeight * 0.064),
                primary: const Color(0xFF002DE3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0))),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PhoneInputScreen()));
            },
            child: Text('Начать общение',
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: screenHeight * 0.019)),
          )),
    );
  }
}
