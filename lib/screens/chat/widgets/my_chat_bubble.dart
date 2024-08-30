import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:jnvst_prep/utils/colors.dart';

class MyChatBubble extends StatelessWidget {
  const MyChatBubble({super.key, required this.text, required this.isSender});
  final String text;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper7(
          type: isSender ? BubbleType.sendBubble : BubbleType.receiverBubble),
      alignment: isSender ? Alignment.topRight : null,
      margin: const EdgeInsets.only(top: 20),
      backGroundColor: isSender ? lightLevender : levender.withOpacity(0.9),
      elevation: 1.5,
      shadowColor: isSender ? lightLevender : levender.withOpacity(0.9),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isSender ? levender : Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
      ),
    );
  }
}
