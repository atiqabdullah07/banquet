// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/food_model.dart';
import 'package:banquet/Views/Screens/Banquet/Events/add_food.dart';
import 'package:banquet/Views/Screens/Banquet/Events/edit_food.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BanquetFoodEvents extends StatelessWidget {
  BanquetFoodEvents({super.key});

  final BanquetController _banquetController = Get.put(BanquetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Events'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFood()));
        },
        backgroundColor: AppColors.primaryColor,
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (_banquetController.myFoods.isEmpty) {
          return const Center(
            child: Text('No Foods'),
          );
        } else {
          return ListView.builder(
            itemCount: _banquetController.myFoods.length,
            itemBuilder: (context, index) {
              var food = _banquetController.myFoods[index];
              return BanquetFoodsCard(
                food: FoodModel(
                    banquetname: food.banquetname,
                    title: food.title,
                    content: food.content,
                    date: food.date),
                onDelete: () async {
                  bool isDeleted =
                      await _banquetController.deleteFood(food.id.toString());
                  if (isDeleted == true) {
                    showDialog(
                        context: context,
                        builder: ((context) => CustomDialogWidget(
                            title: 'Success',
                            message: "Food Post Deleted Successfully")));
                  }
                },
                onEdit: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditFood(food: food,)));
                },
              );
            },
          );
        }
      }),
    );
  }
}

class BanquetFoodsCard extends StatelessWidget {
  const BanquetFoodsCard({
    super.key,
    required this.food,
    required this.onDelete,
    required this.onEdit,
  });

  final FoodModel food;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
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
                          food.date,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: onEdit,
                              child: const Icon(Icons.edit),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: onDelete,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        )
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
