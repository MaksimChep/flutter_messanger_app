import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/presentation/providers/chat_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatTextFieldWidget extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  final ChatProvider provider;
  final String interlocutorId;
  ChatTextFieldWidget(
      {Key? key, required this.provider, required this.interlocutorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    color: const Color(0xFFF7F7FC),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 8.0),
                      child: TextField(
                        controller: textController,
                        maxLines: 3,
                      ),
                    )),
              ),
              const SizedBox(
                width: 16.0,
              ),
              GestureDetector(
                  onTap: () async {
                    await provider.sendMessage(
                        textController.text, interlocutorId);
                  },
                  child: SvgPicture.asset('assets/images/send_button.svg')),
            ],
          )),
    );
  }
}
