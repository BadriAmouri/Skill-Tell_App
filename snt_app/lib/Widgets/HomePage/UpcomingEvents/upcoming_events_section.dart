// UpcomingEventsSection - Updated
import 'package:flutter/material.dart';
import 'package:snt_app/models/event_model.dart';
import 'package:snt_app/services/event_service.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Widgets/HomePage/UpcomingEvents/upcoming_event_scrolling_view.dart';

class UpcomingEventsSection extends StatefulWidget {
  final String title;
  
  const UpcomingEventsSection({
    super.key,
    required this.title,
  });

  @override
  State<UpcomingEventsSection> createState() => _UpcomingEventsSectionState();
}

class _UpcomingEventsSectionState extends State<UpcomingEventsSection> {
  final EventService eventService = EventService();
  late Future<List<EventModel>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = eventService.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          widget.title,
          style: TextStyles.Subtitle
        ),
        FutureBuilder<List<EventModel>>(
          future: _eventsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                height: 359,
                width: MediaQuery.of(context).size.width,
                child: CircularProgressIndicator()
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return UpcomingEventScrollingView(events: snapshot.data!);
            }
          }
        )
      ],
    );
  }
}