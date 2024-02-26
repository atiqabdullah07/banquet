class Reservation {
  String bookingPrice;
  String menu;
  String guests;
  String timeSlot;
  String date;

  Reservation({
    required this.bookingPrice,
    required this.menu,
    required this.guests,
    required this.timeSlot,
    required this.date,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      bookingPrice: json['bookingPrice'] ?? '',
      menu: json['menu'] ?? '',
      guests: json['guests'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingPrice': bookingPrice,
      'menu': menu,
      'guests': guests,
      'timeSlot': timeSlot,
      'date': date,
    };
  }
}
