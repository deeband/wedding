import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late List<Appointment> _appointments;

  @override
  void initState() {
    _appointments = <Appointment>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: _DataSource(_appointments),
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
                          _appointments.add(
                            Appointment(
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
                              notes: notesController.text,
                            ),
                          );
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
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
