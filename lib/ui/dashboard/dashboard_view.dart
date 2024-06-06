import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/CustomColors.dart';
import 'package:ai_travel_planner/data/repository/travel/travel_repository.dart';
import 'package:ai_travel_planner/ui/dashboard/dashboard_viewmodel.dart';
import '../components/travel_card.dart';
import 'dashboard_viewmodel.dart';

class DashboardPage extends StatelessWidget {
  final TravelRepository travelRepository;

  const DashboardPage({super.key, required this.travelRepository});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel(travelRepository: travelRepository)..loadTravels("xotoF1gCuOdGMxgRUX7moQrsbjC2"),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cerca viaggio',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 10.0,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Consumer<DashboardViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                padding: const EdgeInsets.all(0.0),
                color: CustomColors.lightBlue,
                child: ListView.builder(
                  itemCount: viewModel.travels.length,
                  itemBuilder: (context, index) {
                    return TravelCard(travel: viewModel.travels[index]);
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
