import 'package:ai_travel_planner/CustomColors.dart';
import 'package:ai_travel_planner/ui/dashboard/dashboard_view.dart';
import 'package:ai_travel_planner/ui/profile/profile_view.dart';
import 'package:ai_travel_planner/ui/travel_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
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
  static final List<Widget> _widgetOptions = <Widget>[
    DashboardFragment(travelViewModel),
    ProfileFragment(travelViewModel),
  ];

  static final List<Widget> _topBarWidgetOptions = <Widget>[
    const Text(
      'Home Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Profile Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _topBarWidgetOptions.elementAt(selectedIndex),
      ),
      backgroundColor: CustomColors.paleBlue,
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

