import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/chats_controller.dart';
import 'package:banquet/Views/Screens/Chats/chat_screen.dart';

import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Conversations extends StatelessWidget {
  Conversations({super.key});

  final ChatsController _chatsController = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
              onPressed: () {
                print('hello');
                _chatsController.fetchConversations();
              },
              child: const Text('Test'))
        ],
      ),
      body: Obx(() {
        if (_chatsController.conversations.isEmpty) {
          return const Center(
            child: Text('No Chats'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: _chatsController.conversations.length,
              itemBuilder: (context, index) {
                return userCard(
                  name:
                      _chatsController.conversations[index].senderId.toString(),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatsScreen(
                                  receiverID: _chatsController
                                      .conversations[index].senderId,
                                  receiverEmail: _chatsController
                                      .conversations[index].receiverId,
                                  username: 'User',
                                )));
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}

class userCard extends StatelessWidget {
  const userCard({
    super.key,
    required this.name,
    required this.onTap,
  });

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.secondaryColor,
              radius: 30,
              child: Icon(
                Icons.person,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subTitleText(title: name),
                  Text(
                    'Hi! I want to book the Banqueet...',
                    style: TextStyle(color: AppColors.black.withOpacity(0.5)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
