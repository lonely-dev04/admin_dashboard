import 'package:approval/dashboard.dart';
import 'package:approval/report.dart';
import 'package:approval/verfification.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'data.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/', // Default route
    routes: {
      '/': (context) => DashboardScreen(),
      '/studentVerification': (context) => AdminVerificationPage(title: "Student"),
      '/staffVerification': (context) => AdminVerificationPage(title: "Staff"),
      '/studentReport': (context) => AdminReportPage(title: "Student"),
      '/staffReport': (context) => AdminReportPage(title: "Staff"),
    },
  ));
}