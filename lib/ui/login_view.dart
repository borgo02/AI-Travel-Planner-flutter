import 'package:ai_travel_planner/data/repository/User/user_repository.dart';
import 'package:ai_travel_planner/ui/interests/interests_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'interests/interests_view.dart';

class LoginActivity extends StatefulWidget {
  final String title;

  const LoginActivity({super.key, required this.title});

  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  var userRepository = UserRepository();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Text',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () async {
                await _signInWithGoogle();
              },
              icon: Icon(Icons.account_circle),
              label: Text('Sign in with Google'),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
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
        var dbUser = await userRepository.getUserById(idUser: user.uid, isCurrentUser: true);

        if (dbUser!.isInitialized)
          {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => InterestsView(viewModel: InterestsViewModel(),)),
            );
          }
        else
          {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => InterestsView(viewModel: InterestsViewModel(),)),
            );
          }
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication failed. Please try again.'),
        ),
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
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Text('Welcome, ${user?.displayName}'),
      ),
    );
  }
}
