import 'package:approval/config/Colors/colors.dart';
import 'package:approval/event_screen/events_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class PopularEventTile extends StatefulWidget {
  final PreEventsModel event;

  const PopularEventTile({
    super.key,
    required this.event,
  });

  @override
  State<PopularEventTile> createState() => _PopularEventTileState();
}

class _PopularEventTileState extends State<PopularEventTile> {
  late DateTime parsedDate;
  late String day;
  late String month;

  /// Parses and formats the event date
  void getFormattedDate() {
    try {
      // Clean the date string (if needed)
      final cleanedDateString = widget.event.eventStartDate.trim();

      // Check if the date string is valid
      if (cleanedDateString.isEmpty) {
        throw FormatException('Empty date string');
      }

      // Try parsing the date string
      parsedDate = DateFormat("dd MMMM yyyy").parse(cleanedDateString);

      // Extract day and month
      day = DateFormat("d").format(parsedDate);
      month = DateFormat("MMM").format(parsedDate);
    } catch (e) {
      // Log error and fallback to current date
      debugPrint('Error parsing date: $e. Input: ${widget.event.eventStartDate}');
      parsedDate = DateTime.now();
      day = DateFormat("d").format(parsedDate);
      month = DateFormat("MMM").format(parsedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    getFormattedDate();

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 200, // Fixed height for constant UI
        width: 350, // Fixed width for constant UI
        foregroundDecoration: RotatedCornerDecoration.withColor(
          color: widget.event.price == "Free"
              ? Colors.greenAccent
              : Colors.redAccent,
          spanBaselineShift: 4,
          badgeSize: Size(50, 50), // Fixed badge size
          badgeCornerRadius: const Radius.circular(30),
          badgePosition: BadgePosition.topStart,
          textSpan: TextSpan(
            text: widget.event.price == "Free" ? "Free" : "Paid",
            style: TextStyle(
              color: widget.event.price == "Free"
                  ? ColorPalette.textColor
                  : ColorPalette.secondaryTextColor,
              fontSize: 14, // Fixed font size for consistency
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontFamily: 'TimesNewRoman',
            ),
          ),
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: widget.event.eventPoster.isNotEmpty
              ? DecorationImage(
            scale: 1.0,
            image: NetworkImage(widget.event.eventPoster),
            opacity: 0.9,
            fit: BoxFit.fitHeight,
            onError: (exception, stackTrace) {
              debugPrint("Failed to load image: $exception");
            },
          )
              : null, // Provide a fallback if the image URL is empty
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10, // Fixed top position
              right: 20, // Fixed right position
              child: CircleAvatar(
                radius: 40, // Fixed radius for avatar
                backgroundColor: ColorPalette.backgroundColor.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          color: ColorPalette.textColor,
                          fontSize: 20, // Fixed font size
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TimesNewRoman',
                        ),
                      ),
                      Text(
                        month,
                        style: TextStyle(
                          color: ColorPalette.textColor,
                          fontSize: 16, // Fixed font size
                          fontFamily: 'TimesNewRoman',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20, // Fixed horizontal padding
                  vertical: 10,  // Fixed vertical padding
                ),
                decoration: BoxDecoration(
                  color: ColorPalette.backgroundColor.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.event.eventType,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.textColor,
                              fontSize: 16, // Fixed font size
                              fontFamily: 'TimesNewRoman',
                            ),
                          ),
                          Text(
                            widget.event.eventName,
                            style: TextStyle(
                              color: ColorPalette.textColor,
                              fontSize: 14, // Fixed font size
                              fontFamily: 'TimesNewRoman',
                            ),
                            overflow: TextOverflow.ellipsis, // Ensure long text is truncated
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedUniversity,
                                color: ColorPalette.textColor,
                                size: 20, // Fixed icon size
                              ),
                              SizedBox(width: 10), // Fixed space
                              ShrinkTextWidget(
                                fontSize: 14, // Fixed font size
                                text: widget.event.collegeName,
                                maxCharacters: 20, // Fixed max characters for consistency
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedLocation01,
                                color: ColorPalette.textColor,
                                size: 20, // Fixed icon size
                              ),
                              SizedBox(width: 10), // Fixed space
                              ShrinkTextWidget(
                                fontSize: 14, // Fixed font size
                                text: widget.event.collegeAddress,
                                maxCharacters: 20, // Fixed max characters for consistency
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShrinkTextWidget extends StatelessWidget {
  final String text;
  final int maxCharacters;
  final double fontSize;

  const ShrinkTextWidget({
    Key? key,
    required this.text,
    required this.maxCharacters,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final truncatedName = text.length > maxCharacters
        ? '${text.substring(0, maxCharacters)}...'
        : text;

    return Text(
      truncatedName,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'TimesNewRoman',
      ),
      textAlign: TextAlign.center,
    );
  }
}
