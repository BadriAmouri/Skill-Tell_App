import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Theme/theme.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, String>> notifications = List.generate(6, (index) {
    return {
      "id": "${index + 1}",
      "title": "Title of the event",
      "description": index == 2
          ? "Lorem ipsum dolor sit amet consectetur Enim. This one has extra text to test expansion and truncation in the UI. More details can go here..."
          : "Lorem ipsum dolor sit amet consectetur Enim.",
      "time": "1 day ago",
    };
  });

  final _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex),
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.Text400,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.White,
        elevation: 0,
      ),
      body: notifications.isEmpty ? _buildEmptyState() : _buildNotificationList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "lib/Assets/Images/no_notif.svg",
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withAlpha(76), // ~0.3 opacity
              ),
              Positioned(
                bottom: 140,
                left: 16,
                right: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "You're all caught up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.Neutral600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lorem ipsum dolor sit amet consectetur.\nScelerisque viverra blandit egest",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.Neutral400,
                        height: 1.4,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<int, bool> expandedStates = {};
  Map<int, bool> draggingStates = {};

  Widget _buildNotificationList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Divider(
          color: AppColors.Neutral400,
          height: 24,
          thickness: 0.5,
        ),
      ),
      itemBuilder: (context, index) {
        final item = notifications[index];
        bool isExpanded = expandedStates[index] ?? false;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Dismissible(
            key: ValueKey(item["id"]),
            direction: DismissDirection.endToStart,
            onUpdate: (details) {
              setState(() {
                draggingStates[index] = details.progress > 0;
              });
            },
            onDismissed: (_) {
              setState(() {
                notifications.removeAt(index);
                expandedStates.remove(index);
                draggingStates.remove(index);
              });
            },
            background: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 110, 110, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'lib/Assets/Icons/Delete.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: Color(0xFFECECEC),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: GestureDetector(
              onTapDown: (_) => setState(() => draggingStates[index] = true),
              onTapUp: (_) => setState(() => draggingStates[index] = false),
              onTapCancel: () => setState(() => draggingStates[index] = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  color: draggingStates[index] ?? false
                      ? AppColors.Main100
                      : Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.Text500,
                              fontFamily: 'Poppins',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          ClipRect(
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["description"]!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.Text400,
                                      fontFamily: 'Poppins',
                                    ),
                                    maxLines: isExpanded ? null : 2,
                                    overflow: isExpanded
                                        ? TextOverflow.visible
                                        : TextOverflow.ellipsis,
                                  ),
                                  if (item["description"]!.length > 60)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          expandedStates[index] = !isExpanded;
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            isExpanded
                                                ? "Show less"
                                                : "Show more",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.Main600,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Icon(
                                            isExpanded
                                                ? Icons.arrow_drop_up
                                                : Icons.arrow_drop_down,
                                            size: 18,
                                            color: AppColors.Main600,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item["time"]!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.Main400,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
