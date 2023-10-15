import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth_buttons/auth_buttons.dart'; // Import the package

class LoginPage extends StatelessWidget {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginPage({super.key});


  Future<User?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
      await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to My Calendar App',
              style: TextStyle(
                fontSize: 20, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Add fontWeight if desired
              ),
            ),
            const SizedBox(height: 20),
            GoogleAuthButton( // Use the GoogleAuthButton widget
              onPressed: () async {
                final User? user = await _handleSignIn();
                if (user != null) {
                  Navigator.pushNamed(context, '/calendar');
                  // Navigate to the calendar page or the next screen
                } else {
                  // Handle login failure
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
