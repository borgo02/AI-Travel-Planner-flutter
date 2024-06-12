import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/user_model.dart' as auth;
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
                        viewModel.partyValue = value;
                      },
                    ),
                    InterestComponent(
                      imageSrc: 'assets/interests/interest_nature.xml',
                      labelText: 'Natura',
                      sliderValue: viewModel.natureValue,
                      onSliderChanged: (value) {
                        viewModel.natureValue = value;
                      },
                    ),
                    InterestComponent(
                      imageSrc: 'assets/interests/interest_entertainment.xml',
                      labelText: 'Intrattenimento',
                      sliderValue: viewModel.entertainmentValue,
                      onSliderChanged: (value) {
                        viewModel.entertainmentValue = value;
                      },
                    ),
                    InterestComponent(
                      imageSrc: 'assets/interests/interest_sport.xml',
                      labelText: 'Sport',
                      sliderValue: viewModel.sportValue,
                      onSliderChanged: (value) {
                        viewModel.sportValue = value;
                      },
                    ),
                    InterestComponent(
                      imageSrc: 'assets/interests/interest_Shopping.xml',
                      labelText: 'Shopping',
                      sliderValue: viewModel.shoppingValue,
                      onSliderChanged: (value) {
                        viewModel.shoppingValue = value;
                      },
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    // Add more InterestComponents for other interests here
                    SizedBox(
                      height: 60.0, // Adjust this value to your desired height
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.confirmClicked();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                MainPage(viewModel.currentUser)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.darkBlue),
                        child: const Text('Conferma',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18.0),),
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
        },
      ),
    );
  }
}