import 'package:approval/components.dart';
import 'package:approval/data.dart';
import 'package:approval/drawer.dart';
import 'package:approval/event_screen/events_component.dart';
import 'package:approval/event_screen/events_model.dart';
import 'package:approval/event_screen/test_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int totalNumberOfUsers;
  late int totalNumberOfStudents;
  late int totalNumberOfStaff;
  late List<PreEventsModel> events;

  @override
  @override
  void initState() {
    super.initState();
    totalNumberOfStudents = studentData.length;
    totalNumberOfStaff = staffData.length;
    totalNumberOfUsers = totalNumberOfStudents + totalNumberOfStaff;
    events = getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SkillMentors'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person),
          ),
        ],
      ),
      drawerScrimColor: Colors.transparent,
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardCard(title: 'Total Users', color: Colors.green, value: totalNumberOfUsers.toString()),
                SizedBox(width: 20),
                DashboardCard(title: 'Students', color: Colors.orange, value: totalNumberOfStudents.toString()),
                SizedBox(width: 20),
                DashboardCard(title: 'Staff', color: Colors.purple, value: totalNumberOfStaff.toString()),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 50,
                  childAspectRatio: 3 / 2,
                ),
                children: [
                  EventCard(event: events),
                  EventCard(event: events),
                  EventCard(event: events),
                  EventCard(event: events),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  DashboardCard({required this.title, required this.color, this.value = '0'});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final List<PreEventsModel> event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: event.length,
        itemBuilder: (context, index) {
          if (index == event.length) {
            // Show loading indicator at the bottom
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          // Display existing events
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to event details
              },
              child: PopularEventTile(event: event[index]),
            ),
          );
        },
      ),
    );
  }
}