import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;
  const ImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class TotalUsersChart extends StatelessWidget {
  final List<Map<String, dynamic>> graphTotalUsers;

  TotalUsersChart({Key? key, required this.graphTotalUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Prepare the spots dynamically from graphTotalUsers
    List<FlSpot> spots = graphTotalUsers.asMap().entries.map((entry) {
      int index = entry.key;
      double users = entry.value['users'].toDouble();
      return FlSpot(index.toDouble(), users);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) => const FlLine(
              color: Color(0xff37434d),
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => const FlLine(
              color: Color(0xff37434d),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (value, meta) {
                  final months = graphTotalUsers.map((e) => e['month']).toList();
                  if (value.toInt() < months.length) {
                    return Text(
                      months[value.toInt()],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  }
                  return const Text('');
                },
                interval: 1,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                },
                interval: 1,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: const Color(0xff37434d),
            ),
          ),
          minX: 0,
          maxX: (graphTotalUsers.length - 1).toDouble(),
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.cyan],
              ),
              barWidth: 5,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.blueAccent.withOpacity(0.3), Colors.cyan.withOpacity(0.3)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
