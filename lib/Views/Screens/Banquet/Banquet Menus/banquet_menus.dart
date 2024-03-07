// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:banquet/App%20Constants/constants.dart';

import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/menu_model.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final TextEditingController _packageNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _mainMenuController = TextEditingController();
  final TextEditingController _dessertsController = TextEditingController();
  final TextEditingController _drinksController = TextEditingController();

  final BanquetController banquetController = Get.put(BanquetController());
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Marquee/Banquet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Menu'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subTitleText(title: 'Package Name'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _packageNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter Package Name',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Package Name';
                          }

                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    subTitleText(title: 'Price Per Person'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Price Per Person',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Price';
                          }
                          if (!isNumeric(value)) {
                            return 'Only Numbers are Allowed';
                          }

                          return null;
                        },
                      ),
                    ),
                    subTitleText(title: 'Main Menu'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _mainMenuController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter Main Menu of the Package',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Main Menu';
                          }
                          List<String>? words = value.split(' ');
                          if (words.length >= 50) {
                            return 'Max 50 words';
                          }
                          return null;
                        },
                      ),
                    ),
                    subTitleText(title: 'Desserts'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _dessertsController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter Desserts of the Package',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          List<String>? words = value!.split(' ');
                          if (words.length >= 50) {
                            return 'Max 50 words';
                          }
                          return null;
                        },
                      ),
                    ),
                    subTitleText(title: 'Drinks'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _drinksController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter Drinks of the Package',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          List<String>? words = value!.split(' ');
                          if (words.length >= 50) {
                            return 'Max 50 words';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Center(
                      child: appButton(
                        title: 'Add New',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isAdded = await banquetController.addMenu(
                              PackageMenu(
                                  name: _packageNameController.text,
                                  price: _priceController.text,
                                  mainCourse: _mainMenuController.text,
                                  desserts: _dessertsController.text,
                                  drinks: _drinksController.text),
                            );
                            Navigator.of(context).pop();

                            if (isAdded == true) {
                              showDialog(
                                context: context,
                                builder: (context) => CustomDialogWidget(
                                    title: 'Menu Added',
                                    message: 'Menu Added Sucessfully'),
                              );

                              _formKey.currentState!.dispose();
                              _packageNameController.clear();
                              _priceController.clear();
                              _mainMenuController.clear();
                              _dessertsController.clear();
                              _drinksController.clear();
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }

  RadioListTile<String> radioButton({required String venueType}) {
    return RadioListTile(
      title: Text(venueType),
      value: venueType,
      groupValue: selectedValue,
      selectedTileColor: AppColors.primaryColor,
      fillColor: const MaterialStatePropertyAll(AppColors.primaryColor),
      onChanged: (type) {
        setState(() {
          selectedValue = type.toString();
        });
      },
    );
  }
}

bool isNumeric(String value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}
