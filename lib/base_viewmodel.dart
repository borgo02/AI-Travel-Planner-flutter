import 'package:flutter/material.dart';
import 'data/model/User.dart';
import 'data/repository/User/user_repository.dart';


class BaseViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();
  late User currentUser;
  bool _isLoading = false;
  bool isNavigating = false;

  BaseViewModel() {
    currentUser = userRepository.getUser() as User;
  }

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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
    if (!currentUser.isInitialized) {
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