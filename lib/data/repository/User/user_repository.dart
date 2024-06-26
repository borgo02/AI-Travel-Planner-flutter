import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/likes.dart';
import '../../model/travel.dart';
import '../../model/user_model.dart';
import '../base_repository.dart';
import '../Travel/travel_repository.dart';

class UserRepository extends BaseRepository {
  User? currentUser;
  final TravelRepository travelRepository = TravelRepository();
  final CollectionReference usersCollectionRef = FirebaseFirestore.instance.collection('users');
  final CollectionReference travelsCollectionReference = FirebaseFirestore.instance.collection('travels');

  User getUser() {
    return currentUser!;
  }

  Future<void> updateUser(User newUser) async {
    currentUser = newUser;
    await setUser(newUser);
  }

  Future<void> setUser(User user) async {
    await db.collection('users').doc(user.idUser).set(user.toJson());
  }

  Future<void> updateLikedTravelByUser(String idUser, String idTravel, bool isLiked) async {
    transactionHandler(Transaction transaction) async {
      final DocumentReference travelRef = FirebaseFirestore.instance.collection('travels').doc(idTravel);
      final CollectionReference likedTravelsRef = FirebaseFirestore.instance.collection('users').doc(idUser).collection('likedTravels');
      final QuerySnapshot likedTravelQuery = await likedTravelsRef.where('idTravel', isEqualTo: travelRef).get();

      final DocumentSnapshot snapshot = await transaction.get(travelRef);
      final int currentLikesValue = snapshot.get('numberOfLikes') ?? 0;

      if (isLiked) {
        if (likedTravelQuery.docs.isEmpty) {
          final like = Likes(idTravel: travelRef, timestamp: DateTime.now());
          transaction.update(travelRef, {'numberOfLikes': currentLikesValue + 1});
          await likedTravelsRef.add(like.toJson());
        }
      } else {
        for (DocumentSnapshot like in likedTravelQuery.docs) {
          final String idLike = like.id;
          transaction.update(travelRef, {'numberOfLikes': currentLikesValue - 1});
          await likedTravelsRef.doc(idLike).delete();
          break;
        }
      }
    }

    await db.runTransaction(transactionHandler);
  }

  Future<List<Travel>> getTravelsByUser(String idUser) async {
    final travelRef = await travelsCollectionReference.where('idUser', isEqualTo: idUser).get();
    final List<Travel> sharedTravelList = [];

    for (final travel in travelRef.docs) {
      final travelData = await travelRepository.getTravelById(travel.id, idUser);
      if (travelData != null) sharedTravelList.add(travelData);
    }
    return sharedTravelList;
  }

  Future<Map<String, double>?> getInterestsByUser(String idUser) async {
    final userRef = await db.collection('users').doc(idUser).get();

    if (userRef.exists) {
      final interests = userRef.get('interests') as Map<String, double>;
      return interests;
    } else {
      return null;
    }
  }

  Future<List<Travel>> getSharedTravelsByUser(String idUser) async {
    final QuerySnapshot travelRef = await FirebaseFirestore.instance.collection('travels').where('idUser', isEqualTo: idUser).get();
    final List<Travel> sharedTravelList = [];

    for (DocumentSnapshot travel in travelRef.docs) {
      final Travel? travelData = await travelRepository.getTravelById(travel.id, idUser);
      if (travelData != null && travelData.isShared!) {
        sharedTravelList.add(travelData);
      }
    }
    return sharedTravelList;
  }

  Future<List<Travel>> getNotSharedTravelsByUser(String idUser) async {
    final QuerySnapshot travelRef = await FirebaseFirestore.instance.collection('travels').where('idUser', isEqualTo: idUser).get();
    final List<Travel> notSharedTravelList = [];

    for (DocumentSnapshot travel in travelRef.docs) {
      final Travel? travelData = await travelRepository.getTravelById(travel.id, idUser);
      print("Travel: $travelData");
      if (travelData != null && !(travelData.isShared ?? false)) {
        notSharedTravelList.add(travelData);
      }
    }
    return notSharedTravelList;
  }

  Future<List<User>> getUsers() async {
    final users = await usersCollectionRef.get();
    final List<User> userList = [];

    for (final doc in users.docs) {
      final idUser = doc.id;
      final userData = await getUserById(idUser: idUser);
      if (userData != null) userList.add(userData);
    }

    return userList;
  }

  Future<User?> getUserById({required String idUser, bool isCurrentUser = false}) async {
    final userDoc = await usersCollectionRef.doc(idUser).get();
    List<Likes>? likedTravelList;

    if (userDoc.exists) {
      final email = userDoc.get('email');
      final isInit = userDoc.get('initialized');
      final fullname = userDoc.get('fullname');
      final data = userDoc.get('interests');
      Map<String, double> interests = {};
      data.forEach((key, value) {
        if (value is double) {
          interests[key] = value;
        }
      });
      likedTravelList = await getLikesByUser(idUser);
      final user = User(
        idUser: idUser,
        email: email,
        fullname: fullname,
        isInitialized: isInit,
        interests: interests,
        likedTravels: likedTravelList,
      );

      if (isCurrentUser) currentUser = user;
      return user;
    } else {
      return null;
    }
  }

  Future<User?> getUserByTravel(String idTravel) async {
    final travelRef = await travelsCollectionReference.doc(idTravel).get();
    if (travelRef.exists) {
      final idUser = travelRef.get('idUser');
      final userRef = await db.collection('users').doc(idUser).get();
      if (userRef.exists) return getUserById(idUser: idUser);
    }
    return null;
  }

  Future<List<Likes>> getLikesByUser(String idUser) async {
    final List<Likes> likesList = [];
    final likesRef = await usersCollectionRef.doc(idUser).collection('likedTravels').get();

    for (final like in likesRef.docs) {
      final idLike = like.id;
      final idTravelReferencePath = like.get('idTravel').path;
      final idTravelDoc = idTravelReferencePath.split('/').last;
      final timestamp = (like.get('timestamp') as Timestamp).toDate();
      final travelRef = db.collection('travels').doc(idTravelDoc);
      final likeItem = Likes(idLike: idLike, idTravel: travelRef, timestamp: timestamp);
      likesList.add(likeItem);
    }

    return likesList;
  }

  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();
}