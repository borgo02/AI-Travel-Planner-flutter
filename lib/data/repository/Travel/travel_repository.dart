import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/stage.dart';
import '../../model/travel.dart';
import '../../model/user.dart';
import '../base_repository.dart';

class TravelRepository extends BaseRepository {
  final CollectionReference usersCollectionRef = FirebaseFirestore.instance.collection('users');
  final CollectionReference travelsCollectionReference = FirebaseFirestore.instance.collection('travels');

  Future<void> setTravel(Travel travel) async {
    await travelsCollectionReference.add(travel.toJson());
  }

  Future<void> setTravelToShared(String idTravel) async {
    final travelDoc = travelsCollectionReference.doc(idTravel);
    final travelRef = await travelDoc.get();
    if (travelRef.exists) {
      final newShareData = {'isShared': true};
      await travelDoc.update(newShareData);
    }
  }

  Future<void> setStageByTravel(String idTravel, Stage stage) async {
    final travelDoc = travelsCollectionReference.doc(idTravel);
    final travelRef = await travelDoc.get();
    if (travelRef.exists) {
      await travelDoc.collection('stages').add(stage.toJson());
    }
  }

  Future<List<Travel>> getSharedTravels(String idUser) async {
    final travelsDoc = await travelsCollectionReference.get();
    final List<Travel> travelList = [];
    for (final doc in travelsDoc.docs) {
      final idTravel = doc.id;
      final travelData = await getTravelById(idTravel, idUser);
      if (travelData != null && travelData.isShared == true) {
        travelList.add(travelData);
      }
    }
    return travelList;
  }

  Future<Travel?> getTravelById(String idTravel, String idUser) async {
    final doc = await travelsCollectionReference.doc(idTravel).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final idUserRef = data['idUser'] as DocumentReference;
      final info = data['info'] as String?;
      final name = data['name'] as String?;
      final isShared = data['isShared'] as bool?;
      final numberOfLikes = data['numberOfLikes'] as int?;
      final imageUrl = data['imageUrl'] as String?;
      final timestamp = (data['timestamp'] as Timestamp?)?.toDate();
      final isLiked = await isTravelLikedByUser(idTravel, idUser);
      final stages = await getStagesByTravel(idTravel);
      return Travel(
        idTravel: idTravel,
        idUser: idUserRef.id,
        info: info,
        name: name,
        isShared: isShared,
        timestamp: timestamp,
        numberOfLikes: numberOfLikes,
        imageUrl: imageUrl,
        stageList: stages,
        isLiked: isLiked,
      );
    }
    return null;
  }

  Future<List<Stage>> getStagesByTravel(String idTravel) async {
    final stagesRef = await travelsCollectionReference.doc(idTravel).collection('stages').get();
    final List<Stage> stagesList = [];
    for (final stage in stagesRef.docs) {
      final data = stage.data();
      final idStage = stage.id;
      final name = data['name'] as String?;
      final imageUrl = data['imageUrl'] as String?;
      final city = data['city'] as String?;
      final description = data['description'] as String?;
      final position = data['position'] as int;
      final stageItem = Stage(
        idStage: idStage,
        name: name!,
        imageUrl: imageUrl!,
        city: city!,
        description: description!,
        position: position,
      );
      stagesList.add(stageItem);
    }
    return stagesList;
  }

  Future<List<Travel>> getTravelsCreatedByUser(User user) async {
    final travels = await travelsCollectionReference.where('idUser', isEqualTo: user.idUser).get();
    final List<Travel> travelList = [];
    for (final travel in travels.docs) {
      final travelData = Travel.fromJson(travel.data() as Map<String, dynamic>);
      travelList.add(travelData);
    }
    return travelList;
  }

  Future<bool> isTravelLikedByUser(String idTravel, String idUser) async {
    final likesRef = await usersCollectionRef.doc(idUser).collection('likedTravels').get();
    for (final like in likesRef.docs) {
      final idTravelRefPath = like.data()['idTravel'] as DocumentReference;
      final idTravelDoc = idTravelRefPath.id;
      if (idTravelDoc == idTravel) {
        return true;
      }
    }
    return false;
  }
}