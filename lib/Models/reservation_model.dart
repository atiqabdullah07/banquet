import 'package:banquet/Models/customer_model.dart';

class Reservation {
  String uid;
  Customer customer;
  String bookingPrice;
  String menu;
  String guests;
  String timeSlot;
  String date;

  Reservation({
    required this.uid,
    required this.customer,
    required this.bookingPrice,
    required this.menu,
    required this.guests,
    required this.timeSlot,
    required this.date,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      uid: json['uid'] ?? '',
      customer: Customer.fromJson(json['customer'] ?? {}),
      bookingPrice: json['bookingPrice'] ?? '',
      menu: json['menu'] ?? '',
      guests: json['guests'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'customer': customer.toJson(),
      'bookingPrice': bookingPrice,
      'menu': menu,
      'guests': guests,
      'timeSlot': timeSlot,
      'date': date,
    };
  }
}
