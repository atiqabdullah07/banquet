import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
