import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bottom_navigation_view.dart';
import '../../assets/CustomColors.dart';
import '../components/interest.dart';
import 'interests_viewmodel.dart';

class InterestsView extends StatelessWidget {
  final InterestsViewModel interestsViewModel;

  const InterestsView(this.interestsViewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InterestsViewModel>.value(
      value: interestsViewModel,
      child: Consumer<InterestsViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            color: CustomColors.lightBlue,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child:
                      Row(
                      children: [
                        const SizedBox(height: 120.0),
                        const Text(
                        "Inserisci i tuoi interessi",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: CustomColors.darkBlue,
                          fontSize: 18.0,
                        ),
                      ),
                      ]
                    ),
                  ),
                  InterestComponent(
                    imageSrc: 'assets/interests/interest_story.svg',
                    labelText: 'Storia',
                    sliderValue: viewModel.storyValue,
                    onSliderChanged: (value) {
                      viewModel.storyValue = value;
                    },
                  ),
                  InterestComponent(
                    imageSrc: 'assets/interests/interest_art.svg',
                    labelText: 'Arte e Cultura',
                    sliderValue: viewModel.artValue,
                    onSliderChanged: (value) {
                      viewModel.artValue = value;
                    },
                  ),
                  InterestComponent(
                    imageSrc: 'assets/interests/interest_party.svg',
                    labelText: 'Party',
                    sliderValue: viewModel.partyValue,
                    onSliderChanged: (value) {
                      viewModel.partyValue = value;
                    },
                  ),
                  InterestComponent(
                    imageSrc: 'assets/interests/interest_nature.svg',
                    labelText: 'Natura',
                    sliderValue: viewModel.natureValue,
                    onSliderChanged: (value) {
                      viewModel.natureValue = value;
                    },
                  ),
                  InterestComponent(
                    imageSrc: 'assets/interests/interest_entertainment.svg',
                    labelText: 'Intrattenimento',
                    sliderValue: viewModel.entertainmentValue,
                    onSliderChanged: (value) {
                      viewModel.entertainmentValue = value;
                    },
                  ),
                  InterestComponent(
                    imageSrc: 'assets/interests/interest_sport.svg',
                    labelText: 'Sport',
                    sliderValue: viewModel.sportValue,
                    onSliderChanged: (value) {
                      viewModel.sportValue = value;
                    },
                  ),
                  InterestComponent(
                    imageSrc: 'assets/interests/interest_shopping.svg',
                    labelText: 'Shopping',
                    sliderValue: viewModel.shoppingValue,
                    onSliderChanged: (value) {
                      viewModel.shoppingValue = value;
                    },
                  ),
                  const SizedBox(height: 50.0),
                  SizedBox(
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.confirmClicked();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(viewModel.currentUser),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.darkBlue,
                      ),
                      child: const Text(
                        'Conferma',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
