import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/CustomColors.dart';
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
      child: Scaffold(
        body: Consumer<TravelViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                color: CustomColors.lightBlue,
                child: ListView.builder(
                  itemCount: viewModel.sharedTravels.length,
                  itemBuilder: (context, index) {
                    final travel = viewModel.sharedTravels[index];
                    return GestureDetector(
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TravelDetails(viewModel, travel),
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
      ),
    );
  }
}
