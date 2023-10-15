import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'login_page.dart'; // Import your login page
// import 'calendar_page.dart'; // Import your calendar page
import 'package:firebase_core/firebase_core.dart';
import 'add_event.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
      options : DefaultFirebaseOptions.web
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/', // Set the initial route to '/'
      routes: {
        '/': (context) => LoginPage(),
        '/calendar': (context) => CalendarPage(), // Add the new route here
      },
    );
  }
}
