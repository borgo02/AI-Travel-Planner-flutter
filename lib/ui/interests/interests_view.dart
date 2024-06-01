import 'package:flutter/material.dart';

import '../components/interest.dart';
import 'interests_viewmodel.dart';

class InterestsView extends StatelessWidget {
  final InterestsViewModel viewModel;

  const InterestsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InterestComponent(
              imageSrc: const AssetImage('assets/interest_story.png'),
              labelText: 'Storia',
              sliderValue: viewModel.storyValue,
              onSliderChanged: (value) {
                viewModel.storyValue = value;
              },
            ),
            InterestComponent(
              imageSrc: const AssetImage('assets/interest_art.png'),
              labelText: 'Arte e Cultura',
              sliderValue: viewModel.artValue,
              onSliderChanged: (value) {
                viewModel.artValue = value;
              },
            ),
            InterestComponent(
              imageSrc: const AssetImage('assets/interest_party.png'),
              labelText: 'Party',
              sliderValue: viewModel.partyValue,
              onSliderChanged: (value) {
                viewModel.artValue = value;
              },
            ),
            InterestComponent(
              imageSrc: const AssetImage('assets/interest_nature.png'),
              labelText: 'Natura',
              sliderValue: viewModel.natureValue,
              onSliderChanged: (value) {
                viewModel.artValue = value;
              },
            ),
            InterestComponent(
              imageSrc: const AssetImage('assets/interest_entertainment.png'),
              labelText: 'Intrattenimento',
              sliderValue: viewModel.entertainmentValue,
              onSliderChanged: (value) {
                viewModel.artValue = value;
              },
            ),
            InterestComponent(
              imageSrc: const AssetImage('assets/interest_sport.png'),
              labelText: 'Sport',
              sliderValue: viewModel.sportValue,
              onSliderChanged: (value) {
                viewModel.artValue = value;
              },
            ),
            InterestComponent(
              imageSrc: const AssetImage('assets/interest_Shopping.png'),
              labelText: 'Shopping',
              sliderValue: viewModel.shoppingValue,
              onSliderChanged: (value) {
                viewModel.artValue = value;
              },
            ),
            // Add more InterestComponents for other interests here
            ElevatedButton(
              onPressed: viewModel.confirmClicked,
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}