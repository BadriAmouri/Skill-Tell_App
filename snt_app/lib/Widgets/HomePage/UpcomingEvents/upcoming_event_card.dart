import 'package:flutter/material.dart';
import 'package:snt_app/Models-jass/event_model.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Theme/theme.dart';

class UpcomingEventCard extends StatelessWidget {

  final EventModel event;
  const UpcomingEventCard({super.key, required this.event});
  
  // final double cardWidth = MediaQuery.of(context).size.width * 0.7;
  final double cardWidth = 284;
  final double cardHeight = 359;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.Neutral200, // border color
          width: 1, // border width
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 4,
            offset: const Offset(2, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            // Image
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,

              children: [

                Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.Main600,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        image: event.imageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(event.imageUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 218,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                          borderRadius: BorderRadius.circular(15), // Radius of 12px
                        ),
                        child: Icon(
                          Icons.notifications_none, 
                          color: AppColors.Accent300,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 4,

                  children: [
                      Text(
                      event.name,
                      style: TextStyles.EventTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    
                    Text(
                      event.description,
                      style: TextStyles.EventDesc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),


                
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: AppColors.Accent300
                    ),
                    Text(
                      event.date,
                      style: TextStyles.DateAndLocation,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),


                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: AppColors.Accent300
                    ),
                    Text(
                      event.location,
                      style: TextStyles.DateAndLocation,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}