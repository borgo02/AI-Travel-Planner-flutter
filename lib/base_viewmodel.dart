import 'package:ai_travel_planner/data/repository/Travel/travel_repository.dart';
import 'package:flutter/material.dart';
import 'package:ai_travel_planner/data/model/user_model.dart';
import 'package:ai_travel_planner/data/repository/User/user_repository.dart';

class BaseViewModel extends ChangeNotifier {
  final TravelRepository travelRepository = TravelRepository();
  final UserRepository userRepository = UserRepository();
  User? currentUser;
  bool _isLoading = false;
  bool isNavigating = false;

  BaseViewModel() {
    //initializeCurrentUser();
  }

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> initializeCurrentUser() async {
    try {
      currentUser = await userRepository.getUser();
      if (currentUser == null) {
        // Handle the case when currentUser is null, maybe navigate to login or show an error
        print("Error: currentUser is null");
      } else {
        notifyListeners();
      }
    } catch (e) {
      print("Error loading user: $e");
    }
  }

  Future<void> executeWithLoading(Future<void> Function() block) async {
    setLoading(true);

    try {
      await block();
    } catch (e) {
      // Handle the exception if needed
    } finally {
      setLoading(false);
    }
  }

  void checkIfUserHaveInterest() {
    if (currentUser == null || !currentUser!.isInitialized) {
      goToInterestFragment();
    }
  }

  void navigate(/*NavDirections navDirections*/) {
    // Implement navigation logic using your preferred navigation package
  }

  void navigateBack() {
    // Implement navigation back logic using your preferred navigation package
  }

  void goToInterestFragment() {
    /*try {
      navigate(DashboardFragmentDirections.actionNavigationDashboardToInterest());
    } catch (e) {
      // Handle the exception if needed
    }*/
  }
}
