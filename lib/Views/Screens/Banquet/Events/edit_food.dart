// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/banquet_controller.dart';

import 'package:banquet/Models/food_model.dart';

import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditFood extends StatefulWidget {
  const EditFood({super.key, required this.food});

  final FoodModel food;

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  late TextEditingController _foodTitleController;

  late TextEditingController _foodDetailsController;

  final BanquetController banquetController = Get.put(BanquetController());
  final BanquetProfileController _banquetProfileController =
      Get.put(BanquetProfileController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    banquetController.foodDate.value = widget.food.date.toString();

    _foodTitleController =
        TextEditingController(text: widget.food.title.toString());
    _foodDetailsController =
        TextEditingController(text: widget.food.content.toString());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      banquetController.foodDate.value =
          dateTypeConverter(date: picked.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Food'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            if (_banquetProfileController.myBanquet == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height(20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subTitleText(title: 'Date'),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: banquetController.foodDate.value
                                      .toString()),
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.6))),
                                enabled: false,
                                hintText: 'Select Date',
                                hintStyle: TextStyle(
                                    color: AppColors.black.withOpacity(0.5)),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        subTitleText(title: 'Title'),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                          child: TextFormField(
                            controller: _foodTitleController,
                            decoration: InputDecoration(
                              hintText: 'Enter Food Title',
                              hintStyle: TextStyle(
                                  color: AppColors.black.withOpacity(0.5)),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Food Title';
                              }

                              return null;
                            },
                          ),
                        ),
                        subTitleText(title: 'Details'),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                          child: TextFormField(
                            controller: _foodDetailsController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter Food Details',
                              hintStyle: TextStyle(
                                  color: AppColors.black.withOpacity(0.5)),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Food Details';
                              }

                              List<String>? words = value.split(' ');
                              if (words.length >= 50) {
                                return 'Max 50 words';
                              }
                              return null;
                            },
                          ),
                        ),
                        height(00),
                        Center(
                          child: appButton(
                            title: 'Save Changes',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                var isUpdated =
                                    await banquetController.editFood(
                                        food: FoodModel(
                                            id: widget.food.id,
                                            title: _foodTitleController.text,
                                            content:
                                                _foodDetailsController.text,
                                            date: banquetController
                                                .foodDate.value
                                                .toString()));
                                Navigator.of(context).pop();

                                if (isUpdated == true) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialogWidget(
                                        title: 'Success',
                                        message:
                                            'Food Post Edited Sucessfully'),
                                  );
                                  _foodTitleController.clear();
                                  _foodDetailsController.clear();
                                }
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
              );
            }
          }),
        ),
      ),
    );
  }
}
