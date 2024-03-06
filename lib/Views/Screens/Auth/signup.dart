import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/auth_controller.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.role});
  final String role;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            titleText(title: 'Register'),
            height(120),
            Column(
              children: [
                AppTextField(
                  hintText: 'Enter Name',
                  controller: nameController,
                ),
                height(15),
                AppTextField(
                  hintText: 'Enter Email',
                  controller: emailController,
                ),
                height(15),
                AppTextField(
                  hintText: 'Enter Password',
                  controller: passwordController,
                  isObsecure: true,
                ),
                height(15),
                AppTextField(
                  hintText: 'Enter Confirm Password',
                  controller: confirmPasswordController,
                  isObsecure: true,
                ),
                height(35),
                CustomButton(
                    title: 'Register',
                    onPress: () {
                      authController.registerUser(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                        role: widget.role,
                      );
                    }),
                height(150)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
