import 'package:flutter/material.dart';
import 'package:snt_app/Models-jass/event_model.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:intl/intl.dart';

class PreviousEventCard extends StatelessWidget {

  final EventModel event;
  const PreviousEventCard({super.key, required this.event});

  // final double cardWidth = MediaQuery.of(context).size.width * 0.7;
  final double cardWidth = 360;
  final double cardHeight = 460;

  @override
  Widget build(BuildContext context) {

    String month = DateFormat.MMMM().format(DateTime.parse(event.date));
    String day = DateFormat.d().format(DateTime.parse(event.date));

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.Main600,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "lib/Assets/Images/event_bg.jpg", // fallback asset
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),

          // Dark gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Event content
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              padding: const EdgeInsets.only( top: 2.5, bottom: 2.5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(167, 167, 167, 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.Neutral200, // border color
                  width: 1, // border width
                ),
              ),
              child: Column(children: [
                Text(
                  month.length>5?"${month.substring(0,5)}":"$month",
                  style: TextStyle(
                    fontFamily: AppFonts.primaryFontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                    color: AppColors.Neutral200,
                  ),
                ),
                Text(
                  "$day",
                  style: TextStyle(
                    fontFamily: AppFonts.primaryFontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.Neutral200,
                  ),
                ),
              ],
              )
            ),
          ),

          Positioned(
            top: 260,
            left: 12,
            bottom: 12,
            child: Container(
              width: 336,
              height: 188,
              decoration: BoxDecoration(
                color: Color.fromRGBO(167, 167, 167, 0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.Neutral200, // border color
                  width: 1, // border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          event.name,
                          style: const TextStyle(
                            fontFamily: AppFonts.primaryFontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.White,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          event.description,
                          style: TextStyle(
                            fontFamily: AppFonts.primaryFontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.Neutral200,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(
                          "Key features",
                          style: const TextStyle(
                            fontFamily: AppFonts.primaryFontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.White,
                          ),
                        ),

                        Wrap(
                          spacing: 8, 
                          children: event.keyFeatures.map((feature) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 214, 168, 1), 
                                border: Border.all(
                                  color: AppColors.Accent400, 
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontFamily: AppFonts.primaryFontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.Accent400
                                ),
                              ),
                            );
                          }).toList(),
                        )

                      ],
                    )
                
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}