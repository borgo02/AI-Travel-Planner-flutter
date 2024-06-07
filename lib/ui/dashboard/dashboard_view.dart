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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 20.0),
          child: AppBar(
            toolbarHeight: kToolbarHeight,
            backgroundColor: CustomColors.darkBlue,
            elevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cerca viaggio..',
                          hintStyle: const TextStyle(color: CustomColors.darkBlue),
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                        ),
                        style: const TextStyle(color: CustomColors.darkBlue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Consumer<TravelViewModel>(
          builder: (context, travelViewModel, child) {
            return Center(
              child: travelViewModel.isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                color: CustomColors.lightBlue,
                child: ListView.builder(
                  itemCount: travelViewModel.sharedTravels.length,
                  itemBuilder: (context, index) {
                    final travel = travelViewModel.sharedTravels[index];
                    return GestureDetector(
                      onTap: () async {
                        User? ownerUser = await travelViewModel.getOwnerUser(travel);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TravelDetails(
                                travel: travel,
                                travelViewModel: travelViewModel,
                                ownerUser: ownerUser,
                                view: "dashboard"
                            ),
                          ),
                        );
                      },
                      child: FutureBuilder<User?>(
                        future: travelViewModel.getOwnerUser(travel),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Error loading user');
                          } else {
                            return TravelCard(
                              travel: travel,
                              user: null,
                              ownerUser: snapshot.data,
                              onLikeTap: () {
                                travelViewModel.toggleLikeStatus(travel, "xotoF1gCuOdGMxgRUX7moQrsbjC2");
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
