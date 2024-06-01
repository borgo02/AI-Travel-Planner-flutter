import 'package:cloud_firestore/cloud_firestore.dart';

class BaseRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
}
