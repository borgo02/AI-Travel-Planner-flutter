import 'package:ai_travel_planner/CustomColors.dart';
import 'package:flutter/material.dart';

import '../components/interest.dart';
import 'interests_viewmodel.dart';

class InterestsView extends StatelessWidget {
  final InterestsViewModel viewModel;

  const InterestsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: CustomColors.lightBlue,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50.0),
              InterestComponent(
                imageSrc: 'assets/interests/interest_story.xml',
                labelText: 'Storia',
                sliderValue: viewModel.storyValue,
                onSliderChanged: (value) {
                  viewModel.storyValue = value;
                },
              ),
              InterestComponent(
                imageSrc: 'assets/interests/interest_art.xml',
                labelText: 'Arte e Cultura',
                sliderValue: viewModel.artValue,
                onSliderChanged: (value) {
                  viewModel.artValue = value;
                },
              ),
              InterestComponent(
                imageSrc: 'assets/interests/interest_party.xml',
                labelText: 'Party',
                sliderValue: viewModel.partyValue,
                onSliderChanged: (value) {
                  viewModel.artValue = value;
                },
              ),
              InterestComponent(
                imageSrc: 'assets/interests/interest_nature.xml',
                labelText: 'Natura',
                sliderValue: viewModel.natureValue,
                onSliderChanged: (value) {
                  viewModel.artValue = value;
                },
              ),
              InterestComponent(
                imageSrc: 'assets/interests/interest_entertainment.xml',
                labelText: 'Intrattenimento',
                sliderValue: viewModel.entertainmentValue,
                onSliderChanged: (value) {
                  viewModel.artValue = value;
                },
              ),
              InterestComponent(
                imageSrc: 'assets/interests/interest_sport.xml',
                labelText: 'Sport',
                sliderValue: viewModel.sportValue,
                onSliderChanged: (value) {
                  viewModel.artValue = value;
                },
              ),
              InterestComponent(
                imageSrc: 'assets/interests/interest_Shopping.xml',
                labelText: 'Shopping',
                sliderValue: viewModel.shoppingValue,
                onSliderChanged: (value) {
                  viewModel.artValue = value;
                },
              ),
              const SizedBox(
                height: 50.0,
              ),
              // Add more InterestComponents for other interests here
              SizedBox(
                height: 60.0, // Adjust this value to your desired height
                  child: ElevatedButton(
                    onPressed: viewModel.confirmClicked,
                    style: ElevatedButton.styleFrom( backgroundColor: CustomColors.darkBlue),
                    child: const Text('Conferma', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  ),
                ),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}