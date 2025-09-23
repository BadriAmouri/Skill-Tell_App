import 'package:flutter/material.dart';
import 'package:snt_app/models/event_model.dart';
import 'package:snt_app/Services/event_service.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Widgets/HomePage/PreviousEvents/previous_events_scrolling_view.dart';

class PreviousEventsSection extends StatelessWidget {

  final String title;
  final EventService eventService = EventService();
  

  PreviousEventsSection({
    super.key,
    required this.title,
  });

  Future<List<EventModel>> fetchEvents() async {
    return eventService.fetchPrevious();
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // title
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            title,
            style: TextStyles.Subtitle
          ),
        ),

        FutureBuilder<List<EventModel>>(
          future: fetchEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                height: 460,
                width: MediaQuery.of(context).size.width,
                child: CircularProgressIndicator()
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return PreviousEventScrollingView(events: snapshot.data!);
            }
          }
        )
              
      ],
    );
  }
}