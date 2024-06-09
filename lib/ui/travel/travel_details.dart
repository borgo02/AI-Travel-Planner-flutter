import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/data/model/travel.dart';
import 'package:ai_travel_planner/assets/CustomColors.dart';
import 'package:ai_travel_planner/ui/travel_viewmodel.dart';
import '../../data/model/stage.dart';
import '../../data/model/user_model.dart';

class TravelDetailsFragment extends StatelessWidget {
  final Travel travel;
  final TravelViewModel travelViewModel;
  final String? view;
  final User? ownerUser;

  const TravelDetailsFragment({
    super.key,
    required this.travel,
    required this.travelViewModel,
    this.view,
    this.ownerUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: CustomColors.darkBlue,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            travel.name ?? 'Dettaglio Viaggio',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<TravelViewModel>.value(
        value: travelViewModel,
        child: SingleChildScrollView(
          child: Consumer<TravelViewModel>(
            builder: (context, viewModel, child) {
              return FutureBuilder(
                future: viewModel.getStagesByTravel(travel),
                builder: (context, AsyncSnapshot<List<Stage>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Errore nel caricamento delle tappe'));
                  } else if (snapshot.hasData) {
                    final stages = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          travel.imageUrl!.isNotEmpty
                              ? travel.imageUrl!
                              : 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
                          height: 250.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: CustomColors.lightBlue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            ownerUser!.fullname ?? 'Nome utente',
                                            style: const TextStyle(
                                              color: CustomColors.darkBlue,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          if (ownerUser != null) ...[
                                            if(view != "profile") ...[
                                            Text(
                                              '${travel.numberOfLikes ?? 0}',
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            ],
                                            IconButton(
                                              icon: view == "profile"
                                                  ? const Icon(Icons.share, color: CustomColors.darkBlue)
                                                  : travel.isLiked
                                                  ? const Icon(Icons.favorite, color: CustomColors.darkBlue)
                                                  : const Icon(Icons.favorite_border, color: CustomColors.darkBlue),
                                              iconSize: 28.0,
                                              onPressed: () {
                                                if (view == "profile") {
                                                  travelViewModel.shareTravel(travel);
                                                } else {
                                                  travelViewModel.toggleLikeStatus(travel, "xotoF1gCuOdGMxgRUX7moQrsbjC2");
                                                }
                                              },
                                            )
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50.0),
                              const Text(
                                'Tappe del viaggio',
                                style: TextStyle(
                                  color: CustomColors.darkBlue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              SizedBox(
                                height: 400.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: stages.length,
                                  itemBuilder: (context, index) {
                                    final stage = stages[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: SizedBox(
                                        width: 200.0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: stage.imageUrl.isNotEmpty
                                                      ? NetworkImage(stage.imageUrl)
                                                      : const NetworkImage('https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg'),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              stage.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            SizedBox(
                                              width: 150.0,
                                              child: Text(
                                                stage.description,
                                                maxLines: 10,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 70.0),
                              Text(
                                "Descrizione di ${travel.name}",
                                style: const TextStyle(
                                    color: CustomColors.darkBlue,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                travel.info ?? 'Descrizione del viaggio',
                                style: const TextStyle(
                                  color: CustomColors.mediumBlue,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
