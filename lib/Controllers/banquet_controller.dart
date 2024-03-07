import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Models/event_model.dart';
import 'package:banquet/Models/food_model.dart';
import 'package:banquet/Models/menu_model.dart';
import 'package:banquet/Models/reservation_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class BanquetController extends GetxController {
  final BanquetProfileController _banquetProfileController =
      Get.put(BanquetProfileController());

  RxList<EventModel> myEvents = RxList<EventModel>();
  RxList<FoodModel> myFoods = RxList<FoodModel>();
  RxList<Reservation> bookingRequests = RxList<Reservation>();
  RxList<Reservation> bookings = RxList<Reservation>();
  RxInt selectedMenu = 20000.obs;
  RxBool isRequestFetched = false.obs;
  RxString eventDate = dateTypeConverter(date: DateTime.now().toString()).obs;
  RxString foodDate = dateTypeConverter(date: DateTime.now().toString()).obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchBookings();
    await fetchBookingRequests();
    await fetchEvents();
    await fetchFoods();
  }

  Future<bool> editFood({required FoodModel food}) async {
    bool isUpdated = false;

    log('Food ID: ${food.id}');
    try {
      easyLoading();
      String currentUserId = firebaseAuth.currentUser!.uid;
      log('Current User: $currentUserId');
      await firestore
          .collection('banquet')
          .doc(currentUserId)
          .collection('foods')
          .doc(food.id)
          .update(
        {'date': food.date, 'title': food.title, 'content': food.content},
      ).then(
        (value) async {
          EasyLoading.dismiss();
          await fetchFoods();
          isUpdated = true;
        },
      );
    } catch (error) {
      log('editFood Catched Error: $error');
    }
    return isUpdated;
  }

  Future<bool> deleteFood(String foodId) async {
    bool isDeleted = false;
    try {
      easyLoading();
      String currentUserId = firebaseAuth.currentUser!.uid;

      await firestore
          .collection('banquet')
          .doc(currentUserId)
          .collection('foods')
          .doc(foodId)
          .delete();

      EasyLoading.dismiss();

      isDeleted = true;

      fetchFoods();

      log('Food deleted successfully');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error deleting Food: $e');
      rethrow;
    }
    return isDeleted;
  }

  Future<bool> addFood(
    FoodModel food,
  ) async {
    bool isAdded = false;
    try {
      easyLoading();
      String currentUserId = firebaseAuth.currentUser!.uid;
      await firestore
          .collection('banquet')
          .doc(currentUserId)
          .collection('foods')
          .add(food.toJson())
          .then((DocumentReference docRef) {
        docRef.update({'id': docRef.id});
      });

      EasyLoading.dismiss();

      isAdded = true;

      fetchFoods();

      log('Food added successfully');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error adding Food: $e');
      rethrow;
    }
    return isAdded;
  }

  Future<void> fetchFoods() async {
    try {
      var banquetId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('banquet')
          .doc(banquetId)
          .collection('foods')
          .get();

      myFoods.clear();
      myFoods.addAll(
        querySnapshot.docs
            .map(
              (doc) => FoodModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (e) {
      log("Error fetching Foods: $e");
    }
  }

  Future<void> fetchEvents() async {
    try {
      var banquetId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('banquet')
          .doc(banquetId)
          .collection('events')
          .get();

      myEvents.clear();
      myEvents.addAll(
        querySnapshot.docs
            .map(
              (doc) => EventModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (e) {
      log("Error fetching Events: $e");
    }
  }

  Future<bool> addEvent(
    EventModel event,
  ) async {
    bool isAdded = false;
    try {
      easyLoading();
      String currentUserId = firebaseAuth.currentUser!.uid;
      await firestore
          .collection('banquet')
          .doc(currentUserId)
          .collection('events')
          .add(
            event.toJson(),
          );

      EasyLoading.dismiss();

      isAdded = true;
      fetchEvents();
      log('Event added successfully');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error adding event: $e');
      rethrow;
    }
    return isAdded;
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

      log('Bookings :$bookings');
    } catch (e) {
      log("Error fetching and appending banquets: $e");
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
      isRequestFetched.value = false;
      bookingRequests.clear();
      bookingRequests.addAll(
        querySnapshot.docs
            .map(
              (doc) => Reservation.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
      isRequestFetched.value = true;
    } catch (e) {
      log("Error fetching and appending banquets: $e");
    }
  }

  Future<String> uploadProfilePic(File image) async {
    try {
      final imgId = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref('Profile Pics');
      final imgRef = storageRef.child('path_$imgId');

      // Upload the new file
      await imgRef.putFile(image);

      // Get the download URL for the new file
      final url = await imgRef.getDownloadURL();

      return url;
    } catch (e) {
      if (e is FirebaseException) {
        log('Firebase Storage Error: ${e.code}');
        log('Firebase Storage Error Message: ${e.message}');
      } else {
        log('Error uploading or getting download URL: $e');
        // Handle other types of errors if needed.
      }

      return ''; // Return a default value on failure
    }
  }

  Future<bool> addMenu(PackageMenu menu) async {
    bool isAdded = false;
    try {
      easyLoading();

      String currentUserId = firebaseAuth.currentUser!.uid;

      await firestore.collection('banquet').doc(currentUserId).update({
        'menu': FieldValue.arrayUnion([menu.toJson()]),
      });

      EasyLoading.dismiss();
      await _banquetProfileController.getAuthenticatedUserBanquetInfo();

      isAdded = true;

      log('Menu added successfully');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error adding menu: $e');
      rethrow;
    }
    return isAdded;
  }

  Future<bool> sendBookingRequest(Reservation booking, String banquetID) async {
    bool isBooked = false;
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
      isBooked = true;

      log('Request Sent successfully');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error sending Request: $e');
      rethrow;
    }
    return isBooked;
  }

  Future<bool> updateBanquetInfoForCurrentUser(
      Banquet banquet, File? image) async {
    bool isUpdated = false;
    log('Function Called');
    try {
      easyLoading();
      // Get the UID of the currently authenticated user
      String currentUserId = firebaseAuth.currentUser!.uid;

      if (image != null) {
        String banquetLogo = await uploadProfilePic(image);

        // Update the corresponding document in the 'banquet' collection
        await firestore.collection('banquet').doc(currentUserId).update(
          {
            'venueType': banquet.venueType,
            'logo': banquetLogo,
            'parkingCapacity': banquet.parkingCapacity,
            'guestsCapacity': banquet.guestsCapacity,
            'bookingPrice': banquet.bookingPrice,
            'facilities': banquet.facilities,
            'description': banquet.description,
            'location': banquet.location,
          },
        ).then(
          (value) async {
            EasyLoading.dismiss();
            await _banquetProfileController.getAuthenticatedUserBanquetInfo();
            isUpdated = true;
          },
        );
        EasyLoading.dismiss();
      } else {
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
          (value) async {
            EasyLoading.dismiss();
            await _banquetProfileController.getAuthenticatedUserBanquetInfo();
            isUpdated = true;
          },
        );
        EasyLoading.dismiss();
      }

      log('Banquet information updated successfully');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error updating banquet information: $e');
      rethrow;
    }

    return isUpdated;
  }

  Future<bool> acceptBooking(String bookingUid) async {
    bool isAccepted = false;
    try {
      CollectionReference banquetCollection =
          FirebaseFirestore.instance.collection('banquet');
      easyLoading();

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
        EasyLoading.dismiss();
        fetchBookings();
        await fetchBookingRequests();
        isAccepted = true;
      } else {
        log('Booking request not found');
        EasyLoading.dismiss();
      }
    } catch (e) {
      log('Error moving booking: $e');
      rethrow;
    }
    return isAccepted;
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
        log('myBanquet');
        log(myBanquet.value.bookingRequests.toString());
      } else {
        log('error');
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }
}
