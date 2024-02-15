// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Models/customer_model.dart' as model;
import 'package:banquet/Views/Screens/Auth/login.dart';

import 'package:banquet/Views/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String imageUrl = '';
  late Rx<User?> user;

  @override
  void onReady() {
    super.onReady();
    log('OnReady');
    user = Rx<User?>(firebaseAuth.currentUser);
    user.bindStream(firebaseAuth.authStateChanges());
    ever(user, setInitialScreen);
  }

  setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(
        () => Login(
          role: '',
        ),
      );
    } else {
      Get.offAll(
        () => const Home(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log('Error signing out: $e');
    }
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

  // Regester the user
  Future<void> registerUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      easyLoading();
      if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        signOut();

        model.Customer user = model.Customer(
            email: email,
            name: username,
            profilePhoto: '',
            uid: cred.user!.uid);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        EasyLoading.dismiss();
        Get.to(Login(
          role: '',
        ));
        Get.snackbar('User', 'Added Successfully');
        log('User Added Successfully');
      } else {
        EasyLoading.dismiss();
        Get.snackbar('Error', 'Please Enter all the Information');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', e.toString());
      log('Catch Block of RegisterUser: ${e.toString()}');
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      easyLoading();
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        if (user != null) {
          EasyLoading.dismiss();
          Get.to(const Home());
        }
      } else {
        EasyLoading.dismiss();

        Get.snackbar('Error', 'Please Enter both username and password');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', "Wrong Password, Try Again!");
      log('Catch Block of Login User: ${e.toString()}');
    }
  }
}
