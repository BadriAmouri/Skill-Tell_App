import 'package:flutter/material.dart';
import 'package:snt_app/Models/event_model.dart';
import 'package:snt_app/Widgets/HomePage/PreviousEvents/previous_event_card.dart';

class PreviousEventScrollingView extends StatefulWidget {
  final List<EventModel> events;

  const PreviousEventScrollingView({super.key, required this.events});

  @override
  State<PreviousEventScrollingView> createState() => _PreviousEventScrollingViewState();
}

class _PreviousEventScrollingViewState extends State<PreviousEventScrollingView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    // Each card width + separator space
    double cardWidth = 360; // adjust to your card's real width
    double separatorWidth = 12;
    int startIndex = 1; // index you want to start at

    double initialOffset = (cardWidth - separatorWidth) * startIndex;

    _scrollController = ScrollController(initialScrollOffset: initialOffset);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      height: 460,
      child: ListView.separated(
        controller: _scrollController, // attach the controller
        scrollDirection: Axis.horizontal,
        itemCount: widget.events.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return PreviousEventCard(event: widget.events[index]);
        },
      ),
    );
  }
}
