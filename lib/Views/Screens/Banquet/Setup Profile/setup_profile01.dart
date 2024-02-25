import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetupProfile01 extends StatefulWidget {
  const SetupProfile01({super.key});

  @override
  State<SetupProfile01> createState() => _SetupProfile01State();
}

class _SetupProfile01State extends State<SetupProfile01> {
  final TextEditingController _parkingController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();
  final TextEditingController _bookingPriceController = TextEditingController();
  final TextEditingController _facilitiesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final BanquetController banquetController = Get.put(BanquetController());
  final _formKey = GlobalKey<FormState>();
  File? pickedImage;
  String selectedValue = 'Marquee/Banquet';

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          pickedImage = File(pickedFile.path);
        });
        log('Image picked: ${pickedFile.path}');
      } else {
        log('No image picked.');
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

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
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundColor: AppColors.black,
                        child: pickedImage != null
                            ? CircleAvatar(
                                radius: 48.r,
                                backgroundColor: Colors.white,
                                backgroundImage: FileImage(pickedImage!),
                              )
                            : CircleAvatar(
                                radius: 48.r,
                                backgroundColor: Colors.white,
                                backgroundImage: const NetworkImage(
                                    "https://images-platform.99static.com/8o4gbZyhGRrmCBJKnX4GlKZ-9EA=/265x41:1552x1328/500x500/top/smart/99designs-contests-attachments/91/91413/attachment_91413639"),
                              ),
                      ),
                    ),
                    height(10),
                    const Text('Banquet Logo'),
                  ],
                ),
              ),
              height(40),
              subTitleText(title: 'Select Venue Type'),
              Column(
                children: <Widget>[
                  radioButton(venueType: 'Marquee/Banquet'),
                  radioButton(venueType: 'Hall'),
                  radioButton(venueType: 'Outdoor'),
                  radioButton(venueType: 'Other'),
                ],
              ),
              height(20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subTitleText(title: 'Parking Capacity'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _parkingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Parking Capacity',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Parking Capacity';
                          }
                          if (!isNumeric(value)) {
                            return 'Only Numbers are Allowed';
                          }

                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    subTitleText(title: 'Guests Capacity'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _guestsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Guests Capacity',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Parking Capacity';
                          }
                          if (!isNumeric(value)) {
                            return 'Only Numbers are Allowed';
                          }

                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    subTitleText(title: 'Booking Price'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _bookingPriceController,
                        decoration: InputDecoration(
                          hintText: 'Enter Booking Price in PKR',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Booking Price';
                          }
                          if (!isNumeric(value)) {
                            return 'Only Numbers are Allowed';
                          }

                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    subTitleText(title: 'Facilities'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _facilitiesController,
                        decoration: InputDecoration(
                          hintText: 'Enter Facilities',
                          hintStyle: TextStyle(
                            color: AppColors.black.withOpacity(0.5),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Facilities';
                          }
                          List<String>? words = value.split(' ');
                          if (words.length >= 20) {
                            return 'Max 20 words';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    subTitleText(title: 'Description'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter Description of your Banquet',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Description';
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
                    subTitleText(title: 'Location'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: 'Enter Banquet Location',
                          hintStyle: TextStyle(
                              color: AppColors.black.withOpacity(0.5)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Location';
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
                            banquetController
                                .updateBanquetInfoForCurrentUser(Banquet(
                              venueType: selectedValue.toString(),
                              parkingCapacity: _parkingController.text,
                              guestsCapacity: _guestsController.text,
                              bookingPrice: _bookingPriceController.text,
                              facilities: _facilitiesController.text,
                              description: _descriptionController.text,
                              location: _locationController.text,
                            ));
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
