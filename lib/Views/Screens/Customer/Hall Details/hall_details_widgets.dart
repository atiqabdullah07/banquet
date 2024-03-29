import 'package:accordion/accordion.dart';
import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.menu,
  });
  final PackageMenu menu;

  @override
  Widget build(BuildContext context) {
    return Accordion(
        headerBackgroundColor: AppColors.secondaryColor,
        headerBorderColorOpened: Colors.transparent,
        rightIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.black,
        ),
        headerBackgroundColorOpened: AppColors.secondaryColor,
        contentBackgroundColor: Colors.white,
        contentBorderColor: AppColors.secondaryColor,
        contentBorderWidth: 1,
        contentHorizontalPadding: 10,
        scaleWhenAnimating: true,
        paddingListTop: 0,
        paddingListBottom: 5,
        paddingListHorizontal: 0,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: [
          AccordionSection(
              header: Text(menu.name),
              content: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: menuSection(
                            icon: 'assets/icons/restaurant.png',
                            title: 'Main Course',
                            content: menu.mainCourse),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            menuSection(
                              icon: 'assets/icons/icecream.png',
                              title: 'Desserts',
                              content: menu.desserts!,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            menuSection(
                              icon: 'assets/icons/wine_bar.png',
                              title: 'Drinks',
                              content: menu.drinks!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      const Text('Price:'),
                      Text(
                        "${menu.price.toString()}/",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      const Text('Perosn'),
                    ],
                  )
                ],
              ))
        ]);
  }

  static fromJson(Map<String, dynamic> bookingJson) {}
}

Widget menuSection(
    {required String icon, required String title, required String content}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Image.asset(
            icon,
            scale: 1.8,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(
        height: 2.h,
      ),
      Text(
        content,
        style: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.8)),
      )
    ],
  );
}

Widget hallDetailsCard(
    {String? icon, required String title, required String value}) {
  return Expanded(
    child: Container(
      height: 80,
      width: 100,
      decoration: BoxDecoration(
          color: AppColors.secondaryColor.withOpacity(0.2),
          border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon != null
                    ? Image.asset(
                        icon,
                        scale: 1.5,
                      )
                    : const SizedBox(),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.3)),
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SingleChildScrollView(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
