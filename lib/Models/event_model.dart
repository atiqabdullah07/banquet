class EventModel {
  String banquetname;
  String title;
  String content;
  String date;
  String? image;
  String? id;

  EventModel(
      {required this.banquetname,
      required this.title,
      required this.content,
      required this.date,
      this.image,
      this.id});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        banquetname: json['banquetname'],
        title: json['title'],
        content: json['content'],
        date: json['date'],
        image: json['image'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'banquetname': banquetname,
      'title': title,
      'content': content,
      'date': date,
      'image': image,
      'id': id
    };
  }
}
