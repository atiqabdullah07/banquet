class FoodModel {
  String? banquetname;
  String title;
  String content;
  String date;
  String? id;

  FoodModel({
    this.banquetname,
    required this.title,
    required this.content,
    required this.date,
    this.id,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      banquetname: json['banquetname'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banquetname': banquetname,
      'title': title,
      'content': content,
      'date': date,
      'id': id,
    };
  }
}
