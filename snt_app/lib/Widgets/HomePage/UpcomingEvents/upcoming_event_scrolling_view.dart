import 'package:flutter/material.dart';
import 'package:snt_app/Models-jass/event_model.dart';
import 'package:snt_app/Widgets/HomePage/UpcomingEvents/upcoming_event_card.dart';

class UpcomingEventScrollingView extends StatelessWidget {
  final List<EventModel> events;
  const UpcomingEventScrollingView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top:12),
      child: SizedBox(
        height: 369, // card height
        child: ListView.separated(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: events.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            return UpcomingEventCard(event: events[index]);
          },
        ),
      ),
    );
  }
}