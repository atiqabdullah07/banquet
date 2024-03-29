import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/customer_controller.dart';
import 'package:banquet/Models/event_model.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final CustomerController _customerController = Get.put(CustomerController());

  @override
  void initState() {
    super.initState();
    _customerController.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.backgroundColor,
      color: AppColors.primaryColor,
      onRefresh: () async {
        _customerController.fetchEvents();
      },
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            title: const Text('Upcoming Events'),
          ),
          body: Obx(() {
            return ListView.builder(
              itemCount: _customerController.allEvents.length,
              itemBuilder: (context, index) {
                return EventsCard(
                  event: _customerController.allEvents[index],
                );
              },
            );
          })),
    );
  }
}

class EventsCard extends StatelessWidget {
  const EventsCard({
    super.key,
    required this.event,
  });

  final EventModel event;

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
              child: event.image == null || event.image == ''
                  ? Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Event',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    )
                  : Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(event.image!),
                        ),
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
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  event.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          event.content,
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
                        Expanded(
                          child: Text(
                            event.banquetname,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            event.date,
                            style: const TextStyle(fontSize: 14),
                          ),
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
