import 'package:flutter/material.dart';
import 'package:snt_app/Models-jass/event_model.dart';
import 'package:snt_app/Services-jass/event_service.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Widgets/HomePage/UpcomingEvents/upcoming_event_scrolling_view.dart';

class UpcomingEventsSection extends StatelessWidget {

  final String title;
  EventService eventService = EventService();
  

  UpcomingEventsSection({
    super.key,
    required this.title,
  });

  Future<List<EventModel>> fetchEvents() async {
    final response = await eventService.fetchEvents();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // title
        Text(
          title,
          style: TextStyles.Subtitle
        ),

        FutureBuilder<List<EventModel>>(
          future: fetchEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
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