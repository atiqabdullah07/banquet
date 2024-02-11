import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Views/Screens/Customer/Confirm%20Booking/confirm_booking_widgets.dart';
import 'package:banquet/Views/Screens/Customer/Hall%20Details/hall_details_widgets.dart';

import 'package:banquet/Views/Widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({super.key});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  var selectedTime = 'Morning';

  var _guests = 100;
  void _incrementguests() {
    setState(
      () {
        _guests = _guests + 10;
      },
    );
  }

  void _decrementGuests() {
    setState(
      () {
        if (_guests > 10) {
          _guests = _guests - 10;
        } else {
          return;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.now().toString();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Confirm Booking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subTitleText(
                title: 'Date',
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SfDateRangePicker(
                  todayHighlightColor: AppColors.primaryColor,
                  selectionColor: AppColors.primaryColor,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    selectedDate = args.value.toString();
                  },
                ),
              ),
              subTitleText(title: 'Time'),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (selectedTime == 'Morning') {
                        setState(() {
                          selectedTime = 'Evening';
                        });
                      } else if (selectedTime == 'Evening') {
                        setState(() {
                          selectedTime = 'Morning';
                        });
                      }
                    },
                    child: Container(
                      height: 45.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: selectedTime == 'Morning'
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: AppColors.black.withOpacity(0.2),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Morning',
                          style: TextStyle(
                              color: selectedTime == 'Morning'
                                  ? Colors.white
                                  : AppColors.black,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (selectedTime == 'Morning') {
                        setState(() {
                          selectedTime = 'Evening';
                        });
                      } else if (selectedTime == 'Evening') {
                        setState(() {
                          selectedTime = 'Morning';
                        });
                      }
                    },
                    child: Container(
                      height: 45.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: selectedTime == 'Evening'
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: AppColors.black.withOpacity(0.2),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Evening',
                          style: TextStyle(
                              color: selectedTime == 'Evening'
                                  ? Colors.white
                                  : AppColors.black,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              subTitleText(title: 'Select Menu'),
              const Menu(),
              const Menu(),
              const Menu(),
              SizedBox(
                height: 15.h,
              ),
              subTitleText(title: 'No of Guests'),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  incDecButton(
                      icon: Icons.remove,
                      ontap: () {
                        _decrementGuests();
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      _guests.toString(),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),
                  incDecButton(
                      icon: Icons.add,
                      ontap: () {
                        _incrementguests();
                      }),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              subTitleText(title: 'Add Note'),
              SizedBox(
                height: 5.h,
              ),
              TextField(
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Add Note',
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
                  fillColor: Colors.green,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Center(child: appButton(title: 'Send Request', onTap: () {})),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
