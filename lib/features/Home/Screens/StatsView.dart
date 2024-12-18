import 'dart:math';
import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:damdleaders_flutter/Models/Stats.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Statsview extends StatefulWidget {
  @override
  _StatsviewState createState() => _StatsviewState();
}
class _StatsviewState extends State<Statsview> with SingleTickerProviderStateMixin {
  String selectedFilter = 'My Jobs Offer'; // Default filter
  final HomeController postService = HomeController();
  late Future<List<Stats>> statsFuture;
  List<String> jobs = [];
  List<double> applications = [];
  
  late AnimationController _controller;
  bool isDataProcessed = false; // Flag to ensure setState() is not called during build

  @override
  void initState() {
    super.initState();
    statsFuture = postService.fetchApplicationsPerPost("674cabd54603d2eeb31c56e3"); // Fetch stats
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
  }

  // Process fetched data into chart-friendly lists
  void processFetchedData(List<Stats> stats) {
    if (isDataProcessed) return; // Avoid processing data more than once

    setState(() {
      jobs = stats.map((stat) => stat.postName).toList();
      applications = stats.map((stat) => stat.postulations.toDouble()).toList();
      isDataProcessed = true; // Mark data as processed
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Charts'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Stats>>(
        future: statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          // Process fetched data only once
          processFetchedData(snapshot.data!);

          return Column(
            children: [
              const Divider(thickness: 1),
              Expanded(
                child: FadeTransition(
                  opacity: _controller,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Number of Applications per Job Offer',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: applications
                                    .asMap()
                                    .entries
                                    .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                                    .toList(),
                                isCurved: true,
                                barWidth: 4,
                                gradient: const LinearGradient(
                                  colors: [Colors.green, Colors.lightGreen],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green.withOpacity(0.2),
                                      Colors.lightGreen.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: const TextStyle(fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    int index = value.toInt();
                                    if (index >= 0 && index < jobs.length) {
                                      return Text(
                                        jobs[index],
                                        style: const TextStyle(fontSize: 10),
                                      );
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: FlGridData(show: true),
                            borderData: FlBorderData(
                              border: const Border(
                                left: BorderSide(color: Colors.black),
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide.none,
                                right: BorderSide.none,
                              ),
                            ),
                            minX: 0,
                            maxX: applications.length.toDouble() - 1,
                            minY: 0,
                            maxY: applications.reduce(max) + 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
