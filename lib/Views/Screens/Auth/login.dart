import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/auth_controller.dart';
import 'package:banquet/Views/Screens/Auth/signup.dart';

import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key, required this.role});
  final String role;
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleText(title: 'Login'),
              height(120),
              Column(
                children: [
                  AppTextField(
                    hintText: 'Enter Email',
                    controller: emailController,
                  ),
                  height(15),
                  AppTextField(
                    hintText: 'Enter Password',
                    controller: passwordController,
                  ),
                  height(35),
                  CustomButton(
                    title: 'Login',
                    onPress: () {
                      authController.loginUser(
                          emailController.text, passwordController.text, role);
                    },
                  ),
                  height(150)
                ],
              ),
              height(120),
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an Account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp(
                                      role: role,
                                    )));
                      },
                      child: const Text(
                        "Register",
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
      ),
    );
  }
}
