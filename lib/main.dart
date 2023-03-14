// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'add_event.dart';

  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '1058909334199-rmvs3bgh7tfjvdsoknkjit5vio02qe9r.apps.googleusercontent.com');

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: <String>[
//     'email',
//     calendar.CalendarApi.calendarReadonlyScope,
//   ],
// );

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CalendarDataSource _calendarDataSource = CustomCalendarDataSource();

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // TODO: Use the credential to sign in to your app.
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home : CalendarPage()
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('My App'),
      //   ),
      //   body: Padding(
      //   padding: const EdgeInsets.all(80.0),
      //   child: SfCalendar(
      //     view: CalendarView.month,
      //     dataSource: _calendarDataSource,
      //   ),
      //   ),
      //
      //   floatingActionButton: GestureDetector(
      //     onTap: () {
      //       _handleSignIn();
      //     },
      //     child: TextButton(
      //       style: TextButton.styleFrom(
      //         backgroundColor: Colors.blue,
      //         primary: Colors.white,
      //         padding: EdgeInsets.all(8.0),
      //       ),
      //       child: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: <Widget>[
      //           Icon(Icons.account_circle),
      //           SizedBox(width: 10),
      //           Text('Sign in with Google'),
      //         ],
      //       ),
      //       onPressed: () {
      //         _handleSignIn();
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}

class CustomCalendarDataSource extends CalendarDataSource {
  @override
  List<Appointment> get appointments => <Appointment>[
    Appointment(
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 3)),
      subject: 'Meeting',
      color: Colors.blue,
    ),
    Appointment(
      startTime: DateTime.now().add(Duration(days: 1)),
      endTime: DateTime.now().add(Duration(days: 1, hours: 1)),
      subject: 'Shopping',
      color: Colors.green,
    ),
    Appointment(
      startTime: DateTime.now().add(Duration(days: 2)),
      endTime: DateTime.now().add(Duration(days: 2, hours: 2)),
      subject: 'Holiday',
      color: Colors.red,
    ),
  ];
}

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('My App'),
//         ),
//         body: Center(
//           child: GestureDetector(
//             onTap: () {
//               _handleSignIn();
//             },
//             child: TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 primary: Colors.white,
//                 padding: EdgeInsets.all(8.0),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Icon(Icons.account_circle),
//                   SizedBox(width: 10),
//                   Text('Sign in with Google'),
//                 ],
//               ),
//               onPressed: () {
//                 _handleSignIn();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   final GoogleSignIn googleSignIn = GoogleSignIn(clientId: '1058909334199-rmvs3bgh7tfjvdsoknkjit5vio02qe9r.apps.googleusercontent.com');
//
//   Future<void> _handleSignIn() async {
//     try {
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // TODO: Use the credential to sign in to your app.
//     } catch (error) {
//       print(error);
//     }
//   }
// }








// void main() async  {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class RandomWords extends StatefulWidget {
//   const RandomWords({super.key});
//
//   @override
//   State<RandomWords> createState() => _RandomWordsState();
// }
//
// class _RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];                 // NEW
//   final _saved = <WordPair>{};     // NEW
//   final _biggerFont = const TextStyle(fontSize: 18); // NEW
//   void _pushSaved() {
//     Navigator.of(context).push(
//       // Add lines from here...
//       MaterialPageRoute<void>(
//         builder: (context) {
//           final tiles = _saved.map(
//                 (pair) {
//               return ListTile(
//                 title: Text(
//                   pair.asPascalCase,
//                   style: _biggerFont,
//                 ),
//               );
//             },
//           );
//           final divided = tiles.isNotEmpty
//               ? ListTile.divideTiles(
//             context: context,
//             tiles: tiles,
//           ).toList()
//               : <Widget>[];
//
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Saved Suggestions'),
//             ),
//             body: ListView(children: divided),
//           );
//         },
//       ), // ...to here.
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(   // NEW from here ...
//       appBar: AppBar(
//         title: const Text('Startup Name Generator'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.list),
//             onPressed: _pushSaved,
//             tooltip: 'Saved Suggestions',
//           ),
//         ],
//       ),
//       body: ListView.builder(
//       padding: const EdgeInsets.all(16.0),
//       itemBuilder: (context, i) {
//         if (i.isOdd) return const Divider();
//
//         final index = i ~/ 2;
//         if (index >= _suggestions.length) {
//           _suggestions.addAll(generateWordPairs().take(10));
//         }
//         final alreadySaved = _saved.contains(_suggestions[index]); // NEW
//         return ListTile(
//           title: Text(
//             _suggestions[index].asPascalCase,
//             style: _biggerFont,
//           ),
//           trailing: Icon(    // NEW from here ...
//             alreadySaved ? Icons.favorite : Icons.favorite_border,
//             color: alreadySaved ? Colors.red : null,
//             semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
//           ),
//           onTap: () {          // NEW from here ...
//             setState(() {
//               if (alreadySaved) {
//                 _saved.remove(_suggestions[index]);
//               } else {
//                 _saved.add(_suggestions[index]);
//               }
//             });                // to here.
//           },
//         );
//       },
//       )
//     );
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final wordPair = WordPair.random();
//     return  MaterialApp(
//       title: 'Startup Name Generator ',
//       theme: ThemeData(          // Add the 5 lines from here...
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//         ),
//       ),
//       home: RandomWords(),
//     );
//   }
// }