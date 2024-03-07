import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Views/Screens/Chats/chats_widgets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController messageController = TextEditingController();

  var messages = [
    Messages(message: 'Yes it is', isSenderMe: true),
    Messages(message: 'Is it availaible on Monday', isSenderMe: false),
    Messages(message: 'Yes please', isSenderMe: true),
    Messages(message: 'I want some information', isSenderMe: false),
    Messages(message: 'Ok then i wanna book for one day', isSenderMe: false),
    Messages(message: 'Yes it is', isSenderMe: true),
    Messages(message: 'Is it availaible on Monday', isSenderMe: false),
    Messages(message: 'Yes please', isSenderMe: true),
    Messages(message: 'I want some information', isSenderMe: false),
    Messages(message: 'Ok then i wanna book for one day', isSenderMe: false),
    Messages(message: 'Yes it is', isSenderMe: true),
    Messages(message: 'Is it availaible on Monday', isSenderMe: false),
    Messages(message: 'Yes please', isSenderMe: true),
    Messages(message: 'I want some information', isSenderMe: false),
    Messages(message: 'Ok then i wanna book for one day', isSenderMe: false),
    Messages(message: 'Yes it is', isSenderMe: true),
    Messages(message: 'Is it availaible on Monday', isSenderMe: false),
    Messages(message: 'Yes please', isSenderMe: true),
    Messages(message: 'I want some information', isSenderMe: false),
  ];

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Send a message',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: AppColors.primaryColor,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Username'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: messages.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                        alignment: messages[index].isSenderMe == true
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: MessageBubble(
                          text: messages[index].message.toString(),
                          isSenderMe: messages[index].isSenderMe,
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildTextComposer()
            ],
          ),
        ),
      ),
    );
  }
}

class Messages {
  final String message;
  final bool isSenderMe;

  Messages({required this.message, required this.isSenderMe});
}
