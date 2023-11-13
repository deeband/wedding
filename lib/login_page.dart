import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth_buttons/auth_buttons.dart'; // Import the package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'login/UserProvider.dart';

class LoginPage extends StatelessWidget {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn get googleSignIn => _googleSignIn;

  LoginPage({super.key});


  Future<User?> _handleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      String userId = googleUser.id;
      String userEmail = googleUser.email;
      String? userDisplayName = googleUser.displayName;
      // print('DocumentSnapshot added with ID: ${userEmail}');

      Provider.of<UserProvider>(context, listen: false).setUser(googleUser);
      // Call the function to add user data to Firestore
      addUserDataToFirestore(userId, userEmail,userDisplayName);
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUserDataToFirestore(String userId, String userName,String? userDisplayName) async {
    try {
      // print('DocumentSnapshot added with ID: ${userName}');
      await usersCollection.doc(userId).set({
        'name': userName,
        'id': userId,
        'displayName': userDisplayName
        // Add other user data as needed
      });
    //   final user = <String, dynamic>{
    //     'name': userName,
    //     'id': userId,
    //     'displayName': userDisplayName
    //   };
    //   usersCollection.add(user).then((DocumentReference doc) =>
    //       print('DocumentSnapshot added with ID: ${doc.id}'));
    } catch (e) {
      print('Error adding user data to Firestore: $e');
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
                final User? user = await _handleSignIn(context);
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
