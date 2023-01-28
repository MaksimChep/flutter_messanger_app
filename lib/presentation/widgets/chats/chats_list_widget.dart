import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/data/models/chat_list_item_entity.dart';
import 'package:flutter_messenger_app/presentation/providers/chat_provider.dart';
import 'package:flutter_messenger_app/presentation/screens/specific_chat_screen.dart';
import 'package:provider/provider.dart';

class ChatsList extends StatefulWidget {
  ChatsList({Key? key, required this.filter}) : super(key: key);
  String filter;

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Builder(builder: (context) {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      return FutureBuilder(
          future: chatProvider.getAllChats(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  List<ChatListItem> chatItems =
                      chatProvider.allChats.where((element) {
                    String fullName =
                        '${element.interlocutorData.name} ${element.interlocutorData.surname}';
                    if (fullName.toLowerCase().contains(widget.filter)) {
                      return true;
                    }
                    return false;
                  }).toList();
                  return ListView.separated(
                      itemCount: chatItems.length,
                      separatorBuilder: ((context, index) {
                        return SizedBox(height: screenHeight * 0.019);
                      }),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpecificChatScreen(
                                      interlocutorData:
                                          chatItems[index].interlocutorData))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.064),
                            child: Row(
                              children: [
                                Container(
                                    height: screenWidth * 0.128,
                                    width: screenWidth * 0.128,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF166FF6),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Builder(builder: (context) {
                                      if (chatItems[index]
                                              .interlocutorData
                                              .profileImage ==
                                          '') {
                                        return Center(
                                            child: Text(
                                                chatItems[index]
                                                        .interlocutorData
                                                        .name[0] +
                                                    chatItems[index]
                                                        .interlocutorData
                                                        .surname[0],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Lato',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        screenHeight * 0.017)));
                                      }
                                      return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                              chatItems[index]
                                                  .interlocutorData
                                                  .profileImage,
                                              fit: BoxFit.fill));
                                    })),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.032),
                                  child: SizedBox(
                                    width: screenWidth * 0.69,
                                    height: screenWidth * 0.128,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${chatItems[index].interlocutorData.name} ${chatItems[index].interlocutorData.surname}',
                                                style: TextStyle(
                                                    fontFamily: 'Mulish',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        screenHeight * 0.017)),
                                            Builder(builder: (context) {
                                              DateTime time = DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      chatItems[index]
                                                          .lastChatItem
                                                          .time);
                                              return Text(
                                                  '${time.day}/${time.month} ${time.hour}:${time.minute}',
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFFA4A4A4),
                                                      fontFamily: 'Mulish',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: screenHeight *
                                                          0.015));
                                            }),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: screenWidth * 0.62,
                                                child: Text(
                                                    chatItems[index]
                                                        .lastChatItem
                                                        .message,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFFA4A4A4),
                                                        fontFamily: 'Mulish',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: screenHeight *
                                                            0.017))),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }));
                }
              default:
                return const Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
