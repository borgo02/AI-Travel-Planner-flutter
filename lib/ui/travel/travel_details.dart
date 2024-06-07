import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_travel_planner/data/model/travel.dart';
import 'package:ai_travel_planner/CustomColors.dart';
import '../../data/model/stage.dart';
import '../travel_viewmodel.dart';

class TravelDetails extends StatelessWidget {
  final Travel travel;
  final TravelViewModel travelViewModel;

  const TravelDetails(this.travelViewModel, this.travel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: CustomColors.darkBlue,
        elevation: 0,
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
      body: ChangeNotifierProvider(
        create: (_) => TravelViewModel(),
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
                              Text(
                                travel.name ?? 'Nome del viaggio',
                                style: const TextStyle(
                                  color: CustomColors.darkBlue,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                travel.name ?? 'Descrizione del viaggio',
                                style: const TextStyle(
                                  color: CustomColors.mediumBlue,
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              const Text(
                                'Dettagli aggiuntivi:',
                                style: TextStyle(
                                  color: CustomColors.darkBlue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 50.0),
                              SizedBox(
                                height: 500.0,
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
