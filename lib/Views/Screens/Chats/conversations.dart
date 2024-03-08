import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Views/Screens/Chats/chat_screen.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Conversations extends StatelessWidget {
  const Conversations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ChatsScreen()));
                },
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subTitleText(title: 'Username'),
                        Text(
                          'Hi! I want to book the Banqueet...',
                          style: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
