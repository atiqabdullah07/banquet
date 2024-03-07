// ignore_for_file: use_build_context_synchronously

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/auth_controller.dart';
import 'package:banquet/Views/Screens/Auth/signup.dart';
import 'package:banquet/Views/Screens/Banquet/banquet_home.dart';

import 'package:banquet/Views/Screens/Customer/customer_home.dart';

import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.role});
  final String role;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      height(15),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType
                            .emailAddress, // Use email address keyboard type
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: AppColors.black.withOpacity(0.5),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }

                          String emailRegex =
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                          RegExp regex = RegExp(emailRegex);

                          if (!regex.hasMatch(value)) {
                            return 'Please Enter a Valid Email';
                          }

                          return null;
                        },
                      ),
                      height(15),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: AppColors.black.withOpacity(0.5),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a password';
                          }

                          return null;
                        },
                      ),
                      height(35),
                      CustomButton(
                        title: 'Login',
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isLoggedIn = await authController.loginUser(
                                emailController.text,
                                passwordController.text,
                                widget.role);

                            if (isLoggedIn == true) {
                              if (widget.role == 'customer') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerHome()),
                                );
                              } else if (widget.role == 'banquet') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BanquetHome()),
                                );
                              }
                            }
                          }
                        },
                      ),
                      height(150)
                    ],
                  ),
                ),
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
                                      role: widget.role,
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
