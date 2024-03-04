// ignore_for_file: must_be_immutable

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
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: banquet.logo == '' || banquet.logo == null
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
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 18),
                      ),
                    ),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(banquet.logo!),
                      ),
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

class CustomDialogWidget extends StatelessWidget {
  CustomDialogWidget(
      {super.key,
      this.isFailure = false,
      required this.title,
      required this.message,
      this.buttonText = 'OK'});

  bool isFailure;
  final String title;
  final String message;
  String buttonText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 250.w,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: isFailure == true ? Colors.red : Colors.green,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                child: Icon(
                  isFailure == true
                      ? Icons.highlight_off_rounded
                      : Icons.check_circle_outline,
                  size: 70,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(180, 40),
                        backgroundColor:
                            isFailure == true ? Colors.red : Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
