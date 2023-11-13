import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Meeting {

  // Method to retrieve user-specific meetings
  static Future<List<Appointment>> getUserMeetings(String userId) async {
    try {
      final meetingsQuery = await FirebaseFirestore.instance
          .collection('users') // Replace with your collection name
          .doc(userId)          // User's document ID (UID)
          .collection('meetings') // Subcollection name for meetings
          .get();

      final meetings = meetingsQuery.docs.map((meetingDoc) {
        // Map Firestore document data to Meeting objects
        final data = meetingDoc.data();
        return Appointment(
          subject: data['title'],
          startTime: data['startTime'].toDate(),
          endTime: data['endTime'].toDate(),
        );
      }).toList();

      return meetings;
    } catch (e) {
      print('Error retrieving user meetings: $e');
      return [];
    }
  }


  Future<void> addAppointmentToFirestore(Appointment appointment) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Convert the appointment object to a map
      final Map<String, dynamic> appointmentData = {
        'startTime': appointment.startTime.toUtc(),
        'endTime': appointment.endTime.toUtc(),
        'subject': appointment.subject,
        'notes': appointment.notes,
      };

      // Add the appointment to Firestore
      await firestore.collection('users').doc('116362293495481557870').collection('meetings').add(appointmentData);

      print('Appointment added to Firestore');
    } catch (error) {
      print('Error adding appointment to Firestore: $error');
    }
  }

}
