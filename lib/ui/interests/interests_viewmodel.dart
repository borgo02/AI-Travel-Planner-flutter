import 'package:ai_travel_planner/base_viewmodel.dart';
import 'package:ai_travel_planner/data/model/user.dart';
import 'package:flutter/material.dart';

class InterestsViewModel extends BaseViewModel {
  final _storyValue = ValueNotifier<double>(5.0);
  final _artValue = ValueNotifier<double>(5.0);
  final _partyValue = ValueNotifier<double>(5.0);
  final _natureValue = ValueNotifier<double>(5.0);
  final _entertainmentValue = ValueNotifier<double>(5.0);
  final _sportValue = ValueNotifier<double>(5.0);
  final _shoppingValue = ValueNotifier<double>(5.0);

  double get storyValue => _storyValue.value;
  set storyValue(double value) => _storyValue.value = value;

  double get artValue => _artValue.value;
  set artValue(double value) => _artValue.value = value;

  double get partyValue => _partyValue.value;
  set partyValue(double value) => _partyValue.value = value;

  double get natureValue => _natureValue.value;
  set natureValue(double value) => _natureValue.value = value;

  double get entertainmentValue => _entertainmentValue.value;
  set entertainmentValue(double value) => _entertainmentValue.value = value;

  double get sportValue => _sportValue.value;
  set sportValue(double value) => _sportValue.value = value;

  double get shoppingValue => _shoppingValue.value;
  set shoppingValue(double value) => _shoppingValue.value = value;

  void confirmClicked() async {
    Map<String, double> interestEntity = {
      'story': storyValue,
      'art': artValue,
      'party': partyValue,
      'nature': natureValue,
      'entertainment': entertainmentValue,
      'sport': sportValue,
      'shopping': shoppingValue,
    };

    currentUser.interests = interestEntity;
    currentUser.isInitialized = true;
    await userRepository.updateUser(currentUser as User);

    //Navigator.of(context).pop();
  }
}