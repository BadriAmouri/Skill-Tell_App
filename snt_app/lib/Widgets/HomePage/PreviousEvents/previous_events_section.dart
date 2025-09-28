// PreviousEventsSection - Updated
import 'package:flutter/material.dart';
import 'package:snt_app/Models/event_model.dart';
import 'package:snt_app/Services/event_service.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Widgets/HomePage/PreviousEvents/previous_events_scrolling_view.dart';

class PreviousEventsSection extends StatefulWidget {
  final String title;
  
  const PreviousEventsSection({
    super.key,
    required this.title,
  });

  @override
  State<PreviousEventsSection> createState() => _PreviousEventsSectionState();
}

class _PreviousEventsSectionState extends State<PreviousEventsSection> {
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
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            widget.title,
            style: TextStyles.Subtitle
          ),
        ),
        FutureBuilder<List<EventModel>>(
          future: _eventsFuture,
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
