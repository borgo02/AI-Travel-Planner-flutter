import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/ui/dashboard/dashboard_viewmodel.dart';
import 'package:ai_travel_planner/ui/components/travel_card.dart';
import 'package:ai_travel_planner/CustomColors.dart';
import '../Travel/travel_details.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel(),
      child: Container(
        color: CustomColors.lightBlue,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 56,
            backgroundColor: CustomColors.darkBlue,
            elevation: 0,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                Text(
                  'Profilo utente',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          body: Consumer<DashboardViewModel>(
            builder: (context, viewModel, child) {
              return viewModel.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : SingleChildScrollView(
                child: Container(
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.notSharedTravels.length,
                        itemBuilder: (context, index) {
                          final travel = viewModel.notSharedTravels[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TravelDetails(travel: travel),
                                ),
                              );
                            },
                            child: TravelCard(
                              travel: travel,
                              user: null,
                              ownerUser: null,
                              icon: Icons.share,
                              onIconTap: () {
                                viewModel.shareTravel(travel);
                              },
                              onLikeTap: null,
                              showOwnerName: false, // Hide owner name in profile
                              showLikes: false, // Hide likes in profile
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}