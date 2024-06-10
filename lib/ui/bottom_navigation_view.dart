import 'package:ai_travel_planner/assets/CustomColors.dart';
import 'package:ai_travel_planner/ui/dashboard/dashboard_view.dart';
import 'package:ai_travel_planner/ui/profile/profile_view.dart';
import 'package:ai_travel_planner/ui/travel_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/user_model.dart';

class MyApp extends StatelessWidget {
  final User user;

  const MyApp({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(user),
    );
  }
}

class MainPage extends StatefulWidget {
  final User user;
  const MainPage(this.user, {super.key});
  @override
  _MainPageState createState() => _MainPageState();
}

List<IconData> navIcons = [
  Icons.home,
  Icons.person,
];

List<String> navTitles = [
  'Home',
  'Profile',
];

int selectedIndex = 0;

class _MainPageState extends State<MainPage> {
  static final travelViewModel = TravelViewModel();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.text = travelViewModel.searchText;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    DashboardFragment(travelViewModel),
    ProfileFragment(travelViewModel),
  ];

  List<PreferredSize> get _topBarWidgetOptions {
    return <PreferredSize>[
      PreferredSize(
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
                    child: ChangeNotifierProvider<TravelViewModel>.value(
                      value: travelViewModel,
                      child: Consumer<TravelViewModel>(
                        builder: (context, viewModel, child) {
                          return TextField(
                            controller: searchController,
                            onChanged: (query) {
                              viewModel.searchTravel(query);
                            },
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20.0),
        child: AppBar(
          toolbarHeight: kToolbarHeight,
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
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.lightBlue,
      appBar: _topBarWidgetOptions.elementAt(selectedIndex),
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(selectedIndex),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _navVar(),
          ),
        ],
      ),
    );
  }

  Widget _navVar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: CustomColors.darkBlue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: CustomColors.darkBlue.withAlpha(20),
            spreadRadius: 20,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: navIcons.map((icon) {
          int index = navIcons.indexOf(icon);
          bool isSelected = selectedIndex == index;
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 35,
                        right: 35,
                      ),
                      child: Icon(
                        icon,
                        color: isSelected ? Colors.white : CustomColors.mediumBlue,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

