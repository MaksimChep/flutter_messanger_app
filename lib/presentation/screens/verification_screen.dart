import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/presentation/providers/auth_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/user_data_provider.dart';
import 'package:flutter_messenger_app/presentation/screens/home/home_screen.dart';
import 'package:flutter_messenger_app/presentation/screens/profile_account_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String pinCode = "";
  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Column(children: [
            Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.064, top: screenHeight * 0.024),
                    child: Row(
                      children: [
                        GestureDetector(
                            child: SvgPicture.asset(
                              'assets/images/arrow.svg',
                              fit: BoxFit.fill,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            })
                      ],
                    ))),
            const Spacer(flex: 6),
            Expanded(
                flex: 5,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: const TextStyle(
                          fontFamily: 'Mulish', color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'Введите код\n\n',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: screenHeight * 0.029)),
                        TextSpan(
                            text:
                                'Мы отправили вам SMS с кодом\n\n на номер ${widget.phoneNumber}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: screenHeight * 0.017))
                      ]),
                )),
            const Spacer(flex: 1),
            Expanded(
                flex: 4,
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight * 0.039),
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.circle,
                          inactiveColor: const Color(0xFFEDEDED),
                          inactiveFillColor: const Color(0xFFEDEDED),
                          activeColor: Colors.white,
                          activeFillColor: Colors.white,
                          selectedColor: const Color(0xFFEDEDED),
                          selectedFillColor: const Color(0xFFEDEDED)),
                      onChanged: (value) {
                        pinCode = value;

                        print(pinCode);
                      },
                      onCompleted: (value) async {
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        await authProvider.verifyOTP(pinCode);
                        if (authProvider.errorMessage == "") {
                          final userDataProvider =
                              Provider.of<UserDataProvider>(context,
                                  listen: false);
                          await userDataProvider.userExists();
                          bool userExist = userDataProvider.exists;
                          if (!userExist) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileAccountScreen(
                                        phoneNumber: widget.phoneNumber)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MultiMainScreen()));
                          }
                        }
                        print(authProvider.errorMessage);
                      },
                    ))),
            const Spacer(flex: 19)
          ]),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  screenHeight * 0.066,
              left: screenWidth * 0.064,
              right: screenWidth * 0.064),
          child: GestureDetector(
              child: Text('Отправить код еще раз',
                  style: TextStyle(
                      color: const Color(0xFF002DE3),
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      fontSize: screenHeight * 0.019)),
              onTap: () {}),
        ));
  }
}
