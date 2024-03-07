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
  final _formKey = GlobalKey<FormState>();

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
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: AppColors.black.withOpacity(0.5),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          if (widget.role == 'customer') {
                            return 'Please Enter your Name';
                          } else {
                            return 'Please Enter Banquet Name';
                          }
                        }

                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        if (passwordController.text.length < 6) {
                          return 'Please Enter alteast 6 digit Password';
                        }

                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          return 'Confirm Password Does not Matched';
                        }

                        return null;
                      },
                    ),
                    height(15),
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          color: AppColors.black.withOpacity(0.5),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password';
                        }
                        if (confirmPasswordController.text.length < 6) {
                          return 'Please Enter alteast 6 digit Password';
                        }
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          return 'Confirm Password Does not Matched';
                        }

                        return null;
                      },
                    ),
                    height(35),
                    CustomButton(
                        title: 'Register',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            authController.registerUser(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              confirmPasswordController.text,
                              role: widget.role,
                            );
                          }
                        }),
                    height(150)
                  ],
                ),
              ),
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
