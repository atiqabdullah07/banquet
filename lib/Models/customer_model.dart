class Customer {
  String? name;
  String? profilePhoto;
  String? email;
  String? uid;

  Customer({this.name, this.email, this.profilePhoto, this.uid});

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
      };

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        name: json['name'],
        email: json['email'],
        profilePhoto: json['profilePhoto'],
        uid: json['uid']);
  }
}

class ConversationUser {
  String? name;
  String? profilePhoto;

  String? uid;

  ConversationUser({this.name, this.profilePhoto, this.uid});
}
