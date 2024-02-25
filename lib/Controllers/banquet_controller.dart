import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class BanquetController extends GetxController {
  Future<void> updateBanquetInfoForCurrentUser(Banquet banquet) async {
    try {
      easyLoading();
      // Get the UID of the currently authenticated user
      String currentUserId = firebaseAuth.currentUser!.uid;

      // Update the corresponding document in the 'banquet' collection
      await firestore
          .collection('banquet')
          .doc(currentUserId)
          .update({'parkingCapacity': banquet.parkingCapacity}).then(
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
