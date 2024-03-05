class EventModel {
  String banquetname;
  String title;
  String content;
  String date;
  String? image;

  EventModel({
    required this.banquetname,
    required this.title,
    required this.content,
    required this.date,
    this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      banquetname: json['banquetname'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banquetname': banquetname,
      'title': title,
      'content': content,
      'date': date,
      'image': image,
    };
  }
}
