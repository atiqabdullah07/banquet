import 'dart:developer';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Models/menu_model.dart';
import 'package:banquet/Models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class BanquetController extends GetxController {
  RxList<Banquet> banquets = RxList<Banquet>();
  RxList<Reservation> bookingRequests = RxList<Reservation>();
  RxList<Reservation> bookings = RxList<Reservation>();
  @override
  void onInit() async {
    super.onInit();
    await fetchBookingRequests();
    await fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      var banquetId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('banquet')
          .doc(banquetId)
          .collection('bookings')
          .get();

      bookings.clear();
      bookings.addAll(
        querySnapshot.docs
            .map(
              (doc) => Reservation.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (e) {
      print("Error fetching and appending banquets: $e");
    }
  }

  Future<void> fetchBookingRequests() async {
    try {
      var banquetId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('banquet')
          .doc(banquetId)
          .collection('bookingRequests')
          .get();

      bookingRequests.clear();
      bookingRequests.addAll(
        querySnapshot.docs
            .map(
              (doc) => Reservation.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
      print('Booking Requests');
      print(bookingRequests);
    } catch (e) {
      print("Error fetching and appending banquets: $e");
    }
  }

  Future<void> fetchBanquets() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('banquet').get();

      banquets.clear();
      banquets.addAll(
        querySnapshot.docs
            .map(
              (doc) => Banquet.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (e) {
      print("Error fetching and appending banquets: $e");
    }
  }

  Future<void> addMenu(PackageMenu menu) async {
    try {
      easyLoading();

      String currentUserId = firebaseAuth.currentUser!.uid;

      // Update the 'menu' field in the banquet document with the new menu
      await firestore.collection('banquet').doc(currentUserId).update({
        'menu': FieldValue.arrayUnion([menu.toJson()]),
      });

      EasyLoading.dismiss();
      Get.snackbar('Success', 'Menu Added Successfully');

      print('Menu added successfully');
    } catch (e) {
      EasyLoading.dismiss();
      print('Error adding menu: $e');
      throw e;
    }
  }

  Future<void> sendBookingRequest(Reservation booking, String banquetID) async {
    try {
      easyLoading();
      await firestore
          .collection('banquet')
          .doc(banquetID)
          .collection('bookingRequests')
          .add(
            booking.toJson(),
          );

      EasyLoading.dismiss();
      Get.snackbar('Success', 'Menu Added Successfully');

      log('Menu added successfully');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error adding menu: $e');
      rethrow;
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

  Future<void> acceptBooking(String bookingUid) async {
    try {
      CollectionReference banquetCollection =
          FirebaseFirestore.instance.collection('banquet');

      var banquetId = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference banquetDocRef = banquetCollection.doc(banquetId);
      QuerySnapshot bookingRequestSnapshot = await banquetDocRef
          .collection('bookingRequests')
          .where('uid', isEqualTo: bookingUid)
          .get();

      if (bookingRequestSnapshot.docs.isNotEmpty) {
        DocumentSnapshot bookingRequestDoc = bookingRequestSnapshot.docs.first;

        // Move the booking request to the 'bookings' collection

        await banquetDocRef
            .collection('bookings')
            .add(bookingRequestDoc.data() as Map<String, dynamic>);

        // Remove the booking request from the 'bookingRequests' subcollection
        await bookingRequestDoc.reference.delete();
      } else {
        print('Booking request not found');
      }
    } catch (e) {
      print('Error moving booking: $e');
      throw e;
    }
  }
}

class BanquetProfileController extends GetxController {
  Rx<Banquet> myBanquet = Banquet().obs;

  @override
  void onInit() async {
    super.onInit();
    await getAuthenticatedUserBanquetInfo();
  }

  Future<void> getAuthenticatedUserBanquetInfo() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final CollectionReference banquetCollection =
          FirebaseFirestore.instance.collection('banquet');

      User? user = auth.currentUser;

      DocumentSnapshot userDoc = await banquetCollection.doc(user!.uid).get();

      if (userDoc.exists) {
        var banquet = Banquet.fromJson(userDoc.data() as Map<String, dynamic>);

        myBanquet.value = banquet;
        print('myBanquet');
        print(myBanquet.value.bookingRequests);
      } else {
        log('error');
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }
}
