import 'dart:convert';
import 'dart:ui';
import 'package:approval/event_screen/events_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hugeicons/hugeicons.dart';

const String jsonData = '''
  [
    {
      "eventTitle": "Hackathon 2021",
      "eventStartDate": "2021-10-10",
      "eventEndDate": "2021-10-12",
      "eventLocation": "Chennai",
      "eventDescription": "Hackathon 2021 is a 3-day event where developers and designers come together to build something amazing.",
      "eventImage": "https://picsum.photos/200/300"
    },
    {
      "eventTitle": "Sports Meet 2021",
      "eventStartDate": "2021-11-10",
      "eventEndDate": "2021-11-12",
      "eventLocation": "Coimbatore",
      "eventDescription": "Sports Meet 2021 is a 3-day event where athletes from all over the country come together to compete.",
      "eventImage": "https://picsum.photos/200/300"
    },
    {
      "eventTitle": "Academic Conference 2021",
      "eventStartDate": "2021-12-10",
      "eventEndDate": "2021-12-12",
      "eventLocation": "Madurai",
      "eventDescription": "Academic Conference 2021 is a 3-day event where researchers and scholars come together to discuss the latest trends in academia.",
      "eventImage": "https://picsum.photos/200/300"
    }
  ]
''';

List<PreEventsModel> getEvents() {
  final List<dynamic> decodedJson = jsonDecode(jsonData);
  return decodedJson.map((json) => PreEventsModel.fromJson(json)).toList();
}

