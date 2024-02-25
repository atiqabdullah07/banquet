class Banquet {
  String? name;
  String? email;
  String? venueType;
  String? parkingCapacity;
  String? guestsCapacity;
  String? bookingPrice;
  String? facilities;
  String? description;
  String? location;

  Banquet({
    this.name,
    this.email,
    this.venueType,
    this.parkingCapacity,
    this.guestsCapacity,
    this.bookingPrice,
    this.facilities,
    this.description,
    this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'venueType': venueType,
      'parkingCapacity': parkingCapacity,
      'guestsCapacity': guestsCapacity,
      'bookingPrice': bookingPrice,
      'facilities': facilities,
      'description': description,
      'location': location,
    };
  }

  factory Banquet.fromJson(Map<String, dynamic> json) {
    return Banquet(
      name: json['name'],
      email: json['email'],
      venueType: json['venueType'],
      parkingCapacity: json['parkingCapacity'],
      guestsCapacity: json['guestsCapacity'],
      bookingPrice: json['bookingPrice'],
      facilities: json['facilities'],
      description: json['description'],
      location: json['location'],
    );
  }
}
