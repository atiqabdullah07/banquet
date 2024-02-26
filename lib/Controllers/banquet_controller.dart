import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class BanquetController extends GetxController {
  RxList<Banquet> banquets = RxList<Banquet>();

  // Method to fetch and append all banquets
  Future<void> fetchBanquets() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('banquet').get();

      // Clear existing items in the RxList and append the new ones
      banquets.clear();
      banquets.addAll(
        querySnapshot.docs
            .map(
              (doc) => Banquet.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );

      print(banquets);
    } catch (e) {
      print("Error fetching and appending banquets: $e");
    }
  }

  Future<void> updateBanquetInfoForCurrentUser(Banquet banquet) async {
    try {
      easyLoading();
      // Get the UID of the currently authenticated user
      String currentUserId = firebaseAuth.currentUser!.uid;

      // Update the corresponding document in the 'banquet' collection
      await firestore.collection('banquet').doc(currentUserId).update(
        {
          'venueType': banquet.venueType,
          'parkingCapacity': banquet.parkingCapacity,
          'guestsCapacity': banquet.guestsCapacity,
          'bookingPrice': banquet.bookingPrice,
          'facilities': banquet.facilities,
          'description': banquet.description,
          'location': banquet.location,
        },
      ).then(
        (value) {
          EasyLoading.dismiss();
          Get.snackbar('Sucess', "Data Added Successfully");
        },
      );
      EasyLoading.dismiss();

      print('Banquet information updated successfully');
    } catch (e) {
      EasyLoading.dismiss();
      print('Error updating banquet information: $e');
      throw e;
    }
  }
}

class BanquetProfileController extends GetxController {
  RxString banquetname = ''.obs;
  Rx<Banquet> myBanquet = Banquet().obs;

  @override
  void onInit() async {
    super.onInit();
    await getAuthenticatedUserBanquetInfo();
  }

  Future<void> getAuthenticatedUserBanquetInfo() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final CollectionReference _banquetCollection =
          FirebaseFirestore.instance.collection('banquet');

      // Check if a user is authenticated
      User? user = _auth.currentUser;
      if (user == null) {
        return null; // User not authenticated
      }

      // Get the document snapshot from the 'banquet' collection using the user's UID
      DocumentSnapshot userDoc = await _banquetCollection.doc(user.uid).get();

      //print(userDoc);

      // Check if the document exists
      if (userDoc.exists) {
        // Map the data from the document snapshot to your Banquet model
        // banquet = Banquet.fromJson(userDoc.data() as Map<String, dynamic>)
        //     as Rx<Banquet>;
        var banquet = Banquet.fromJson(userDoc.data() as Map<String, dynamic>);
        print(banquet.name);
        banquetname.value = banquet.name!;

        myBanquet.value = banquet;
      } else {
        return null; // Document not found
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}
