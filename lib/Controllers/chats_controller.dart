import 'dart:developer';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Models/chats_models.dart';
import 'package:banquet/Models/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class ChatsController extends GetxController {
  RxList<Conversation> conversations = RxList<Conversation>();
  RxList<ConversationUser> conversationUsers = RxList<ConversationUser>();

  @override
  void onInit() async {
    super.onInit();
    await fetchConversations();
  }

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
      ids.sort(); // Sort the ids (to ensure that chat room id is the same for any 2 people)s
      String chatRoomID = ids.join('_');

      await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomID)
          .set(Conversation(senderId: currentUserId, receiverId: receiverID)
              .toJson());

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

    print('Getting Messsages');
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join('_');

    print(chatRoomID);

    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> fetchConversations() async {
    try {
      conversations.clear();
      conversationUsers.clear();

      final String currentUserId = firebaseAuth.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chat_rooms')
          .where('senderId', isEqualTo: currentUserId)
          .get();

      conversations.addAll(
        querySnapshot.docs
            .map(
              (doc) =>
                  Conversation.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );

      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('chat_rooms')
          .where('receiverId', isEqualTo: currentUserId)
          .get();

      conversations.addAll(
        querySnapshot2.docs
            .map(
              (doc) =>
                  Conversation.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );

      for (var i = 0; i < conversations.length; i++) {
        QuerySnapshot users = await FirebaseFirestore.instance
            .collection('customer')
            .where('uid', isEqualTo: conversations[i].senderId.toString())
            .get();

        print(users.docs);

        // conversationUsers.add(ConversationUser(
        //     name: users.docs[i]['name'],
        //     uid: users.docs[i]['uid'],
        //     profilePhoto: users.docs[i]['profilePhoto']));
      }
      for (var i = 0; i < conversations.length; i++) {
        QuerySnapshot users = await FirebaseFirestore.instance
            .collection('banquet')
            .where('uid', isEqualTo: conversations[i].receiverId.toString())
            .get();

        print(users.docs);

        // conversationUsers.add(ConversationUser(
        //     name: users.docs[i]['name'],
        //     uid: users.docs[i]['uid'],
        //     profilePhoto: users.docs[i]['logo']));
      }

      conversations.addAll(
        querySnapshot.docs
            .map(
              (doc) =>
                  Conversation.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );

      // log(conversations[0].receiverId.toString());
      log(conversationUsers.toString());
      //  log(banquets.toString());
    } catch (error) {
      log('fetchConversations Catched Error: $error');
    }
  }
}
