import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Models/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {}

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
