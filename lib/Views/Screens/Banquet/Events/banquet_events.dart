import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Views/Screens/Banquet/Events/add_event.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class BanquetEvents extends StatelessWidget {
  const BanquetEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banquet Events'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEvent()));
        },
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return const BanquetEventsCard();
        },
      ),
    );
  }
}

class BanquetEventsCard extends StatelessWidget {
  const BanquetEventsCard({
    super.key,
  });

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
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://i.pinimg.com/originals/85/7a/bc/857abcdd95af8530c9d022f5cb420932.png')),
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 15, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Small Trip Expo',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
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
                          'Buissness Expo new enterpenuer to seek buissness insights at 2:00 pm',
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
                        const Text(
                          '26 Jan 2024',
                          style: TextStyle(fontSize: 14),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.edit),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {},
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
