import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/data/models/country_code_entity.dart';
import 'package:flutter_messenger_app/presentation/providers/auth_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/country_code_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/phone_validator_provider.dart';
import 'package:flutter_messenger_app/presentation/screens/verification_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({Key? key}) : super(key: key);

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  late CountryCodeProvider _countryCodeProvider;
  late List<CountryCode> _countryCodes;
  late double screenHeight;
  late double screenWidth;
  String selectedCode = 'UA';
  String phoneNumber = "";
  String fullPhoneNumber = "";

  @override
  Widget build(BuildContext context) {
    _countryCodeProvider = context.watch<CountryCodeProvider>();
    _countryCodes = _countryCodeProvider.countryCodes;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
          child: Column(
        children: [
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
                          text: 'Введите свой номер телефона\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: screenHeight * 0.029)),
                      TextSpan(
                          text:
                              'Пожалуйста, подтвердите код страны и введите свой\n\n номер телефона',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: screenHeight * 0.017))
                    ]),
              )),
          const Spacer(flex: 1),
          Expanded(
              flex: 2,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(6)),
                              height: screenHeight * 0.0443,
                              child: DropdownButton(
                                underline: const SizedBox(),
                                menuMaxHeight: screenHeight * 0.266,
                                value: selectedCode,
                                items: List.generate(
                                    _countryCodes.length,
                                    (index) => DropdownMenuItem(
                                        value: _countryCodes[index].code,
                                        child: Text(
                                            '${_countryCodes[index].flag} ${_countryCodes[index].dialCode}',
                                            style: TextStyle(
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    screenHeight * 0.017)))),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCode = newValue.toString();
                                    print(selectedCode);
                                  });
                                },
                              ))),
                      const Spacer(flex: 1),
                      Expanded(
                          flex: 9,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(6)),
                              height: screenHeight * 0.0443,
                              child: TextField(
                                onChanged: ((value) {
                                  setState(() {
                                    phoneNumber = value;
                                    String dialCode = _countryCodes
                                        .firstWhere((element) =>
                                            element.code == selectedCode)
                                        .dialCode;
                                    fullPhoneNumber = dialCode + phoneNumber;
                                    print(fullPhoneNumber);
                                  });
                                }),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Номер телефона',
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
                                keyboardType: TextInputType.phone,
                              )))
                    ],
                  ))),
          const Spacer(flex: 19)
        ],
      )),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  screenHeight * 0.066,
              left: screenWidth * 0.064,
              right: screenWidth * 0.064),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.872, screenHeight * 0.064),
                primary: const Color(0xFF002DE3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0))),
            onPressed: () async {
              final phoneValidatorProvider =
                  Provider.of<PhoneValidatorProvider>(context, listen: false);
              await phoneValidatorProvider.isPhoneValid(
                  phoneNumber, selectedCode);
              bool isValid = phoneValidatorProvider.isValid;
              print(isValid);
              if (isValid) {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                authProvider.createUserWithPhoneNumber(fullPhoneNumber);
                print(authProvider.errorMessage);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            VerificationScreen(phoneNumber: fullPhoneNumber)));
              }
            },
            child: Text('Продолжить',
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: screenHeight * 0.019)),
          )),
    );
  }
}
