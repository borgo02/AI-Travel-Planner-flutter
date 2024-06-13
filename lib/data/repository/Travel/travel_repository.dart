import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/stage.dart';
import '../../model/travel.dart';
import '../../model/user_model.dart';
import '../base_repository.dart';

class TravelRepository extends BaseRepository {
  final CollectionReference usersCollectionRef = FirebaseFirestore.instance.collection('users');
  final CollectionReference travelsCollectionReference = FirebaseFirestore.instance.collection('travels');

  Future<void> setTravel(Travel travel) async {
    final documentReference = travelsCollectionReference.doc();
    travel.idTravel = documentReference.id;
    await documentReference.set(travel.toJson());
    travel.stageList?.forEach((stage) {
      setStageByTravel(travel.idTravel!, stage);
    });
  }

  Future<void> setTravelToShared(String idTravel) async {
    final travelDoc = travelsCollectionReference.doc(idTravel);
    final travelRef = await travelDoc.get();
    if (travelRef.exists) {
      final newShareData = {'shared': true};
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
    bool isLiked;
    final doc = await travelsCollectionReference.doc(idTravel).get();
    if (doc.exists) {
      final idUserRef = doc.get('idUser') as String;
      final info = doc.get('info') as String?;
      final name = doc.get('name') as String?;
      final isShared = doc.get('shared') as bool?;
      final numberOfLikes = doc.get('numberOfLikes')?.toInt();
      final imageUrl = doc.get('imageUrl') as String?;
      final timestamp = (doc.get('timestamp') as Timestamp?)?.toDate();
      isLiked = idUser.isNotEmpty ? await isTravelLikedByUser(idTravel, idUser) : false;
      final stages = await getStagesByTravel(idTravel);
      return Travel(
        idTravel: idTravel,
        idUser: idUserRef,
        info: info,
        name: name,
        isShared: isShared,
        timestamp: timestamp,
        numberOfLikes: numberOfLikes,
        imageUrl: imageUrl,
        stageList: stages,
        isLiked: isLiked,
      );
    } else {
      return null;
    }
  }

  Future<List<Travel>> getTravels() async {
    final travelsDoc = await travelsCollectionReference.get();
    final List<Travel> travelList = [];
    for (final doc in travelsDoc.docs) {
      final idTravel = doc.id;
      final travelData = await getTravelById(idTravel, "");
      if (travelData != null) {
        travelList.add(travelData);
      }
    }
    return travelList;
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

  Future<List<Stage>> getFilteredStagesByCity(String filter, String city) async {
    final travels = await getTravels();
    final List<Stage> stageList = [];
    for (final travel in travels) {
      final stages = await getStagesByTravel(travel.idTravel!);
      for (final stage in stages) {
        if (stage.city.toLowerCase() == city.toLowerCase() &&
            filter.toLowerCase().contains(stage.name.toLowerCase())) {
          stageList.add(stage);
        }
      }
    }
    return stageList;
  }

  Future<bool> isTravelLikedByUser(String idTravel, String idUser) async {
    final likesRef = await usersCollectionRef.doc(idUser).collection("likedTravels").get();
    bool isTravelLiked = false;
    for (final like in likesRef.docs) {
      final idTravelReferencePath = like.get("idTravel")!.path;
      final idTravelDoc = idTravelReferencePath.split("/").last;
      if (idTravelDoc == idTravel) {
        isTravelLiked = true;
        break;
      }
    }
    return isTravelLiked;
  }
}