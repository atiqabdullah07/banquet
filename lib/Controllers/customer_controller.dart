import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';

import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Models/customer_model.dart';
import 'package:banquet/Models/event_model.dart';
import 'package:banquet/Models/food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  RxList<FoodModel> myFoods = RxList<FoodModel>();
  RxList<EventModel> allEvents = RxList<EventModel>();
  RxList<Banquet> myWishlist = RxList<Banquet>();
  RxList<Banquet> banquets = RxList<Banquet>();

  @override
  void onInit() async {
    super.onInit();

    await fetchFoods();
    await fetchEvents();
    await fetchWishlist();
  }

  Future<void> fetchBanquets() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('banquet').get();

      banquets.clear();
      log('Banquets');
      log(querySnapshot.toString());
      banquets.addAll(
        querySnapshot.docs
            .map(
              (doc) => Banquet.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );

      log('Banquets');
      log(banquets.toString());
    } catch (e) {
      log("Error fetching and appending banquets: $e");
    }
  }

  Future<void> fetchWishlist() async {
    //  List<String> wishlistedBanquetUids = [];

    var userUid = firebaseAuth.currentUser!.uid;
    myWishlist.clear();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('banquet')
          .where('wishlist', arrayContains: userUid)
          .get();

      List<Banquet> wishlistedBanquets = querySnapshot.docs.map((foodDoc) {
        return Banquet.fromJson(foodDoc.data() as Map<String, dynamic>);
      }).toList();

      myWishlist.addAll(wishlistedBanquets);
    } catch (e) {
      log("Error fetching wishlisted banquets: $e");
    }
  }

  Future<void> addToWishlist({
    required String id,
  }) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('banquet').doc(id).get();
      var uid = firebaseAuth.currentUser!.uid;

      if ((doc.data()! as dynamic)['wishlist'].contains(uid)) {
        await firestore.collection('banquet').doc(id).update({
          'wishlist': FieldValue.arrayRemove([uid])
        });
      } else {
        await firestore.collection('banquet').doc(id).update({
          'wishlist': FieldValue.arrayUnion([uid])
        });
      }

      fetchWishlist();
      fetchBanquets();
    } catch (e) {
      log('Like Banquet Error: $e');
    }
  }

  Future<void> fetchFoods() async {
    try {
      QuerySnapshot banquetSnapshot =
          await FirebaseFirestore.instance.collection('banquet').get();

      for (QueryDocumentSnapshot banquetDoc in banquetSnapshot.docs) {
        QuerySnapshot foodSnapshot = await FirebaseFirestore.instance
            .collection('banquet')
            .doc(banquetDoc.id)
            .collection('foods')
            .get();

        List<FoodModel> foods = foodSnapshot.docs.map((foodDoc) {
          return FoodModel.fromJson(foodDoc.data() as Map<String, dynamic>);
        }).toList();

        myFoods.addAll(foods);
      }
    } catch (e) {
      log("Error fetching Foods: $e");
    }
  }

  Future<void> fetchEvents() async {
    try {
      QuerySnapshot banquetSnapshot =
          await FirebaseFirestore.instance.collection('banquet').get();

      for (QueryDocumentSnapshot banquetDoc in banquetSnapshot.docs) {
        QuerySnapshot eventSnapshot = await FirebaseFirestore.instance
            .collection('banquet')
            .doc(banquetDoc.id)
            .collection('events')
            .get();

        List<EventModel> events = eventSnapshot.docs.map((eventDoc) {
          return EventModel.fromJson(eventDoc.data() as Map<String, dynamic>);
        }).toList();

        allEvents.addAll(events);
      }
    } catch (e) {
      log("Error fetching Foods: $e");
    }
  }
}

class CustomerProfileController extends GetxController {
  Rx<Customer> customer = Customer().obs;

  @override
  void onInit() async {
    super.onInit();
    log("Customer init: ${customer.value.name}");
    await getCustomer();
  }

  Future<String> uploadProfilePic(File image, String? existingImageUrl) async {
    late String imageURL = '';

    try {
      final imgId = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref('Profile Pics');
      final imgRef = storageRef.child('path_$imgId');

      if (existingImageUrl != null && existingImageUrl.isNotEmpty) {
        try {
          await FirebaseStorage.instance
              .refFromURL(existingImageUrl.toString())
              .delete();
        } catch (error) {
          log("Error deleting existing image: $error");
        }
      }

      // Upload the new file
      await imgRef.putFile(image).catchError((error) {
        log("Error uploading image: $error");
        return null;
      });

      try {
        // Get the download URL for the new file
        var url = await imgRef.getDownloadURL();
        imageURL = url;
      } catch (error) {
        log("Error getting download URL: $error");
      }

      return imageURL;
    } catch (e) {
      log('Catch Block of uploadFile: ${e.toString()}');
      return imageURL; // Return a default value on failure
    }
  }

  Future<void> updateCustomerProfile(Customer? customer, File? image) async {
    try {
      easyLoading();
      String currentUserId = firebaseAuth.currentUser!.uid;

      if (image != null) {
        String profilePhoto =
            await uploadProfilePic(image, customer!.profilePhoto);
        await firestore.collection('customer').doc(currentUserId).update(
          {
            'name': customer.name,
            'profilePhoto': profilePhoto,
          },
        ).then(
          (value) {
            EasyLoading.dismiss();
            Get.snackbar('Sucess', "Profile Updated");
          },
        );
      } else if (image == null) {
        await firestore.collection('customer').doc(currentUserId).update(
          {
            'name': customer?.name,
          },
        ).then(
          (value) {
            EasyLoading.dismiss();
            Get.snackbar('Sucess', "Profile Updated");
          },
        );
      }

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      log('Error updating banquet information: $e');
      rethrow;
    }
  }

  Future<void> getCustomer() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final CollectionReference banquetCollection =
          FirebaseFirestore.instance.collection('customer');

      User? user = auth.currentUser;

      DocumentSnapshot userDoc = await banquetCollection.doc(user!.uid).get();

      if (userDoc.exists) {
        var customerData =
            Customer.fromJson(userDoc.data() as Map<String, dynamic>);

        customer.value = customerData;

        log('Name: ${customer.value.name}');
      } else {
        log('error');
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }
}
