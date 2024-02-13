import 'package:banquet/App%20Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return whishlistCard();
        },
      ),
    );
  }
}

Widget whishlistCard() {
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
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://i.pinimg.com/originals/85/7a/bc/857abcdd95af8530c9d022f5cb420932.png')),
                  color: AppColors.backgroundColor,
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
                const Text(
                  'Mashallah Halls',
                  style: TextStyle(
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
                    Icon(
                      Icons.star,
                      size: 24.r,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      size: 24.r,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      size: 24.r,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      size: 24.r,
                      color: Colors.yellow,
                    ),
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
                color: AppColors.black,
              )),
        )
      ]),
    ),
  );
}
