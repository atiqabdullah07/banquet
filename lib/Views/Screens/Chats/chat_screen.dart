// ignore: must_be_immutable
import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/chats_controller.dart';
import 'package:banquet/Views/Screens/Chats/chats_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen(
      {super.key,
      required this.receiverID,
      required this.receiverEmail,
      required this.username});
  final String receiverID;
  final String receiverEmail;
  final String username;
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ChatsController _chatsController = Get.put(ChatsController());

  void sendMessage() async {
    print('Method Called');
    if (_messageController.text.isNotEmpty) {
      _chatsController.sendMessage(
          receiverID: widget.receiverID, message: _messageController.text);
      _messageController.clear();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.receiverID);
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _messageController,
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
            onPressed: () {
              sendMessage();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String senderId = firebaseAuth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username.toString()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                  child: StreamBuilder(
                      stream: _chatsController.getMessages(
                          userId: widget.receiverID, otherUserId: senderId),
                      builder: (context, snapshot) {
                        // Errors
                        if (snapshot.hasError) {
                          return const Center(child: Text('Error'));
                        }

                        // List virw

                        return ListView(
                          reverse: true,
                          children: snapshot.data!.docs
                              .map((doc) => buildMessageItem(doc))
                              .toList(),
                        );
                      })
                  // ListView.builder(
                  //   itemCount: messages.length,
                  //   reverse: true,
                  //   itemBuilder: (context, index) {
                  //     return
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(vertical: 10),
                  //       child: Align(
                  //         alignment: messages[index].isSenderMe == true
                  //             ? Alignment.centerLeft
                  //             : Alignment.centerRight,
                  //         child: MessageBubble(
                  //           text: messages[index].message.toString(),
                  //           isSenderMe: messages[index].isSenderMe,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
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

Widget buildMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  String senderId = firebaseAuth.currentUser!.uid;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Align(
      alignment: senderId == data['senderId']
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: MessageBubble(
        text: data['message'],
        isSenderMe: senderId == data['senderId'],
      ),
    ),
  );
}
