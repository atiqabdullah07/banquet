import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String name;
  String profilePhoto;
  String? email;
  String? uid;

  Customer(
      {required this.name, this.email, required this.profilePhoto, this.uid});

  Map<String, dynamic> toJson() =>
      {"name": name, "profilePhoto": profilePhoto, "email": email, "uid": uid};

  static Customer fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Customer(
        name: snapshot['name'],
        email: snapshot['email'],
        profilePhoto: snapshot['profilePhoto'],
        uid: snapshot['uid']);
  }
}
