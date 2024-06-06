import 'package:ai_travel_planner/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ai_travel_planner/data/repository/travel/travel_repository.dart';
import 'package:ai_travel_planner/data/model/travel.dart';

class DashboardViewModel extends BaseViewModel {
  final TravelRepository travelRepository;
  List<Travel> travels = [];
  @override
  bool isLoading = true;

  DashboardViewModel({required this.travelRepository});

  Future<void> loadTravels(String userId) async {
    try {
      final loadedTravels = await travelRepository.getSharedTravels(userId);
      travels = loadedTravels;
    } catch (e) {
      print("Error loading travels, $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
