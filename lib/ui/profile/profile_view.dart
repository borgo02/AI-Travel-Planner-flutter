import 'package:ai_travel_planner/ui/travel/travel_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/ui/travel_viewmodel.dart';
import 'package:ai_travel_planner/ui/components/travel_card.dart';
import 'package:ai_travel_planner/assets/CustomColors.dart';

import '../../data/model/user_model.dart';
import '../Travel/travel_details.dart';

class ProfileFragment extends StatelessWidget {
  final TravelViewModel travelViewModel;
  const ProfileFragment(this.travelViewModel, {Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TravelViewModel>.value(
      value: travelViewModel,
      child: Consumer<TravelViewModel>(
        builder: (context, travelViewModel, child) {
          return travelViewModel.isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 120.0,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png"),
                        radius: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'Nome utente',
                        style: TextStyle(
                          color: CustomColors.darkBlue,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 10.0),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded( // Added Expanded widget
                  child: ListView.builder(
                    itemCount: travelViewModel.notSharedTravels.length,
                    itemBuilder: (context, index) {
                      final travel =
                      travelViewModel.notSharedTravels[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TravelDetailsFragment(
                                travelViewModel,
                                travel,
                              ),
                            ),
                          );
                        },
                        child: TravelCard(
                          bottomMargin: index ==
                              travelViewModel.notSharedTravels.length -
                                  1
                              ? 120
                              : 10,
                          travel: travel,
                          user: null,
                          ownerUser: null,
                          icon: Icons.share,
                          onIconTap: () {
                            travelViewModel.shareTravel(travel);
                          },
                          onLikeTap: null,
                          showOwnerName: false, // Hide owner name in profile
                          showLikes:
                          false, // Hide likes in profile
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}