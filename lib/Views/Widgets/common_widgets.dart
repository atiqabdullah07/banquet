import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget titleText({required String title}) {
  return Text(
    title,
    style: const TextStyle(
        fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.black),
  );
}

Widget subTitleText({required String title}) {
  return Text(
    title,
    style: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.black),
  );
}

Widget appButton({required String title, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      )),
    ),
  );
}

Widget hallCards({required Banquet banquet, required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 400,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://i.pinimg.com/originals/04/35/6e/04356ed3ba8787b478e50804d81e1bf1.jpg')),
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
          )
        ]),
      ),
    ),
  );
}

BoxShadow softShadow() {
  return const BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.07), // Adjust opacity as needed
    blurRadius: 20,
    offset: Offset(0, 0),
    spreadRadius: 0,
  );
}

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    required this.onPress,
    this.color = AppColors.primaryColor,
    this.nextIcon = false,
  });

  final String title;
  final VoidCallback onPress;
  Color color;
  bool nextIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 60.h,
        width: 285,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            nextIcon == true
                ? const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: 20,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.isObsecure = false,
    required this.controller,
  });

  final String hintText;
  final bool isObsecure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isObsecure,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: AppColors.black.withOpacity(0.5)),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
