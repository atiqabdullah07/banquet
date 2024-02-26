import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/banquet_model.dart';
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
        title: const Text('Setup Banquet Profile'),
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
                        keyboardType: TextInputType.number,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    height(00),
                    Center(
                      child: appButton(
                        title: 'Continue',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            print('Hi');
                            banquetController.addMenu(
                              PackageMenu(
                                  name: _packageNameController.text,
                                  price: _priceController.text,
                                  mainCourse: _mainMenuController.text,
                                  desserts: _dessertsController.text,
                                  drinks: _drinksController.text),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 200,
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
