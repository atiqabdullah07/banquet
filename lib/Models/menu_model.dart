class PackageMenu {
  String name;
  String price;
  String mainCourse;
  String? desserts;
  String? drinks;

  PackageMenu({
    required this.name,
    required this.price,
    required this.mainCourse,
    this.desserts,
    this.drinks,
  });

  factory PackageMenu.fromJson(Map<String, dynamic> json) {
    return PackageMenu(
      name: json['name'],
      price: json['price'],
      mainCourse: json['mainCourse'],
      desserts: json['desserts'],
      drinks: json['drinks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'mainCourse': mainCourse,
      'desserts': desserts,
      'drinks': drinks,
    };
  }
}
