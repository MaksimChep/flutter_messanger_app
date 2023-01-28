import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/presentation/widgets/chats/chats_list_widget.dart';
import 'package:flutter_svg/svg.dart';

class ChatsScreen extends StatefulWidget {
  ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late double screenHeight;
  late double screenWidth;

  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(children: [
        Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.019),
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xFFF7F7FC)),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchValue = value;
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(
                            maxHeight: screenHeight * 0.019,
                            maxWidth: screenWidth * 0.106),
                        prefixIcon: Row(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.032,
                            ),
                            SvgPicture.asset('assets/images/search.svg')
                          ],
                        ),
                        hintText: 'Поиск',
                        hintStyle: TextStyle(
                            color: const Color(0xFFADB5BD),
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w600,
                            fontSize: screenHeight * 0.017),
                        border: InputBorder.none),
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                        fontSize: screenHeight * 0.017),
                  ),
                ))),
        Expanded(
            flex: 10,
            child: ChatsList(
              filter: searchValue,
            ))
      ]),
    );
  }
}
