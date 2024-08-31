import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jnvst_prep/controllers/gemini_controller.dart';
import 'package:jnvst_prep/models/message.dart';
import 'package:jnvst_prep/screens/chat/widgets/input_text_field.dart';
import 'package:jnvst_prep/screens/chat/widgets/my_chat_bubble.dart';
import 'package:jnvst_prep/screens/chat/widgets/my_faq_button.dart';
import 'package:jnvst_prep/utils/tools.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<Message> _messages = [];
  final Message _greeting = Message(
      sender: 'system',
      text:
          'Hey there, future JNVST champ! 🌟 Ready to crush the exam? 💪 Ask me anything! 📚🚀');
  final List<String> faqs = [
    "What is the JNVST exam and what is its purpose?",
    "What is the syllabus for the JNVST exam?",
    "How can I prepare for the JNVST exam?",
    "What is the exam pattern for the JNVST exam?",
    "How can I apply for the JNVST exam?"
  ];
  final GeminiController geminiController = GeminiController.instance;
  @override
  void initState() {
    _messages.add(_greeting);
    geminiController.initGemini();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new)),
          actions: [
            IconButton(
              onPressed: () {
                _messages.clear();
                _messages.add(_greeting);
                setState(() {});
              },
              icon: const FaIcon(FontAwesomeIcons.trashCan),
            )
          ],
        ),
        body: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 16.0,vertical:  2.0),
          child: SizedBox(
            height: getHeight(context) -
                kBottomNavigationBarHeight -
                kToolbarHeight,
            child: Column(
              children: [
                Flexible(
                  child: _messages.length < 2
                      ? _buildInitColumn()
                      : _buildMessageList(),
                ),
                if (isLoading)
                  SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: Lottie.asset(
                        'assets/generating.json',
                      )),
                TextInputField(
                  controller: _controller,
                  focusNode: _focusNode,
                  sendMessage: _sendMessage,
                ),
                space(20)
              ],
            ),
          ),
        ),
        );
  }

  _buildMessageList() => ListView.builder(
        itemBuilder: (context, index) => MyChatBubble(
            text: _messages[index].text,
            isSender: _messages[index].sender == 'user'),
        itemCount: _messages.length,
      );
  _buildInitColumn() => Column(
        children: [
          MyChatBubble(
            isSender: _messages.first.sender == 'user',
            text: _messages.first.text,
          ),
          space(10),
          for (String str in faqs)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: MyFaqButton(
                context: context,
                str: str,
                onPressCallback: () => _handelFaq(str),
              ),
            ),
        ],
      );

  _handelFaq(String text) async {
    _messages.add(Message(sender: 'user', text: text));
    _controller.clear();
    _focusNode.unfocus();
    setState(() => isLoading = true);
    String response = await geminiController.promptAi(_messages.last.text);
    _messages.add(Message(
      text: response,
      sender: 'bot',
    ));
    setState(() => isLoading = false);
  }

  _sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      _messages.add(Message(
        text: _controller.text,
        sender: 'user',
      ));
    } else {
      logEvent("MSG: ${_controller.text}");
    }
    _controller.clear();
    _focusNode.unfocus();
    setState(() => isLoading = true);
    String response = await geminiController.promptAi(_messages.last.text);
    _messages.add(Message(
      text: response,
      sender: 'bot',
    ));
    setState(() => isLoading = false);
  }
}
