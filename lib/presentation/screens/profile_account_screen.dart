import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/presentation/providers/image_storage_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/shared_preferences_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/user_data_provider.dart';
import 'package:flutter_messenger_app/presentation/screens/home/home_screen.dart';
import 'package:flutter_messenger_app/presentation/widgets/profile_account/profile_account_input_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProfileAccountScreen extends StatefulWidget {
  const ProfileAccountScreen({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;
  @override
  State<ProfileAccountScreen> createState() => _ProfileAccountScreenState();
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {
  late double screenHeight;
  late double screenWidth;
  String name = "";
  String surname = "";
  File? image;
  @override
  Widget build(BuildContext context) {
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
                          }),
                      SizedBox(width: screenWidth * 0.04),
                      Text('Ваш профиль',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                              fontSize: screenHeight * 0.022))
                    ],
                  ))),
          const Spacer(flex: 4),
          Expanded(
              flex: 6,
              child: GestureDetector(onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  if (pickedFile != null) {
                    image = File(pickedFile.path);
                    print(basename(image!.path));
                  }
                });
              }, child: Builder(
                builder: (context) {
                  if (image == null) {
                    return SvgPicture.asset(
                      'assets/images/changeAvatar.svg',
                      fit: BoxFit.fill,
                    );
                  } else {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.file(image!, fit: BoxFit.fill));
                  }
                },
              ))),
          const Spacer(flex: 2),
          Expanded(
              flex: 2,
              child: ProfileAccountInput(
                hintText: 'Имя (обязательно)',
                onSonChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              )),
          const Spacer(flex: 1),
          Expanded(
              flex: 2,
              child: ProfileAccountInput(
                hintText: 'Фамилия (необязательно)',
                onSonChanged: (value) {
                  setState(() {
                    surname = value;
                  });
                },
              )),
          const Spacer(flex: 21)
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
              if (name == "") {
              } else {
                final sharedPreferencesProvider =
                    Provider.of<SharedPreferencesProvider>(context,
                        listen: false);
                await sharedPreferencesProvider.getUid();
                String uid = sharedPreferencesProvider.uid;
                String url = '';
                final imageStorageProvider =
                    Provider.of<ImageStorageProvider>(context, listen: false);
                if (image != null) {
                  await imageStorageProvider.addToStorage(uid, image!);

                  await imageStorageProvider.getDownloadUrl();
                  url = imageStorageProvider.imageUrl;

                  print(url);
                }

                final userDataProvider =
                    Provider.of<UserDataProvider>(context, listen: false);
                userDataProvider.createUser(
                    name, surname, widget.phoneNumber, url);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MultiMainScreen()),
                    (route) => false);
              }
            },
            child: Text('Сохранить',
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: screenHeight * 0.019)),
          )),
    );
  }
}
