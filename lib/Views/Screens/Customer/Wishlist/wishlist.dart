import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/customer_controller.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Wishlist extends StatelessWidget {
  Wishlist({super.key});

  final CustomerController _customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: _customerController.myWishlist.length,
          itemBuilder: (context, index) {
            var banquet = _customerController.myWishlist[index];
            return whishlistCard(banquet: banquet);
          },
        );
      }),
    );
  }
}

Widget whishlistCard({required Banquet banquet}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Container(
      height: 120,
      width: 400,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: banquet.logo == null || banquet.logo == ''
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Banquet',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(banquet.logo.toString())),
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banquet.name.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 24.r,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '4.0',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: AppColors.secondaryColor,
              )),
        )
      ]),
    ),
  );
}
