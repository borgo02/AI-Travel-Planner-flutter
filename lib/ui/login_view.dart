import 'dart:ui';
import 'package:ai_travel_planner/data/repository/User/user_repository.dart';
import 'package:ai_travel_planner/ui/bottom_navigation_view.dart';
import 'package:ai_travel_planner/ui/interests/interests_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../assets/CustomColors.dart';
import 'interests/interests_view.dart';

class LoginActivity extends StatefulWidget {

  const LoginActivity({super.key});

  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  final InterestsViewModel interestsViewModel = InterestsViewModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  var userRepository = UserRepository();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (_auth.currentUser != null)
    {
      setState(() {
        isLoading = true;
      });
      _handleLoginNavigation(_auth.currentUser!);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: const BoxDecoration(color: CustomColors.darkBlue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Bentornato!", style: TextStyle(fontSize: 35.0, decoration: TextDecoration.none, color: Colors.white)),
              const SizedBox(height: 40.0),
              ElevatedButton.icon(
                onPressed: () async {
                  await _signInWithGoogle();
                },
                icon: const Icon(Icons.account_circle, color: CustomColors.darkBlue,),
                label: const Text('Accedi con Google', style: TextStyle( color: CustomColors.darkBlue),),
              ),
              if (isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
        await _auth.signInWithCredential(credential);
        final User user = authResult.user!;
        await _handleLoginNavigation(user);
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed. Please try again.'),
        ),
      );
    }
  }

  Future<void> _handleLoginNavigation(User user) async
  {
    var dbUser = await userRepository.getUserById(idUser: user.uid, isCurrentUser: true);

    if (dbUser!.isInitialized)
    {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage(dbUser)),
      );
    }
    else
    {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => InterestsView(interestsViewModel)),
      );
    }
  }
}

class LoginScreen extends StatelessWidget {
  final User? user;
  final String title;

  const LoginScreen({super.key, required this.title, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Benvenuto, ${user?.displayName}'),
      ),
    );
  }
}