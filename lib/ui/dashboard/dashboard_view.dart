import 'package:ai_travel_planner/ui/travel/travel_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/ui/travel_viewmodel.dart';
import '../../data/model/user_model.dart';
import '../Travel/travel_details.dart';
import '../components/travel_card.dart';

class DashboardFragment extends StatelessWidget {
  final TravelViewModel travelViewModel;
  const DashboardFragment(this.travelViewModel,{super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TravelViewModel>.value(
      value: travelViewModel,
      child: Consumer<TravelViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: viewModel.filteredTravels.length,
                  itemBuilder: (context, index) {
                    final travel = viewModel.filteredTravels[index];
                    return GestureDetector(
                      onTap: () async {
                        User? ownerUser = await viewModel.getOwnerUser(travel);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TravelDetailsFragment(
                                travel: travel,
                                travelViewModel: travelViewModel,
                                ownerUser: ownerUser,
                                view: "dashboard"
                            ),
                          ),
                        );
                      },
                      child: FutureBuilder<User?>(
                        future: viewModel.getOwnerUser(travel),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Error loading user');
                          } else {
                            return TravelCard(
                              bottomMargin: index == viewModel.filteredTravels.length - 1 ? 120 : 10,
                              travel: travel,
                              user: null,
                              ownerUser: snapshot.data,
                              onLikeTap: () {
                                viewModel.toggleLikeStatus(travel, "xotoF1gCuOdGMxgRUX7moQrsbjC2");
                              },
                              showOwnerName: true,
                              showLikes: true,
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
      ),
    );
  }
}
