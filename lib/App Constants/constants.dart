import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF946946);
  static const secondaryColor = Color(0xFFF2E3D4);
  static const backgroundColor = Color(0xFFFCFCFC);
  static const black = Color(0xFF454545);
}

//FireBase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
