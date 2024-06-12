import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/ui/travel_viewmodel.dart';
import 'package:ai_travel_planner/ui/components/travel_card.dart';
import 'package:ai_travel_planner/assets/CustomColors.dart';
import 'package:ai_travel_planner/ui/travel/travel_details.dart';

class ProfileFragment extends StatelessWidget {
  final TravelViewModel travelViewModel;
  const ProfileFragment(this.travelViewModel, {super.key});

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
                SizedBox(
                  height: 130.0,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png"),
                        radius: 25.0,
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        '${travelViewModel.currentUser.fullname}',
                        style: TextStyle(
                          color: CustomColors.darkBlue,
                          fontSize: 16.0,
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
                SizedBox(height: 30.0),
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
                                travel: travel,
                                travelViewModel: travelViewModel,
                                ownerUser: travelViewModel.currentUser,
                                view: "profile",
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
                          ownerUser: travelViewModel.currentUser,
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