class FoodModel {
  String banquetname;
  String title;
  String content;
  String date;

  FoodModel({
    required this.banquetname,
    required this.title,
    required this.content,
    required this.date,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      banquetname: json['banquetname'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banquetname': banquetname,
      'title': title,
      'content': content,
      'date': date,
    };
  }
}
