// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Models/customer_model.dart';
import 'package:banquet/Views/Screens/Auth/login.dart';

import 'package:banquet/Views/Screens/Customer/customer_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String imageUrl = '';
  late Rx<User?> user;

  // @override
  // void onReady() {
  //   super.onReady();
  //   log('OnReady');
  //   user = Rx<User?>(firebaseAuth.currentUser);
  //   user.bindStream(firebaseAuth.authStateChanges());
  //   ever(user, setInitialScreen);
  // }

  // setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(
  //       () => const Login(
  //         role: '',
  //       ),
  //     );
  //   } else {
  //     Get.offAll(
  //       () => const CustomerHome(),
  //     );
  //   }
  // }

  Future<bool> signOut() async {
    var isLoggedOut = false;
    try {
      await FirebaseAuth.instance.signOut();
      isLoggedOut = true;
    } catch (e) {
      log('Error signing out: $e');
    }
    return isLoggedOut;
  }

  //Upload the Profile Picture
  Future<void> uploadToStorage(File image) async {
    try {
      final imgId = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref('Profile Pics');
      final imgRef = storageRef.child('path_$imgId');
      var uploadTask = imgRef.putFile(image);

      try {
        await uploadTask;
        var url = await imgRef.getDownloadURL();
        imageUrl = url;
      } catch (error) {
        log("Error uploading image: $error");
      }
    } catch (e) {
      log('Catch Block of uploadFile: ${e.toString()}');
    }
  }

  Future<void> registerUser(
      String username, String email, String password, String confitmPassword,
      {required String role}) async {
    try {
      log('Role: $role');
      easyLoading();
      if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
        if (password == confitmPassword) {
          UserCredential cred =
              await firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          if (role == 'customer') {
            // Create a new customer document in the 'customers' collection
            Customer customer = Customer(
              email: email,
              name: username,
              profilePhoto: '',
              uid: cred.user!.uid,
            );

            await firestore
                .collection(role)
                .doc(cred.user!.uid)
                .set(customer.toJson());

            EasyLoading.dismiss();
            Get.to(const Login(
                role: 'customer')); // navigate to login screen for customer
            Get.snackbar('Customer', 'Account has been created successfully');
            log('Customer Added Successfully');
          } else if (role == 'banquet') {
            Banquet banquet = Banquet(
              email: email,
              name: username,
              uid: cred.user!.uid,
            );
            await firestore
                .collection(role)
                .doc(cred.user!.uid)
                .set(banquet.toJson());
            EasyLoading.dismiss();
            Get.to(const Login(
                role: 'banquet')); // navigate to login screen for customer
            Get.snackbar('Banquet', 'Account has been created successfully');
          }
        } else {
          EasyLoading.dismiss();
          Get.snackbar('Error', 'pasword and confirm password must be same');
        }
      } else {
        EasyLoading.dismiss();
        Get.snackbar('Error', 'Please Enter all the Information');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', e.toString());
      log('Catch Block of RegisterCustomer: ${e.toString()}');
    }
  }

  Future<bool> loginUser(String email, String password, String role) async {
    bool isLoggedIn = false;
    try {
      easyLoading();
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Check if the user exists in the 'customers' collection
        DocumentSnapshot userDoc =
            await firestore.collection(role).doc(cred.user!.uid).get();

        if (userDoc.exists) {
          // User does not exist in the 'customers' collection
          EasyLoading.dismiss();
          isLoggedIn = true;
          // if (role == 'customer') {
          //   Get.to(const CustomerHome());
          // } else if (role == 'banquet') {
          //   Get.to(const BanquetHome());
          // }
        } else {
          EasyLoading.dismiss();

          Get.snackbar('Error', 'User not found');
        }
      } else {
        EasyLoading.dismiss();
        Get.snackbar('Error', 'Please Enter both email and password');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', 'Wrong Email or Passowrd');
      log('Catch Block of Login User: ${e.toString()}');
    }

    return isLoggedIn;
  }
}
