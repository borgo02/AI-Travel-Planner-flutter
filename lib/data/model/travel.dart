import 'package:cloud_firestore/cloud_firestore.dart';
import 'stage.dart';

class Travel {
  String? idTravel;
  String? idUser;
  String? info;
  String? name;
  bool? isShared;
  DateTime? timestamp;
  int? numberOfLikes;
  String? imageUrl;
  List<Stage>? stageList;
  bool? isLiked;

  Travel({
    this.idTravel,
    this.idUser,
    this.info,
    this.name,
    this.isShared,
    this.timestamp,
    this.numberOfLikes,
    this.imageUrl,
    this.stageList,
    this.isLiked,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      idTravel: json['idTravel'] as String?,
      idUser: json['idUser'] as String?,
      info: json['info'] as String?,
      name: json['name'] as String?,
      isShared: json['isShared'] as bool?,
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
      numberOfLikes: json['numberOfLikes'] as int?,
      imageUrl: json['imageUrl'] as String?,
      stageList: (json['stages'] as List<dynamic>?)
          ?.map((item) => Stage.fromJson(item as Map<String, dynamic>))
          .toList(),
      isLiked: json['isLiked'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTravel': idTravel,
      'idUser': idUser,
      'info': info,
      'name': name,
      'isShared': isShared,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
      'numberOfLikes': numberOfLikes,
      'imageUrl': imageUrl,
      'stages': stageList?.map((item) => item.toJson()).toList(),
      'isLiked': isLiked,
    };
  }
}