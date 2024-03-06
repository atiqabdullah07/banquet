// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/event_model.dart';

import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _eventNameController = TextEditingController();

  final TextEditingController _detailsController = TextEditingController();

  final BanquetController banquetController = Get.put(BanquetController());
  final BanquetProfileController _banquetProfileController =
      Get.put(BanquetProfileController());
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Marquee/Banquet';

  File? pickedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          pickedImage = File(pickedFile.path);
        });

        if (pickedFile.path.isNotEmpty) {
          log('Image picked: ${pickedFile.path}');
        } else {
          log('Invalid file path: ${pickedFile.path}');
          // Handle the case where the file path is empty
          // You might want to show a message to the user or take appropriate action.
        }
      } else {
        log('No image picked.');
      }
    } catch (e) {
      log('Error picking image: $e');
      // Handle other exceptions that might occur during the image picking process
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      banquetController.eventDate.value =
          dateTypeConverter(date: picked.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Event'),
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
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: pickedImage == null
                          ? Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image,
                                      size: 50,
                                    ),
                                    height(5),
                                    const Text('Pick Event Image')
                                  ],
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(pickedImage!),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.secondaryColor,
                                    child: Center(
                                      child: Icon(
                                        Icons.edit,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
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
                                  text: banquetController.eventDate.toString()),
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.6))),
                                enabled: false,
                                hintText: 'Select Date for Event',
                                hintStyle: TextStyle(
                                    color: AppColors.black.withOpacity(0.5)),
                                border: const OutlineInputBorder(),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ),
                        subTitleText(title: 'Event Name'),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                          child: TextFormField(
                            controller: _eventNameController,
                            decoration: InputDecoration(
                              hintText: 'Enter Event Name',
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
                          ),
                        ),
                        subTitleText(title: 'Details'),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                          child: TextFormField(
                            controller: _detailsController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter Event Details',
                              hintStyle: TextStyle(
                                  color: AppColors.black.withOpacity(0.5)),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Package Name';
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
                            title: 'Post Now',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                var addEvent = await banquetController.addEvent(
                                  EventModel(
                                    banquetname: _banquetProfileController
                                        .myBanquet.value.name
                                        .toString(),
                                    title: _eventNameController.text,
                                    content: _detailsController.text,
                                    date:
                                        banquetController.eventDate.toString(),
                                  ),
                                );
                                if (addEvent == true) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialogWidget(
                                        title: 'Event Added',
                                        message: 'Event Posted Sucessfully'),
                                  );
                                  Navigator.of(context).pop();

                                  _eventNameController.clear();
                                  _detailsController.clear();
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
