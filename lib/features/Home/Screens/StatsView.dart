import 'dart:math';
import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:damdleaders_flutter/Models/Post.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Statsview extends StatefulWidget {
  @override
  _ChartExampleState createState() => _ChartExampleState();
}

class _ChartExampleState extends State<Statsview>
    with SingleTickerProviderStateMixin {

  final HomeController postService = HomeController();
  late Future<List<Post>> mesPosts;

  String selectedFilter = 'My Jobs Offer'; // Default filter

  List<Map<String, dynamic>> data = [
    {
      'filter': 'My Jobs Offer',
      'jobs': List.generate(8, (i) => 'Job ${i + 1}'),
      'applications': [13, 15, 10, 32, 20, 15, 10, 32],
      'ageIntervals': {'18-25': 30, '26-35': 40, '36-45': 22, '46+': 8},
    },
    {
      'filter': 'Category B',
      'jobs': List.generate(8, (i) => 'Job ${i + 1}'),
      'applications': [10, 20, 30, 25, 35, 45, 40, 50],
      'ageIntervals': {'18-25': 20, '26-35': 30, '36-45': 25, '46+': 25},
    },
    {
      'filter': 'Category C',
      'jobs': List.generate(7, (i) => 'Job ${i + 1}'),
      'applications': [5, 10, 15, 20, 25, 30, 35],
      'ageIntervals': {'18-25': 25, '26-35': 35, '36-45': 30, '46+': 10},
    },
  ];

  List<String> jobs = [];
  List<double> applications = [];
  List<double> agePercentages = [];
  List<String> ageLabels = [];
  Map<String, int> ageCounts = {};
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    mesPosts = postService.fetchMyPosts("674cabd54603d2eeb31c56e3");
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
    updateChartData();
  }

  void updateChartData() {
    final selectedData =
        data.firstWhere((element) => element['filter'] == selectedFilter);

    setState(() {
      jobs = List<String>.from(selectedData['jobs']);
      applications =
          List<double>.from(selectedData['applications'].map((e) => e.toDouble()));

      // Calculate age interval percentages
      final ageData = selectedData['ageIntervals'] as Map<String, int>;
      ageCounts = ageData; // Save raw counts for display
      final totalCandidates = ageData.values.reduce((a, b) => a + b);
      ageLabels = ageData.keys.toList();
      agePercentages = ageData.values
          .map((count) => (count / totalCandidates) * 100)
          .toList();
    });

    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Charts'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Dataset:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.indigo.withOpacity(0.5), width: 1),
                    color: Colors.indigo.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: selectedFilter,
                    borderRadius: BorderRadius.circular(12),
                    underline: const SizedBox(),
                    isExpanded: false,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    items: data
                        .map((item) => DropdownMenuItem<String>(
                              value: item['filter'],
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  item['filter'],
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                        updateChartData();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          // Pie Chart Section
          Expanded(
            child: FadeTransition(
              opacity: _controller,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Age Distribution of Candidates',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 110,),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: List.generate(
                          agePercentages.length,
                          (index) => PieChartSectionData(
                            value: agePercentages[index],
                            color: Colors.primaries[index % Colors.primaries.length],
                            title: '${agePercentages[index].toStringAsFixed(1)}%',
                            radius: 60,
                            titleStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        centerSpaceRadius: 50,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Age Intervals Legend
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ageLabels.asMap().entries.map((entry) {
                        final index = entry.key;
                        final label = entry.value;
                        final color = Colors.primaries[index % Colors.primaries.length];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$label',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1),      
          // Line Chart Section
          Expanded(
  child: Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Number of Applications per Job Offer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
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
                  sideTitles: SideTitles(showTitles: false), // Hide top numbers
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Hide right numbers
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
)


        ],
      ),
    );
  }
}
