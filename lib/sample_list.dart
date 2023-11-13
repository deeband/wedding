import 'package:flutter/foundation.dart';

import 'calendar/agenda_view.dart';
import 'calendar/airfare.dart';
import 'calendar/appointment_editor.dart';
import 'calendar/calendar_loadmore.dart';
import 'calendar/customization.dart';
import 'calendar/drag_and_drop_calendar.dart';
import 'calendar/getting_started.dart';
import 'calendar/heatmap.dart';
import 'calendar/localization.dart';
import 'calendar/recurrence.dart';
import 'calendar/resizing_calendar.dart';
import 'calendar/rtl.dart';
import 'calendar/schedule_view.dart';
import 'calendar/shift_scheduler.dart';
import 'calendar/special_regions.dart';
import 'calendar/timeline_views.dart';

/// Contains the output widget of sample
/// appropriate key and output widget mapped
Map<String, Function> getSampleWidget() {
  return <String, Function>{


    // Calendar Samples
    'getting_started_calendar': (Key key) => GettingStartedCalendar(key),
    'recurrence_calendar': (Key key) => RecurrenceCalendar(key),
    'agenda_view_calendar': (Key key) => AgendaViewCalendar(key),
    'appointment_editor_calendar': (Key key) => CalendarAppointmentEditor(key),
    'customization_calendar': (Key key) => CustomizationCalendar(key),
    'special_regions_calendar': (Key key) => SpecialRegionsCalendar(key),
    'schedule_view_calendar': (Key key) => ScheduleViewCalendar(key),
    'shift_scheduler': (Key key) => ShiftScheduler(key),
    'timeline_views_calendar': (Key key) => TimelineViewsCalendar(key),
    'heat_map_calendar': (Key key) => HeatMapCalendar(key),
    'air_fare_calendar': (Key key) => AirFareCalendar(key),
    'loadmore_calendar': (Key key) => LoadMoreCalendar(key),
    'drag_and_drop_calendar': (Key key) => DragAndDropCalendar(key),
    'resizing_calendar': (Key key) => ResizingCalendar(key),
    'rtl_calendar': (Key key) => CalendarRtl(key),
    'localization_calendar': (Key key) => CalendarLocalization(key),
  };
}
