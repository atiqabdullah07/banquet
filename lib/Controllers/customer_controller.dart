import 'dart:developer';

import 'package:banquet/Models/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {}

class CustomerProfileController extends GetxController {
  Rx<Customer> customer = Customer().obs;

  @override
  void onInit() async {
    super.onInit();
    await getCustomer();
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

        print('Name: ${customer.value.name}');
      } else {
        log('error');
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }
}
