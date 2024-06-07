import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/ui/travel_viewmodel.dart';
import 'package:ai_travel_planner/ui/components/travel_card.dart';
import 'package:ai_travel_planner/CustomColors.dart';
import '../../data/model/user_model.dart';
import '../Travel/travel_details.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TravelViewModel(),
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
              children: const [
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
          body: Consumer<TravelViewModel>(
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
                              backgroundImage: const NetworkImage(
                                "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png",
                              ),
                              radius: 30.0,
                            ),
                            const SizedBox(width: 10.0),
                            const Text(
                              'Nome utente',
                              style: TextStyle(
                                color: CustomColors.darkBlue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: const [
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
                            onTap: () async {
                              final ownerUser = await viewModel.getOwnerUser(travel);
                              if (ownerUser != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TravelDetails(
                                      travel: travel,
                                      travelViewModel: viewModel,
                                      ownerUser: ownerUser,
                                      view: "profile"
                                    ),
                                  ),
                                );
                              }
                            },
                            child: FutureBuilder<User?>(
                              future: viewModel.getOwnerUser(travel),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Text(
                                    ''
                                  );
                                } else {
                                  final ownerUser = snapshot.data;
                                  return TravelCard(
                                    travel: travel,
                                    user: null,
                                    ownerUser: ownerUser,
                                    icon: Icons.share,
                                    onIconTap: () {
                                      viewModel.shareTravel(travel);
                                    },
                                    onLikeTap: null,
                                    showOwnerName: false,
                                    showLikes: false,
                                  );
                                }
                              },
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
