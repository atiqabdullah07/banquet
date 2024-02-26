import 'package:banquet/Models/menu_model.dart';
import 'package:banquet/Models/reservation_model.dart';

class Banquet {
  String? name;
  String? email;
  String? logo;
  String? uid;
  String? venueType;
  String? parkingCapacity;
  String? guestsCapacity;
  String? bookingPrice;
  String? facilities;
  String? description;
  String? location;
  List<Reservation>? bookings;
  List<PackageMenu>? menu; // List of reservations, now non-required

  Banquet({
    this.name,
    this.uid,
    this.email,
    this.logo,
    this.venueType,
    this.parkingCapacity,
    this.guestsCapacity,
    this.bookingPrice,
    this.facilities,
    this.description,
    this.location,
    this.bookings = const [],
    this.menu = const [], // Initialize with an empty list
  });

  factory Banquet.fromJson(Map<String, dynamic> json) {
    return Banquet(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      logo: json['logo'],
      venueType: json['venueType'],
      parkingCapacity: json['parkingCapacity'],
      guestsCapacity: json['guestsCapacity'],
      bookingPrice: json['bookingPrice'],
      facilities: json['facilities'],
      description: json['description'],
      location: json['location'],
      bookings: (json['bookings'] as List<dynamic>?)
              ?.map((bookingJson) =>
                  Reservation.fromJson(bookingJson as Map<String, dynamic>))
              .toList() ??
          [],
      menu: (json['bookings'] as List<dynamic>?)
              ?.map((bookingJson) =>
                  PackageMenu.fromJson(bookingJson as Map<String, dynamic>))
              .toList() ??
          [], // Convert JSON array to List of Reservation objects
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'logo': logo,
      'venueType': venueType,
      'parkingCapacity': parkingCapacity,
      'guestsCapacity': guestsCapacity,
      'bookingPrice': bookingPrice,
      'facilities': facilities,
      'description': description,
      'location': location,
      'bookings': bookings?.map((booking) => booking.toJson()).toList(),
      'menu': menu?.map((menuItem) => menuItem.toJson()).toList(),
    };
  }
}
