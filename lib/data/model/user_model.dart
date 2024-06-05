import 'likes.dart';

class User {
  String idUser;
  String email;
  String fullname;
  bool isInitialized;
  Map<String, double>? interests;
  List<Likes>? likedTravels;

  User({
    required this.idUser,
    required this.email,
    required this.fullname,
    required this.isInitialized,
    this.interests,
    this.likedTravels,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['idUser'] as String,
      email: json['email'] as String,
      fullname: json['fullname'] as String,
      isInitialized: json['initialized'] as bool,
      interests: (json['interests'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as num).toDouble())),
      likedTravels: (json['likedTravels'] as List<dynamic>?)
          ?.map((item) => Likes.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'email': email,
      'fullname': fullname,
      'initialized': isInitialized,
      'interests': interests,
      'likedTravels': likedTravels?.map((item) => item.toJson()).toList(),
    };
  }
}