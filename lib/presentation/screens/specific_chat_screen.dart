import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';
import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/presentation/providers/chat_provider.dart';
import 'package:flutter_messenger_app/presentation/widgets/specific_chat/chat_list_tile_widget.dart';
import 'package:flutter_messenger_app/presentation/widgets/specific_chat/chat_text_field_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SpecificChatScreen extends StatefulWidget {
  final UserData interlocutorData;
  const SpecificChatScreen({Key? key, required this.interlocutorData})
      : super(key: key);

  @override
  State<SpecificChatScreen> createState() => _SpecificChatScreenState();
}

class _SpecificChatScreenState extends State<SpecificChatScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/images/arrow.svg',
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
              '${widget.interlocutorData.name} ${widget.interlocutorData.surname}',
              style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight * 0.022,
                  color: Colors.black))),
      body: SafeArea(child: Builder(builder: (context) {
        final chatProvider = Provider.of<ChatProvider>(context, listen: false);

        return Column(
          children: [
            FutureBuilder(
                future: chatProvider
                    .getConversationStream(widget.interlocutorData.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final Stream<DatabaseEvent> stream =
                        chatProvider.conversationStream;
                    stream.listen(
                      (event) async {
                        setState(() {});
                      },
                    );
                    return FutureBuilder(
                        future: chatProvider
                            .getConversation(widget.interlocutorData.id),
                        builder: (context, snapshot) {
                          List<ChatInfo> conversation =
                              chatProvider.conversation;
                          switch (snapshot.connectionState) {
                            case ConnectionState.done:
                              return Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: conversation.length,
                                  itemBuilder: (context, index) =>
                                      ChatListTileWidget(
                                          chatItem: conversation[index]),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12.0),
                                ),
                              );
                            default:
                              return const Center(
                                  child: CircularProgressIndicator());
                          }
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            ChatTextFieldWidget(
              provider: chatProvider,
              interlocutorId: widget.interlocutorData.id,
            )
          ],
        );
      })),
    );
  }
}
