import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Meeting.dart';
import 'login/UserProvider.dart';
import 'login_page.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

// final FirebaseAuth _auth = FirebaseAuth.instance;


class _CalendarPageState extends State<CalendarPage> {
  late List<Appointment> _appointments;

  @override
  void initState() {
    _appointments = <Appointment>[];
    super.initState();
    _loadAppointmentsFromFirestore();
  }


  void _loadAppointmentsFromFirestore() async {
    // Initialize Firestore (you may have already done this)
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Replace 'yourCollectionName' with the name of your Firestore collection.
    CollectionReference meetingsCollection = firestore.collection('users');

    // Replace 'userId' with the user's ID or any criteria to identify the user's meetings.
    String userId = '116362293495481557870'; // You may need to retrieve the user's ID from your app's authentication system.

    QuerySnapshot querySnapshot = await meetingsCollection.where('id', isEqualTo: userId).get();
    print('Error retrieving user meetings: ');

    // if (querySnapshot.docs.isNotEmpty) {
    if(true){

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // print(document.data());
        DocumentReference userDocumentRef = document.reference;
        CollectionReference meetingsCollection = userDocumentRef.collection('meetings');
        QuerySnapshot meetingsSnapshot = await meetingsCollection.get();

        for (QueryDocumentSnapshot meetingDocument in meetingsSnapshot.docs) {
          DateTime startTime = meetingDocument['startTime'].toDate();
          DateTime endTime = meetingDocument['endTime'].toDate();
          String subject = meetingDocument['subject'];
          String notes = meetingDocument['notes'];

          _appointments.add(
            Appointment(
              startTime: startTime,
              endTime: endTime,
              subject: subject,
              notes: notes,
            ),
          );
        }
      }

      // Update the calendar with the new appointments.
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    return Provider<UserProvider>(
      create: (_) => UserProvider(),
      // Use `builder` to obtain a new `BuildContext` that has access to the provider
      builder: (context, child) {
        // No longer throws
        final userProvider = context.watch<UserProvider>();
        Provider.debugCheckInvalidValueType = null ;

        // Now you can use userProvider to get your data
        return Scaffold(
          appBar: AppBar(
            title: Text('Calendar'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Wedding',
                      style: TextStyle(
                        fontSize: 24.0, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profile Tab'),
                  onTap: () {
                    // Handle profile tab tap
                    Navigator.pop(context);
                    // Add your logic for the profile tab
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    // Handle logout tab tap
                    Navigator.pop(context);
                    _handleSignOut(context);
                    Navigator.pushNamed(context, '/');
                    // Add your logic for logout
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: userProvider.user == null ?
            // Navigator.pushNamed(context, '/');
            // Navigator.pushReplacementNamed(context, '/login')
            LoginPage()
                :
            SfCalendar(
              view: CalendarView.month,
              dataSource: _DataSource(_appointments),
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
              appointmentTextStyle: TextStyle(color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.calendarCell) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController titleController =
                      TextEditingController();
                      TextEditingController notesController =
                      TextEditingController();
                      DateTime selectedDate = details.date!;
                      return AlertDialog(
                        title: Text('Add Event'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: InputDecoration(
                                hintText: 'Title',
                              ),
                            ),
                            TextField(
                              controller: notesController,
                              decoration: InputDecoration(
                                hintText: 'Notes',
                              ),
                            ),
                            TextButton(
                              child: Text('Choose Date'),
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  selectedDate = pickedDate;
                                }
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text('Save'),
                            onPressed: () {
                              setState(() {

                                Appointment appointment = Appointment(
                                    startTime: DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      details.date!.hour,
                                      details.date!.minute,
                                    ),
                                    endTime: DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      details.date!.hour,
                                      details.date!.minute + 30,
                                    ),
                                    subject: titleController.text,
                                    notes: notesController.text);
                                _appointments.add(appointment);
                                final meeting = Meeting();
                                meeting.addAppointmentToFirestore(appointment);
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

void _handleSignOut(BuildContext context) async {
  final LoginPage _loginPage = LoginPage();

  await _loginPage.googleSignIn.signOut();
  Provider.of<UserProvider>(context, listen: false).signOut();
}


class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
