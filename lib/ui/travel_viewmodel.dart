import 'package:ai_travel_planner/base_viewmodel.dart';
import 'package:ai_travel_planner/data/model/stage.dart';
import 'package:ai_travel_planner/data/model/travel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/model/user_model.dart' as PushaPaolo;


class TravelViewModel extends BaseViewModel {
  List<Travel> notSharedTravels = [];
  List<Travel> sharedTravels = [];
  List<Travel> filteredTravels = [];
  String searchText = "";

  TravelViewModel(){
    loadNotSharedTravels();
    loadSharedTravels();
  }

  Future<void> loadNotSharedTravels() async {
    await executeWithLoading(() async {
      try {
        setLoading(true);
        notSharedTravels = await userRepository.getNotSharedTravelsByUser(currentUser.idUser);
      } catch (e) {
        print("Error loading not shared travels: $e");
      } finally {
        setLoading(false);
        notifyListeners();
      }
    });
  }

  Future<void> loadSharedTravels() async {
    try {
      setLoading(true);
      sharedTravels = await travelRepository.getSharedTravels(currentUser.idUser);
    } catch (e) {
      print("Error loading shared travels, $e");
    } finally {
      setLoading(false);
      filteredTravels.addAll(sharedTravels);
      notifyListeners();
    }
  }

  Future<void> updateLikedTravel(idTravel, idUser, isLiked) async {
    try {
      userRepository.updateLikedTravelByUser(idUser, idTravel, isLiked);
    } catch (e) {
      print("Error updating like to the travel, $e");
    } finally {
      notifyListeners();
    }
  }

  void toggleLikeStatus(Travel travel, String userId) {
    if (travel.isLiked) {
      travel.numberOfLikes = (travel.numberOfLikes! - 1);
    } else {
      travel.numberOfLikes = (travel.numberOfLikes! + 1);
    }
    travel.isLiked = !travel.isLiked;
    updateLikedTravel(travel.idTravel, userId, travel.isLiked);
    notifyListeners();
  }

  void searchTravel(String query) {
    searchText = query;
    if(query!="") {
      filteredTravels = sharedTravels.where((travel) => travel.name!.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      filteredTravels.clear();
      filteredTravels.addAll(sharedTravels);
    }
    print('Query: $query');
    print('Filtered travels: $filteredTravels');
    notifyListeners();
  }

  void shareTravel(Travel travel) {
    notSharedTravels.remove(travel);
    sharedTravels.add(travel);
    searchTravel(searchText);
    travelRepository.setTravelToShared(travel.idTravel!);
    notifyListeners();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().disconnect();
  }

  Future<PushaPaolo.User?> getOwnerUser(Travel travel){
    return userRepository.getUserByTravel(travel.idTravel!);
  }

  Future<List<Stage>> getStagesByTravel(Travel travel){
    return travelRepository.getStagesByTravel(travel.idTravel!);
  }
}


