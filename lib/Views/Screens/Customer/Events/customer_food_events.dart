import 'package:banquet/App%20Constants/constants.dart';

import 'package:banquet/Controllers/customer_controller.dart';
import 'package:banquet/Models/food_model.dart';

import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerFoodEvents extends StatelessWidget {
  CustomerFoodEvents({super.key});

  final CustomerController _customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Events'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: _customerController.myFoods.length,
          itemBuilder: (context, index) {
            var food = _customerController.myFoods[index];
            return BanquetFoodsCard(
                food: FoodModel(
                    banquetname: food.banquetname,
                    title: food.title,
                    content: food.content,
                    date: food.date));
          },
        );
      }),
    );
  }
}

class BanquetFoodsCard extends StatelessWidget {
  const BanquetFoodsCard({
    super.key,
    required this.food,
  });

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Container(
        height: 150,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            softShadow(),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 15, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        food.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          food.content,
                          style: TextStyle(
                              color: AppColors.black.withOpacity(0.7)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          food.banquetname!,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          food.date,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
