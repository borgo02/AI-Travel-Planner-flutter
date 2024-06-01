import 'package:cloud_firestore/cloud_firestore.dart';

class Likes {
  String? idLike;
  DocumentReference idTravel;
  DateTime? timestamp;

  Likes({
    this.idLike,
    required this.idTravel,
    this.timestamp,
  });

  factory Likes.fromJson(Map<String, dynamic> json) {
    return Likes(
      idLike: json['idLike'] as String?,
      idTravel: json['idTravel'] as DocumentReference,
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idLike': idLike,
      'idTravel': idTravel,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }
}
