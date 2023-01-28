import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/data/services/realtime_database_service.dart';
import 'package:flutter_messenger_app/presentation/screens/home/chats/chats_screen.dart';
import 'package:flutter_messenger_app/presentation/screens/home/contacts/contacts_screen.dart';
import 'package:flutter_messenger_app/presentation/screens/more_screen.dart';
import 'package:flutter_messenger_app/presentation/widgets/chats/chats_appbar_widget.dart';
import 'package:flutter_messenger_app/presentation/widgets/contacts/contacts_appbar_widget.dart';
import 'package:flutter_messenger_app/presentation/widgets/more/more_appbar_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MultiMainScreen extends StatefulWidget {
  const MultiMainScreen({Key? key}) : super(key: key);

  @override
  State<MultiMainScreen> createState() => _MultiMainScreenState();
}

class _MultiMainScreenState extends State<MultiMainScreen> {
  int index = 1;
  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _getAppBar(),
      ),
      body: _getScreen(),
      bottomNavigationBar: BottomNavyBar(
          containerHeight: screenHeight * 0.102,
          selectedIndex: index,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          onItemSelected: ((value) => setState(() {
                index = value;
              })),
          items: [
            _bottomNavyBarItem('contacts', 0),
            _bottomNavyBarItem('chats', 1),
            _bottomNavyBarItem('more', 2),
          ]),
    );
  }

  Widget _getAppBar() {
    switch (index) {
      case 0:
        return ContactsAppBar();
      case 1:
        return ChatsAppBar();
      default:
        return MoreAppBar();
    }
  }

  Widget _getScreen() {
    switch (index) {
      case 0:
        return const ContactsScreen();
      case 1:
        return ChatsScreen();
      default:
        return const MoreScreen();
    }
  }

  BottomNavyBarItem _bottomNavyBarItem(String item, int index) {
    return BottomNavyBarItem(
        activeColor: Colors.white,
        textAlign: TextAlign.center,
        icon: this.index == index
            ? Container()
            : SvgPicture.asset('assets/images/$item.svg'),
        title: this.index == index
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  item[0].toUpperCase() + item.substring(1),
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                      fontSize: screenHeight * 0.02),
                ),
                Container(
                  height: screenWidth * 0.013,
                  width: screenWidth * 0.013,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                )
              ])
            : Container());
  }
}
