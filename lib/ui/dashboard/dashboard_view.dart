import 'package:flutter/material.dart';
import 'package:ai_travel_planner/CustomColors.dart';
import 'package:ai_travel_planner/data/repository/travel/travel_repository.dart';
import 'package:ai_travel_planner/data/model/travel.dart';

import '../components/travel_card.dart';

class DashboardPage extends StatefulWidget {
  final TravelRepository travelRepository;

  const DashboardPage({super.key, required this.travelRepository});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController searchController = TextEditingController();
  List<Travel> travels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTravels();
  }

  Future<void> _loadTravels() async {
    try {
      const userId = "xotoF1gCuOdGMxgRUX7moQrsbjC2";
      final loadedTravels = await widget.travelRepository.getSharedTravels(userId);
      setState(() {
        travels = loadedTravels;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: searchController,
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
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Container(
          padding: const EdgeInsets.all(0.0),
          color: CustomColors.lightBlue,
          child: ListView.builder(
            itemCount: travels.length,
            itemBuilder: (context, index) {
              return TravelCard(travel: travels[index]);
            },
          ),
        ),
      ),
    );
  }
}
