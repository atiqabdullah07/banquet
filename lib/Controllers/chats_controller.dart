import 'dart:developer';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  Future<void> sendMessage(
      {required String receiverID, required String message}) async {
    try {
      // Get Current User Info
      final String currentUserId = firebaseAuth.currentUser!.uid;
      final String currentuserEmail = firebaseAuth.currentUser!.email!;
      final Timestamp timestamp = Timestamp.now();

      // Create a New Message

      Message newMessage = Message(
          senderId: currentUserId,
          senderEmail: currentuserEmail,
          receiverId: receiverID,
          message: message,
          timestamp: timestamp);

      // Construct Chat Room id for the two users

      List<String> ids = [currentUserId, receiverID];
      ids.sort(); // Sort the ids (to ensure that chat room id is the same for any 2 people)
      String chatRoomID = ids.join('_');

      // Add new message to Database
      await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomID)
          .collection('messages')
          .add(newMessage.toJson());
    } catch (error) {
      log('sendMessage Catched Error: $error');
    }
  }

  Stream<QuerySnapshot> getMessages(
      {required String userId, required String otherUserId}) {
    // Construct a chatroom ID for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join('_');

    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
